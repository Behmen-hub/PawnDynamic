-- PawnDynamic (MIT License)
-- Fully automatic, level- and target-scaled Cap Engine & Delta Calculator (Interface 16001).

local _, ns = ...

local Caps = ns:NewModule("Caps")
local L = ns.L

------------------------------------------------------------------------
-- Profile Cap Defaults & Role Configuration
------------------------------------------------------------------------

Caps.DEFAULT_CAPS = {
    enableCaps = true,
    useTalents = true,
    targetMode = "auto",      -- "auto" (Lv < 60 => +0, Lv 60 => +3) | 0 | 2 | 3
    hitMode = "auto",         -- "auto" | "melee" | "spell"
    tankExpertiseMode = false,
    includeRaidResistBuff = false, -- Optional +60 Raid Resistance Buff offset
    spiritTarget = 0,         -- Optional manual sustain target for healers (0 = off)
    mp5Target = 0,

    -- Internal mechanics constants (automatically resolved; no manual clutter)
    dwBeyondFactor = 0.4,
    tankExpertiseFactor = 0.5,
    expertiseParryCap = 14.0,
    hasteSoftCap = 50.0,
    hasteBeyondFactor = 0.35,
    armorDRCap = 75.0,
    sustainBeyondFactor = 0.25,
}

function Caps.MakeDefaultCaps(role)
    local cfg = {}
    for k, v in pairs(Caps.DEFAULT_CAPS) do
        cfg[k] = v
    end
    if role == "TANK" then
        cfg.tankExpertiseMode = true
    end
    return cfg
end

------------------------------------------------------------------------
-- Racial Weapon Skills & Armor Formula Constants
------------------------------------------------------------------------

local RACIAL_WEAPON_SKILLS = {
    Human = { [4] = 5, [5] = 5, [7] = 5, [8] = 5 }, -- 1H/2H Maces, 1H/2H Swords
    Orc = { [0] = 5, [1] = 5 },                     -- 1H/2H Axes
    Dwarf = { [3] = 5, [4] = 5, [5] = 5 },          -- Guns, 1H/2H Maces
    Troll = { [2] = 5, [16] = 5 },                  -- Bows, Thrown
}

local ARMOR_TANK_REF_HEALTH = 6000
local ARMOR_TANK_REF_ARMOR = 6000

local RESIST_SCHOOLS = {
    { key = "FIRE_RES",   alias = "FireResist",   schoolIndex = 2, labelKey = "Fire resistance" },
    { key = "FROST_RES",  alias = "FrostResist",  schoolIndex = 4, labelKey = "Frost resistance" },
    { key = "NATURE_RES", alias = "NatureResist", schoolIndex = 3, labelKey = "Nature resistance" },
    { key = "SHADOW_RES", alias = "ShadowResist", schoolIndex = 5, labelKey = "Shadow resistance" },
    { key = "ARCANE_RES", alias = "ArcaneResist", schoolIndex = 6, labelKey = "Arcane resistance" },
}

local RESIST_KEY_SET = {
    FIRE_RES = true,
    FROST_RES = true,
    NATURE_RES = true,
    SHADOW_RES = true,
    ARCANE_RES = true,
}

local RESIST_ALIAS_TO_KEY = {
    FireResist = "FIRE_RES",
    FrostResist = "FROST_RES",
    NatureResist = "NATURE_RES",
    ShadowResist = "SHADOW_RES",
    ArcaneResist = "ARCANE_RES",
    AllResist = "ALL_RES",
}

-- Classic armor constant K for enemy level (playerLevel + targetOffset).
function Caps.ArmorConstantForEnemy(enemyLevel)
    enemyLevel = math.max(1, enemyLevel or 60)
    if enemyLevel < 60 then
        return 400 + 85 * enemyLevel
    end
    -- Classic Era 60+ scaling: at enemyLevel 60 => 5882.5, at 63 => 7285
    return 400 + 85 * (enemyLevel + 4.5 * (enemyLevel - 59))
end

local function ArmorWorthInStamina(health, armor, enemyLevel)
    return health / (10 * (armor + Caps.ArmorConstantForEnemy(enemyLevel)))
end

local function SafeCallNumber(fn, ...)
    if type(fn) ~= "function" then
        return nil
    end
    local ok, val = pcall(fn, ...)
    if ok then
        return ns.PlainNumber(val)
    end
    return nil
end

local function SafeCallMulti(fn, index, ...)
    if type(fn) ~= "function" then
        return nil
    end
    local ok, a, b, c, d = pcall(fn, ...)
    if not ok then
        return nil
    end
    if index == 1 then return ns.PlainNumber(a) end
    if index == 2 then return ns.PlainNumber(b) end
    if index == 3 then return ns.PlainNumber(c) end
    if index == 4 then return ns.PlainNumber(d) end
    return nil
end

------------------------------------------------------------------------
-- Equipped Gear Stat Sum (Fallback & Weapon Subclass Detection)
------------------------------------------------------------------------

local function ReadUnitResistance(schoolIndex, gearFallback)
    if type(_G.UnitResistance) == "function" then
        local ok, base, total, bonus, minus = pcall(_G.UnitResistance, "player", schoolIndex)
        if ok then
            local plainTotal = ns.PlainNumber(total)
            if plainTotal ~= nil then
                return plainTotal
            end
            local plainBase = ns.PlainNumber(base)
            if plainBase ~= nil then
                return math.max(0, plainBase + ns.PlainNumber(bonus, 0) - ns.PlainNumber(minus, 0))
            end
        end
    end
    return gearFallback or 0
end

local function ReadEquippedGearSums()
    local sums = {
        HIT = 0, CRIT = 0, HASTE = 0, EXPERTISE = 0,
        DEFENSE = 0, DODGE = 0, PARRY = 0, BLOCK = 0, BLOCK_VALUE = 0,
        ARMOR = 0, SPIRIT = 0, MP5 = 0, WEAPON_SKILL = 0,
        FIRE_RES = 0, FROST_RES = 0, NATURE_RES = 0, SHADOW_RES = 0, ARCANE_RES = 0,
        skillsBySubclass = {},
        wieldedSubclasses = {},
        dualWielding = false,
    }
    if not ns.Parser then
        return sums
    end

    for slot = 1, 18 do
        local link = ns.PlainText(GetInventoryItemLink and GetInventoryItemLink("player", slot))
        if link then
            local info = ns.Parser:Get(link)
            if info then
                local st = info.currentStats or info.stats
                for k, v in pairs(st) do
                    if type(v) == "number" then
                        sums[k] = (sums[k] or 0) + v
                    end
                end
                if info.skills then
                    for subID, val in pairs(info.skills) do
                        sums.skillsBySubclass[subID] = (sums.skillsBySubclass[subID] or 0) + val
                    end
                end
                if (slot == 16 or slot == 17 or slot == 18) and info.classID == 2 and info.subclassID then
                    sums.wieldedSubclasses[info.subclassID] = true
                    if slot == 17 then
                        sums.dualWielding = true
                    end
                end
            end
        end
    end

    return sums
end

------------------------------------------------------------------------
-- Live Character Stats Snapshot (Cached per ns.generation; zero double-counting)
------------------------------------------------------------------------

local statsCache = nil
local statsGen = nil

function Caps:GetCharacterStats()
    if statsCache and statsGen == ns.generation then
        return statsCache
    end

    local level = math.max(1, math.min(ns.PlainNumber(UnitLevel and UnitLevel("player"), 60), 60))
    local race = select(2, UnitRace("player"))
    local gear = ReadEquippedGearSums()
    local fallbackTalents = (ns.Talents and ns.Talents:GetFallbackSheetBonuses()) or {
        meleeHit = 0, rangedHit = 0, spellHit = 0, defense = 0, expertise = 0, block = 0, parry = 0,
    }

    -- Weapon skill calculation (racial + gear matching active weapons)
    local racialSkills = RACIAL_WEAPON_SKILLS[race] or {}
    local activeWeaponSkill = gear.WEAPON_SKILL
    for subID in pairs(gear.wieldedSubclasses) do
        activeWeaponSkill = activeWeaponSkill + (racialSkills[subID] or 0) + (gear.skillsBySubclass[subID] or 0)
    end
    local weaponSkillHitEquiv = math.min(activeWeaponSkill, 10) * 0.4
    local weaponSkillExpEquiv = math.min(activeWeaponSkill, 15) * 0.2

    -- Hit (Melee, Ranged, Spell): use client API directly without adding passive sheet talents on top
    local crMelee = SafeCallNumber(_G.GetCombatRatingBonus, 6)
    local modMelee = SafeCallNumber(_G.GetHitModifier)
    local hasMeleeAPI = (crMelee ~= nil or modMelee ~= nil)
    local apiMeleeHit = (crMelee or 0) + (modMelee or 0)
    local meleeHit = hasMeleeAPI and apiMeleeHit or (gear.HIT + fallbackTalents.meleeHit)

    local crRanged = SafeCallNumber(_G.GetCombatRatingBonus, 7)
    local modRanged = SafeCallNumber(_G.GetRangedHitModifier)
    local hasRangedAPI = (crRanged ~= nil or modRanged ~= nil)
    local apiRangedHit = (crRanged or 0) + (modRanged or 0)
    local rangedHit = hasRangedAPI and apiRangedHit or meleeHit

    local crSpell = SafeCallNumber(_G.GetCombatRatingBonus, 8)
    local modSpell = SafeCallNumber(_G.GetSpellHitModifier)
    local hasSpellAPI = (crSpell ~= nil or modSpell ~= nil)
    local apiSpellHit = (crSpell or 0) + (modSpell or 0)
    local spellHit = hasSpellAPI and apiSpellHit or (gear.HIT + fallbackTalents.spellHit)

    -- Crit & Haste
    local crit = SafeCallNumber(_G.GetCritChance) or gear.CRIT
    local spellCrit = SafeCallNumber(_G.GetSpellCritChance, 2) or crit
    local haste = SafeCallNumber(_G.GetCombatRatingBonus, 18) or gear.HASTE

    -- Expertise
    local expertise = SafeCallNumber(_G.GetExpertisePercent)
    if not expertise then
        local expRating = SafeCallNumber(_G.GetExpertise)
        if expRating then
            expertise = expRating * 0.25
        else
            expertise = gear.EXPERTISE + fallbackTalents.expertise
        end
    end

    -- Defense (UnitDefense already includes passive Anticipation talent)
    local baseDef, modDef = nil, nil
    if type(_G.UnitDefense) == "function" then
        local ok, b, m = pcall(_G.UnitDefense, "player")
        if ok then
            baseDef = ns.PlainNumber(b)
            modDef = ns.PlainNumber(m)
        end
    end
    local defense
    if baseDef then
        defense = baseDef + (modDef or 0)
    else
        defense = level * 5 + gear.DEFENSE + fallbackTalents.defense
    end

    -- Avoidance: Dodge, Parry, Block (APIs already include passive Shield Spec / Deflection + active auras)
    local dodge = SafeCallNumber(_G.GetDodgeChance) or (5 + gear.DODGE)
    local parry = SafeCallNumber(_G.GetParryChance) or (5 + gear.PARRY + fallbackTalents.parry)
    local block = SafeCallNumber(_G.GetBlockChance) or (5 + gear.BLOCK + fallbackTalents.block)
    local blockValue = SafeCallNumber(_G.GetShieldBlock) or gear.BLOCK_VALUE

    local baseSkillCap = level * 5
    local bonusDef = math.max(0, defense - baseSkillCap)
    local bossMiss = 5.0 + bonusDef * 0.04
    local avoidanceBase = bossMiss + dodge + parry + block

    -- Armor & DR (base display uses +0 enemy or resolved later per scale)
    local armor = SafeCallMulti(_G.UnitArmor, 2, "player") or gear.ARMOR
    local kPlayer = Caps.ArmorConstantForEnemy(level)
    local armorDR = armor > 0 and (armor / (armor + kPlayer) * 100) or 0

    -- Health & Sustain
    local healthMax = SafeCallNumber(_G.UnitHealthMax, "player") or 3000
    local spirit = SafeCallMulti(_G.UnitStat, 2, "player", 5) or gear.SPIRIT
    local intellect = SafeCallMulti(_G.UnitStat, 2, "player", 4) or 0
    local manaRegenCombat = SafeCallMulti(_G.GetManaRegen, 2) or 0
    local mp5 = math.max(gear.MP5, manaRegenCombat * 5)

    -- Magic Resistances (UnitResistance includes gear, enchants, active buffs, flasks & jujus)
    local resistances = {}
    for i = 1, #RESIST_SCHOOLS do
        local sc = RESIST_SCHOOLS[i]
        resistances[sc.key] = ReadUnitResistance(sc.schoolIndex, gear[sc.key])
    end

    statsCache = {
        level = level,
        race = race,
        gear = gear,
        rawAPIs = {
            apiMeleeHit = apiMeleeHit,
            apiRangedHit = apiRangedHit,
            apiSpellHit = apiSpellHit,
        },
        meleeHit = meleeHit,
        rangedHit = rangedHit,
        spellHit = spellHit,
        effectiveMeleeHit = meleeHit + weaponSkillHitEquiv,
        effectiveRangedHit = rangedHit + weaponSkillHitEquiv,
        weaponSkillBonus = activeWeaponSkill,
        weaponSkillHitEquiv = weaponSkillHitEquiv,
        weaponSkillExpEquiv = weaponSkillExpEquiv,
        crit = crit,
        spellCrit = spellCrit,
        haste = haste,
        expertise = expertise,
        effectiveExpertise = expertise + weaponSkillExpEquiv,
        defense = defense,
        bonusDefense = bonusDef,
        dodge = dodge,
        parry = parry,
        block = block,
        blockValue = blockValue,
        bossMiss = bossMiss,
        avoidanceBase = avoidanceBase,
        armor = armor,
        armorDR = armorDR,
        healthMax = healthMax,
        spirit = spirit,
        intellect = intellect,
        mp5 = mp5,
        dualWielding = gear.dualWielding,
        wieldedSubclasses = gear.wieldedSubclasses,
        resistances = resistances,
    }
    statsGen = ns.generation
    return statsCache
end

------------------------------------------------------------------------
-- Piecewise Value Curves f(x)
------------------------------------------------------------------------

function Caps.CurveHit(x, hitCap, isDualWield, dwFactor, dwWhiteCap)
    x = math.max(0, x)
    if not isDualWield then
        return math.min(x, hitCap)
    end
    local whiteCap = math.max(hitCap, dwWhiteCap or 27.0)
    local basePart = math.min(x, hitCap)
    local dwPart = math.max(0, math.min(x, whiteCap) - hitCap) * (dwFactor or 0.4)
    return basePart + dwPart
end

function Caps.CurveDefense(x, defCap)
    return math.min(math.max(0, x), defCap)
end

function Caps.CurveExpertise(x, dodgeCap, isTank, parryCap, tankFactor)
    x = math.max(0, x)
    if not isTank then
        return math.min(x, dodgeCap)
    end
    local pCap = math.max(dodgeCap, parryCap or 14.0)
    local firstPart = math.min(x, dodgeCap)
    local secondPart = math.max(0, math.min(x, pCap) - dodgeCap) * (tankFactor or 0.5)
    return firstPart + secondPart
end

function Caps.CurveArmor(x, armorCap)
    return math.min(math.max(0, x), armorCap)
end

function Caps.CurveBlock(x, blockCap)
    return math.min(math.max(0, x), math.max(0, blockCap))
end

function Caps.CurveResistance(x, resistCap)
    return math.min(math.max(0, x), resistCap)
end

function Caps:GetWeightedResistanceSchools(scale)
    local w = (scale and scale.weights) or {}
    local allRes = math.max(w.ALL_RES or 0, w.AllResist or 0)
    local active = {}
    for i = 1, #RESIST_SCHOOLS do
        local sc = RESIST_SCHOOLS[i]
        local schoolW = w[sc.key] or w[sc.alias] or 0
        if allRes > 0 or schoolW > 0 then
            active[#active + 1] = sc
        end
    end
    return active, (#active > 0)
end

function Caps.CurveSoft(x, softCap, beyondFactor)
    x = math.max(0, x)
    if not softCap or softCap <= 0 then
        return x
    end
    local under = math.min(x, softCap)
    local over = math.max(0, x - softCap) * (beyondFactor or 0.35)
    return under + over
end

------------------------------------------------------------------------
-- Weight Multipliers (Level Scaling, Tank EHP, Caster Weapons, Talents)
------------------------------------------------------------------------

local LEVEL_SCALED_STATS = {
    HIT = true, CRIT = true, EXPERTISE = true, HASTE = true, WEAPON_SKILL = true,
    DEFENSE = true, DODGE = true, PARRY = true, BLOCK = true,
}

function Caps:GetEffectiveWeights(scale, opts)
    local st = self:GetCharacterStats()
    local caps = scale.caps or Caps.DEFAULT_CAPS
    local level = st.level
    local baseWeights = scale.weights or {}

    local weights = {}
    for k, v in pairs(baseWeights) do
        local mapped = RESIST_ALIAS_TO_KEY[k] or k
        weights[mapped] = (weights[mapped] or 0) + v
    end

    if (weights.ALL_RES or 0) > 0 then
        local allW = weights.ALL_RES
        for i = 1, #RESIST_SCHOOLS do
            local rk = RESIST_SCHOOLS[i].key
            weights[rk] = (weights[rk] or 0) + allW
        end
        weights.ALL_RES = nil
    end

    if caps.useTalents ~= false and scale.class == ns.class and scale.specKey and ns.Talents then
        local talentAdds = ns.Talents:GetStatWeightAdditions(scale.class, scale.specKey)
        for statKey, delta in pairs(talentAdds) do
            weights[statKey] = (weights[statKey] or 0) + delta
        end
    end

    local isSpellScale = scale.isSpell or ((weights.SPELL_DAMAGE or 0) >= 0.9) or ((weights.HEALING or 0) >= 0.9)

    local levelShare = 1.0
    if level < 60 then
        levelShare = level / 60
        if isSpellScale then
            levelShare = levelShare * levelShare
        end
    end

    local casterMeleeShare, casterWandShare = 1.0, 1.0
    if isSpellScale then
        local hasWand = st.wieldedSubclasses[19] and true or false
        if level >= 20 or hasWand then
            casterMeleeShare = 0
        else
            casterMeleeShare = math.max(0, (20 - level) / 19)
        end
        local levellingFrac = math.min(math.max((60 - level) / 40, 0), 1)
        casterWandShare = 1 + 1.5 * levellingFrac
    end

    local survivalMult = 1.0
    local armorMult = 1.0
    if scale.isTank and st.healthMax > 0 then
        local targetOffset = self:ResolveTargetOffset(scale, level)
        local enemyLevel = level + targetOffset
        survivalMult = math.min(st.healthMax / ARMOR_TANK_REF_HEALTH, 1.5)
        if st.armor > 0 then
            armorMult = ArmorWorthInStamina(st.healthMax, st.armor, enemyLevel)
                / ArmorWorthInStamina(ARMOR_TANK_REF_HEALTH, ARMOR_TANK_REF_ARMOR, 63)
        end
    end

    local effective = {}
    for statKey, w in pairs(weights) do
        local mult = 1.0
        if LEVEL_SCALED_STATS[statKey] then
            mult = mult * levelShare
        end
        if isSpellScale then
            if statKey == "MELEE_DPS" then
                mult = mult * casterMeleeShare
            elseif statKey == "RANGED_DPS" then
                mult = mult * casterWandShare
            end
        end
        if scale.isTank then
            if statKey == "DODGE" or statKey == "PARRY" or statKey == "BLOCK" or statKey == "DEFENSE" then
                mult = mult * survivalMult
            elseif statKey == "ARMOR" then
                mult = mult * armorMult
            end
        end
        effective[statKey] = w * mult
    end

    return effective
end

------------------------------------------------------------------------
-- Exact Mechanical Target & Cap Resolver
------------------------------------------------------------------------

function Caps:ResolveTargetOffset(scale, level)
    level = level or self:GetCharacterStats().level
    local caps = (scale and scale.caps) or Caps.DEFAULT_CAPS
    local mode = caps.targetMode
    if mode == 0 or mode == 2 or mode == 3 then
        return mode
    end
    return level >= 60 and 3 or 0
end

function Caps:ResolveHitKind(scale)
    local caps = (scale and scale.caps) or Caps.DEFAULT_CAPS
    if caps.hitMode == "melee" then
        return "melee"
    elseif caps.hitMode == "spell" then
        return "spell"
    end

    if caps.tankExpertiseMode == true or (scale and (scale.isTank == true or scale.role == "TANK")) then
        return "melee"
    end

    local w = (scale and scale.weights) or {}
    local cls = (scale and scale.class) or ns.class

    if cls == "WARRIOR" or cls == "ROGUE" then
        return "melee"
    end
    if cls == "HUNTER" then
        if (w.RANGED_DPS or 0) > (w.MELEE_DPS or 0)
            or (w.RANGED_HIT or 0) > 0
            or (w.RANGED_AP or 0) > (w.ATTACK_POWER or 0) then
            return "ranged"
        end
        return "melee"
    end
    if scale and scale.isStarter then
        return scale.isSpell and "spell" or "melee"
    end

    local spellWeight = math.max(
        w.SPELL_DAMAGE or 0,
        w.HEALING or 0,
        w.ARCANE_DAMAGE or 0,
        w.FIRE_DAMAGE or 0,
        w.FROST_DAMAGE or 0,
        w.NATURE_DAMAGE or 0,
        w.SHADOW_DAMAGE or 0,
        w.HOLY_DAMAGE or 0
    )
    local meleeScore = (w.STRENGTH or 0) * 2
        + (w.AGILITY or 0) * 1.5
        + (w.ATTACK_POWER or 0) * 2
        + (w.FERAL_AP or 0) * 2
        + (w.EXPERTISE or 0)
        + (w.WEAPON_SKILL or 0) * 2
        + (w.ARMOR_PEN or 0) * 2
        + (w.DEFENSE or 0) * 3
        + (w.DODGE or 0)
        + (w.PARRY or 0)
        + (w.BLOCK or 0)
        + (w.BLOCK_VALUE or 0) * 2
        + (w.MELEE_DPS or 0)
        + (w.OFFHAND_DPS or 0)

    if cls == "MAGE" or cls == "PRIEST" or cls == "WARLOCK" then
        if meleeScore > 0 and spellWeight == 0 then
            return "melee"
        end
        return "spell"
    end

    -- Hybrid classes (PALADIN, SHAMAN, DRUID): require clear caster dominance for "spell"
    local casterScore = spellWeight * 1.5
        + (w.INTELLECT or 0)
        + (w.SPIRIT or 0)
        + (w.MP5 or 0) * 0.5
        + (w.SPELL_PEN or 0) * 2

    if casterScore > 0 and meleeScore <= casterScore * 0.25 then
        return "spell"
    end
    if meleeScore > casterScore * 0.25 then
        return "melee"
    end
    if (scale and scale.isSpell) or (scale and scale.role == "HEALER") then
        return "spell"
    end
    return "melee"
end

local HIT_CAPS_BY_OFFSET = {
    [0] = { physical = 5.0, spell = 4.0, dwWhite = 24.0 },
    [2] = { physical = 6.0, spell = 6.0, dwWhite = 25.0 },
    [3] = { physical = 8.0, spell = 17.0, dwWhite = 27.0 },
}

local DEFENSE_BONUS_BY_OFFSET = {
    [0] = 125, -- e.g. Level 36 => 305, Level 60 => 425
    [2] = 135, -- e.g. Level 36 => 315, Level 60 => 435
    [3] = 140, -- e.g. Level 36 => 320, Level 60 => 440
}

local AVOIDANCE_CAP_BY_OFFSET = {
    [0] = 100.0,
    [2] = 101.6,
    [3] = 102.4,
}

local EXPERTISE_DODGE_BY_OFFSET = {
    [0] = 5.0,
    [2] = 5.5,
    [3] = 6.5,
}

function Caps:GetResolvedCapsForLevel(scale)
    local st = self:GetCharacterStats()
    local caps = (scale and scale.caps) or Caps.DEFAULT_CAPS
    local level = st.level
    local hitKind = self:ResolveHitKind(scale)
    local targetOffset = self:ResolveTargetOffset(scale, level)
    local enemyLevel = level + targetOffset

    local hitRow = HIT_CAPS_BY_OFFSET[targetOffset] or HIT_CAPS_BY_OFFSET[3]
    local hitHard = hitKind == "spell" and hitRow.spell or hitRow.physical
    local dwSoftCap = (hitKind == "melee") and st.dualWielding or false
    local dwHard = hitRow.dwWhite

    local defBonus = DEFENSE_BONUS_BY_OFFSET[targetOffset] or 140
    local defHard = level * 5 + defBonus

    local expDodge = EXPERTISE_DODGE_BY_OFFSET[targetOffset] or 6.5
    local expTank = (caps.tankExpertiseMode == true) or (scale and scale.isTank == true)
    local expParry = caps.expertiseParryCap or 14.0

    local avoidanceCap = AVOIDANCE_CAP_BY_OFFSET[targetOffset] or 102.4

    local drPct = math.min(99, math.max(1, caps.armorDRCap or 75.0))
    local armorConst = Caps.ArmorConstantForEnemy(enemyLevel)
    local armorHard = (drPct / (100 - drPct)) * armorConst
    local armorDRAtEnemy = st.armor > 0 and (st.armor / (st.armor + armorConst) * 100) or 0

    -- Magic Resistance Hard-Cap: (PlayerLevel + targetOffset) * 5 (e.g. Lv 60: 300 / 310 / 315)
    local resistHard = enemyLevel * 5
    local _, anyResistWeighted = self:GetWeightedResistanceSchools(scale)
    local resistOffsets = {}
    local resistBuffLive = {}
    if (anyResistWeighted or caps.includeRaidResistBuff == true)
        and ns.Talents and ns.Talents.GetRaidResistBuffOffsets then
        resistOffsets, resistBuffLive = ns.Talents:GetRaidResistBuffOffsets(scale)
    end

    -- Active talent & combat buff offsets (never double-counted with live sheet APIs)
    local offsets = { meleeHit = 0, rangedHit = 0, spellHit = 0, block = 0, notes = {} }
    if caps.useTalents ~= false and ns.Talents and ns.Talents.GetProfileOffsets then
        offsets = ns.Talents:GetProfileOffsets(scale, st.gear, st.rawAPIs)
    end

    return {
        targetMode = caps.targetMode or "auto",
        targetOffset = targetOffset,
        enemyLevel = enemyLevel,
        hitKind = hitKind,
        hitHard = hitHard,
        dwSoftCap = dwSoftCap,
        dwBeyond = caps.dwBeyondFactor or 0.4,
        dwHard = dwHard,
        defHard = defHard,
        expDodge = expDodge,
        expTank = expTank,
        expParry = expParry,
        expTankFactor = caps.tankExpertiseFactor or 0.5,
        armorHard = armorHard,
        armorConst = armorConst,
        armorDRAtEnemy = armorDRAtEnemy,
        avoidanceCap = avoidanceCap,
        avoidanceOffset = offsets.block or 0,
        resistHard = resistHard,
        resistOffsets = resistOffsets,
        resistBuffLive = resistBuffLive,
        anyResistWeighted = anyResistWeighted,
        hitOffsets = offsets,
        offsetNotes = offsets.notes or {},
        hasteSoft = caps.hasteSoftCap or 50.0,
        hasteBeyond = caps.hasteBeyondFactor or 0.35,
        spiritTarget = caps.spiritTarget or 0,
        mp5Target = caps.mp5Target or 0,
        sustainBeyond = caps.sustainBeyondFactor or 0.25,
    }
end

------------------------------------------------------------------------
-- Dynamic Delta Evaluation Engine
-- Formula: Effective = f(CharVal - OldItem + NewItem) - f(CharVal - OldItem)
------------------------------------------------------------------------

local function SumReplacedStat(replacedItems, statKey, useCurrent)
    if not replacedItems then
        return 0
    end
    local sum = 0
    for i = 1, #replacedItems do
        local item = replacedItems[i]
        if item then
            local src = (useCurrent and item.currentStats) or item.stats
            if src and src[statKey] then
                sum = sum + src[statKey]
            end
        end
    end
    return sum
end

function Caps:EvaluateItemDelta(newInfo, replacedItems, scale, opts)
    opts = opts or {}
    local useCurrent = opts.useCurrent or false
    local hand = opts.hand or "main"
    local ignoreCaps = opts.ignoreCaps or (scale.caps and scale.caps.enableCaps == false)

    local itemStats = (useCurrent and newInfo.currentStats) or newInfo.stats or {}
    local itemDps = (useCurrent and newInfo.currentDps) or newInfo.dps
    local itemHit = (useCurrent and newInfo.currentHit) or newInfo.hit
    local itemSpeed = (useCurrent and newInfo.currentSpeed) or newInfo.speed
    local itemSkills = (useCurrent and newInfo.currentSkills) or newInfo.skills

    if replacedItems == nil and opts.allowSelfSubtract ~= false and ns.Upgrades and ns.Upgrades:IsWorn(newInfo.link) then
        replacedItems = { newInfo }
    end

    local weights = self:GetEffectiveWeights(scale, opts)
    local st = self:GetCharacterStats()
    local rc = self:GetResolvedCapsForLevel(scale)

    local totalScore = 0
    local rawScore = 0
    local contributions = {}

    -- Precompute avoidance baseline (without old item(s)) for combat-table rule
    local oldDef = SumReplacedStat(replacedItems, "DEFENSE", useCurrent)
    local oldDodge = SumReplacedStat(replacedItems, "DODGE", useCurrent)
    local oldParry = SumReplacedStat(replacedItems, "PARRY", useCurrent)
    local oldBlock = SumReplacedStat(replacedItems, "BLOCK", useCurrent)

    local newDef = itemStats.DEFENSE or 0
    local newDodge = itemStats.DODGE or 0
    local newParry = itemStats.PARRY or 0

    local baseDefWithoutOld = math.max(0, st.defense - oldDef)
    local baseDodgeWithoutOld = math.max(0, st.dodge - oldDodge)
    local baseParryWithoutOld = math.max(0, st.parry - oldParry)
    local baseBlockWithoutOld = math.max(0, st.block - oldBlock)

    -- Compute non-block avoidance after equipping newInfo (Dodge and Parry keep their full value!)
    local bonusDefAfterNew = math.max(0, (baseDefWithoutOld + newDef) - (st.level * 5))
    local missAfterNew = 5.0 + bonusDefAfterNew * 0.04
    local dodgeAfterNew = baseDodgeWithoutOld + newDodge + newDef * 0.04
    local parryAfterNew = baseParryWithoutOld + newParry + newDef * 0.04
    local nonBlockAvoidanceAfterNew = missAfterNew + dodgeAfterNew + parryAfterNew + rc.avoidanceOffset
    local blockRoomCap = math.max(0, rc.avoidanceCap - nonBlockAvoidanceAfterNew)

    for statKey, rawAmount in pairs(itemStats) do
        local weight = weights[statKey]
        if weight and weight ~= 0 and rawAmount ~= 0 then
            local oldVal = SumReplacedStat(replacedItems, statKey, useCurrent)
            local effAmount = rawAmount
            local capped = false

            if not ignoreCaps then
                if statKey == "HIT" then
                    local charHit
                    if rc.hitKind == "spell" then
                        charHit = st.spellHit + (rc.hitOffsets.spellHit or 0)
                    elseif rc.hitKind == "ranged" then
                        charHit = st.effectiveRangedHit + (rc.hitOffsets.rangedHit or 0)
                    else
                        charHit = st.effectiveMeleeHit + (rc.hitOffsets.meleeHit or 0)
                    end
                    local base = math.max(0, charHit - oldVal)
                    effAmount = Caps.CurveHit(base + rawAmount, rc.hitHard, rc.dwSoftCap, rc.dwBeyond, rc.dwHard)
                        - Caps.CurveHit(base, rc.hitHard, rc.dwSoftCap, rc.dwBeyond, rc.dwHard)
                    capped = effAmount < rawAmount - 0.001
                elseif statKey == "DEFENSE" then
                    local base = baseDefWithoutOld
                    effAmount = Caps.CurveDefense(base + rawAmount, rc.defHard)
                        - Caps.CurveDefense(base, rc.defHard)
                    capped = effAmount < rawAmount - 0.001
                elseif statKey == "EXPERTISE" then
                    local base = math.max(0, st.effectiveExpertise - oldVal)
                    effAmount = Caps.CurveExpertise(base + rawAmount, rc.expDodge, rc.expTank, rc.expParry, rc.expTankFactor)
                        - Caps.CurveExpertise(base, rc.expDodge, rc.expTank, rc.expParry, rc.expTankFactor)
                    capped = effAmount < rawAmount - 0.001
                elseif statKey == "ARMOR" then
                    local base = math.max(0, st.armor - oldVal)
                    effAmount = Caps.CurveArmor(base + rawAmount, rc.armorHard)
                        - Caps.CurveArmor(base, rc.armorHard)
                    capped = effAmount < rawAmount - 0.001
                elseif statKey == "BLOCK" then
                    effAmount = Caps.CurveBlock(baseBlockWithoutOld + rawAmount, blockRoomCap)
                        - Caps.CurveBlock(baseBlockWithoutOld, blockRoomCap)
                    capped = effAmount < rawAmount - 0.001
                elseif statKey == "HASTE" then
                    local base = math.max(0, st.haste - oldVal)
                    effAmount = Caps.CurveSoft(base + rawAmount, rc.hasteSoft, rc.hasteBeyond)
                        - Caps.CurveSoft(base, rc.hasteSoft, rc.hasteBeyond)
                    capped = effAmount < rawAmount - 0.001
                elseif statKey == "SPIRIT" and rc.spiritTarget > 0 then
                    local base = math.max(0, st.spirit - oldVal)
                    effAmount = Caps.CurveSoft(base + rawAmount, rc.spiritTarget, rc.sustainBeyond)
                        - Caps.CurveSoft(base, rc.spiritTarget, rc.sustainBeyond)
                    capped = effAmount < rawAmount - 0.001
                elseif statKey == "MP5" and rc.mp5Target > 0 then
                    local base = math.max(0, st.mp5 - oldVal)
                    effAmount = Caps.CurveSoft(base + rawAmount, rc.mp5Target, rc.sustainBeyond)
                        - Caps.CurveSoft(base, rc.mp5Target, rc.sustainBeyond)
                    capped = effAmount < rawAmount - 0.001
                elseif RESIST_KEY_SET[statKey] then
                    local charRes = ((st.resistances and st.resistances[statKey]) or 0)
                        + ((rc.resistOffsets and rc.resistOffsets[statKey]) or 0)
                    local base = math.max(0, charRes - oldVal)
                    effAmount = Caps.CurveResistance(base + rawAmount, rc.resistHard)
                        - Caps.CurveResistance(base, rc.resistHard)
                    capped = effAmount < rawAmount - 0.001
                end
            end

            local rawEP = rawAmount * weight
            local effEP = effAmount * weight
            rawScore = rawScore + rawEP
            totalScore = totalScore + effEP
            contributions[statKey] = {
                rawAmount = rawAmount,
                effectiveAmount = effAmount,
                weight = weight,
                rawEP = rawEP,
                effectiveEP = effEP,
                capped = capped,
            }
        end
    end

    if itemDps and itemDps > 0 then
        local dpsKey = newInfo.ranged and "RANGED_DPS" or (hand == "off" and "OFFHAND_DPS" or "MELEE_DPS")
        local w = weights[dpsKey] or 0
        if w ~= 0 then
            local ep = itemDps * w
            rawScore = rawScore + ep
            totalScore = totalScore + ep
            contributions[dpsKey] = { rawAmount = itemDps, effectiveAmount = itemDps, weight = w, rawEP = ep, effectiveEP = ep, capped = false }
        end
    end

    if itemHit and itemHit > 0 and hand ~= "off" then
        local hitKey = newInfo.ranged and "RANGED_HIT" or "MELEE_HIT"
        local w = weights[hitKey] or 0
        if w ~= 0 then
            local ep = itemHit * w
            rawScore = rawScore + ep
            totalScore = totalScore + ep
            contributions[hitKey] = { rawAmount = itemHit, effectiveAmount = itemHit, weight = w, rawEP = ep, effectiveEP = ep, capped = false }
        end
    end

    if itemSpeed and itemSpeed > 0 and itemDps then
        local spdKey = newInfo.ranged and "RANGED_SPEED" or (hand == "off" and "OFFHAND_SPEED" or "MELEE_SPEED")
        local w = weights[spdKey] or 0
        if w ~= 0 then
            local baseline = weights.SPEED_BASELINE or 0
            local deltaSpd = itemSpeed - baseline
            local ep = deltaSpd * w
            rawScore = rawScore + ep
            totalScore = totalScore + ep
            contributions[spdKey] = { rawAmount = deltaSpd, effectiveAmount = deltaSpd, weight = w, rawEP = ep, effectiveEP = ep, capped = false }
        end
    end

    if itemSkills and weights.WEAPON_SKILL and weights.WEAPON_SKILL ~= 0 then
        local w = weights.WEAPON_SKILL
        for subID, val in pairs(itemSkills) do
            if st.wieldedSubclasses[subID] or (newInfo.classID == 2 and newInfo.subclassID == subID) then
                local ep = val * w
                rawScore = rawScore + ep
                totalScore = totalScore + ep
                contributions.WEAPON_SKILL = {
                    rawAmount = val,
                    effectiveAmount = val,
                    weight = w,
                    rawEP = ep,
                    effectiveEP = ep,
                    capped = false,
                }
            end
        end
    end

    local normFactor = scale.normalizeFactor
    if normFactor and normFactor > 0 then
        local sumPos = 0
        for _, weightVal in pairs(weights) do
            if type(weightVal) == "number" and weightVal > 0 then
                sumPos = sumPos + weightVal
            end
        end
        if sumPos > 0 then
            local scaleMult = normFactor / sumPos
            rawScore = rawScore * scaleMult
            totalScore = totalScore * scaleMult
        end
    end

    return {
        totalScore = totalScore,
        rawScore = rawScore,
        contributions = contributions,
        anyCapped = (rawScore - totalScore) > 0.05,
    }
end

------------------------------------------------------------------------
-- Live Cap Status Summary for UI Tab 3 ("Caps & Dynamik")
------------------------------------------------------------------------

function Caps:GetLiveCapStatus(scale)
    local st = self:GetCharacterStats()
    local rc = self:GetResolvedCapsForLevel(scale)
    local rows = {}

    local function StatusState(current, capZero, capReduced)
        if capZero and current >= capZero - 0.001 then
            return "HARD", L["Cap reached (weight = 0)"]
        elseif capReduced and current >= capReduced - 0.001 then
            return "SOFT", L["Cap reached (reduced)"]
        end
        return "UNDER", L["Under cap"]
    end

    -- Hit / Spell Hit
    local hitCurrent
    local hitLabel
    if rc.hitKind == "spell" then
        hitCurrent = st.spellHit + (rc.hitOffsets.spellHit or 0)
        hitLabel = L["Spell hit cap (%)"]
    elseif rc.hitKind == "ranged" then
        hitCurrent = st.effectiveRangedHit + (rc.hitOffsets.rangedHit or 0)
        hitLabel = L["Hit cap (%)"]
    else
        hitCurrent = st.effectiveMeleeHit + (rc.hitOffsets.meleeHit or 0)
        hitLabel = L["Hit cap (%)"]
    end

    local hitState, hitText = StatusState(
        hitCurrent,
        rc.dwSoftCap and rc.dwHard or rc.hitHard,
        rc.dwSoftCap and rc.hitHard or nil
    )
    local hitDetails = {}
    if st.weaponSkillBonus > 0 then
        hitDetails[#hitDetails + 1] = ("WeaponSkill +%d"):format(st.weaponSkillBonus)
    end
    if rc.dwSoftCap then
        hitDetails[#hitDetails + 1] = ("Dual Wield -> %.0f%%"):format(rc.dwHard)
    end
    rows[#rows + 1] = {
        key = "HIT",
        label = hitLabel,
        current = hitCurrent,
        cap = rc.dwSoftCap and rc.dwHard or rc.hitHard,
        primaryCap = rc.hitHard,
        unit = "%",
        state = hitState,
        statusText = hitText,
        detail = #hitDetails > 0 and table.concat(hitDetails, " | ") or nil,
    }

    -- Defense (Crit immune)
    local defState, defText = StatusState(st.defense, rc.defHard)
    rows[#rows + 1] = {
        key = "DEFENSE",
        label = L["Defense (Crit immune)"],
        current = st.defense,
        cap = rc.defHard,
        unit = "",
        state = defState,
        statusText = defText,
        detail = ("%d * 5 + %d"):format(st.level, rc.defHard - st.level * 5),
    }

    -- Expertise
    local expState, expText = StatusState(
        st.effectiveExpertise,
        rc.expTank and rc.expParry or rc.expDodge,
        rc.expTank and rc.expDodge or nil
    )
    rows[#rows + 1] = {
        key = "EXPERTISE",
        label = L["Expertise cap (%)"],
        current = st.effectiveExpertise,
        cap = rc.expTank and rc.expParry or rc.expDodge,
        unit = "%",
        state = expState,
        statusText = expText,
    }

    -- Armor DR (75%)
    local armorCapPct = (scale.caps and scale.caps.armorDRCap) or 75.0
    local armorState, armorText = StatusState(rc.armorDRAtEnemy, armorCapPct)
    rows[#rows + 1] = {
        key = "ARMOR",
        label = L["Armor cap (75% DR)"],
        current = rc.armorDRAtEnemy,
        cap = armorCapPct,
        unit = "%",
        state = armorState,
        statusText = armorText,
        detail = ("%d / %d Armor"):format(st.armor, math.floor(rc.armorHard)),
    }

    -- Avoidance (Uncrushable / Combat-Table sum)
    local totalAvoidWithOffset = st.avoidanceBase + rc.avoidanceOffset
    local avoidState, avoidText = StatusState(totalAvoidWithOffset, rc.avoidanceCap)
    local avoidDetail
    if (rc.avoidanceOffset or 0) > 0 then
        avoidDetail = (L["Avoidance detail offset format"]):format(
            st.bossMiss, st.dodge, st.parry, st.block, rc.avoidanceOffset
        )
    else
        avoidDetail = (L["Avoidance detail format"]):format(
            st.bossMiss, st.dodge, st.parry, st.block
        )
    end
    rows[#rows + 1] = {
        key = "BLOCK",
        label = L["Avoidance (Uncrushable)"],
        current = totalAvoidWithOffset,
        cap = rc.avoidanceCap,
        unit = "%",
        state = avoidState,
        statusText = avoidText,
        detail = avoidDetail,
    }

    -- Haste GCD Cap (50%)
    local hasteState, hasteText = StatusState(st.haste, nil, rc.hasteSoft)
    rows[#rows + 1] = {
        key = "HASTE",
        label = L["Haste cap (GCD)"],
        current = st.haste,
        cap = rc.hasteSoft,
        unit = "%",
        state = hasteState,
        statusText = hasteText,
    }

    -- Optional Sustain Target (Spirit)
    if rc.spiritTarget > 0 then
        local spState, spText = StatusState(st.spirit, nil, rc.spiritTarget)
        rows[#rows + 1] = {
            key = "SPIRIT",
            label = L["Spirit"],
            current = st.spirit,
            cap = rc.spiritTarget,
            unit = "",
            state = spState,
            statusText = spText,
        }
    end

    -- Weighted Magic Resistances (only schools weighted > 0, or all 5 when ALL_RES > 0)
    if rc.anyResistWeighted then
        local activeRes = self:GetWeightedResistanceSchools(scale)
        for i = 1, #activeRes do
            local school = activeRes[i]
            local rawRes = (st.resistances and st.resistances[school.key]) or 0
            local offset = (rc.resistOffsets and rc.resistOffsets[school.key]) or 0
            local isLiveBuff = (rc.resistBuffLive and rc.resistBuffLive[school.key]) or false
            local effectiveRes = rawRes + offset
            local rState, rText = StatusState(effectiveRes, rc.resistHard)
            local rDetail
            if isLiveBuff then
                rDetail = "Raid-Buff +60 (live)"
            elseif offset > 0 then
                rDetail = ("%d + %d Raid-Buff"):format(math.floor(rawRes + 0.5), offset)
            else
                rDetail = ("%d * 5 (75%% DR)"):format(rc.enemyLevel)
            end
            rows[#rows + 1] = {
                key = school.key,
                isResistance = true,
                label = L[school.labelKey],
                rawCurrent = rawRes,
                offset = offset,
                current = effectiveRes,
                cap = rc.resistHard,
                unit = "",
                state = rState,
                statusText = rText,
                detail = rDetail,
            }
        end
    end

    return rows, st, rc
end
