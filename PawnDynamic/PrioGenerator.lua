-- PawnDynamic (MIT License)
-- Stat-Priority-to-Weight Generator with WoW Classic Forever item-budget factors & attribute synergies.

local _, ns = ...

local PrioGen = ns:NewModule("PrioGenerator")
local L = ns.L

------------------------------------------------------------------------
-- Roles & Class Filtering
------------------------------------------------------------------------

PrioGen.ROLES = {
    "TANK",
    "MELEE",
    "RANGED",
    "CASTER",
    "HEALER",
}

PrioGen.ROLE_LABELS = {
    TANK = "Tank",
    MELEE = "Melee DPS",
    RANGED = "Ranged DPS",
    CASTER = "Caster DPS",
    HEALER = "Healer",
}

PrioGen.CLASS_ROLES = {
    WARRIOR = { "TANK", "MELEE" },
    PALADIN = { "TANK", "MELEE", "HEALER" },
    HUNTER  = { "RANGED", "MELEE" },
    ROGUE   = { "MELEE" },
    PRIEST  = { "HEALER", "CASTER" },
    SHAMAN  = { "CASTER", "MELEE", "HEALER" },
    MAGE    = { "CASTER" },
    WARLOCK = { "CASTER" },
    DRUID   = { "TANK", "MELEE", "CASTER", "HEALER" },
}

local SHIELD_CLASSES = {
    WARRIOR = true,
    PALADIN = true,
    SHAMAN = true,
}

local MANA_CLASSES = {
    PALADIN = true,
    HUNTER = true,
    PRIEST = true,
    SHAMAN = true,
    MAGE = true,
    WARLOCK = true,
    DRUID = true,
}

function PrioGen:GetValidRolesForClass(classToken)
    classToken = classToken or ns.class or "WARRIOR"
    local src = self.CLASS_ROLES[classToken] or { "MELEE" }
    local out = {}
    for i = 1, #src do
        out[i] = src[i]
    end
    return out
end

function PrioGen:IsRoleValidForClass(classToken, role)
    local list = self.CLASS_ROLES[classToken or ns.class]
    if not list then
        return false
    end
    for i = 1, #list do
        if list[i] == role then
            return true
        end
    end
    return false
end

function PrioGen:GetDefaultRoleForClass(classToken, selectedScale)
    classToken = classToken or ns.class or "WARRIOR"
    if selectedScale and selectedScale.class == classToken then
        if selectedScale.isTank or selectedScale.role == "TANK" then
            if self:IsRoleValidForClass(classToken, "TANK") then
                return "TANK"
            end
        elseif selectedScale.role == "HEALER" then
            if self:IsRoleValidForClass(classToken, "HEALER") then
                return "HEALER"
            end
        elseif selectedScale.isSpell then
            if self:IsRoleValidForClass(classToken, "CASTER") then
                return "CASTER"
            end
        elseif classToken == "HUNTER" then
            local w = selectedScale.weights or {}
            if (w.MELEE_DPS or 0) > (w.RANGED_DPS or 0) then
                return "MELEE"
            end
            return "RANGED"
        elseif self:IsRoleValidForClass(classToken, "MELEE") then
            return "MELEE"
        end
    end
    local roles = self.CLASS_ROLES[classToken]
    return (roles and roles[1]) or "MELEE"
end

------------------------------------------------------------------------
-- WoW Classic Forever Item-Budget Base Factors & Aliases
------------------------------------------------------------------------

PrioGen.STAT_BUDGET_BASE = {
    STAMINA       = 1.0,
    STRENGTH      = 1.0,
    AGILITY       = 1.0,
    INTELLECT     = 1.0,
    SPIRIT        = 1.0,
    ARMOR         = 0.08,
    DEFENSE       = 1.5,
    DODGE         = 12.0,
    PARRY         = 13.0,
    BLOCK         = 5.0,
    BLOCK_VALUE   = 0.65,
    HP5           = 0.4,
    RESILIENCE    = 1.0,

    HIT           = 12.0,
    CRIT          = 11.0,
    HASTE         = 10.0,
    EXPERTISE     = 11.0,
    WEAPON_SKILL  = 3.0,
    ARMOR_PEN     = 0.35,

    ATTACK_POWER  = 0.5,
    RANGED_AP     = 0.5,
    FERAL_AP      = 0.5,
    MELEE_DPS     = 5.5,
    MELEE_HIT     = 1.0,
    OFFHAND_DPS   = 3.5,
    RANGED_DPS    = 3.5,
    RANGED_HIT    = 0.9,

    SPELL_DAMAGE  = 0.85,
    HEALING       = 0.45,
    MP5           = 2.5,
    SPELL_PEN     = 0.25,

    ARCANE_DAMAGE = 0.85,
    FIRE_DAMAGE   = 0.85,
    FROST_DAMAGE  = 0.85,
    NATURE_DAMAGE = 0.85,
    SHADOW_DAMAGE = 0.85,
    HOLY_DAMAGE   = 0.85,

    ALL_RES       = 1.0,
    FIRE_RES      = 1.0,
    FROST_RES     = 1.0,
    NATURE_RES    = 1.0,
    SHADOW_RES    = 1.0,
    ARCANE_RES    = 1.0,
}

local STAT_ALIASES = {
    AP = "ATTACK_POWER",
    RAP = "RANGED_AP",
    SPELL_DMG = "SPELL_DAMAGE",
    WEAPON_DPS = "MELEE_DPS",
}

local CLASS_SPELL_SCHOOLS = {
    MAGE    = { "ARCANE_DAMAGE", "FIRE_DAMAGE", "FROST_DAMAGE" },
    WARLOCK = { "SHADOW_DAMAGE", "FIRE_DAMAGE" },
    PRIEST  = { "SHADOW_DAMAGE", "HOLY_DAMAGE" },
    SHAMAN  = { "NATURE_DAMAGE", "FIRE_DAMAGE" },
    DRUID   = { "ARCANE_DAMAGE", "NATURE_DAMAGE" },
    PALADIN = { "HOLY_DAMAGE" },
}

local DUAL_WIELD_MELEE = {
    WARRIOR = true,
    ROGUE = true,
    SHAMAN = true,
    HUNTER = true,
}

local RANGED_STAT_CLASSES = {
    WARRIOR = true,
    ROGUE = true,
    HUNTER = true,
}

local WAND_CLASSES = {
    MAGE = true,
    WARLOCK = true,
    PRIEST = true,
}

local RESIST_KEYS = {
    "ALL_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES", "ARCANE_RES",
}

function PrioGen.NormalizeStatKey(key)
    return STAT_ALIASES[key] or key
end

------------------------------------------------------------------------
-- Available Stats Filtering (Strictly excludes irrelevant stats per Class & Role)
------------------------------------------------------------------------

function PrioGen:GetAvailableStats(classToken, role)
    classToken = classToken or ns.class or "WARRIOR"
    if not self:IsRoleValidForClass(classToken, role) then
        role = self:GetDefaultRoleForClass(classToken)
    end

    local ordered = {}
    local allowed = {}

    local function AddStat(statKey)
        statKey = PrioGen.NormalizeStatKey(statKey)
        if not allowed[statKey] and PrioGen.STAT_BUDGET_BASE[statKey] then
            allowed[statKey] = true
            ordered[#ordered + 1] = statKey
        end
    end

    if role == "TANK" then
        AddStat("STAMINA")
        AddStat("ARMOR")
        AddStat("DEFENSE")
        AddStat("DODGE")
        if SHIELD_CLASSES[classToken] then
            AddStat("PARRY")
            AddStat("BLOCK")
            AddStat("BLOCK_VALUE")
        end
        AddStat("HIT")
        AddStat("EXPERTISE")
        if classToken ~= "DRUID" then
            AddStat("WEAPON_SKILL")
        end
        AddStat("AGILITY")
        AddStat("STRENGTH")
        AddStat("ATTACK_POWER")
        if classToken == "DRUID" then
            AddStat("FERAL_AP")
        end
        AddStat("CRIT")
        AddStat("HASTE")
        AddStat("MELEE_DPS")
        if classToken ~= "DRUID" then
            AddStat("MELEE_HIT")
        end
        if classToken == "WARRIOR" then
            AddStat("RANGED_DPS")
        end
        AddStat("ARMOR_PEN")
        AddStat("HP5")
        if classToken == "PALADIN" then
            AddStat("SPELL_DAMAGE")
            AddStat("HOLY_DAMAGE")
            AddStat("INTELLECT")
            AddStat("MP5")
            AddStat("SPIRIT")
        end
    elseif role == "MELEE" then
        AddStat("MELEE_DPS")
        if classToken ~= "DRUID" then
            AddStat("MELEE_HIT")
        end
        if DUAL_WIELD_MELEE[classToken] then
            AddStat("OFFHAND_DPS")
        end
        AddStat("HIT")
        AddStat("EXPERTISE")
        if classToken ~= "DRUID" then
            AddStat("WEAPON_SKILL")
        end
        AddStat("CRIT")
        AddStat("HASTE")
        AddStat("ATTACK_POWER")
        if classToken == "DRUID" then
            AddStat("FERAL_AP")
        end
        AddStat("STRENGTH")
        AddStat("AGILITY")
        AddStat("STAMINA")
        AddStat("ARMOR_PEN")
        AddStat("ARMOR")
        if RANGED_STAT_CLASSES[classToken] then
            AddStat("RANGED_DPS")
            AddStat("RANGED_AP")
        end
        if MANA_CLASSES[classToken] then
            AddStat("INTELLECT")
            AddStat("MP5")
            AddStat("SPIRIT")
        end
        if classToken == "PALADIN" or classToken == "SHAMAN" then
            AddStat("SPELL_DAMAGE")
            local schools = CLASS_SPELL_SCHOOLS[classToken]
            if schools then
                for i = 1, #schools do
                    AddStat(schools[i])
                end
            end
        end
    elseif role == "RANGED" then
        AddStat("RANGED_DPS")
        AddStat("RANGED_HIT")
        AddStat("HIT")
        AddStat("CRIT")
        AddStat("HASTE")
        AddStat("AGILITY")
        AddStat("RANGED_AP")
        AddStat("ATTACK_POWER")
        AddStat("MELEE_DPS")
        AddStat("OFFHAND_DPS")
        AddStat("STRENGTH")
        AddStat("INTELLECT")
        AddStat("STAMINA")
        AddStat("MP5")
        AddStat("SPIRIT")
        AddStat("ARMOR_PEN")
        AddStat("ARMOR")
    elseif role == "CASTER" then
        AddStat("SPELL_DAMAGE")
        local schools = CLASS_SPELL_SCHOOLS[classToken]
        if schools then
            for i = 1, #schools do
                AddStat(schools[i])
            end
        end
        AddStat("HIT")
        AddStat("CRIT")
        AddStat("HASTE")
        AddStat("INTELLECT")
        AddStat("SPIRIT")
        AddStat("MP5")
        AddStat("SPELL_PEN")
        AddStat("STAMINA")
        if classToken == "WARLOCK" then
            AddStat("HP5")
        end
        if WAND_CLASSES[classToken] then
            AddStat("RANGED_DPS")
        end
        AddStat("ARMOR")
    elseif role == "HEALER" then
        AddStat("HEALING")
        AddStat("SPELL_DAMAGE")
        AddStat("MP5")
        AddStat("INTELLECT")
        AddStat("SPIRIT")
        AddStat("CRIT")
        AddStat("HASTE")
        AddStat("STAMINA")
        AddStat("ARMOR")
        if WAND_CLASSES[classToken] then
            AddStat("RANGED_DPS")
        end
    end

    for i = 1, #RESIST_KEYS do
        AddStat(RESIST_KEYS[i])
    end

    return ordered, allowed
end

------------------------------------------------------------------------
-- Curated Default Priority Lists per Class & Role
------------------------------------------------------------------------

function PrioGen:GetDefaultPrioList(classToken, role)
    classToken = classToken or ns.class or "WARRIOR"
    if not self:IsRoleValidForClass(classToken, role) then
        role = self:GetDefaultRoleForClass(classToken)
    end

    if role == "TANK" then
        if classToken == "DRUID" then
            return { "STAMINA", "ARMOR", "DEFENSE", "DODGE", "AGILITY", "HIT", "EXPERTISE", "STRENGTH", "FERAL_AP", "CRIT" }
        elseif classToken == "PALADIN" then
            return { "STAMINA", "DEFENSE", "ARMOR", "DODGE", "PARRY", "BLOCK", "BLOCK_VALUE", "SPELL_DAMAGE", "HIT", "INTELLECT" }
        else
            return { "STAMINA", "DEFENSE", "ARMOR", "DODGE", "PARRY", "HIT", "EXPERTISE", "WEAPON_SKILL", "BLOCK", "STRENGTH" }
        end
    elseif role == "MELEE" then
        if classToken == "ROGUE" or classToken == "HUNTER" then
            return { "MELEE_DPS", "HIT", "EXPERTISE", "CRIT", "AGILITY", "ATTACK_POWER", "HASTE", "STRENGTH", "STAMINA" }
        elseif classToken == "DRUID" then
            return { "STRENGTH", "AGILITY", "HIT", "CRIT", "EXPERTISE", "FERAL_AP", "ATTACK_POWER", "HASTE", "STAMINA" }
        else
            return { "MELEE_DPS", "HIT", "EXPERTISE", "CRIT", "STRENGTH", "ATTACK_POWER", "HASTE", "AGILITY", "STAMINA" }
        end
    elseif role == "RANGED" then
        return { "RANGED_DPS", "HIT", "AGILITY", "CRIT", "RANGED_AP", "ATTACK_POWER", "HASTE", "INTELLECT", "STAMINA" }
    elseif role == "CASTER" then
        local list = { "SPELL_DAMAGE", "HIT", "CRIT", "HASTE", "INTELLECT", "SPIRIT", "MP5", "STAMINA" }
        local schools = CLASS_SPELL_SCHOOLS[classToken]
        if schools and schools[1] then
            table.insert(list, 2, schools[1])
        end
        return list
    elseif role == "HEALER" then
        if classToken == "PALADIN" then
            return { "HEALING", "CRIT", "INTELLECT", "MP5", "HASTE", "SPIRIT", "STAMINA" }
        end
        return { "HEALING", "MP5", "SPIRIT", "INTELLECT", "CRIT", "HASTE", "STAMINA" }
    end

    return { "STAMINA" }
end

------------------------------------------------------------------------
-- Dynamic Rank Curve & Synergy Weight Calculator
------------------------------------------------------------------------

-- Smooth curve from 1.00 (rank 1) down to 0.15 (rank N), supporting 17+ entries cleanly.
function PrioGen.GetRankMultiplier(rankIndex, totalCount)
    if not rankIndex or rankIndex <= 1 or not totalCount or totalCount <= 1 then
        return 1.0
    end
    local t = math.min(1, math.max(0, (rankIndex - 1) / (totalCount - 1)))
    return 0.15 + 0.85 * ((1 - t) ^ 1.15)
end

local function RoundWeight(v)
    if not v or v ~= v or v == math.huge or v == -math.huge or v <= 0 then
        return 0
    end
    return math.floor(v * 1000 + 0.5) / 1000
end

local AGI_PER_DODGE = {
    ROGUE = 14.5,
    HUNTER = 26.5,
}

local AGI_PER_CRIT = {
    ROGUE = 29.0,
    HUNTER = 53.0,
}

local AP_PER_STR = {
    ROGUE = 1.0,
    HUNTER = 1.0,
}

local function GetMandatoryStats(classToken, role)
    if role == "TANK" then
        return { "STAMINA", "DEFENSE", "ARMOR", "HIT" }
    elseif role == "MELEE" then
        local prim = (classToken == "ROGUE" or classToken == "HUNTER") and "AGILITY" or "STRENGTH"
        return { "HIT", "MELEE_DPS", prim }
    elseif role == "RANGED" then
        return { "HIT", "RANGED_DPS", "AGILITY" }
    elseif role == "CASTER" then
        return { "HIT", "SPELL_DAMAGE", "INTELLECT" }
    elseif role == "HEALER" then
        return { "HEALING", "INTELLECT", "MP5", "SPIRIT" }
    end
    return {}
end

function PrioGen:CalculateWeights(classToken, role, prioList)
    classToken = classToken or ns.class or "WARRIOR"
    if not self:IsRoleValidForClass(classToken, role) then
        role = self:GetDefaultRoleForClass(classToken)
    end

    local _, allowedSet = self:GetAvailableStats(classToken, role)

    -- Deduplicate prioList while filtering strictly to allowedSet
    local cleanPrio = {}
    local seen = {}
    if type(prioList) == "table" then
        for i = 1, #prioList do
            local sk = PrioGen.NormalizeStatKey(prioList[i])
            if sk and allowedSet[sk] and not seen[sk] then
                seen[sk] = true
                cleanPrio[#cleanPrio + 1] = sk
            end
        end
    end

    local N = #cleanPrio
    local baseWeights = {}
    local rankOf = {}
    for idx = 1, N do
        local sk = cleanPrio[idx]
        local mult = PrioGen.GetRankMultiplier(idx, N)
        local baseFactor = PrioGen.STAT_BUDGET_BASE[sk] or 1.0
        baseWeights[sk] = baseFactor * mult
        rankOf[sk] = idx
    end

    -- Automatic Primary Attribute Synergies from derived stats (Classic Forever class formulas)
    local syn = {
        AGILITY = 0,
        STRENGTH = 0,
        INTELLECT = 0,
    }

    if (baseWeights.ARMOR or 0) > 0 then
        -- 1 Agility = 2 Armor in Classic Forever
        syn.AGILITY = syn.AGILITY + 2.0 * baseWeights.ARMOR
    end
    if (baseWeights.DODGE or 0) > 0 then
        local agiPerDodge = AGI_PER_DODGE[classToken] or 20.0
        syn.AGILITY = syn.AGILITY + baseWeights.DODGE / agiPerDodge
    end
    if (baseWeights.CRIT or 0) > 0 then
        if role == "CASTER" or role == "HEALER" then
            -- ~59.5 Intellect = 1% Spell Crit
            syn.INTELLECT = syn.INTELLECT + baseWeights.CRIT / 59.5
        else
            local agiPerCrit = AGI_PER_CRIT[classToken] or 20.0
            syn.AGILITY = syn.AGILITY + baseWeights.CRIT / agiPerCrit
        end
    end

    local apWeight = (baseWeights.ATTACK_POWER or 0) + (baseWeights.FERAL_AP or 0)
    if apWeight > 0 then
        local apPerStr = AP_PER_STR[classToken] or 2.0
        syn.STRENGTH = syn.STRENGTH + apPerStr * apWeight
        if classToken == "ROGUE" or classToken == "HUNTER" or (classToken == "DRUID" and role == "MELEE") then
            syn.AGILITY = syn.AGILITY + 1.0 * (baseWeights.ATTACK_POWER or 0)
        end
    end
    if (baseWeights.RANGED_AP or 0) > 0 and classToken == "HUNTER" then
        syn.AGILITY = syn.AGILITY + 2.0 * baseWeights.RANGED_AP
    end
    if (baseWeights.BLOCK_VALUE or 0) > 0 and SHIELD_CLASSES[classToken] then
        -- 20 Strength = 1 Block Value
        syn.STRENGTH = syn.STRENGTH + baseWeights.BLOCK_VALUE / 20.0
    end

    local finalWeights = {}
    local sources = {}

    for sk, w in pairs(baseWeights) do
        local rounded = RoundWeight(w)
        if rounded > 0 then
            finalWeights[sk] = rounded
            sources[sk] = "prio"
        end
    end

    for _, primKey in ipairs({ "AGILITY", "STRENGTH", "INTELLECT" }) do
        if allowedSet[primKey] and syn[primKey] > 0 then
            local direct = finalWeights[primKey] or 0
            local sVal = syn[primKey]
            local combined
            if direct > 0 then
                combined = math.max(direct, sVal) + 0.15 * math.min(direct, sVal)
            else
                combined = sVal
                sources[primKey] = "synergy"
            end
            local rounded = RoundWeight(combined)
            if rounded > 0 then
                finalWeights[primKey] = rounded
            end
        end
    end

    -- Weapon speed (average per-swing damage) & Dual-Wield off-hand weapon synergies
    if (baseWeights.MELEE_DPS or 0) > 0 and classToken ~= "DRUID" then
        if role == "MELEE" and DUAL_WIELD_MELEE[classToken] and (baseWeights.OFFHAND_DPS or 0) <= 0 and allowedSet.OFFHAND_DPS then
            local roundedOH = RoundWeight(baseWeights.MELEE_DPS * 0.625)
            if roundedOH > 0 then
                finalWeights.OFFHAND_DPS = roundedOH
                sources.OFFHAND_DPS = "synergy"
            end
        end
        if (baseWeights.MELEE_HIT or 0) <= 0 and allowedSet.MELEE_HIT then
            local hitRatio = (classToken == "ROGUE" and 0.20) or (role == "TANK" and 0.08) or 0.15
            local roundedHit = RoundWeight(baseWeights.MELEE_DPS * hitRatio)
            if roundedHit > 0 then
                finalWeights.MELEE_HIT = roundedHit
                sources.MELEE_HIT = "synergy"
            end
        end
    end
    if (baseWeights.RANGED_DPS or 0) > 0 and role == "RANGED" and (baseWeights.RANGED_HIT or 0) <= 0 and allowedSet.RANGED_HIT then
        local roundedRHit = RoundWeight(baseWeights.RANGED_DPS * 0.25)
        if roundedRHit > 0 then
            finalWeights.RANGED_HIT = roundedRHit
            sources.RANGED_HIT = "synergy"
        end
    end

    -- Ensure mandatory class & role baseline weights if user omitted them
    if N > 0 then
        local mandatory = GetMandatoryStats(classToken, role)
        for i = 1, #mandatory do
            local mKey = mandatory[i]
            if allowedSet[mKey] and (finalWeights[mKey] or 0) <= 0 then
                local baseFactor = PrioGen.STAT_BUDGET_BASE[mKey] or 1.0
                local rounded = RoundWeight(0.12 * baseFactor)
                if rounded > 0 then
                    finalWeights[mKey] = rounded
                    sources[mKey] = "base"
                end
            end
        end
    end

    -- Strictly strip any non-allowed or non-positive weight
    for k, v in pairs(finalWeights) do
        if not allowedSet[k] or v <= 0 then
            finalWeights[k] = nil
            sources[k] = nil
        end
    end

    return finalWeights, sources, rankOf
end

function PrioGen:BuildCapsForRole(role)
    local caps = (ns.Caps and ns.Caps.MakeDefaultCaps and ns.Caps.MakeDefaultCaps(role)) or {}
    if ns.Caps and ns.Caps.DEFAULT_CAPS then
        for k, v in pairs(ns.Caps.DEFAULT_CAPS) do
            if caps[k] == nil then
                caps[k] = v
            end
        end
    end
    caps.enableCaps = true
    caps.useTalents = true
    caps.targetMode = "auto"
    caps.tankExpertiseMode = (role == "TANK")
    if role == "CASTER" then
        caps.hitMode = "spell"
    elseif role == "MELEE" or role == "RANGED" or role == "TANK" then
        caps.hitMode = "melee"
    else
        caps.hitMode = "auto"
    end
    return caps
end

function PrioGen:BuildProfilePayload(classToken, role, prioList, name)
    classToken = classToken or ns.class or "WARRIOR"
    if not self:IsRoleValidForClass(classToken, role) then
        role = self:GetDefaultRoleForClass(classToken)
    end
    local weights, sources, rankOf = self:CalculateWeights(classToken, role, prioList)
    local scaleRole = (role == "TANK" and "TANK") or (role == "HEALER" and "HEALER") or "DAMAGER"
    local isTank = (role == "TANK")
    local isSpell = (role == "CASTER" or role == "HEALER")
    local isDualWield = (role == "MELEE") and ((weights.OFFHAND_DPS or 0) > 0) or false

    return {
        name = ns.Trim((name or ""):gsub("[%c]", ""):gsub('"', "'")),
        class = classToken,
        role = scaleRole,
        genRole = role,
        isTank = isTank,
        isSpell = isSpell,
        isDualWield = isDualWield,
        weights = weights,
        caps = self:BuildCapsForRole(role),
        unusableTypes = (ns.Scales and ns.Scales.GetDefaultUnusableTypes and ns.Scales.GetDefaultUnusableTypes(classToken)) or {},
        sources = sources,
        rankOf = rankOf,
    }
end

function PrioGen:CreateProfile(name, classToken, role, prioList)
    local payload = self:BuildProfilePayload(classToken, role, prioList, name)
    if not next(payload.weights) then
        return nil, L["Prio list is empty."]
    end
    if payload.name == "" then
        payload.name = (L[self.ROLE_LABELS[payload.genRole] or "Custom scale"] .. " Prio")
    end
    if ns.Scales and ns.Scales.CreateFromGenerator then
        return ns.Scales:CreateFromGenerator(payload.name, payload)
    end
    return nil, "Scales unavailable"
end

function PrioGen:ApplyToProfile(scaleID, classToken, role, prioList)
    local payload = self:BuildProfilePayload(classToken, role, prioList, "")
    if not next(payload.weights) then
        return nil, L["Prio list is empty."]
    end
    if ns.Scales and ns.Scales.ApplyGeneratorToCustom then
        return ns.Scales:ApplyGeneratorToCustom(scaleID, payload)
    end
    return nil, "Scales unavailable"
end
