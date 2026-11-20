-- PawnDynamic (MIT License)
-- Multi-lingual item & tooltip parser for World of Warcraft: Classic Forever (Interface 16001).

local _, ns = ...

local Parser = ns:NewModule("Parser")
local L = ns.L

------------------------------------------------------------------------
-- Canonical Stat Catalog & Groups
------------------------------------------------------------------------

Parser.statGroups = {
    { key = "ATTRIBUTES", name = L["Attributes"], "STRENGTH", "AGILITY", "STAMINA", "INTELLECT", "SPIRIT" },
    { key = "OFFENSE", name = L["Offense"], "ATTACK_POWER", "RANGED_AP", "FERAL_AP", "HIT", "CRIT", "EXPERTISE", "WEAPON_SKILL", "HASTE", "ARMOR_PEN" },
    { key = "WEAPON", name = L["Weapon damage"], "MELEE_DPS", "MELEE_HIT", "MELEE_SPEED", "OFFHAND_DPS", "OFFHAND_SPEED", "RANGED_DPS", "RANGED_HIT", "RANGED_SPEED", "SPEED_BASELINE" },
    { key = "SPELLS", name = L["Spells"], "SPELL_DAMAGE", "HEALING", "ARCANE_DAMAGE", "FIRE_DAMAGE", "FROST_DAMAGE", "NATURE_DAMAGE", "SHADOW_DAMAGE", "HOLY_DAMAGE", "MP5", "SPELL_PEN" },
    { key = "DEFENSE", name = L["Defense"], "ARMOR", "DEFENSE", "DODGE", "PARRY", "BLOCK", "BLOCK_VALUE", "HP5", "RESILIENCE" },
    { key = "RESISTANCES", name = L["Resistances"], "ALL_RES", "ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES" },
}

Parser.statLabels = {
    STRENGTH = L["Strength"],
    AGILITY = L["Agility"],
    STAMINA = L["Stamina"],
    INTELLECT = L["Intellect"],
    SPIRIT = L["Spirit"],
    ATTACK_POWER = L["Attack power"],
    RANGED_AP = L["Ranged attack power"],
    FERAL_AP = L["Feral attack power"],
    HIT = L["Hit %"],
    CRIT = L["Crit %"],
    EXPERTISE = L["Expertise %"],
    WEAPON_SKILL = L["Weapon skill"],
    HASTE = L["Haste %"],
    ARMOR_PEN = L["Armor penetration"],
    MELEE_DPS = L["Main-hand DPS"],
    MELEE_HIT = L["Main-hand hit damage"],
    MELEE_SPEED = L["Main-hand speed"],
    OFFHAND_DPS = L["Off-hand DPS"],
    OFFHAND_SPEED = L["Off-hand speed"],
    RANGED_DPS = L["Ranged / wand DPS"],
    RANGED_HIT = L["Ranged hit damage"],
    RANGED_SPEED = L["Ranged speed"],
    SPEED_BASELINE = L["Speed baseline"],
    SPELL_DAMAGE = L["Spell damage"],
    HEALING = L["Healing"],
    ARCANE_DAMAGE = L["Arcane damage"],
    FIRE_DAMAGE = L["Fire damage"],
    FROST_DAMAGE = L["Frost damage"],
    NATURE_DAMAGE = L["Nature damage"],
    SHADOW_DAMAGE = L["Shadow damage"],
    HOLY_DAMAGE = L["Holy damage"],
    MP5 = L["Mana per 5 sec"],
    SPELL_PEN = L["Spell penetration"],
    ARMOR = L["Armor"],
    DEFENSE = L["Defense"],
    DODGE = L["Dodge %"],
    PARRY = L["Parry %"],
    BLOCK = L["Block %"],
    BLOCK_VALUE = L["Block value"],
    HP5 = L["Health per 5 sec"],
    RESILIENCE = L["Resilience"],
    ALL_RES = L["All resistances"],
    ARCANE_RES = L["Arcane resistance"],
    FIRE_RES = L["Fire resistance"],
    FROST_RES = L["Frost resistance"],
    NATURE_RES = L["Nature resistance"],
    SHADOW_RES = L["Shadow resistance"],
}

Parser.armorTypeKeys = {
    { key = "IsCloth", label = L["Cloth"], classID = 4, subclassID = 1 },
    { key = "IsLeather", label = L["Leather"], classID = 4, subclassID = 2 },
    { key = "IsMail", label = L["Mail"], classID = 4, subclassID = 3 },
    { key = "IsPlate", label = L["Plate"], classID = 4, subclassID = 4 },
    { key = "IsShield", label = L["Shield"], classID = 4, subclassID = 6 },
}

Parser.weaponTypeKeys = {
    { key = "IsAxe", label = L["1H Axe"], classID = 2, subclassID = 0 },
    { key = "Is2HAxe", label = L["2H Axe"], classID = 2, subclassID = 1 },
    { key = "IsBow", label = L["Bow"], classID = 2, subclassID = 2 },
    { key = "IsGun", label = L["Gun"], classID = 2, subclassID = 3 },
    { key = "IsMace", label = L["1H Mace"], classID = 2, subclassID = 4 },
    { key = "Is2HMace", label = L["2H Mace"], classID = 2, subclassID = 5 },
    { key = "IsPolearm", label = L["Polearm"], classID = 2, subclassID = 6 },
    { key = "IsSword", label = L["1H Sword"], classID = 2, subclassID = 7 },
    { key = "Is2HSword", label = L["2H Sword"], classID = 2, subclassID = 8 },
    { key = "IsStaff", label = L["Staff"], classID = 2, subclassID = 10 },
    { key = "IsFist", label = L["Fist weapon"], classID = 2, subclassID = 13 },
    { key = "IsDagger", label = L["Dagger"], classID = 2, subclassID = 15 },
    { key = "IsThrown", label = L["Thrown weapon"], classID = 2, subclassID = 16 },
    { key = "IsCrossbow", label = L["Crossbow"], classID = 2, subclassID = 18 },
    { key = "IsWand", label = L["Wand"], classID = 2, subclassID = 19 },
    { key = "IsOffHand", label = L["Off-hand weapon"], equipLoc = "INVTYPE_WEAPONOFFHAND" },
    { key = "IsFrill", label = L["Off-hand frill"], equipLoc = "INVTYPE_HOLDABLE" },
    { key = "IsRelic", label = L["Relic"], equipLoc = "INVTYPE_RELIC" },
}

local ARMOR_SUBCLASS_MAP = {
    [1] = "IsCloth",
    [2] = "IsLeather",
    [3] = "IsMail",
    [4] = "IsPlate",
    [6] = "IsShield",
}

local WEAPON_SUBCLASS_MAP = {
    [0] = "IsAxe",
    [1] = "Is2HAxe",
    [2] = "IsBow",
    [3] = "IsGun",
    [4] = "IsMace",
    [5] = "Is2HMace",
    [6] = "IsPolearm",
    [7] = "IsSword",
    [8] = "Is2HSword",
    [10] = "IsStaff",
    [13] = "IsFist",
    [15] = "IsDagger",
    [16] = "IsThrown",
    [18] = "IsCrossbow",
    [19] = "IsWand",
}

local SCHOOL_DAMAGE = {
    arcane = "ARCANE_DAMAGE",
    fire = "FIRE_DAMAGE",
    frost = "FROST_DAMAGE",
    nature = "NATURE_DAMAGE",
    shadow = "SHADOW_DAMAGE",
    holy = "HOLY_DAMAGE",
}

local RESIST_STATS = { "ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES" }
local BASE_STATS = { "STRENGTH", "AGILITY", "STAMINA", "INTELLECT", "SPIRIT" }

local HEALING_TO_DAMAGE = 1 / 3

local RATING_PER_PERCENT = {
    HIT = 10,
    CRIT = 14,
    HASTE = 10,
    DEFENSE = 1.5,
    DODGE = 12,
    PARRY = 15,
    BLOCK = 5,
    EXPERTISE = 2.5,
}

------------------------------------------------------------------------
-- Stat Accumulation Callbacks Passed to Locale Grammars
------------------------------------------------------------------------

local function Add(stats, key, value)
    value = tonumber(value)
    if value and key then
        stats[key] = (stats[key] or 0) + value
    end
end

local function AddSpellPower(stats, value)
    Add(stats, "SPELL_DAMAGE", value)
    Add(stats, "HEALING", value)
end

local function AddHealing(stats, value)
    value = tonumber(value)
    if value then
        Add(stats, "HEALING", value)
        stats.impliedDamage = (stats.impliedDamage or 0) + value * HEALING_TO_DAMAGE
    end
end

local function AddAllStats(stats, value)
    value = tonumber(value)
    if value then
        for i = 1, #BASE_STATS do
            Add(stats, BASE_STATS[i], value)
        end
    end
end

local function AddAllResistances(stats, value)
    value = tonumber(value)
    if value then
        for i = 1, #RESIST_STATS do
            Add(stats, RESIST_STATS[i], value)
        end
    end
end

local function Rating(key)
    local div = RATING_PER_PERCENT[key] or 10
    return function(stats, value)
        value = tonumber(value)
        if value then
            Add(stats, key, value / div)
        end
    end
end

local function Skill(kinds)
    return function(stats, name, value)
        if not name then
            return false
        end
        local cleanName = ns.Trim(name)
        local kind = kinds[cleanName]
        if kind then
            stats.skills = stats.skills or {}
            stats.skills[kind] = (stats.skills[kind] or 0) + (tonumber(value) or 0)
            return true
        end
        return false
    end
end

local UNREAD = {}
local NUM = "(%d+%.?%d*)"

local function LoadGrammar()
    local builder = (ns.locale and ns.locale.grammar) or ns.BuildEnglishGrammar
    local own = builder({
        NUM = NUM,
        UNREAD = UNREAD,
        SCHOOL_DAMAGE = SCHOOL_DAMAGE,
        Add = Add,
        AddSpellPower = AddSpellPower,
        AddHealing = AddHealing,
        AddAllStats = AddAllStats,
        AddAllResistances = AddAllResistances,
        Rating = Rating,
        Skill = Skill,
    })
    return own.rules, own.names, own.skip, own.words
end

local RULES, NAMES, SKIP_PREFIX, WORDS = LoadGrammar()

local function EscapeLiteral(text)
    return (text:gsub("%p", "%%%0"))
end

local ALSO_PAT = "(.-)" .. EscapeLiteral(WORDS.also or " and your ")
local PLUS_PAT = EscapeLiteral(WORDS.plus or " and ")

------------------------------------------------------------------------
-- Central Text & Number Cleaner (Forever Decimal Dot + NBSP Fix)
------------------------------------------------------------------------

function Parser:CleanLine(text)
    if type(text) ~= "string" or text == "" then
        return ""
    end
    -- Remove WoW formatting codes & textures
    text = text:gsub("|c%x%x%x%x%x%x%x%x", "")
        :gsub("|cn[^:]+:", "")
        :gsub("|r", "")
        :gsub("|T.-|t", "")
        :gsub("|A.-|a", "")

    -- Replace UTF-8 NBSP (U+00A0), narrow NBSP (U+202F), and en/em dashes
    text = text:gsub("\194\160", " "):gsub("\226\128\175", " ")
        :gsub("\226\128\147", "-"):gsub("\226\128\148", "-")

    -- Strip spaces between digits in French/Russian thousands groupings (e.g. "1 234 Armor")
    text = text:gsub("(%d) (%d%d%d)([^%d%%])", "%1%2%3")

    if WORDS.looseNumbers then
        -- Remove thousands separators while preserving Forever decimal dots ("2.0%") & classic commas ("2,60")
        text = (text .. " "):gsub("(%d)[.,](%d%d%d)([^%d%%])", "%1%2%3"):gsub("(%d),(%d)", "%1.%2")
    else
        text = text:gsub("(%d),(%d%d%d)", "%1%2")
    end

    return ns.Trim(ns.Lower(text))
end

local function MatchAny(text, patterns)
    if type(patterns) ~= "table" then
        return nil
    end
    for i = 1, #patterns do
        local a, b = text:match(patterns[i])
        if a then
            return a, b
        end
    end
    return nil
end

local function StartsWith(text, prefix)
    return text:sub(1, #prefix) == prefix
end

local function ApplyRule(stats, target, ...)
    if type(target) == "function" then
        return target(stats, ...) ~= false
    elseif target then
        Add(stats, target, (...))
        return true
    end
    return false
end

local function ParsePiece(stats, piece)
    local cleaned = ns.Trim(piece):gsub("^%[.-%]%s*", "")
    local sign, value, percent, name = cleaned:match("^([+-]?)" .. NUM .. "(%%?)%s+(.+)$")
    if not name then
        -- Handle suffix format like "Stamina +5" or "Strength +12"
        local prefixName, s2, v2, p2 = cleaned:match("^(.+)%s+([+-]?)" .. NUM .. "(%%?)$")
        if prefixName and s2 ~= "" then
            name, sign, value, percent = prefixName, s2, v2, p2
        end
    end
    if not name then
        return false
    end

    name = ns.Trim(name)
    if WORDS.name then
        name = ns.Trim(WORDS.name(name))
    end

    local target = (percent == "%" and NAMES["% " .. name]) or NAMES[name]
    if not target then
        return false
    end
    local mult = (sign == "-") and -1 or 1
    ApplyRule(stats, target, (tonumber(value) or 0) * mult)
    return true
end

local function ParsePieces(stats, text)
    text = text:gsub("%.$", "")
    if ParsePiece(stats, text) then
        return true
    end
    -- Split by comma or localized conjunction ("and", "und", "et", "y")
    local splitText = text:gsub(PLUS_PAT, ",")
    local matched = false
    for piece in splitText:gmatch("[^,]+") do
        if ParsePiece(stats, piece) then
            matched = true
        end
    end
    return matched
end

local function ParseClause(stats, text, negative)
    text = ns.Trim(text)
    if text == "" then
        return false
    end
    for i = 1, #RULES do
        local rule = RULES[i]
        local a, b = text:match(rule[1])
        if a then
            local target = rule[2]
            if target == false then
                return true -- Known conditional/proc ignored intentionally
            elseif target == UNREAD then
                return false
            end
            if negative and not rule[3] and type(target) == "string" then
                a = -(tonumber(a) or 0)
            end
            return ApplyRule(stats, target, a, b)
        end
    end
    return ParsePieces(stats, text)
end

local function ParseLine(info, text, rawLine)
    local low, high = MatchAny(text, WORDS.range)
    if not low then
        low = MatchAny(text, WORDS.flat)
        high = low
    end
    if low then
        info.minDamage = (info.minDamage or 0) + (tonumber(low) or 0)
        info.maxDamage = (info.maxDamage or 0) + (tonumber(high) or 0)
        return true
    end

    local dps = WORDS.dps and text:match(WORDS.dps)
    if dps then
        info.dps = tonumber(dps)
        return true
    end

    local speed = (WORDS.speed and text:match(WORDS.speed)) or (WORDS.speedAlt and text:match(WORDS.speedAlt))
    if speed then
        info.speed = tonumber(speed)
        return true
    end

    local negative = MatchAny(text, WORDS.negative)
    local understood = false
    local alsoSep = WORDS.also or " and your "
    for clause in (text .. alsoSep):gmatch(ALSO_PAT) do
        if ParseClause(info.stats, clause, negative) then
            understood = true
        end
    end
    if not understood then
        understood = ParseClause(info.stats, text, negative)
    end
    return understood
end

------------------------------------------------------------------------
-- Tooltip Line Reader (C_TooltipInfo Primary + GameTooltip Fallback)
------------------------------------------------------------------------

local function IsRed(r, g, b)
    return (r and g and b and r > 0.9 and g < 0.2 and b < 0.2) and true or false
end

local function ColorIsRed(color)
    if type(color) ~= "table" then
        return false
    end
    return IsRed(ns.Plain(color.r), ns.Plain(color.g), ns.Plain(color.b))
end

local scanTooltip

local function ScanTooltipLines(itemString)
    if not scanTooltip then
        scanTooltip = CreateFrame("GameTooltip", "PawnDynamicScanTooltip", nil, "GameTooltipTemplate")
    end
    scanTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
    scanTooltip:ClearLines()
    local ok = pcall(scanTooltip.SetHyperlink, scanTooltip, itemString)
    if not ok then
        return nil
    end

    local lines = {}
    local numLines = ns.PlainNumber(scanTooltip:NumLines(), 0)
    for i = 1, numLines do
        local left = _G["PawnDynamicScanTooltipTextLeft" .. i]
        local right = _G["PawnDynamicScanTooltipTextRight" .. i]
        local leftText = left and ns.PlainText(left:GetText())
        local rightText = right and right:IsShown() and ns.PlainText(right:GetText()) or nil
        local red = false
        if leftText and left.GetTextColor then
            red = IsRed(ns.Plain(left:GetTextColor()))
        end
        if not red and rightText and right.GetTextColor then
            red = IsRed(ns.Plain(right:GetTextColor()))
        end
        lines[#lines + 1] = {
            left = leftText,
            right = rightText,
            red = red,
            colored = true,
        }
    end
    return #lines > 0 and lines or nil
end

local function ReadTooltipLines(itemString)
    if C_TooltipInfo and C_TooltipInfo.GetHyperlink then
        local ok, data = pcall(C_TooltipInfo.GetHyperlink, itemString)
        local source = ok and type(data) == "table" and ns.Plain(data.lines)
        if type(source) == "table" and #source > 0 then
            local lines = {}
            for i = 1, #source do
                local line = source[i]
                local leftText = ns.PlainText(line.leftText)
                local rightText = ns.PlainText(line.rightText)
                lines[#lines + 1] = {
                    left = leftText,
                    right = rightText,
                    red = ColorIsRed(line.leftColor) or (rightText and ColorIsRed(line.rightColor)) or false,
                    colored = type(line.leftColor) == "table",
                }
            end
            if #lines > 0 then
                return lines
            end
        end
    end
    return ScanTooltipLines(itemString)
end

------------------------------------------------------------------------
-- Item Link Normalization (Base Unenchanted vs. Full Enchanted)
------------------------------------------------------------------------

function Parser.FullItemString(link)
    link = ns.PlainText(link)
    if not link then
        return nil
    end
    local itemString = link:match("|H(item:[^|]+)|h") or link:match("^(item:[%-%d:]+)")
    if itemString then
        return itemString
    end
    local numID = link:match("^(%d+)$")
    if numID then
        return "item:" .. numID
    end
    return nil
end

function Parser.BaseItemString(link)
    local full = Parser.FullItemString(link)
    if not full then
        return nil
    end
    local id, rest = full:match("^item:(%-?%d+):?[^:]*:?[^:]*:?[^:]*:?[^:]*:?[^:]*(.*)$")
    if id then
        if rest and rest ~= "" then
            return "item:" .. id .. ":::::" .. rest
        end
        return "item:" .. id
    end
    return full
end

local function ClassNamesForPlayer()
    local names = {}
    local function Take(n)
        n = ns.PlainText(n)
        if n then
            names[#names + 1] = ns.Lower(n)
        end
    end
    Take((UnitClass("player")))
    local male = _G.LOCALIZED_CLASS_NAMES_MALE
    local female = _G.LOCALIZED_CLASS_NAMES_FEMALE
    if type(male) == "table" and ns.class then
        Take(male[ns.class])
    end
    if type(female) == "table" and ns.class then
        Take(female[ns.class])
    end
    return names
end

local function ContainsAny(text, list)
    for i = 1, #list do
        if text:find(list[i], 1, true) then
            return true
        end
    end
    return false
end

local RANGED_LOCS = {
    INVTYPE_RANGED = true,
    INVTYPE_RANGEDRIGHT = true,
    INVTYPE_THROWN = true,
}

local function ResolveItemTypeKey(equipLoc, classID, subclassID)
    if equipLoc == "INVTYPE_CLOAK" then
        return nil
    end
    if classID == 4 and subclassID then
        return ARMOR_SUBCLASS_MAP[subclassID]
    end
    if classID == 2 and subclassID then
        return WEAPON_SUBCLASS_MAP[subclassID]
    end
    if equipLoc == "INVTYPE_HOLDABLE" then
        return "IsFrill"
    elseif equipLoc == "INVTYPE_RELIC" then
        return "IsRelic"
    end
    return nil
end

local function ParseTooltipIntoPayload(itemString, equipLoc)
    local lines = ReadTooltipLines(itemString)
    if not lines then
        return nil
    end

    local payload = {
        stats = {},
        unread = {},
        lines = lines,
        unusable = false,
        hasRedLine = false,
        colored = false,
        hasProcOrUse = false,
    }
    local classNames = ClassNamesForPlayer()
    local isSetBlock = false

    for i = 2, #lines do
        local line = lines[i]
        if line.red then
            payload.hasRedLine = true
        end
        if line.colored then
            payload.colored = true
        end

        local text = line.left and Parser:CleanLine(line.left)
        if text and text ~= "" then
            if WORDS.set and text:match(WORDS.set) then
                isSetBlock = true
            end

            local classes = WORDS.classes and text:match(WORDS.classes)
            if classes and ((#classNames > 0 and not ContainsAny(classes, classNames)) or line.red) then
                payload.unusable = true
            end

            local equip = WORDS.equip and text:match(WORDS.equip)
            local skip = isSetBlock
            if not skip then
                for j = 1, #SKIP_PREFIX do
                    if StartsWith(text, SKIP_PREFIX[j]) then
                        skip = true
                        if j <= 2 then -- Use / Chance on hit
                            payload.hasProcOrUse = true
                        end
                        break
                    end
                end
            end

            if not skip then
                local parsed = ParseLine(payload, equip or text, line.left)
                if not parsed and equip then
                    payload.unread[#payload.unread + 1] = line.left
                    payload.hasProcOrUse = true
                end
            end
        end

        local right = line.right and Parser:CleanLine(line.right)
        local speed = right and ((WORDS.speed and right:match(WORDS.speed)) or (WORDS.speedAlt and right:match(WORDS.speedAlt)))
        if speed then
            payload.speed = tonumber(speed)
        end
    end

    if not payload.dps and payload.minDamage and payload.maxDamage and payload.speed and payload.speed > 0 then
        payload.dps = (payload.minDamage + payload.maxDamage) / 2 / payload.speed
    end
    if payload.minDamage and payload.maxDamage then
        payload.hit = (payload.minDamage + payload.maxDamage) / 2
    elseif payload.dps and payload.speed then
        payload.hit = payload.dps * payload.speed
    end

    local stats = payload.stats
    if stats.impliedDamage and not stats.SPELL_DAMAGE then
        if not ns.options or ns.options.healingToDamageFallback ~= false then
            stats.SPELL_DAMAGE = stats.impliedDamage
        end
    end
    stats.impliedDamage = nil

    payload.skills = stats.skills
    stats.skills = nil

    return payload
end

------------------------------------------------------------------------
-- Cache & Public API
------------------------------------------------------------------------

local GetItemInfo = C_Item and C_Item.GetItemInfo or _G.GetItemInfo
local GetItemInfoInstant = C_Item and C_Item.GetItemInfoInstant or _G.GetItemInfoInstant

local cache = {}
local cacheCount = 0

function Parser:Wipe()
    cache = {}
    cacheCount = 0
end

function Parser:Get(link)
    local fullString = self.FullItemString(link)
    local baseString = self.BaseItemString(link)
    if not fullString or not baseString then
        return false
    end

    local cacheKey = fullString
    local cached = cache[cacheKey]
    if cached ~= nil then
        return cached
    end

    local id, _, _, equipLoc, icon, classID, subclassID = GetItemInfoInstant(baseString)
    id = ns.PlainNumber(id)
    if not id then
        return false
    end

    if not equipLoc or equipLoc == "" or equipLoc == "INVTYPE_NON_EQUIP_IGNORE" or equipLoc == "INVTYPE_BAG" or equipLoc == "INVTYPE_QUIVER" then
        cache[cacheKey] = false
        cacheCount = cacheCount + 1
        return false
    end

    local name, itemLink, quality, itemLevel, minLevel, _, _, _, _, itemTexture, sellPrice = GetItemInfo(fullString)
    name = ns.PlainText(name)
    if not name then
        if C_Item and C_Item.RequestLoadItemDataByID then
            pcall(C_Item.RequestLoadItemDataByID, id)
        end
        return nil
    end

    local basePayload = ParseTooltipIntoPayload(baseString, equipLoc)
    if not basePayload then
        return nil
    end

    local currentPayload = basePayload
    local isEnchanted = (fullString ~= baseString)
    if isEnchanted then
        local fullParsed = ParseTooltipIntoPayload(fullString, equipLoc)
        if fullParsed then
            currentPayload = fullParsed
        end
    end

    local info = {
        id = id,
        name = name,
        link = ns.PlainText(itemLink) or fullString,
        itemString = baseString,
        fullItemString = fullString,
        isEnchanted = isEnchanted,
        quality = ns.PlainNumber(quality, 1),
        itemLevel = ns.PlainNumber(itemLevel, 0),
        minLevel = ns.PlainNumber(minLevel, 0),
        sellPrice = ns.PlainNumber(sellPrice, 0),
        icon = ns.Plain(itemTexture) or ns.Plain(icon),
        equipLoc = equipLoc,
        classID = ns.PlainNumber(classID, 0),
        subclassID = ns.PlainNumber(subclassID, 0),
        itemTypeKey = ResolveItemTypeKey(equipLoc, classID, subclassID),
        ranged = RANGED_LOCS[equipLoc] or false,
        unusable = basePayload.unusable,
        hasRedLine = basePayload.hasRedLine,
        colored = basePayload.colored,
        hasProcOrUse = basePayload.hasProcOrUse,

        -- Base (unenchanted) stats
        stats = basePayload.stats,
        skills = basePayload.skills,
        dps = basePayload.dps,
        hit = basePayload.hit,
        speed = basePayload.speed,
        minDamage = basePayload.minDamage,
        maxDamage = basePayload.maxDamage,
        unread = basePayload.unread,
        lines = basePayload.lines,

        -- Current (enchanted/gemmed) stats
        currentStats = currentPayload.stats,
        currentSkills = currentPayload.skills,
        currentDps = currentPayload.dps,
        currentHit = currentPayload.hit,
        currentSpeed = currentPayload.speed,
        currentMinDamage = currentPayload.minDamage,
        currentMaxDamage = currentPayload.maxDamage,
    }

    if cacheCount > 900 then
        self:Wipe()
    end
    cache[cacheKey] = info
    cacheCount = cacheCount + 1
    return info
end

------------------------------------------------------------------------
-- /pd debug & /pd dump
------------------------------------------------------------------------

function Parser:DebugItem(link)
    if not link or link == "" then
        link = ns.PlainText(GetInventoryItemLink("player", 16))
        if not link then
            ns.Print("Usage: /pd debug [item link or itemID]")
            return
        end
    end

    local full = self.FullItemString(link)
    if full then
        cache[full] = nil
    end

    local info = self:Get(link)
    if info == false then
        ns.Print("Not an equippable gear item.")
        return
    elseif info == nil then
        ns.Print("Item is still loading from server - try again in a second.")
        return
    end

    ns.Print(("%s [%s] iLvl %d | %s"):format(info.link, info.equipLoc, info.itemLevel, info.unusable and "|cffff4040Unusable|r" or "|cff33ff99Usable|r"))
    for _, group in ipairs(self.statGroups) do
        for _, statKey in ipairs(group) do
            local baseVal = info.stats[statKey]
            local curVal = info.currentStats[statKey]
            if baseVal or curVal then
                if info.isEnchanted and curVal ~= baseVal then
                    ns.Print(("  %s: %s (Current: %s)"):format(self.statLabels[statKey] or statKey, ns.Format(baseVal or 0), ns.Format(curVal or 0)))
                else
                    ns.Print(("  %s: %s"):format(self.statLabels[statKey] or statKey, ns.Format(baseVal or 0)))
                end
            end
        end
    end
    if info.dps then
        ns.Print(("  Weapon DPS: %s | Avg Hit: %s | Speed: %s"):format(
            ns.Format(info.dps),
            info.hit and ns.Format(info.hit) or "?",
            info.speed and ns.Format(info.speed, 2) or "?"
        ))
    end
    if info.skills then
        for kind, val in pairs(info.skills) do
            ns.Print(("  Weapon Skill (%d): +%s"):format(kind, ns.Format(val)))
        end
    end
    if #info.unread > 0 then
        for _, u in ipairs(info.unread) do
            ns.Print("  |cffffaa40Unread Equip:|r", u)
        end
    end

    local tracked = ns.Scales and ns.Scales:GetTracked() or {}
    for _, scale in ipairs(tracked) do
        local verdict = ns.Upgrades and ns.Upgrades:Check(info.link, scale)
        local score = verdict and verdict.score or (ns.Scales and ns.Scales:ScoreItem(info, scale)) or 0
        ns.Print(("  Score (%s): %s"):format(scale.name, ns.Format(score)))
    end
end

function Parser:DumpAll()
    local items = {}
    local seen = {}

    local function Record(link, where, worn)
        local full = self.FullItemString(link)
        if not full or seen[full] or #items >= 90 then
            return
        end
        seen[full] = true
        local info = self:Get(link)
        if not info then
            return
        end
        local lineDump = {}
        for idx, l in ipairs(info.lines) do
            lineDump[idx] = (l.red and "(RED) " or "") .. tostring(l.left or "") .. (l.right and ("  ||  " .. l.right) or "")
        end
        local verdict = ns.Upgrades and ns.Upgrades:Check(link)
        items[#items + 1] = {
            where = where,
            itemString = info.itemString,
            fullItemString = info.fullItemString,
            name = info.name,
            equipLoc = info.equipLoc,
            itemTypeKey = info.itemTypeKey,
            stats = info.stats,
            currentStats = info.isEnchanted and info.currentStats or nil,
            skills = info.skills,
            dps = info.dps,
            hit = info.hit,
            speed = info.speed,
            unread = info.unread,
            lines = lineDump,
            score = verdict and verdict.score or nil,
            upgrade = (not worn) and verdict and verdict.upgrade or false,
        }
    end

    for slot = 1, 18 do
        local link = ns.PlainText(GetInventoryItemLink("player", slot))
        if link then
            Record(link, "slot:" .. slot, true)
        end
    end
    if C_Container and C_Container.GetContainerNumSlots and C_Container.GetContainerItemInfo then
        for bag = 0, NUM_BAG_SLOTS or 4 do
            local slots = C_Container.GetContainerNumSlots(bag) or 0
            for slot = 1, slots do
                local item = C_Container.GetContainerItemInfo(bag, slot)
                local link = item and ns.PlainText(item.hyperlink)
                if link then
                    Record(link, "bag:" .. bag .. ":" .. slot, false)
                end
            end
        end
    end

    if ns.db then
        ns.db.dump = {
            version = ns.version,
            locale = ns.clientLocale,
            class = ns.class,
            level = ns.PlainNumber(UnitLevel("player"), 1),
            talents = ns.Talents and ns.Talents:GetDumpData() or {},
            items = items,
        }
    end
    ns.Print(ns.Count(#items, "Saved %d item - /reload to write to disk.", "Saved %d items - /reload to write to disk."))
end
