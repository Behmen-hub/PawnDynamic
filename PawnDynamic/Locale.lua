-- PawnDynamic (MIT License)
-- Localization loader, UTF-8 lower-casing, and English baseline fallback.

local _, ns = ...

local clientLocale = (type(_G.GetLocale) == "function" and _G.GetLocale()) or "enUS"
ns.clientLocale = clientLocale

ns.L = setmetatable({}, {
    __index = function(_, key)
        return key
    end,
})

ns.locale = {
    code = clientLocale,
    strings = ns.L,
    scales = {},
    talents = {},
    grammar = nil,
}

------------------------------------------------------------------------
-- UTF-8 Lowercase Helper (ASCII, Latin-1 Supplement, Cyrillic)
------------------------------------------------------------------------

local function LowerLatin1(byteStr)
    local b = byteStr:byte()
    if b == 151 then -- U+00D7 multiplication sign
        return nil
    end
    return "\195" .. string.char(b + 32)
end

local function LowerCyrillic(byteStr)
    local b = byteStr:byte()
    if b >= 144 and b <= 159 then
        -- U+0410..U+041F -> U+0430..U+043F
        return "\208" .. string.char(b + 32)
    elseif b >= 160 and b <= 175 then
        -- U+0420..U+042F -> U+0440..U+044F
        return "\209" .. string.char(b - 32)
    end
    return nil
end

function ns.Lower(text)
    if type(text) ~= "string" then
        return ""
    end
    local s = text:lower()
    s = s:gsub("\195([\128-\158])", LowerLatin1)
    s = s:gsub("\208([\144-\175])", LowerCyrillic)
    s = s:gsub("\208\129", "\209\145") -- Ё -> ё
    return s
end

------------------------------------------------------------------------
-- Count Helper
------------------------------------------------------------------------

function ns.Count(n, singular, plural)
    local fmt = ns.L[n == 1 and singular or plural]
    return fmt:format(n)
end

------------------------------------------------------------------------
-- Locale Registration
------------------------------------------------------------------------

function ns:NewLocale(...)
    for i = 1, select("#", ...) do
        local code = select(i, ...)
        if code == clientLocale then
            self.locale = {
                code = clientLocale,
                strings = self.L,
                scales = {},
                talents = {},
                grammar = nil,
            }
            return self.locale
        end
    end
    return nil
end

------------------------------------------------------------------------
-- Baseline English Tooltip Grammar (Fallback for unsupported locales)
------------------------------------------------------------------------

function ns.BuildEnglishGrammar(P)
    local NUM, UNREAD, Add = P.NUM, P.UNREAD, P.Add
    local SCHOOL_DAMAGE = P.SCHOOL_DAMAGE

    local WEAPON_SKILLS = {
        ["axes"] = 0, ["two-handed axes"] = 1, ["bows"] = 2, ["guns"] = 3,
        ["maces"] = 4, ["two-handed maces"] = 5, ["polearms"] = 6, ["swords"] = 7,
        ["two-handed swords"] = 8, ["staves"] = 10, ["fist weapons"] = 13,
        ["daggers"] = 15, ["thrown"] = 16, ["crossbows"] = 18,
    }

    local rules = {
        { "when fighting", false },
        { " against ", false },
        { " for %d+ sec", false },
        { "has a chance", false },
        { "a chance to", false },
        { "chance on ", false },

        { "block value of your shield by " .. NUM, "BLOCK_VALUE" },
        { "block value.-by " .. NUM, "BLOCK_VALUE" },
        { "your spells pierce " .. NUM .. " magical resistance", "SPELL_PEN" },
        { "magical resistances of your spell targets by " .. NUM, "SPELL_PEN", true },
        { "spell penetration.-by " .. NUM, "SPELL_PEN" },
        { " of your ", UNREAD },

        { "critical strike with all spells and attacks by " .. NUM .. "%%", "CRIT" },
        { "chance to get a critical strike.-" .. NUM .. "%%", "CRIT" },
        { "critical strike chance.-" .. NUM .. "%%", "CRIT" },
        { "critical hit chance.-" .. NUM .. "%%", "CRIT" },
        { "chance to hit with all spells and attacks by " .. NUM .. "%%", "HIT" },
        { "chance to hit.-" .. NUM .. "%%", "HIT" },
        { "hit chance.-" .. NUM .. "%%", "HIT" },
        { "chance to be dodged or parried by " .. NUM .. "%%", "EXPERTISE", true },
        { "dodged or parried.-" .. NUM .. "%%", "EXPERTISE", true },
        { "parried or dodged.-" .. NUM .. "%%", "EXPERTISE", true },
        { "expertise.-by " .. NUM, "EXPERTISE" },

        { "chance to dodge.-by " .. NUM .. "%%", "DODGE" },
        { "chance to parry.-by " .. NUM .. "%%", "PARRY" },
        { "chance to block.-by " .. NUM .. "%%", "BLOCK" },
        { "increased defense %+" .. NUM, "DEFENSE" },
        { "defense.-by " .. NUM, "DEFENSE" },
        { "^increased ([%a%- ]+) %+" .. NUM, P.Skill(WEAPON_SKILLS) },
        { "weapon skill.-by " .. NUM, "WEAPON_SKILL" },

        { "healing done by up to " .. NUM .. " and damage done by up to " .. NUM, function(stats, healing, damage)
            Add(stats, "HEALING", healing)
            Add(stats, "SPELL_DAMAGE", damage)
        end },
        { "damage and healing done by magical spells and effects by up to " .. NUM, P.AddSpellPower },
        { "spell damage and healing by up to " .. NUM, P.AddSpellPower },
        { "damage done by magical spells and effects by up to " .. NUM, "SPELL_DAMAGE" },
        { "healing done by magical spells and effects by up to " .. NUM, P.AddHealing },
        { "healing done by spells and effects by up to " .. NUM, P.AddHealing },
        { "healing done by up to " .. NUM, P.AddHealing },
        { "damage done by (%a+) spells and effects by up to " .. NUM, function(stats, school, value)
            if school == "magical" then
                Add(stats, "SPELL_DAMAGE", value)
            elseif SCHOOL_DAMAGE[school] then
                Add(stats, SCHOOL_DAMAGE[school], value)
            else
                return false
            end
        end },
        { "(%a+) spell damage by " .. NUM, function(stats, school, value)
            Add(stats, SCHOOL_DAMAGE[school] or "SPELL_DAMAGE", value)
        end },
        { "(%a+) spell power by " .. NUM, function(stats, school, value)
            if SCHOOL_DAMAGE[school] then
                Add(stats, SCHOOL_DAMAGE[school], value)
            else
                P.AddSpellPower(stats, value)
            end
        end },
        { "spell power by " .. NUM, P.AddSpellPower },
        { "healing power by " .. NUM, P.AddHealing },
        { "bonus healing by " .. NUM, P.AddHealing },
        { "spell damage by up to " .. NUM, "SPELL_DAMAGE" },

        { NUM .. " mana per 5 sec", "MP5" },
        { NUM .. " mana every 5 sec", "MP5" },
        { NUM .. " health per 5 sec", "HP5" },
        { NUM .. " health every 5 sec", "HP5" },

        { NUM .. " attack power in cat", "FERAL_AP" },
        { "attack power by " .. NUM .. " in cat", "FERAL_AP" },
        { NUM .. " ranged attack power", "RANGED_AP" },
        { "ranged attack power by " .. NUM, "RANGED_AP" },
        { "attack power by " .. NUM, "ATTACK_POWER" },

        { "attack speed and casting speed by " .. NUM .. "%%", "HASTE" },
        { "attack and casting speed by " .. NUM .. "%%", "HASTE" },
        { "casting speed by " .. NUM .. "%%", "HASTE" },
        { "attack speed by " .. NUM .. "%%", "HASTE" },
        { "haste.-by " .. NUM .. "%%", "HASTE" },
        { "haste rating by " .. NUM, P.Rating("HASTE") },
        { "hit rating by " .. NUM, P.Rating("HIT") },
        { "critical strike rating by " .. NUM, P.Rating("CRIT") },
        { "defense rating by " .. NUM, P.Rating("DEFENSE") },
        { "dodge rating by " .. NUM, P.Rating("DODGE") },
        { "parry rating by " .. NUM, P.Rating("PARRY") },
        { "block rating by " .. NUM, P.Rating("BLOCK") },
        { "expertise rating by " .. NUM, P.Rating("EXPERTISE") },
        { "armor penetration.-by " .. NUM, "ARMOR_PEN" },
    }

    local names = {
        ["strength"] = "STRENGTH",
        ["agility"] = "AGILITY",
        ["stamina"] = "STAMINA",
        ["intellect"] = "INTELLECT",
        ["spirit"] = "SPIRIT",
        ["all stats"] = P.AddAllStats,
        ["armor"] = "ARMOR",
        ["block"] = "BLOCK_VALUE",
        ["% block"] = "BLOCK",
        ["block value"] = "BLOCK_VALUE",
        ["block chance"] = "BLOCK",
        ["block rating"] = P.Rating("BLOCK"),
        ["defense"] = "DEFENSE",
        ["defense rating"] = P.Rating("DEFENSE"),
        ["dodge"] = "DODGE",
        ["% dodge"] = "DODGE",
        ["dodge chance"] = "DODGE",
        ["dodge rating"] = P.Rating("DODGE"),
        ["parry"] = "PARRY",
        ["% parry"] = "PARRY",
        ["parry chance"] = "PARRY",
        ["parry rating"] = P.Rating("PARRY"),
        ["attack power"] = "ATTACK_POWER",
        ["ranged attack power"] = "RANGED_AP",
        ["feral attack power"] = "FERAL_AP",
        ["hit"] = "HIT",
        ["% hit"] = "HIT",
        ["hit chance"] = "HIT",
        ["chance to hit"] = "HIT",
        ["hit rating"] = P.Rating("HIT"),
        ["spell hit rating"] = P.Rating("HIT"),
        ["crit"] = "CRIT",
        ["% crit"] = "CRIT",
        ["crit chance"] = "CRIT",
        ["critical strike"] = "CRIT",
        ["% critical strike"] = "CRIT",
        ["critical strike chance"] = "CRIT",
        ["critical strike rating"] = P.Rating("CRIT"),
        ["spell critical strike rating"] = P.Rating("CRIT"),
        ["crit rating"] = P.Rating("CRIT"),
        ["expertise"] = "EXPERTISE",
        ["% expertise"] = "EXPERTISE",
        ["expertise rating"] = P.Rating("EXPERTISE"),
        ["weapon skill"] = "WEAPON_SKILL",
        ["haste"] = "HASTE",
        ["% haste"] = "HASTE",
        ["haste rating"] = P.Rating("HASTE"),
        ["spell haste rating"] = P.Rating("HASTE"),
        ["armor penetration"] = "ARMOR_PEN",
        ["armor penetration rating"] = "ARMOR_PEN",
        ["spell power"] = P.AddSpellPower,
        ["spell damage"] = "SPELL_DAMAGE",
        ["spell damage and healing"] = P.AddSpellPower,
        ["damage and healing spells"] = P.AddSpellPower,
        ["healing"] = P.AddHealing,
        ["healing power"] = P.AddHealing,
        ["bonus healing"] = P.AddHealing,
        ["healing spells"] = P.AddHealing,
        ["mana per 5 sec"] = "MP5",
        ["mana per 5 seconds"] = "MP5",
        ["mana every 5 sec"] = "MP5",
        ["mp5"] = "MP5",
        ["mana regen"] = "MP5",
        ["health per 5 sec"] = "HP5",
        ["health every 5 sec"] = "HP5",
        ["hp5"] = "HP5",
        ["spell penetration"] = "SPELL_PEN",
        ["all resistances"] = P.AddAllResistances,
        ["to all resistances"] = P.AddAllResistances,
        ["resilience"] = "RESILIENCE",
        ["resilience rating"] = "RESILIENCE",
    }
    for school, key in pairs(SCHOOL_DAMAGE) do
        names[school .. " damage"] = key
        names[school .. " spell damage"] = key
        names[school .. " spell power"] = key
        if school ~= "holy" then
            names[school .. " resistance"] = school:upper() .. "_RES"
        end
    end

    local skip = {
        "use:", "chance on hit:", "set:", "requires", "classes:", "races:",
        "durability", "item level", "sell price", "unique", "binds", "soulbound", "\"",
    }

    local words = {
        equip = "^equip: (.+)$",
        classes = "^classes: (.+)$",
        set = "^%(%d+%) set",
        range = { "^" .. NUM .. " %- " .. NUM .. " %a* ?damage" },
        flat = { "^" .. NUM .. " %a* ?damage$" },
        dps = "%(?" .. NUM .. " damage per second",
        speed = "^speed " .. NUM,
        negative = { "^reduces", "^decreases", "^lowers" },
        also = " and your ",
        plus = " and ",
        looseNumbers = false,
    }

    return { rules = rules, names = names, skip = skip, words = words }
end
