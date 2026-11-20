-- PawnDynamic (MIT License)
-- 100% compatible Pawn v1 profile string importer and exporter.

local _, ns = ...

local ImportExport = ns:NewModule("ImportExport")

------------------------------------------------------------------------
-- Pawn v1 <-> PawnDynamic Stat Mapping
------------------------------------------------------------------------

local PAWN_TO_DYNAMIC = {
    Strength = "STRENGTH",
    Str = "STRENGTH",
    Agility = "AGILITY",
    Agi = "AGILITY",
    Stamina = "STAMINA",
    Sta = "STAMINA",
    Intellect = "INTELLECT",
    Int = "INTELLECT",
    Spirit = "SPIRIT",
    Spi = "SPIRIT",
    Armor = "ARMOR",
    BaseArmor = "ARMOR",
    BonusArmor = "ARMOR",
    Ap = "ATTACK_POWER",
    AttackPower = "ATTACK_POWER",
    MeleeAp = "ATTACK_POWER",
    Rap = "RANGED_AP",
    RangedAp = "RANGED_AP",
    RangedAttackPower = "RANGED_AP",
    FeralAp = "FERAL_AP",
    FeralAttackPower = "FERAL_AP",
    HitRating = "HIT",
    Hit = "HIT",
    MeleeHit = "HIT",
    MeleeHitRating = "HIT",
    RangedHit = "HIT",
    RangedHitRating = "HIT",
    SpellHit = "HIT",
    SpellHitRating = "HIT",
    CritRating = "CRIT",
    Crit = "CRIT",
    MeleeCrit = "CRIT",
    MeleeCritRating = "CRIT",
    RangedCrit = "CRIT",
    RangedCritRating = "CRIT",
    SpellCrit = "CRIT",
    SpellCritRating = "CRIT",
    HasteRating = "HASTE",
    Haste = "HASTE",
    MeleeHaste = "HASTE",
    MeleeHasteRating = "HASTE",
    RangedHaste = "HASTE",
    RangedHasteRating = "HASTE",
    SpellHaste = "HASTE",
    SpellHasteRating = "HASTE",
    ExpertiseRating = "EXPERTISE",
    Expertise = "EXPERTISE",
    WeaponSkill = "WEAPON_SKILL",
    ArmorPenetration = "ARMOR_PEN",
    ArmorPenetrationRating = "ARMOR_PEN",
    SpellPenetration = "SPELL_PEN",
    DefenseRating = "DEFENSE",
    Defense = "DEFENSE",
    DodgeRating = "DODGE",
    Dodge = "DODGE",
    ParryRating = "PARRY",
    Parry = "PARRY",
    BlockRating = "BLOCK",
    Block = "BLOCK",
    BlockChance = "BLOCK",
    BlockValue = "BLOCK_VALUE",
    ShieldBlockValue = "BLOCK_VALUE",
    SpellDamage = "SPELL_DAMAGE",
    Damage = "SPELL_DAMAGE",
    Healing = "HEALING",
    SpellHealing = "HEALING",
    ArcaneSpellDamage = "ARCANE_DAMAGE",
    ArcaneDamage = "ARCANE_DAMAGE",
    FireSpellDamage = "FIRE_DAMAGE",
    FireDamage = "FIRE_DAMAGE",
    FrostSpellDamage = "FROST_DAMAGE",
    FrostDamage = "FROST_DAMAGE",
    NatureSpellDamage = "NATURE_DAMAGE",
    NatureDamage = "NATURE_DAMAGE",
    ShadowSpellDamage = "SHADOW_DAMAGE",
    ShadowDamage = "SHADOW_DAMAGE",
    HolySpellDamage = "HOLY_DAMAGE",
    HolyDamage = "HOLY_DAMAGE",
    Mp5 = "MP5",
    ManaPer5 = "MP5",
    Hp5 = "HP5",
    HealthPer5 = "HP5",
    ResilienceRating = "RESILIENCE",
    Resilience = "RESILIENCE",
    AllResist = "ALL_RES",
    AllResistances = "ALL_RES",
    ArcaneResist = "ARCANE_RES",
    ArcaneResistance = "ARCANE_RES",
    FireResist = "FIRE_RES",
    FireResistance = "FIRE_RES",
    FrostResist = "FROST_RES",
    FrostResistance = "FROST_RES",
    NatureResist = "NATURE_RES",
    NatureResistance = "NATURE_RES",
    ShadowResist = "SHADOW_RES",
    ShadowResistance = "SHADOW_RES",
    Dps = "MELEE_DPS",
    MeleeDps = "MELEE_DPS",
    MainHandDps = "MELEE_DPS",
    OffHandDps = "OFFHAND_DPS",
    RangedDps = "RANGED_DPS",
    Speed = "MELEE_SPEED",
    MeleeSpeed = "MELEE_SPEED",
    MainHandSpeed = "MELEE_SPEED",
    OffHandSpeed = "OFFHAND_SPEED",
    RangedSpeed = "RANGED_SPEED",
    SpeedBaseline = "SPEED_BASELINE",
}

local DYNAMIC_TO_PAWN = {
    STRENGTH = "Strength",
    AGILITY = "Agility",
    STAMINA = "Stamina",
    INTELLECT = "Intellect",
    SPIRIT = "Spirit",
    ARMOR = "Armor",
    ATTACK_POWER = "Ap",
    RANGED_AP = "Rap",
    FERAL_AP = "FeralAp",
    HIT = "HitRating",
    CRIT = "CritRating",
    HASTE = "HasteRating",
    EXPERTISE = "ExpertiseRating",
    ARMOR_PEN = "ArmorPenetration",
    SPELL_PEN = "SpellPenetration",
    DEFENSE = "DefenseRating",
    DODGE = "DodgeRating",
    PARRY = "ParryRating",
    BLOCK = "BlockRating",
    BLOCK_VALUE = "BlockValue",
    SPELL_DAMAGE = "SpellDamage",
    HEALING = "Healing",
    ARCANE_DAMAGE = "ArcaneSpellDamage",
    FIRE_DAMAGE = "FireSpellDamage",
    FROST_DAMAGE = "FrostSpellDamage",
    NATURE_DAMAGE = "NatureSpellDamage",
    SHADOW_DAMAGE = "ShadowSpellDamage",
    HOLY_DAMAGE = "HolySpellDamage",
    MP5 = "Mp5",
    HP5 = "Hp5",
    RESILIENCE = "ResilienceRating",
    ALL_RES = "AllResist",
    ARCANE_RES = "ArcaneResist",
    FIRE_RES = "FireResist",
    FROST_RES = "FrostResist",
    NATURE_RES = "NatureResist",
    SHADOW_RES = "ShadowResist",
    MELEE_DPS = "MainHandDps",
    OFFHAND_DPS = "OffHandDps",
    RANGED_DPS = "RangedDps",
    MELEE_SPEED = "MainHandSpeed",
    OFFHAND_SPEED = "OffHandSpeed",
    RANGED_SPEED = "RangedSpeed",
    SPEED_BASELINE = "SpeedBaseline",
}

local UNUSABLE_KEYS = {
    IsCloth = true, IsLeather = true, IsMail = true, IsPlate = true, IsShield = true,
    IsAxe = true, Is2HAxe = true, IsBow = true, IsCrossbow = true, IsDagger = true,
    IsFist = true, IsGun = true, IsMace = true, Is2HMace = true, IsPolearm = true,
    IsRelic = true, IsStaff = true, IsSword = true, Is2HSword = true, IsThrown = true,
    IsWand = true, IsOffHand = true, IsFrill = true,
}

local CLASS_PAWN_TO_TOKEN = {
    WARRIOR = "WARRIOR", PALADIN = "PALADIN", HUNTER = "HUNTER", ROGUE = "ROGUE",
    PRIEST = "PRIEST", SHAMAN = "SHAMAN", MAGE = "MAGE", WARLOCK = "WARLOCK", DRUID = "DRUID",
}

local CLASS_TOKEN_TO_PAWN = {
    WARRIOR = "Warrior", PALADIN = "Paladin", HUNTER = "Hunter", ROGUE = "Rogue",
    PRIEST = "Priest", SHAMAN = "Shaman", MAGE = "Mage", WARLOCK = "Warlock", DRUID = "Druid",
}

local SPEC_PAWN_TO_KEY = {
    ARMS = "ARMS", FURY = "FURY", PROTECTION = "PROTECTION",
    HOLY = "HOLY", RETRIBUTION = "RETRIBUTION",
    BEASTMASTERY = "BEAST_MASTERY", BEAST_MASTERY = "BEAST_MASTERY", MARKSMANSHIP = "MARKSMANSHIP", SURVIVAL = "SURVIVAL",
    ASSASSINATION = "ASSASSINATION", COMBAT = "COMBAT", OUTLAW = "COMBAT", SUBTLETY = "SUBTLETY",
    DISCIPLINE = "DISCIPLINE", SHADOW = "SHADOW", SMITE = "SMITE",
    ELEMENTAL = "ELEMENTAL", ENHANCEMENT = "ENHANCEMENT", RESTORATION = "RESTORATION",
    ARCANE = "ARCANE", FIRE = "FIRE", FROST = "FROST",
    AFFLICTION = "AFFLICTION", DEMONOLOGY = "DEMONOLOGY", DESTRUCTION = "DESTRUCTION",
    BALANCE = "BALANCE", FERAL = "FERAL_CAT", FERAL_CAT = "FERAL_CAT", GUARDIAN = "FERAL_BEAR", FERAL_BEAR = "FERAL_BEAR",
}

local SPEC_KEY_TO_PAWN = {
    ARMS = "Arms", FURY = "Fury", PROTECTION = "Protection",
    HOLY = "Holy", RETRIBUTION = "Retribution",
    BEAST_MASTERY = "BeastMastery", MARKSMANSHIP = "Marksmanship", SURVIVAL = "Survival",
    ASSASSINATION = "Assassination", COMBAT = "Combat", SUBTLETY = "Subtlety",
    DISCIPLINE = "Discipline", SHADOW = "Shadow", SMITE = "Smite",
    ELEMENTAL = "Elemental", ENHANCEMENT = "Enhancement", RESTORATION = "Restoration",
    ARCANE = "Arcane", FIRE = "Fire", FROST = "Frost",
    AFFLICTION = "Affliction", DEMONOLOGY = "Demonology", DESTRUCTION = "Destruction",
    BALANCE = "Balance", FERAL_CAT = "Feral", FERAL_BEAR = "Guardian",
}

------------------------------------------------------------------------
-- Export
------------------------------------------------------------------------

function ImportExport:Export(scaleID)
    local scale = ns.Scales:Get(scaleID)
    if not scale then
        return nil
    end

    local safeName = (scale.name or "Profile"):gsub('"', "'")
    local parts = {}

    if scale.class and CLASS_TOKEN_TO_PAWN[scale.class] then
        parts[#parts + 1] = "Class=" .. CLASS_TOKEN_TO_PAWN[scale.class]
    end
    if scale.specKey and SPEC_KEY_TO_PAWN[scale.specKey] then
        parts[#parts + 1] = "Spec=" .. SPEC_KEY_TO_PAWN[scale.specKey]
    end
    if scale.colorHex then
        parts[#parts + 1] = "Color=" .. scale.colorHex
    end
    if scale.normalizeFactor and scale.normalizeFactor > 0 then
        parts[#parts + 1] = "Normalize=" .. tostring(scale.normalizeFactor)
    end
    if scale.hide1H then
        parts[#parts + 1] = "DoNotShow1HUpgrades=1"
    end
    if scale.hide2H then
        parts[#parts + 1] = "DoNotShow2HUpgrades=1"
    end

    local statPairs = {}
    for statKey, val in pairs(scale.weights or {}) do
        local pawnKey = DYNAMIC_TO_PAWN[statKey]
        if pawnKey and type(val) == "number" and val ~= 0 then
            statPairs[#statPairs + 1] = { key = pawnKey, val = val }
        end
    end
    table.sort(statPairs, function(a, b) return a.key < b.key end)
    for _, entry in ipairs(statPairs) do
        parts[#parts + 1] = entry.key .. "=" .. tostring(entry.val)
    end

    local typeKeys = {}
    for typeKey, flag in pairs(scale.unusableTypes or {}) do
        if flag then
            typeKeys[#typeKeys + 1] = typeKey
        end
    end
    table.sort(typeKeys)
    for _, typeKey in ipairs(typeKeys) do
        parts[#parts + 1] = typeKey .. "=X"
    end

    return ('( Pawn: v1: "%s": %s )'):format(safeName, table.concat(parts, ", "))
end

function ImportExport:ExportAll()
    local tags = {}
    if ns.db and ns.db.customScales then
        for id in pairs(ns.db.customScales) do
            local tag = self:Export(id)
            if tag then
                tags[#tags + 1] = tag
            end
        end
    end
    table.sort(tags)
    return table.concat(tags, "\n")
end

------------------------------------------------------------------------
-- Import
------------------------------------------------------------------------

local function ParseFiniteNumber(v)
    if type(v) == "string" then
        v = v:gsub(",", ".")
    end
    local num = tonumber(v)
    if not num or num ~= num or num == math.huge or num == -math.huge then
        return nil
    end
    return num
end

local function SanitizeScaleName(name)
    if type(name) ~= "string" then
        return "Imported Profile"
    end
    name = name:gsub("[%c]", ""):gsub('"', "'")
    name = ns.Trim(name)
    if name == "" then
        return "Imported Profile"
    end
    return name
end

local UNIFIED_MAX_KEYS = {
    HIT = true,
    CRIT = true,
    HASTE = true,
}

local function SplitTagPairs(body)
    local out = {}
    local start = 1
    local inQuote = false
    local quoteChar = nil
    local len = #body
    for i = 1, len do
        local ch = body:sub(i, i)
        if inQuote then
            if ch == quoteChar then
                inQuote = false
                quoteChar = nil
            end
        elseif ch == '"' or ch == "'" then
            inQuote = true
            quoteChar = ch
        elseif ch == "," then
            out[#out + 1] = body:sub(start, i - 1)
            start = i + 1
        end
    end
    if start <= len then
        out[#out + 1] = body:sub(start)
    end
    return out
end

local function ParseSingleTag(tag)
    tag = ns.Trim((tag or ""):gsub("[\r\n]+", " "))
    local version, name, body = tag:match('^%(%s*Pawn%s*:%s*v(%d+)%s*:%s*"([^"]+)"%s*:%s*(.+)%s*%)$')
    version = tonumber(version)
    if not version or version > 1 or not name or name == "" or not body or body == "" then
        return nil, "Invalid Pawn v1 tag syntax"
    end

    name = SanitizeScaleName(name)

    local weights = {}
    local unusableTypes = {}
    local explicitUnusable = {}
    local classToken = ns.class
    local specKey = nil
    local colorHex = nil
    local normalizeFactor = nil
    local hide1H = false
    local hide2H = false

    local pairsList = SplitTagPairs(body)
    for i = 1, #pairsList do
        local pair = pairsList[i]
        local k, v = pair:match("^%s*([%a%d_]+)%s*=%s*(.-)%s*$")
        if k and v and v ~= "" then
            v = v:match('^"(.*)"$') or v:match("^'(.*)'$") or v
            v = ns.Trim(v)
            if v ~= "" then
                if k == "Class" then
                    classToken = CLASS_PAWN_TO_TOKEN[v:upper()] or classToken
                elseif k == "Spec" then
                    specKey = SPEC_PAWN_TO_KEY[v:upper()] or specKey
                elseif k == "Color" then
                    local hex = v:gsub("^#", ""):gsub("^|[cC][fF][fF]", "")
                    if hex:match("^%x%x%x%x%x%x$") then
                        colorHex = hex:lower()
                    end
                elseif k == "NormalizeValues" or k == "Normalize" or k == "NormalizationFactor" then
                    local lv = v:lower()
                    if lv == "1" or lv == "true" or lv == "yes" then
                        normalizeFactor = 1
                    elseif lv == "0" or lv == "false" or lv == "no" then
                        normalizeFactor = nil
                    else
                        local nf = ParseFiniteNumber(v)
                        if nf and nf > 0 then
                            normalizeFactor = nf
                        else
                            normalizeFactor = nil
                        end
                    end
                elseif k == "DoNotShow1HUpgrades" then
                    local lv = v:lower()
                    hide1H = (lv == "1" or lv == "true")
                elseif k == "DoNotShow2HUpgrades" then
                    local lv = v:lower()
                    hide2H = (lv == "1" or lv == "true")
                elseif UNUSABLE_KEYS[k] then
                    explicitUnusable[k] = true
                    if v == "X" or v == "x" or ParseFiniteNumber(v) == -1000000 then
                        unusableTypes[k] = true
                    end
                elseif k == "SpellPower" then
                    local num = ParseFiniteNumber(v)
                    if num and num ~= 0 then
                        weights.SPELL_DAMAGE = math.max(weights.SPELL_DAMAGE or 0, num)
                        weights.HEALING = math.max(weights.HEALING or 0, num)
                    end
                elseif k == "AllStats" then
                    local num = ParseFiniteNumber(v)
                    if num and num ~= 0 then
                        for _, statKey in ipairs({ "STRENGTH", "AGILITY", "STAMINA", "INTELLECT", "SPIRIT" }) do
                            weights[statKey] = (weights[statKey] or 0) + num
                        end
                    end
                else
                    local dynKey = PAWN_TO_DYNAMIC[k]
                    if dynKey then
                        local num = ParseFiniteNumber(v)
                        if num and num ~= 0 then
                            if UNIFIED_MAX_KEYS[dynKey] then
                                weights[dynKey] = math.max(weights[dynKey] or 0, num)
                            else
                                weights[dynKey] = num
                            end
                            if k == "Dps" and classToken == "HUNTER" and not weights.RANGED_DPS then
                                weights.RANGED_DPS = num
                            end
                        end
                    end
                end
            end
        end
    end

    local classDefaults = (ns.Scales and ns.Scales.GetDefaultUnusableTypes and ns.Scales.GetDefaultUnusableTypes(classToken)) or {}
    for k, v in pairs(classDefaults) do
        if v and not explicitUnusable[k] then
            unusableTypes[k] = true
        end
    end

    return {
        name = name,
        class = classToken,
        specKey = specKey,
        colorHex = colorHex or "00d1ff",
        normalizeFactor = normalizeFactor,
        hide1H = hide1H,
        hide2H = hide2H,
        weights = weights,
        unusableTypes = unusableTypes,
    }
end

function ImportExport:Import(inputText, overwrite)
    if type(inputText) ~= "string" or ns.Trim(inputText) == "" then
        return false, "Empty input"
    end

    local imported = {}
    local anyTag = false
    for tag in inputText:gmatch("(%b())") do
        if tag:find("Pawn%s*:") then
            anyTag = true
            local parsed, err = ParseSingleTag(tag)
            if not parsed then
                return false, err
            end
            imported[#imported + 1] = parsed
        end
    end

    if not anyTag then
        return false, "No valid Pawn v1 string found"
    end

    local lastScale
    for _, data in ipairs(imported) do
        local existingID
        if ns.db and ns.db.customScales then
            for id, raw in pairs(ns.db.customScales) do
                if raw.name and raw.name:lower() == data.name:lower() then
                    existingID = id
                    break
                end
            end
        end

        if existingID and not overwrite then
            return false, "EXISTS:" .. data.name
        end

        local role = "DAMAGER"
        local isTank = (data.weights.DEFENSE or 0) > 0 or (data.weights.DODGE or 0) > 0 or (data.weights.BLOCK or 0) > 0
        if isTank then
            role = "TANK"
        elseif (data.weights.HEALING or 0) >= 0.9 and (data.weights.SPELL_DAMAGE or 0) < 0.5 then
            role = "HEALER"
        end
        local isDualWield = (data.weights.OFFHAND_DPS or 0) > 0

        local targetID = existingID
        if not targetID then
            local idx = 1
            while ns.db.customScales["CUSTOM:" .. idx] do
                idx = idx + 1
            end
            targetID = "CUSTOM:" .. idx
        end

        local w = data.weights
        local isPureCaster = (data.class == "MAGE" or data.class == "PRIEST" or data.class == "WARLOCK")
        local isSpell = (role == "HEALER") or isPureCaster

        local caps = (ns.Caps and ns.Caps.MakeDefaultCaps and ns.Caps.MakeDefaultCaps(role, isDualWield)) or {}
        if ns.Caps and ns.Caps.DEFAULT_CAPS then
            for k, v in pairs(ns.Caps.DEFAULT_CAPS) do
                if caps[k] == nil then
                    caps[k] = v
                end
            end
        end

        ns.db.customScales[targetID] = {
            name = data.name,
            class = data.class,
            specKey = data.specKey,
            role = role,
            isTank = isTank,
            isSpell = isSpell,
            isDualWield = isDualWield,
            colorHex = data.colorHex or "00d1ff",
            normalizeFactor = data.normalizeFactor,
            hide1H = data.hide1H,
            hide2H = data.hide2H,
            weights = w,
            caps = caps,
            unusableTypes = data.unusableTypes,
        }

        ns.char.autoMode = false
        ns.char.visibleScales[targetID] = true
        ns.char.selectedScale = targetID
        lastScale = ns.Scales:Get(targetID)
    end

    ns:Changed(false)
    return true, lastScale
end
