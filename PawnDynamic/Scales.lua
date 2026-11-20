-- PawnDynamic (MIT License)
-- Starter templates, custom profile management, and scoring facade.

local _, ns = ...

local Scales = ns:NewModule("Scales")
local L = ns.L

------------------------------------------------------------------------
-- Color Palette
------------------------------------------------------------------------

Scales.COLOR_PALETTE = {
    { key = "cyan",    name = "Cyan",    hex = "00d1ff", r = 0.00, g = 0.82, b = 1.00 },
    { key = "green",   name = "Green",   hex = "33ff99", r = 0.20, g = 1.00, b = 0.60 },
    { key = "emerald", name = "Lime",    hex = "40ff40", r = 0.25, g = 1.00, b = 0.25 },
    { key = "red",     name = "Red",     hex = "ff4d4d", r = 1.00, g = 0.30, b = 0.30 },
    { key = "blue",    name = "Blue",    hex = "4d99ff", r = 0.30, g = 0.60, b = 1.00 },
    { key = "yellow",  name = "Yellow",  hex = "ffd91a", r = 1.00, g = 0.85, b = 0.10 },
    { key = "purple",  name = "Purple",  hex = "cc73ff", r = 0.80, g = 0.45, b = 1.00 },
    { key = "orange",  name = "Orange",  hex = "ff8c1a", r = 1.00, g = 0.55, b = 0.10 },
    { key = "gold",    name = "Gold",    hex = "f2c94c", r = 0.95, g = 0.79, b = 0.30 },
    { key = "pink",    name = "Pink",    hex = "ff70b8", r = 1.00, g = 0.44, b = 0.72 },
    { key = "teal",    name = "Teal",    hex = "26d9b8", r = 0.15, g = 0.85, b = 0.72 },
    { key = "silver",  name = "Silver",  hex = "c8ccd4", r = 0.78, g = 0.80, b = 0.83 },
}

function Scales.HexToRGB(hex)
    hex = type(hex) == "string" and hex:gsub("^#", "") or "33ff99"
    if #hex ~= 6 then
        hex = "33ff99"
    end
    local r = tonumber(hex:sub(1, 2), 16) or 51
    local g = tonumber(hex:sub(3, 4), 16) or 255
    local b = tonumber(hex:sub(5, 6), 16) or 153
    return r / 255, g / 255, b / 255
end

function Scales.ColorCode(hex)
    hex = type(hex) == "string" and hex:gsub("^#", "") or "33ff99"
    if #hex ~= 6 then
        hex = "33ff99"
    end
    return "|cff" .. hex
end

------------------------------------------------------------------------
-- Starter Templates for All Classic Forever Classes & Specs
------------------------------------------------------------------------

Scales.STARTER_DEFINITIONS = {
    WARRIOR = {
        {
            specKey = "ARMS", name = "Arms", tab = 1, match = "arms", role = "DAMAGER", leveling = true,
            colorHex = "c79c6e",
            weights = {
                STRENGTH = 1, AGILITY = 0.5, STAMINA = 0.15, ATTACK_POWER = 0.5,
                HIT = 13, CRIT = 12, EXPERTISE = 12, WEAPON_SKILL = 3, HASTE = 10,
                MELEE_DPS = 4.2, MELEE_HIT = 0.83, OFFHAND_DPS = 2.5, ARMOR = 0.01, RANGED_DPS = 0.2,
            },
        },
        {
            specKey = "FURY", name = "Fury", tab = 2, match = "fury", role = "DAMAGER", isDualWield = true,
            colorHex = "e06c4d",
            weights = {
                STRENGTH = 1, AGILITY = 0.5, STAMINA = 0.15, ATTACK_POWER = 0.5,
                HIT = 11, CRIT = 11, EXPERTISE = 11, WEAPON_SKILL = 3, HASTE = 8,
                MELEE_DPS = 6, MELEE_HIT = 0.6, OFFHAND_DPS = 3.75, ARMOR = 0.01, RANGED_DPS = 0.2,
            },
        },
        {
            specKey = "PROTECTION", name = "Protection", tab = 3, match = "protection", role = "TANK", isTank = true,
            colorHex = "5c9ce6",
            weights = {
                STAMINA = 1, STRENGTH = 0.7, AGILITY = 0.5, ATTACK_POWER = 0.3,
                HIT = 8, CRIT = 3, EXPERTISE = 8, WEAPON_SKILL = 1.5, MELEE_DPS = 4, MELEE_HIT = 0.35,
                ARMOR = 0.05, DEFENSE = 1.2, DODGE = 7.5, PARRY = 7.5, BLOCK = 4, BLOCK_VALUE = 0.3, HP5 = 0.3,
                RANGED_DPS = 0.2,
            },
        },
    },
    PALADIN = {
        {
            specKey = "HOLY", name = "Holy", tab = 1, match = "holy", role = "HEALER", isSpell = true,
            colorHex = "f58cba",
            weights = {
                HEALING = 1, INTELLECT = 1.2, MP5 = 3, CRIT = 13, HASTE = 8, SPIRIT = 0.5, STAMINA = 0.2,
                ARMOR = 0.01, MELEE_DPS = 1,
            },
        },
        {
            specKey = "PROTECTION", name = "Protection", tab = 2, match = "protection", role = "TANK", isTank = true,
            colorHex = "70b8ff",
            weights = {
                STAMINA = 1, STRENGTH = 0.5, AGILITY = 0.4, INTELLECT = 0.2, ATTACK_POWER = 0.2,
                SPELL_DAMAGE = 0.6, HOLY_DAMAGE = 0.5, HIT = 8, CRIT = 3, EXPERTISE = 7, MELEE_DPS = 3, MELEE_HIT = 0.25,
                ARMOR = 0.05, DEFENSE = 1.2, DODGE = 7.5, PARRY = 7.5, BLOCK = 5, BLOCK_VALUE = 0.4, MP5 = 0.5, HP5 = 0.3,
            },
        },
        {
            specKey = "RETRIBUTION", name = "Retribution", tab = 3, match = "retribution", role = "DAMAGER", leveling = true,
            colorHex = "ff78b0",
            weights = {
                STRENGTH = 1, AGILITY = 0.45, INTELLECT = 0.2, STAMINA = 0.15, SPIRIT = 0.05, ATTACK_POWER = 0.45,
                SPELL_DAMAGE = 0.7, HOLY_DAMAGE = 0.6, HIT = 13, CRIT = 12, EXPERTISE = 12, WEAPON_SKILL = 3, HASTE = 8,
                MELEE_DPS = 4.7, MELEE_HIT = 0.4, MP5 = 0.3, ARMOR = 0.01,
            },
        },
    },
    HUNTER = {
        {
            specKey = "BEAST_MASTERY", name = "Beast Mastery", tab = 1, match = "beast", role = "DAMAGER", leveling = true,
            colorHex = "abd473",
            weights = {
                AGILITY = 1, INTELLECT = 0.25, STAMINA = 0.05, SPIRIT = 0.1,
                ATTACK_POWER = 0.42, RANGED_AP = 0.42, HIT = 12, CRIT = 8, HASTE = 5.5,
                RANGED_DPS = 3.4, RANGED_HIT = 0.9, MELEE_DPS = 0.3, OFFHAND_DPS = 0.15, ARMOR = 0.01,
            },
        },
        {
            specKey = "MARKSMANSHIP", name = "Marksmanship", tab = 2, match = "marksman", role = "DAMAGER",
            colorHex = "8fd14f",
            weights = {
                AGILITY = 1, INTELLECT = 0.25, STAMINA = 0.05, SPIRIT = 0.1,
                ATTACK_POWER = 0.42, RANGED_AP = 0.42, HIT = 12, CRIT = 10, HASTE = 3,
                RANGED_DPS = 3.4, RANGED_HIT = 0.9, MELEE_DPS = 0.3, OFFHAND_DPS = 0.15, ARMOR = 0.01,
            },
        },
        {
            specKey = "SURVIVAL", name = "Survival (Melee)", tab = 3, match = "survival", role = "DAMAGER", isDualWield = true,
            colorHex = "6bbf59",
            weights = {
                AGILITY = 1, STRENGTH = 0.77, INTELLECT = 0.15, STAMINA = 0.1,
                ATTACK_POWER = 0.77, RANGED_AP = 0.1, HIT = 12, CRIT = 11, EXPERTISE = 11, WEAPON_SKILL = 3, HASTE = 4,
                MELEE_DPS = 7.7, MELEE_HIT = 0.75, OFFHAND_DPS = 5, RANGED_DPS = 2, ARMOR = 0.01,
            },
        },
    },
    ROGUE = {
        {
            specKey = "ASSASSINATION", name = "Assassination", tab = 1, match = "assassination", role = "DAMAGER", isDualWield = true,
            colorHex = "fff569",
            weights = {
                AGILITY = 1, STRENGTH = 0.67, STAMINA = 0.25, ATTACK_POWER = 0.67,
                HIT = 11, CRIT = 11, EXPERTISE = 10, WEAPON_SKILL = 3, HASTE = 4,
                MELEE_DPS = 5.4, MELEE_HIT = 1.2, OFFHAND_DPS = 4, ARMOR = 0.01, RANGED_DPS = 0.2,
            },
        },
        {
            specKey = "COMBAT", name = "Combat", tab = 2, match = "combat", role = "DAMAGER", leveling = true, isDualWield = true,
            colorHex = "ffd91a",
            weights = {
                AGILITY = 1, STRENGTH = 0.67, STAMINA = 0.25, ATTACK_POWER = 0.67,
                HIT = 11, CRIT = 10, EXPERTISE = 10, WEAPON_SKILL = 3, HASTE = 6,
                MELEE_DPS = 5.5, MELEE_HIT = 1.25, OFFHAND_DPS = 4.25, ARMOR = 0.01, RANGED_DPS = 0.2,
            },
        },
        {
            specKey = "SUBTLETY", name = "Subtlety", tab = 3, match = "subtlety", role = "DAMAGER", isDualWield = true,
            colorHex = "e6be00",
            weights = {
                AGILITY = 1, STRENGTH = 0.67, STAMINA = 0.25, ATTACK_POWER = 0.67,
                HIT = 11, CRIT = 10, EXPERTISE = 10, WEAPON_SKILL = 3, HASTE = 6,
                MELEE_DPS = 5.5, MELEE_HIT = 1.25, OFFHAND_DPS = 4, ARMOR = 0.01, RANGED_DPS = 0.2,
            },
        },
    },
    PRIEST = {
        {
            specKey = "DISCIPLINE", name = "Discipline", tab = 1, match = "discipline", role = "HEALER", isSpell = true,
            colorHex = "ffffff",
            weights = {
                HEALING = 1, MP5 = 3, SPIRIT = 0.95, INTELLECT = 1.1, CRIT = 10, HASTE = 8, STAMINA = 0.2,
                RANGED_DPS = 0.3, MELEE_DPS = 1, ARMOR = 0.01,
            },
        },
        {
            specKey = "HOLY", name = "Holy", tab = 2, match = "holy", role = "HEALER", isSpell = true,
            colorHex = "e8eef5",
            weights = {
                HEALING = 1, MP5 = 3, SPIRIT = 1.05, INTELLECT = 1, CRIT = 9, HASTE = 8, STAMINA = 0.2,
                RANGED_DPS = 0.3, MELEE_DPS = 1, ARMOR = 0.01,
            },
        },
        {
            specKey = "SHADOW", name = "Shadow", tab = 3, match = "shadow", role = "DAMAGER", leveling = true, isSpell = true,
            colorHex = "b88cff",
            weights = {
                SPELL_DAMAGE = 1, SHADOW_DAMAGE = 1, HIT = 9.5, CRIT = 8, HASTE = 7,
                INTELLECT = 0.35, SPIRIT = 0.2, MP5 = 0.5, STAMINA = 0.15, SPELL_PEN = 0.1, RANGED_DPS = 1, MELEE_DPS = 1, ARMOR = 0.01,
            },
        },
        {
            specKey = "SMITE", name = "Smite", role = "DAMAGER", isSpell = true,
            colorHex = "ffd166",
            weights = {
                SPELL_DAMAGE = 1, HOLY_DAMAGE = 1, HIT = 3, CRIT = 8, HASTE = 7,
                INTELLECT = 0.5, SPIRIT = 0.3, MP5 = 0.5, STAMINA = 0.15, RANGED_DPS = 1, MELEE_DPS = 1, ARMOR = 0.01,
            },
        },
    },
    SHAMAN = {
        {
            specKey = "ELEMENTAL", name = "Elemental", tab = 1, match = "elemental", role = "DAMAGER", isSpell = true,
            colorHex = "0070de",
            weights = {
                SPELL_DAMAGE = 1, NATURE_DAMAGE = 0.9, FIRE_DAMAGE = 0.1, HIT = 9.5, CRIT = 8, HASTE = 8,
                INTELLECT = 0.4, SPIRIT = 0.2, MP5 = 0.5, STAMINA = 0.15, SPELL_PEN = 0.1, MELEE_DPS = 1, ARMOR = 0.01,
            },
        },
        {
            specKey = "ENHANCEMENT", name = "Enhancement", tab = 2, match = "enhancement", role = "DAMAGER", leveling = true,
            colorHex = "3399ff",
            weights = {
                STRENGTH = 1, INTELLECT = 0.2, AGILITY = 0.45, STAMINA = 0.15, SPIRIT = 0.1, ATTACK_POWER = 0.5,
                SPELL_DAMAGE = 0.35, HIT = 13, CRIT = 12, EXPERTISE = 12, WEAPON_SKILL = 3, HASTE = 8,
                MELEE_DPS = 4.6, MELEE_HIT = 0.55, MP5 = 0.3, ARMOR = 0.01,
            },
        },
        {
            specKey = "RESTORATION", name = "Restoration", tab = 3, match = "restoration", role = "HEALER", isSpell = true,
            colorHex = "4dc4ff",
            weights = {
                HEALING = 1, INTELLECT = 1, MP5 = 3, SPIRIT = 0.7, CRIT = 9, HASTE = 8, STAMINA = 0.2,
                MELEE_DPS = 1, ARMOR = 0.01,
            },
        },
    },
    MAGE = {
        {
            specKey = "ARCANE", name = "Arcane", tab = 1, match = "arcane", role = "DAMAGER", isSpell = true,
            colorHex = "69ccf0",
            weights = {
                SPELL_DAMAGE = 1, ARCANE_DAMAGE = 1, HIT = 9.5, CRIT = 8, HASTE = 8,
                INTELLECT = 0.35, SPIRIT = 0.2, MP5 = 0.4, STAMINA = 0.1, SPELL_PEN = 0.1, RANGED_DPS = 1, MELEE_DPS = 1, ARMOR = 0.01,
            },
        },
        {
            specKey = "FIRE", name = "Fire", tab = 2, match = "fire", role = "DAMAGER", isSpell = true,
            colorHex = "ff704d",
            weights = {
                SPELL_DAMAGE = 1, FIRE_DAMAGE = 0.95, HIT = 9.5, CRIT = 11, HASTE = 8,
                INTELLECT = 0.4, SPIRIT = 0.3, MP5 = 0.45, STAMINA = 0.1, SPELL_PEN = 0.1, RANGED_DPS = 1, MELEE_DPS = 1, ARMOR = 0.01,
            },
        },
        {
            specKey = "FROST", name = "Frost", tab = 3, match = "frost", role = "DAMAGER", leveling = true, isSpell = true,
            colorHex = "3fc7eb",
            weights = {
                SPELL_DAMAGE = 1, FROST_DAMAGE = 0.95, HIT = 9.5, CRIT = 8, HASTE = 8,
                INTELLECT = 0.4, SPIRIT = 0.25, MP5 = 0.4, STAMINA = 0.15, SPELL_PEN = 0.1, RANGED_DPS = 1, MELEE_DPS = 1, ARMOR = 0.01,
            },
        },
    },
    WARLOCK = {
        {
            specKey = "AFFLICTION", name = "Affliction", tab = 1, match = "affliction", role = "DAMAGER", leveling = true, isSpell = true,
            colorHex = "9482c9",
            weights = {
                SPELL_DAMAGE = 1, SHADOW_DAMAGE = 0.9, FIRE_DAMAGE = 0.1, HIT = 9.5, CRIT = 6.5, HASTE = 7,
                INTELLECT = 0.3, SPIRIT = 0.25, STAMINA = 0.35, MP5 = 0.25, HP5 = 0.25, SPELL_PEN = 0.1, RANGED_DPS = 0.8, MELEE_DPS = 1, ARMOR = 0.01,
            },
        },
        {
            specKey = "DEMONOLOGY", name = "Demonology", tab = 2, match = "demonology", role = "DAMAGER", isSpell = true,
            colorHex = "a992e8",
            weights = {
                SPELL_DAMAGE = 1, SHADOW_DAMAGE = 0.85, FIRE_DAMAGE = 0.15, HIT = 9.5, CRIT = 8, HASTE = 7,
                INTELLECT = 0.3, SPIRIT = 0.2, STAMINA = 0.4, MP5 = 0.25, HP5 = 0.25, SPELL_PEN = 0.1, RANGED_DPS = 0.8, MELEE_DPS = 1, ARMOR = 0.01,
            },
        },
        {
            specKey = "DESTRUCTION", name = "Destruction", tab = 3, match = "destruction", role = "DAMAGER", isSpell = true,
            colorHex = "c27dff",
            weights = {
                SPELL_DAMAGE = 1, SHADOW_DAMAGE = 0.5, FIRE_DAMAGE = 0.5, HIT = 9.5, CRIT = 8, HASTE = 8,
                INTELLECT = 0.3, SPIRIT = 0.15, STAMINA = 0.3, MP5 = 0.25, HP5 = 0.25, SPELL_PEN = 0.1, RANGED_DPS = 0.8, MELEE_DPS = 1, ARMOR = 0.01,
            },
        },
    },
    DRUID = {
        {
            specKey = "BALANCE", name = "Balance", tab = 1, match = "balance", role = "DAMAGER", isSpell = true,
            colorHex = "ff7d0a",
            weights = {
                SPELL_DAMAGE = 1, ARCANE_DAMAGE = 0.6, NATURE_DAMAGE = 0.4, HIT = 9.5, CRIT = 8, HASTE = 7,
                INTELLECT = 0.4, SPIRIT = 0.25, MP5 = 0.5, STAMINA = 0.15, SPELL_PEN = 0.1, MELEE_DPS = 1, ARMOR = 0.01,
            },
        },
        {
            specKey = "FERAL_CAT", name = "Feral (Cat)", tab = 2, match = "feral", role = "DAMAGER", leveling = true,
            colorHex = "ffa033",
            weights = {
                STRENGTH = 1, AGILITY = 0.8, STAMINA = 0.15, SPIRIT = 0.1, INTELLECT = 0.1,
                ATTACK_POWER = 0.5, FERAL_AP = 0.5, HIT = 13, CRIT = 12, EXPERTISE = 12, HASTE = 5,
                MELEE_DPS = 6.5, ARMOR = 0.01,
            },
        },
        {
            specKey = "FERAL_BEAR", name = "Feral (Bear)", role = "TANK",
            colorHex = "e07a26",
            weights = {
                STAMINA = 1, AGILITY = 0.7, STRENGTH = 0.5, ATTACK_POWER = 0.25, FERAL_AP = 0.25,
                HIT = 8, CRIT = 4, EXPERTISE = 8, MELEE_DPS = 3.5,
                ARMOR = 0.12, DEFENSE = 1, DODGE = 9, HP5 = 0.3,
            },
        },
        {
            specKey = "RESTORATION", name = "Restoration", tab = 3, match = "restoration", role = "HEALER", isSpell = true,
            colorHex = "ffb366",
            weights = {
                HEALING = 1, SPIRIT = 1.05, INTELLECT = 0.9, MP5 = 3, CRIT = 7, HASTE = 6, STAMINA = 0.2,
                MELEE_DPS = 1, ARMOR = 0.01,
            },
        },
    },
}

------------------------------------------------------------------------
-- Permanent Classic Forever Class Restrictions (Unusable Armor/Weapons)
------------------------------------------------------------------------

Scales.CLASS_UNUSABLE_DEFAULTS = {
    WARRIOR = {
        IsWand = true, IsRelic = true,
    },
    PALADIN = {
        IsDagger = true, IsFist = true, IsStaff = true, IsWand = true,
        IsBow = true, IsCrossbow = true, IsGun = true, IsThrown = true, IsOffHand = true,
    },
    HUNTER = {
        IsPlate = true, IsShield = true,
        IsMace = true, Is2HMace = true, IsWand = true, IsRelic = true,
    },
    ROGUE = {
        IsMail = true, IsPlate = true, IsShield = true,
        Is2HAxe = true, Is2HMace = true, Is2HSword = true, IsPolearm = true,
        IsStaff = true, IsWand = true, IsRelic = true,
    },
    PRIEST = {
        IsLeather = true, IsMail = true, IsPlate = true, IsShield = true,
        IsAxe = true, Is2HAxe = true, Is2HMace = true, IsSword = true, Is2HSword = true,
        IsPolearm = true, IsFist = true, IsBow = true, IsCrossbow = true, IsGun = true,
        IsThrown = true, IsOffHand = true, IsRelic = true,
    },
    SHAMAN = {
        IsPlate = true,
        IsSword = true, Is2HSword = true, IsPolearm = true,
        IsBow = true, IsCrossbow = true, IsGun = true, IsThrown = true,
        IsWand = true, IsOffHand = true,
    },
    MAGE = {
        IsLeather = true, IsMail = true, IsPlate = true, IsShield = true,
        IsAxe = true, Is2HAxe = true, IsMace = true, Is2HMace = true, Is2HSword = true,
        IsPolearm = true, IsFist = true, IsBow = true, IsCrossbow = true, IsGun = true,
        IsThrown = true, IsOffHand = true, IsRelic = true,
    },
    WARLOCK = {
        IsLeather = true, IsMail = true, IsPlate = true, IsShield = true,
        IsAxe = true, Is2HAxe = true, IsMace = true, Is2HMace = true, Is2HSword = true,
        IsPolearm = true, IsFist = true, IsBow = true, IsCrossbow = true, IsGun = true,
        IsThrown = true, IsOffHand = true, IsRelic = true,
    },
    DRUID = {
        IsMail = true, IsPlate = true, IsShield = true,
        IsAxe = true, Is2HAxe = true, IsSword = true, Is2HSword = true, IsPolearm = true,
        IsBow = true, IsCrossbow = true, IsGun = true, IsThrown = true,
        IsWand = true, IsOffHand = true,
    },
}

------------------------------------------------------------------------
-- Runtime Scale Materialization
------------------------------------------------------------------------

local starterByID = {}
local starterListByClass = {}

local function CopyTable(src)
    local dst = {}
    if type(src) ~= "table" then
        return dst
    end
    for k, v in pairs(src) do
        if type(v) == "table" then
            dst[k] = CopyTable(v)
        else
            dst[k] = v
        end
    end
    return dst
end

function Scales.GetDefaultUnusableTypes(classToken)
    local src = Scales.CLASS_UNUSABLE_DEFAULTS[classToken or ns.class]
    return CopyTable(src)
end

function Scales:IsItemTypeUnusable(info, scale)
    if not info or not scale or type(scale.unusableTypes) ~= "table" then
        return false
    end
    local loc = info.equipLoc
    if loc == "INVTYPE_CLOAK" then
        return false
    end
    local ut = scale.unusableTypes
    if info.itemTypeKey and ut[info.itemTypeKey] then
        return true
    end
    if ut.IsOffHand and loc == "INVTYPE_WEAPONOFFHAND" then
        return true
    end
    if ut.IsFrill and loc == "INVTYPE_HOLDABLE" then
        return true
    end
    if ut.IsRelic and loc == "INVTYPE_RELIC" then
        return true
    end
    return false
end

local function BuildStarterCatalog()
    local localizedScales = ns.locale and ns.locale.scales or {}
    for classToken, list in pairs(Scales.STARTER_DEFINITIONS) do
        starterListByClass[classToken] = {}
        for _, def in ipairs(list) do
            local id = "STARTER:" .. classToken .. ":" .. def.specKey
            local locEntry = localizedScales[classToken] and localizedScales[classToken][def.specKey]
            local obj = {
                id = id,
                isStarter = true,
                class = classToken,
                specKey = def.specKey,
                tab = def.tab,
                match = def.match,
                localMatch = locEntry and locEntry.match or nil,
                name = (locEntry and locEntry.name) or def.name,
                role = def.role,
                leveling = def.leveling or false,
                isDualWield = def.isDualWield or false,
                isTank = def.isTank or false,
                isSpell = def.isSpell or false,
                colorHex = def.colorHex or "33ff99",
                baseWeights = CopyTable(def.weights),
                baseCaps = ns.Caps and ns.Caps.MakeDefaultCaps(def.role, def.isDualWield) or {},
                baseUnusableTypes = Scales.GetDefaultUnusableTypes(classToken),
            }
            starterByID[id] = obj
            starterListByClass[classToken][#starterListByClass[classToken] + 1] = obj
        end
    end
end

local function EnsureOverrides(starterID, create)
    local all = ns.db and ns.db.scaleOverrides
    if not all then
        return nil
    end
    if not all[starterID] and create then
        all[starterID] = { weights = {}, caps = {}, unusableTypes = {} }
    end
    return all[starterID]
end

local function MaterializeStarter(starterObj)
    local ov = EnsureOverrides(starterObj.id, false)
    local weights = CopyTable(starterObj.baseWeights)
    if ov and type(ov.weights) == "table" then
        for statKey, val in pairs(ov.weights) do
            weights[statKey] = val
        end
    end
    local caps = CopyTable(starterObj.baseCaps)
    if ov and type(ov.caps) == "table" then
        for capKey, val in pairs(ov.caps) do
            caps[capKey] = val
        end
    end
    local ut = CopyTable(starterObj.baseUnusableTypes)
    if ov and type(ov.unusableTypes) == "table" then
        for typeKey, flag in pairs(ov.unusableTypes) do
            if flag then
                ut[typeKey] = true
            else
                ut[typeKey] = nil
            end
        end
    end
    local nf = ov and ov.normalizeFactor
    local normFactor = nil
    if type(nf) == "number" and nf > 0 then
        normFactor = nf
    elseif nf == true then
        normFactor = 1
    end
    return {
        id = starterObj.id,
        isStarter = true,
        class = starterObj.class,
        specKey = starterObj.specKey,
        tab = starterObj.tab,
        match = starterObj.match,
        localMatch = starterObj.localMatch,
        name = starterObj.name,
        role = starterObj.role,
        isTank = starterObj.isTank,
        isSpell = starterObj.isSpell,
        isDualWield = starterObj.isDualWield,
        colorHex = (ov and ov.colorHex) or starterObj.colorHex,
        normalizeFactor = normFactor,
        hide1H = ov and ov.hide1H or false,
        hide2H = ov and ov.hide2H or false,
        unusableTypes = ut,
        weights = weights,
        caps = caps,
        baseWeights = starterObj.baseWeights,
        overrides = ov and ov.weights or {},
    }
end

local function MaterializeCustom(customID, raw)
    local caps = ns.Caps and ns.Caps.MakeDefaultCaps(raw.role or "DAMAGER", raw.isDualWield) or {}
    if ns.Caps and ns.Caps.DEFAULT_CAPS then
        for k, v in pairs(ns.Caps.DEFAULT_CAPS) do
            if caps[k] == nil then
                caps[k] = v
            end
        end
    end
    if type(raw.caps) == "table" then
        for k, v in pairs(raw.caps) do
            caps[k] = v
        end
    end
    local isSpell = (raw.isSpell == true)
    local nf = raw.normalizeFactor
    local normFactor = nil
    if type(nf) == "number" and nf > 0 then
        normFactor = nf
    elseif nf == true then
        normFactor = 1
    end
    return {
        id = customID,
        isStarter = false,
        class = raw.class or ns.class,
        specKey = raw.specKey,
        name = raw.name or customID,
        role = raw.role or "DAMAGER",
        isTank = raw.isTank or false,
        isSpell = isSpell,
        isDualWield = raw.isDualWield or false,
        colorHex = raw.colorHex or "00d1ff",
        normalizeFactor = normFactor,
        hide1H = raw.hide1H or false,
        hide2H = raw.hide2H or false,
        unusableTypes = type(raw.unusableTypes) == "table" and raw.unusableTypes or {},
        weights = type(raw.weights) == "table" and raw.weights or {},
        caps = caps,
        baseWeights = nil,
        overrides = nil,
    }
end

------------------------------------------------------------------------
-- Auto Talent Tree Detection & Active Scale Resolution
------------------------------------------------------------------------

local autoStarterID = nil

function Scales:DetectAutoScaleID()
    local classList = starterListByClass[ns.class] or {}
    if #classList == 0 then
        return nil
    end

    if ns.Talents and ns.Talents.GetPrimaryTree then
        local treeIndex, treeName, spent = ns.Talents:GetPrimaryTree()
        if spent and spent > 0 then
            for _, s in ipairs(classList) do
                if (s.match and treeName and treeName:find(s.match, 1, true))
                    or (s.localMatch and treeName and treeName:find(s.localMatch, 1, true)) then
                    return s.id
                end
            end
            for _, s in ipairs(classList) do
                if s.tab == treeIndex then
                    return s.id
                end
            end
        end
    end

    for _, s in ipairs(classList) do
        if s.leveling then
            return s.id
        end
    end
    return classList[1].id
end

function Scales:OnTalentsChanged()
    autoStarterID = self:DetectAutoScaleID()
end

function Scales:Get(id)
    if not id then
        return nil
    end
    if starterByID[id] then
        return MaterializeStarter(starterByID[id])
    end
    if ns.db and ns.db.customScales and ns.db.customScales[id] then
        return MaterializeCustom(id, ns.db.customScales[id])
    end
    return nil
end

function Scales:GetAll(includeOtherClasses)
    local out = {}
    local classList = starterListByClass[ns.class] or {}
    for _, s in ipairs(classList) do
        out[#out + 1] = MaterializeStarter(s)
    end
    if includeOtherClasses then
        for classToken, list in pairs(starterListByClass) do
            if classToken ~= ns.class then
                for _, s in ipairs(list) do
                    out[#out + 1] = MaterializeStarter(s)
                end
            end
        end
    end
    if ns.db and ns.db.customScales then
        local customs = {}
        for id, raw in pairs(ns.db.customScales) do
            customs[#customs + 1] = MaterializeCustom(id, raw)
        end
        table.sort(customs, function(a, b)
            return (a.name or ""):lower() < (b.name or ""):lower()
        end)
        for _, c in ipairs(customs) do
            out[#out + 1] = c
        end
    end
    return out
end

function Scales:IsVisible(scaleID)
    if not ns.char then
        return false
    end
    if ns.char.autoMode then
        if not autoStarterID then
            autoStarterID = self:DetectAutoScaleID()
        end
        return scaleID == autoStarterID
    end
    return ns.char.visibleScales[scaleID] == true
end

function Scales:GetTracked()
    local tracked = {}
    if ns.char and ns.char.autoMode then
        if not autoStarterID then
            autoStarterID = self:DetectAutoScaleID()
        end
        local s = self:Get(autoStarterID)
        if s then
            tracked[1] = s
        end
        return tracked
    end

    if ns.char and ns.char.visibleScales then
        for id, vis in pairs(ns.char.visibleScales) do
            if vis then
                local s = self:Get(id)
                if s then
                    tracked[#tracked + 1] = s
                end
            end
        end
    end
    table.sort(tracked, function(a, b)
        if a.isStarter ~= b.isStarter then
            return not a.isStarter
        end
        return (a.name or ""):lower() < (b.name or ""):lower()
    end)

    if #tracked == 0 then
        -- Fallback to auto scale if user hid everything while testing
        if not autoStarterID then
            autoStarterID = self:DetectAutoScaleID()
        end
        local fallback = self:Get(autoStarterID)
        if fallback then
            tracked[1] = fallback
        end
    end
    return tracked
end

function Scales:GetSelected()
    if ns.char and ns.char.selectedScale then
        local s = self:Get(ns.char.selectedScale)
        if s then
            return s
        end
    end
    local tracked = self:GetTracked()
    if tracked[1] then
        return tracked[1]
    end
    local classList = starterListByClass[ns.class] or {}
    return classList[1] and MaterializeStarter(classList[1]) or nil
end

function Scales:SelectForEdit(scaleID)
    if ns.char and self:Get(scaleID) then
        ns.char.selectedScale = scaleID
    end
end

-- Returns three groups for the UI Left Panel:
--   myScales: visible/active profiles for current character
--   otherScales: hidden custom profiles
--   starterScales: built-in starter templates for current class
function Scales:GetGrouped()
    local myScales, otherScales, starterScales = {}, {}, {}

    if ns.db and ns.db.customScales then
        local customs = {}
        for id, raw in pairs(ns.db.customScales) do
            customs[#customs + 1] = MaterializeCustom(id, raw)
        end
        table.sort(customs, function(a, b)
            return (a.name or ""):lower() < (b.name or ""):lower()
        end)
        for _, c in ipairs(customs) do
            if self:IsVisible(c.id) then
                myScales[#myScales + 1] = c
            else
                otherScales[#otherScales + 1] = c
            end
        end
    end

    for _, def in ipairs(starterListByClass[ns.class] or {}) do
        local s = MaterializeStarter(def)
        starterScales[#starterScales + 1] = s
        if self:IsVisible(s.id) then
            -- Show active auto/visible starter at top of My Scales as well
            table.insert(myScales, 1, s)
        end
    end

    return myScales, otherScales, starterScales
end

function Scales:GetStarterCatalog()
    local out = {}
    for classToken, list in pairs(starterListByClass) do
        for _, def in ipairs(list) do
            out[#out + 1] = MaterializeStarter(def)
        end
    end
    table.sort(out, function(a, b)
        if a.class ~= b.class then
            if a.class == ns.class then return true end
            if b.class == ns.class then return false end
            return a.class < b.class
        end
        return (a.tab or 9) < (b.tab or 9)
    end)
    return out
end

------------------------------------------------------------------------
-- CRUD & Profile Mutations
------------------------------------------------------------------------

local function CustomNameExists(name, ignoreID)
    if not ns.db or not ns.db.customScales then
        return false
    end
    local lower = name:lower()
    for id, raw in pairs(ns.db.customScales) do
        if id ~= ignoreID and raw.name and raw.name:lower() == lower then
            return true
        end
    end
    return false
end

local function NextCustomID()
    local idx = 1
    while ns.db.customScales["CUSTOM:" .. idx] do
        idx = idx + 1
    end
    return "CUSTOM:" .. idx
end

function Scales:SetAutoMode(enabled)
    if not ns.char then
        return
    end
    ns.char.autoMode = enabled and true or false
    if ns.char.autoMode then
        self:OnTalentsChanged()
    end
    ns:Changed(false)
end

function Scales:SetVisible(scaleID, visible)
    if not ns.char then
        return
    end
    if ns.char.autoMode then
        ns.char.autoMode = false
    end
    ns.char.visibleScales[scaleID] = visible and true or nil
    ns:Changed(false)
end

function Scales:CreateEmpty(name, classToken)
    name = ns.Trim(name or "")
    if name == "" or name:find('"', 1, true) then
        return nil, "Invalid name"
    end
    if CustomNameExists(name) then
        return nil, "Duplicate name"
    end
    local id = NextCustomID()
    local targetClass = classToken or ns.class
    ns.db.customScales[id] = {
        name = name,
        class = targetClass,
        role = "DAMAGER",
        colorHex = "00d1ff",
        weights = { STAMINA = 0.01 },
        caps = ns.Caps and ns.Caps.MakeDefaultCaps("DAMAGER", false) or {},
        unusableTypes = Scales.GetDefaultUnusableTypes(targetClass),
    }
    ns.char.autoMode = false
    ns.char.visibleScales[id] = true
    ns.char.selectedScale = id
    ns:Changed(false)
    return self:Get(id)
end

function Scales:CreateFromTemplate(name, starterID)
    local tpl = starterByID[starterID]
    if not tpl then
        return nil, "Template not found"
    end
    name = ns.Trim(name or "")
    if name == "" or name:find('"', 1, true) then
        return nil, "Invalid name"
    end
    if CustomNameExists(name) then
        return nil, "Duplicate name"
    end
    local id = NextCustomID()
    ns.db.customScales[id] = {
        name = name,
        class = tpl.class,
        specKey = tpl.specKey,
        role = tpl.role,
        isTank = tpl.isTank,
        isSpell = tpl.isSpell,
        isDualWield = tpl.isDualWield,
        colorHex = tpl.colorHex,
        weights = CopyTable(tpl.baseWeights),
        caps = CopyTable(tpl.baseCaps),
        unusableTypes = CopyTable(tpl.baseUnusableTypes or Scales.GetDefaultUnusableTypes(tpl.class)),
    }
    ns.char.autoMode = false
    ns.char.visibleScales[id] = true
    ns.char.selectedScale = id
    ns:Changed(false)
    return self:Get(id)
end

function Scales:Copy(sourceID, newName)
    local src = self:Get(sourceID)
    if not src then
        return nil, "Source not found"
    end
    newName = ns.Trim(newName or "")
    if newName == "" or newName:find('"', 1, true) then
        return nil, "Invalid name"
    end
    if CustomNameExists(newName) then
        return nil, "Duplicate name"
    end
    local id = NextCustomID()
    ns.db.customScales[id] = {
        name = newName,
        class = src.class,
        specKey = src.specKey,
        role = src.role,
        isTank = src.isTank,
        isSpell = src.isSpell,
        isDualWield = src.isDualWield,
        colorHex = src.colorHex,
        normalizeFactor = src.normalizeFactor,
        hide1H = src.hide1H,
        hide2H = src.hide2H,
        weights = CopyTable(src.weights),
        caps = CopyTable(src.caps),
        unusableTypes = CopyTable(src.unusableTypes),
    }
    ns.char.autoMode = false
    ns.char.visibleScales[id] = true
    ns.char.selectedScale = id
    ns:Changed(false)
    return self:Get(id)
end

function Scales:Rename(scaleID, newName)
    local raw = ns.db.customScales[scaleID]
    if not raw then
        return false
    end
    newName = ns.Trim(newName or "")
    if newName == "" or newName:find('"', 1, true) or CustomNameExists(newName, scaleID) then
        return false
    end
    raw.name = newName
    ns:Changed(false)
    return true
end

function Scales:Delete(scaleID)
    if not ns.db.customScales[scaleID] then
        return false
    end
    ns.db.customScales[scaleID] = nil
    for _, charData in pairs(ns.db.chars) do
        if type(charData.visibleScales) == "table" then
            charData.visibleScales[scaleID] = nil
        end
        if charData.selectedScale == scaleID then
            charData.selectedScale = nil
        end
    end
    ns:Changed(false)
    return true
end

function Scales:SetWeight(scaleID, statKey, value)
    if not ns.Parser.statLabels[statKey] then
        return
    end
    if starterByID[scaleID] then
        local ov = EnsureOverrides(scaleID, true)
        local defVal = starterByID[scaleID].baseWeights[statKey] or 0
        if value == nil or math.abs(value - defVal) < 0.0001 then
            ov.weights[statKey] = nil
        else
            ov.weights[statKey] = value
        end
        ns:Changed(false)
        return
    end
    local raw = ns.db.customScales[scaleID]
    if raw then
        raw.weights = raw.weights or {}
        if value == nil or value == 0 then
            raw.weights[statKey] = nil
        else
            raw.weights[statKey] = value
        end
        ns:Changed(false)
    end
end

function Scales:SetCapOption(scaleID, key, value)
    if starterByID[scaleID] then
        local ov = EnsureOverrides(scaleID, true)
        ov.caps[key] = value
        ns:Changed(false)
        return
    end
    local raw = ns.db.customScales[scaleID]
    if raw then
        raw.caps = raw.caps or CopyTable(ns.Caps.DEFAULT_CAPS)
        raw.caps[key] = value
        ns:Changed(false)
    end
end

function Scales:SetUnusableType(scaleID, typeKey, isUnusable)
    if starterByID[scaleID] then
        local ov = EnsureOverrides(scaleID, true)
        local defFlag = (starterByID[scaleID].baseUnusableTypes and starterByID[scaleID].baseUnusableTypes[typeKey]) and true or false
        local newFlag = isUnusable and true or false
        if newFlag == defFlag then
            ov.unusableTypes[typeKey] = nil
        else
            ov.unusableTypes[typeKey] = newFlag
        end
        ns:Changed(false)
        return
    end
    local raw = ns.db.customScales[scaleID]
    if raw then
        raw.unusableTypes = raw.unusableTypes or {}
        raw.unusableTypes[typeKey] = isUnusable and true or nil
        ns:Changed(false)
    end
end

function Scales:SetProperty(scaleID, propKey, value)
    if propKey == "normalizeFactor" then
        if value == false or value == 0 or value == nil then
            value = nil
        elseif value == true then
            value = 1
        elseif type(value) ~= "number" or value <= 0 or value ~= value or value == math.huge or value == -math.huge then
            value = nil
        end
    end
    if starterByID[scaleID] then
        local ov = EnsureOverrides(scaleID, true)
        ov[propKey] = value
        ns:Changed(false)
        return
    end
    local raw = ns.db.customScales[scaleID]
    if raw then
        raw[propKey] = value
        ns:Changed(false)
    end
end

function Scales:ResetStarter(scaleID)
    if starterByID[scaleID] and ns.db and ns.db.scaleOverrides then
        ns.db.scaleOverrides[scaleID] = nil
        ns:Changed(false)
        return true
    end
    return false
end

function Scales:CreateFromGenerator(name, payload)
    if not payload or type(payload.weights) ~= "table" then
        return nil, "Invalid payload"
    end
    name = ns.Trim((name or ""):gsub("[%c]", ""):gsub('"', "'"))
    if name == "" then
        return nil, "Invalid name"
    end
    if CustomNameExists(name) then
        return nil, "Duplicate name"
    end

    local id = NextCustomID()
    local targetClass = payload.class or ns.class
    ns.db.customScales[id] = {
        name = name,
        class = targetClass,
        role = payload.role or "DAMAGER",
        isTank = payload.isTank and true or false,
        isSpell = payload.isSpell and true or false,
        isDualWield = payload.isDualWield and true or false,
        colorHex = "00d1ff",
        weights = CopyTable(payload.weights),
        caps = CopyTable(payload.caps or (ns.Caps and ns.Caps.DEFAULT_CAPS) or {}),
        unusableTypes = CopyTable(payload.unusableTypes or Scales.GetDefaultUnusableTypes(targetClass)),
    }
    ns.char.autoMode = false
    ns.char.visibleScales[id] = true
    ns.char.selectedScale = id
    ns:Changed(false)
    return self:Get(id)
end

function Scales:ApplyGeneratorToCustom(scaleID, payload)
    if not payload or type(payload.weights) ~= "table" then
        return nil, "Invalid payload"
    end
    if starterByID[scaleID] then
        return nil, "Starter templates cannot be overwritten"
    end
    local raw = ns.db and ns.db.customScales and ns.db.customScales[scaleID]
    if not raw then
        return nil, "Custom scale not found"
    end

    local prevClass = raw.class
    local targetClass = payload.class or raw.class or ns.class
    raw.class = targetClass
    raw.role = payload.role or raw.role or "DAMAGER"
    raw.isTank = payload.isTank and true or false
    raw.isSpell = payload.isSpell and true or false
    raw.isDualWield = payload.isDualWield and true or false
    raw.weights = CopyTable(payload.weights)
    raw.caps = raw.caps or {}
    for k, v in pairs(payload.caps or {}) do
        raw.caps[k] = v
    end
    local defUnusable = payload.unusableTypes or Scales.GetDefaultUnusableTypes(targetClass)
    if prevClass ~= targetClass or type(raw.unusableTypes) ~= "table" or not next(raw.unusableTypes) then
        raw.unusableTypes = CopyTable(defUnusable)
    else
        for k, v in pairs(defUnusable) do
            if v and raw.unusableTypes[k] == nil then
                raw.unusableTypes[k] = true
            end
        end
    end

    ns:Changed(false)
    return self:Get(scaleID)
end

------------------------------------------------------------------------
-- Scoring Entry Point
------------------------------------------------------------------------

function Scales:ScoreItem(info, scale, opts)
    if not info or not scale then
        return 0, nil
    end
    if not (opts and opts.ignoreUnusableTypes) and self:IsItemTypeUnusable(info, scale) then
        return 0, { totalScore = 0, rawScore = 0, contributions = {}, anyCapped = false }
    end
    local replaced = opts and opts.replacedItems
    local res = ns.Caps:EvaluateItemDelta(info, replaced, scale, opts)
    return res.totalScore, res
end

function Scales:Init()
    BuildStarterCatalog()
    self:OnTalentsChanged()
end
