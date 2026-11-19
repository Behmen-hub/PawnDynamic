-- PawnDynamic (MIT License)
-- Language-independent Forever talent & active buff reader via C_Traits / C_UnitAuras (Interface 16001).

local _, ns = ...

local Talents = ns:NewModule("Talents")

------------------------------------------------------------------------
-- 1. Stat-Scaling Talents (C_Traits)
------------------------------------------------------------------------

local STAT_SCALING_CATALOG = {
    {
        key = "ARCANE_BLAST",
        class = "MAGE",
        maxRank = 1,
        spells = { [30451] = true },
        nodes = {},
        fallbackName = "arcane blast",
        statAdd = { ARCANE = { INTELLECT = 0.45 } },
    },
    {
        key = "ARCANE_MIND",
        class = "MAGE",
        maxRank = 5,
        spells = { [11232] = true, [12500] = true, [12501] = true, [12502] = true, [12503] = true },
        nodes = {},
        fallbackName = "arcane mind",
        statAdd = { ARCANE = { INTELLECT = 0.08 }, FIRE = { INTELLECT = 0.05 }, FROST = { INTELLECT = 0.05 } },
    },
    {
        key = "MENTAL_DEXTERITY",
        class = "SHAMAN",
        maxRank = 3,
        spells = { [51883] = true, [51884] = true, [51885] = true },
        nodes = {},
        fallbackName = "mental dexterity",
        statAdd = { ENHANCEMENT = { INTELLECT = 0.45 } },
    },
    {
        key = "MENTAL_QUICKNESS",
        class = "SHAMAN",
        maxRank = 2,
        spells = { [30812] = true, [30813] = true, [30814] = true },
        nodes = {},
        fallbackName = "mental quickness",
        statAdd = { ELEMENTAL = { INTELLECT = 0.30 }, RESTORATION = { INTELLECT = 0.30 }, ENHANCEMENT = { INTELLECT = 0.15 } },
    },
    {
        key = "CAREFUL_AIM",
        class = "HUNTER",
        maxRank = 5,
        spells = { [34482] = true, [34483] = true, [34484] = true },
        nodes = {},
        fallbackName = "careful aim",
        statAdd = { BEAST_MASTERY = { INTELLECT = 0.42 }, MARKSMANSHIP = { INTELLECT = 0.42 }, SURVIVAL = { INTELLECT = 0.77 } },
    },
    {
        key = "CHAMPION_OF_THE_LIGHT",
        class = "PALADIN",
        maxRank = 3,
        spells = { [53581] = true, [53582] = true, [53583] = true },
        nodes = {},
        fallbackName = "champion of the light",
        statAdd = { RETRIBUTION = { INTELLECT = 0.42 }, PROTECTION = { INTELLECT = 0.36 } },
    },
    {
        key = "HOLY_GUIDANCE",
        class = "PALADIN",
        maxRank = 5,
        spells = { [31837] = true, [31838] = true, [31839] = true, [31840] = true, [31841] = true },
        nodes = {},
        fallbackName = "holy guidance",
        statAdd = { HOLY = { INTELLECT = 0.35 } },
    },
    {
        key = "SPIRITUAL_GUIDANCE",
        class = "PRIEST",
        maxRank = 5,
        spells = { [14901] = true, [15028] = true, [15029] = true, [15030] = true, [15031] = true },
        nodes = {},
        fallbackName = "spiritual guidance",
        statAdd = { HOLY = { SPIRIT = 0.25 }, DISCIPLINE = { SPIRIT = 0.25 }, SHADOW = { SPIRIT = 0.08 }, SMITE = { SPIRIT = 0.08 } },
    },
    {
        key = "LIVING_SPIRIT",
        class = "DRUID",
        maxRank = 3,
        spells = { [34151] = true, [34152] = true, [34153] = true },
        nodes = {},
        fallbackName = "living spirit",
        statAdd = { RESTORATION = { SPIRIT = 0.15 } },
    },
    {
        key = "HEART_OF_THE_WILD",
        class = "DRUID",
        maxRank = 5,
        spells = { [17003] = true, [17004] = true, [17005] = true, [17006] = true, [24894] = true },
        nodes = {},
        fallbackName = "heart of the wild",
        statAdd = { FERAL_CAT = { INTELLECT = 0.04, STRENGTH = 0.05 }, FERAL_BEAR = { STAMINA = 0.20 }, RESTORATION = { INTELLECT = 0.15 } },
    },
}

------------------------------------------------------------------------
-- 2. Passive Talents Already Reflected by Character Sheet APIs
-- (NEVER double-counted when client API returns a value; fallback only)
------------------------------------------------------------------------

local PASSIVE_SHEET_CATALOG = {
    {
        key = "PRECISION_WARRIOR",
        class = "WARRIOR",
        maxRank = 3,
        spells = { [29590] = true, [29591] = true, [29592] = true },
        nodes = {},
        fallbackName = "precision",
        includedInSheetAPI = true,
        fallbackBonus = { meleeHitPerRank = 1.0 },
    },
    {
        key = "PRECISION_ROGUE",
        class = "ROGUE",
        maxRank = 5,
        spells = { [13705] = true, [13832] = true, [13843] = true, [13844] = true, [13845] = true },
        nodes = {},
        fallbackName = "precision",
        includedInSheetAPI = true,
        fallbackBonus = { meleeHitPerRank = 1.0 },
    },
    {
        key = "PRECISION_PALADIN",
        class = "PALADIN",
        maxRank = 3,
        spells = { [20189] = true, [20190] = true, [20191] = true },
        nodes = {},
        fallbackName = "precision",
        includedInSheetAPI = true,
        fallbackBonus = { meleeHitPerRank = 1.0, spellHitPerRank = 1.0 },
    },
    {
        key = "SUREFOOTED",
        class = "HUNTER",
        maxRank = 3,
        spells = { [19290] = true, [19294] = true, [24283] = true },
        nodes = {},
        fallbackName = "surefooted",
        includedInSheetAPI = true,
        fallbackBonus = { meleeHitPerRank = 1.0, rangedHitPerRank = 1.0 },
    },
    {
        key = "ANTICIPATION_WARRIOR",
        class = "WARRIOR",
        maxRank = 5,
        spells = { [12297] = true, [12750] = true, [12751] = true, [12752] = true, [12753] = true },
        nodes = {},
        fallbackName = "anticipation",
        includedInSheetAPI = true,
        fallbackBonus = { defensePerRank = 4 },
    },
    {
        key = "ANTICIPATION_PALADIN",
        class = "PALADIN",
        maxRank = 5,
        spells = { [20096] = true, [20097] = true, [20098] = true, [20099] = true, [20100] = true },
        nodes = {},
        fallbackName = "anticipation",
        includedInSheetAPI = true,
        fallbackBonus = { defensePerRank = 4 },
    },
    {
        key = "WEAPON_EXPERTISE",
        class = "ROGUE",
        maxRank = 2,
        spells = { [30919] = true, [30920] = true },
        nodes = {},
        fallbackName = "weapon expertise",
        includedInSheetAPI = true,
        fallbackBonus = { expertisePerRank = 1.25 },
    },
    {
        key = "SHIELD_SPEC_WARRIOR",
        class = "WARRIOR",
        maxRank = 5,
        spells = { [12298] = true, [12724] = true, [12725] = true, [12726] = true, [12727] = true },
        nodes = {},
        fallbackName = "shield specialization",
        includedInSheetAPI = true,
        fallbackBonus = { blockPerRank = 1.0 },
    },
    {
        key = "SHIELD_SPEC_PALADIN",
        class = "PALADIN",
        maxRank = 3,
        spells = { [20148] = true, [20149] = true, [20150] = true },
        nodes = {},
        fallbackName = "shield specialization",
        includedInSheetAPI = true,
        fallbackBonus = { blockPerRank = 1.0 },
    },
    {
        key = "DEFLECTION_WARRIOR",
        class = "WARRIOR",
        maxRank = 5,
        spells = { [16462] = true, [16463] = true, [16464] = true, [16465] = true, [16466] = true },
        nodes = {},
        fallbackName = "deflection",
        includedInSheetAPI = true,
        fallbackBonus = { parryPerRank = 1.0 },
    },
    {
        key = "DEFLECTION_PALADIN",
        class = "PALADIN",
        maxRank = 5,
        spells = { [20060] = true, [20061] = true, [20062] = true, [20063] = true, [20064] = true },
        nodes = {},
        fallbackName = "deflection",
        includedInSheetAPI = true,
        fallbackBonus = { parryPerRank = 1.0 },
    },
    {
        key = "DEFLECTION_ROGUE",
        class = "ROGUE",
        maxRank = 5,
        spells = { [13713] = true, [13853] = true, [13854] = true, [13855] = true, [13856] = true },
        nodes = {},
        fallbackName = "deflection",
        includedInSheetAPI = true,
        fallbackBonus = { parryPerRank = 1.0 },
    },
}

------------------------------------------------------------------------
-- 3. School- / Ability-Specific Hidden Cap Talents
-- (Not exposed by global GetSpellHitModifier; applied strictly to matching specs)
------------------------------------------------------------------------

local SPECIAL_CAP_RULES = {
    {
        key = "SHADOW_FOCUS",
        class = "PRIEST",
        maxRank = 5,
        spells = { [15260] = true, [15327] = true, [15328] = true, [15329] = true, [15330] = true },
        nodes = {},
        fallbackName = "shadow focus",
        displayName = "Shadow Focus",
        specs = { SHADOW = true },
        stat = "spellHit",
        perRank = 2.0,
        schoolSpecific = true,
    },
    {
        key = "FOCUSED_POWER",
        class = "PRIEST",
        maxRank = 2,
        spells = { [33192] = true, [33193] = true },
        nodes = {},
        fallbackName = "focused power",
        displayName = "Focused Power",
        specs = { SMITE = true, HOLY = true, DISCIPLINE = true },
        stat = "spellHit",
        perRank = 2.0,
        schoolSpecific = true,
    },
    {
        key = "SUPPRESSION",
        class = "WARLOCK",
        maxRank = 5,
        spells = { [18174] = true, [18175] = true, [18176] = true, [18177] = true, [18178] = true },
        nodes = {},
        fallbackName = "suppression",
        displayName = "Suppression",
        specs = { AFFLICTION = true },
        stat = "spellHit",
        perRank = 2.0,
        schoolSpecific = true,
    },
    {
        key = "ARCANE_FOCUS",
        class = "MAGE",
        maxRank = 5,
        spells = { [11222] = true, [12839] = true, [12840] = true, [12841] = true, [12842] = true },
        nodes = {},
        fallbackName = "arcane focus",
        displayName = "Arcane Focus",
        specs = { ARCANE = true },
        stat = "spellHit",
        perRank = 2.0,
        schoolSpecific = true,
    },
    {
        key = "ELEMENTAL_PRECISION_MAGE",
        class = "MAGE",
        maxRank = 3,
        spells = { [29438] = true, [29439] = true, [29440] = true },
        nodes = {},
        fallbackName = "elemental precision",
        displayName = "Elemental Precision",
        specs = { FIRE = true, FROST = true },
        stat = "spellHit",
        perRank = 1.0,
        schoolSpecific = true,
    },
    {
        key = "ELEMENTAL_PRECISION_SHAMAN",
        class = "SHAMAN",
        maxRank = 3,
        spells = { [30672] = true, [30673] = true, [30674] = true },
        nodes = {},
        fallbackName = "elemental precision",
        displayName = "Elemental Precision",
        specs = { ELEMENTAL = true, ENHANCEMENT = true },
        stat = "spellHit",
        perRank = 2.0,
        schoolSpecific = true,
    },
    {
        key = "NATURES_GUIDANCE",
        class = "SHAMAN",
        maxRank = 3,
        spells = { [16180] = true, [16196] = true, [16198] = true },
        nodes = {},
        fallbackName = "nature's guidance",
        displayName = "Nature's Guidance",
        specs = { ELEMENTAL = true, ENHANCEMENT = true, RESTORATION = true },
        stat = "allHit",
        perRank = 1.0,
        schoolSpecific = false, -- check against API delta to avoid double-counting
    },
    {
        key = "BALANCE_OF_POWER",
        class = "DRUID",
        maxRank = 2,
        spells = { [33592] = true, [33596] = true },
        nodes = {},
        fallbackName = "balance of power",
        displayName = "Balance of Power",
        specs = { BALANCE = true },
        stat = "spellHit",
        perRank = 2.0,
        schoolSpecific = false,
    },
}

------------------------------------------------------------------------
-- 4. Active Combat Buff Offsets (Talent- or Spell-Gated)
-- Applied when talented/known AND NOT currently active in player auras
-- (if buff aura IS active, client API already includes it -> offset = 0).
------------------------------------------------------------------------

local COMBAT_BUFF_RULES = {
    {
        key = "HOLY_SHIELD",
        class = "PALADIN",
        maxRank = 1,
        spells = { [20925] = true, [20927] = true, [20928] = true, [27179] = true, [48952] = true },
        auraSpells = { [20925] = true, [20927] = true, [20928] = true, [27179] = true, [48952] = true },
        nodes = {},
        fallbackName = "holy shield",
        displayName = "Holy Shield",
        auraAliases = {
            "holy shield", "heiliger schild", "bouclier sacré", "escudo sagrado",
            "scudo sacro", "щит небес", "신성한 방패", "神圣之盾", "神聖之盾",
        },
        roles = { TANK = true },
        stat = "block",
        bonus = 30.0,
    },
    {
        key = "REDOUBT",
        class = "PALADIN",
        maxRank = 5,
        spells = { [20127] = true, [20128] = true, [20129] = true, [20130] = true, [20131] = true, [20135] = true },
        auraSpells = { [20128] = true, [20135] = true },
        nodes = {},
        fallbackName = "redoubt",
        displayName = "Redoubt",
        auraAliases = { "redoubt", "verschanzen", "redoute", "baluarte" },
        roles = { TANK = true },
        stat = "block",
        bonus = 0, -- reactive proc; tracked only to detect live aura status
    },
    {
        key = "SHIELD_BLOCK",
        class = "WARRIOR",
        maxRank = 1,
        spells = { [2565] = true },
        auraSpells = { [2565] = true },
        nodes = {},
        fallbackName = "shield block",
        displayName = "Shield Block",
        auraAliases = { "shield block", "schildblock", "maîtrise du blocage", "bloquear con escudo" },
        roles = { TANK = true },
        stat = "block",
        bonus = 0, -- short cooldown; tracked to reflect live aura without skewing passive gear weight
    },
}

local ALL_CATALOG = {}
for _, d in ipairs(STAT_SCALING_CATALOG) do ALL_CATALOG[#ALL_CATALOG + 1] = d end
for _, d in ipairs(PASSIVE_SHEET_CATALOG) do ALL_CATALOG[#ALL_CATALOG + 1] = d end
for _, d in ipairs(SPECIAL_CAP_RULES) do ALL_CATALOG[#ALL_CATALOG + 1] = d end
for _, d in ipairs(COMBAT_BUFF_RULES) do ALL_CATALOG[#ALL_CATALOG + 1] = d end

local state = {
    readable = false,
    trees = {},
    byKey = {},
    bySpellID = {},
    byNodeID = {},
    byName = {},
    purchasedNodes = {},
}

local function MatchTalentDefinition(def, nodeID, spellID, lowerName)
    if nodeID and def.nodes and def.nodes[nodeID] then
        return true
    end
    if spellID and def.spells and def.spells[spellID] then
        return true
    end
    if lowerName and lowerName ~= "" and def.class == ns.class then
        if lowerName == def.fallbackName then
            return true
        end
        local aliases = ns.locale and ns.locale.talents and ns.locale.talents[def.fallbackName]
        if aliases then
            for i = 1, #aliases do
                if lowerName == aliases[i] then
                    return true
                end
            end
        end
    end
    return false
end

local function ReadTraitData()
    local traits = _G.C_Traits
    local classTalents = _G.C_ClassTalents
    if not (traits and classTalents and classTalents.GetActiveConfigID and traits.GetConfigInfo) then
        return nil
    end

    local configID = ns.PlainNumber(classTalents.GetActiveConfigID())
    if not configID then
        return nil
    end
    local config = traits.GetConfigInfo(configID)
    local treeID = type(config) == "table" and type(config.treeIDs) == "table" and config.treeIDs[1]
    if not treeID then
        return nil
    end

    local result = {
        readable = true,
        trees = {},
        byKey = {},
        bySpellID = {},
        byNodeID = {},
        byName = {},
        purchasedNodes = {},
    }

    local displays = traits.GetGroupDisplayInfoByTreeID and traits.GetGroupDisplayInfoByTreeID(treeID) or {}
    local groupIDs = {}
    local spentByGroup = {}

    for i, display in ipairs(displays) do
        groupIDs[i] = display.groupID
    end
    if #groupIDs > 0 and traits.GetGroupCurrencyInfo then
        for _, group in ipairs(traits.GetGroupCurrencyInfo(configID, groupIDs) or {}) do
            local currency = type(group.currencyInfos) == "table" and group.currencyInfos[1]
            spentByGroup[group.traitNodeGroupID] = currency and ns.PlainNumber(currency.spent, 0) or 0
        end
    end

    for i, display in ipairs(displays) do
        local dName = ns.PlainText(display.displayName) or ""
        result.trees[i] = {
            index = i,
            groupID = display.groupID,
            rawName = dName,
            name = ns.Lower(dName),
            spent = spentByGroup[display.groupID] or 0,
        }
    end

    local nodes = traits.GetTreeNodes and traits.GetTreeNodes(treeID) or {}
    for _, nodeID in ipairs(nodes) do
        local node = traits.GetNodeInfo(configID, nodeID)
        local rank = type(node) == "table" and ns.PlainNumber(node.ranksPurchased, 0) or 0
        if rank > 0 then
            result.byNodeID[nodeID] = rank
            local entryID = (type(node.activeEntry) == "table" and node.activeEntry.entryID)
                or (type(node.entryIDs) == "table" and node.entryIDs[1])
            local entry = entryID and traits.GetEntryInfo(configID, entryID)
            local defID = type(entry) == "table" and entry.definitionID
            local defInfo = defID and traits.GetDefinitionInfo(defID)

            local spellID = type(defInfo) == "table" and ns.PlainNumber(defInfo.spellID) or nil
            local rawName = type(defInfo) == "table" and ns.PlainText(defInfo.overrideName) or nil
            if not rawName and spellID and C_Spell and C_Spell.GetSpellName then
                rawName = ns.PlainText(C_Spell.GetSpellName(spellID))
            end
            local lowerName = rawName and ns.Lower(rawName) or ""

            if spellID then
                result.bySpellID[spellID] = rank
            end
            if lowerName ~= "" then
                result.byName[lowerName] = rank
            end

            result.purchasedNodes[#result.purchasedNodes + 1] = {
                nodeID = nodeID,
                spellID = spellID,
                name = rawName or ("Node#" .. tostring(nodeID)),
                rank = rank,
            }

            for _, def in ipairs(ALL_CATALOG) do
                if MatchTalentDefinition(def, nodeID, spellID, lowerName) then
                    result.byKey[def.key] = math.max(result.byKey[def.key] or 0, rank)
                end
            end
        end
    end

    return result
end

function Talents:Refresh()
    local ok, data = pcall(ReadTraitData)
    if ok and data then
        state = data
    else
        if not ok then
            ns.ReportError(data)
        end
        state = {
            readable = false,
            trees = {},
            byKey = {},
            bySpellID = {},
            byNodeID = {},
            byName = {},
            purchasedNodes = {},
        }
    end
end

------------------------------------------------------------------------
-- Active Player Aura Detection (Language-Independent spellID + Alias)
------------------------------------------------------------------------

function Talents:IsAuraActive(spellIDSet, aliasList)
    if C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID and spellIDSet then
        for spellID in pairs(spellIDSet) do
            local ok, aura = pcall(C_UnitAuras.GetPlayerAuraBySpellID, spellID)
            if ok and ns.Plain(aura) ~= nil then
                return true
            end
        end
    end

    local aliasMap
    if aliasList and #aliasList > 0 then
        aliasMap = {}
        for i = 1, #aliasList do
            aliasMap[aliasList[i]] = true
        end
    end

    if C_UnitAuras and C_UnitAuras.GetAuraDataByIndex then
        for i = 1, 40 do
            local ok, aura = pcall(C_UnitAuras.GetAuraDataByIndex, "player", i, "HELPFUL")
            if not ok or not aura then
                break
            end
            local sid = ns.PlainNumber(aura.spellId)
            if sid and spellIDSet and spellIDSet[sid] then
                return true
            end
            if aliasMap then
                local aname = ns.PlainText(aura.name)
                if aname and aliasMap[ns.Lower(aname)] then
                    return true
                end
            end
        end
    elseif type(_G.UnitBuff) == "function" then
        for i = 1, 40 do
            local ok, name, _, _, _, _, _, _, _, _, sid = pcall(_G.UnitBuff, "player", i)
            if not ok or not name then
                break
            end
            sid = ns.PlainNumber(sid)
            if sid and spellIDSet and spellIDSet[sid] then
                return true
            end
            if aliasMap then
                local plainName = ns.PlainText(name)
                if plainName and aliasMap[ns.Lower(plainName)] then
                    return true
                end
            end
        end
    end

    return false
end

------------------------------------------------------------------------
-- Public Queries
------------------------------------------------------------------------

function Talents:GetRank(talentKey)
    if not state.readable then
        return 0
    end
    return state.byKey[talentKey] or 0
end

function Talents:GetRankBySpellOrNode(spellID, nodeID)
    if not state.readable then
        return 0
    end
    if nodeID and state.byNodeID[nodeID] then
        return state.byNodeID[nodeID]
    end
    if spellID and state.bySpellID[spellID] then
        return state.bySpellID[spellID]
    end
    return 0
end

function Talents:GetPrimaryTree()
    if not state.readable or #state.trees == 0 then
        return nil, nil, 0, {}
    end
    local bestTree, bestIndex
    for i, tree in ipairs(state.trees) do
        if tree.spent > 0 and (not bestTree or tree.spent > bestTree.spent) then
            bestTree, bestIndex = tree, i
        end
    end
    if bestTree then
        return bestIndex, bestTree.name, bestTree.spent, state.trees
    end
    return nil, nil, 0, state.trees
end

function Talents:GetStatWeightAdditions(classToken, specKey)
    local adds = {}
    if not state.readable then
        return adds
    end
    for _, def in ipairs(STAT_SCALING_CATALOG) do
        if def.class == classToken and def.statAdd and def.statAdd[specKey] then
            local rank = state.byKey[def.key] or 0
            if rank > 0 then
                local share = math.min(rank / (def.maxRank or 1), 1)
                for statKey, amount in pairs(def.statAdd[specKey]) do
                    adds[statKey] = (adds[statKey] or 0) + amount * share
                end
            end
        end
    end
    return adds
end

-- Fallback bonuses ONLY used when the client's sheet API is unavailable.
function Talents:GetFallbackSheetBonuses()
    local bonuses = {
        meleeHit = 0,
        rangedHit = 0,
        spellHit = 0,
        defense = 0,
        expertise = 0,
        block = 0,
        parry = 0,
    }
    if not state.readable then
        return bonuses
    end
    for _, def in ipairs(PASSIVE_SHEET_CATALOG) do
        if def.class == ns.class and def.fallbackBonus then
            local rank = state.byKey[def.key] or 0
            if rank > 0 then
                local b = def.fallbackBonus
                if b.meleeHitPerRank then bonuses.meleeHit = bonuses.meleeHit + b.meleeHitPerRank * rank end
                if b.rangedHitPerRank then bonuses.rangedHit = bonuses.rangedHit + b.rangedHitPerRank * rank end
                if b.spellHitPerRank then bonuses.spellHit = bonuses.spellHit + b.spellHitPerRank * rank end
                if b.defensePerRank then bonuses.defense = bonuses.defense + b.defensePerRank * rank end
                if b.expertisePerRank then bonuses.expertise = bonuses.expertise + b.expertisePerRank * rank end
                if b.blockPerRank then bonuses.block = bonuses.block + b.blockPerRank * rank end
                if b.parryPerRank then bonuses.parry = bonuses.parry + b.parryPerRank * rank end
            end
        end
    end
    return bonuses
end

-- Computes profile-specific offsets that are NOT reflected in the static character sheet:
--   1. Active combat buffs from talents (e.g. Holy Shield +30% Block when talented & buff inactive)
--   2. School- or ability-specific hit talents for matching specs (without double-counting API values)
function Talents:GetProfileOffsets(scale, gearSums, rawAPIs)
    local offsets = {
        meleeHit = 0,
        rangedHit = 0,
        spellHit = 0,
        block = 0,
        notes = {},
    }
    if not scale then
        return offsets
    end

    local isTank = scale.isTank or (scale.caps and scale.caps.tankExpertiseMode)
    local gearHit = (gearSums and gearSums.HIT) or 0
    local apiSpellDelta = math.max(0, ((rawAPIs and rawAPIs.apiSpellHit) or 0) - gearHit)
    local apiMeleeDelta = math.max(0, ((rawAPIs and rawAPIs.apiMeleeHit) or 0) - gearHit)

    -- 1. Active combat buff offsets (e.g., Paladin Holy Shield)
    for _, rule in ipairs(COMBAT_BUFF_RULES) do
        if rule.class == ns.class then
            local known = (state.readable and (state.byKey[rule.key] or 0) > 0)
            if not known and rule.spells and type(_G.IsSpellKnown) == "function" then
                for sid in pairs(rule.spells) do
                    local ok, has = pcall(_G.IsSpellKnown, sid)
                    if ok and ns.Plain(has) then
                        known = true
                        break
                    end
                end
            end

            if known then
                local auraActive = self:IsAuraActive(rule.auraSpells, rule.auraAliases)
                local appliesRole = (not rule.roles) or (isTank and rule.roles.TANK)
                if auraActive then
                    -- Buff is already included live in GetBlockChance() -> offset MUST be 0
                    offsets.notes[#offsets.notes + 1] = rule.displayName .. " (live)"
                elseif appliesRole and rule.bonus > 0 and rule.stat == "block" then
                    offsets.block = offsets.block + rule.bonus
                    offsets.notes[#offsets.notes + 1] = ("%s +%d%%"):format(rule.displayName, rule.bonus)
                end
            end
        end
    end

    -- 2. School- / spec-specific hidden hit talents
    if state.readable then
        local specKey = scale.specKey
        for _, rule in ipairs(SPECIAL_CAP_RULES) do
            if rule.class == ns.class then
                local rank = state.byKey[rule.key] or 0
                if rank > 0 then
                    local matchesSpec = (not rule.specs) or (specKey and rule.specs[specKey])
                    if matchesSpec then
                        local rawVal = math.min(rank, rule.maxRank or rank) * rule.perRank
                        if rule.stat == "spellHit" then
                            local addVal = rule.schoolSpecific and rawVal or math.max(0, rawVal - apiSpellDelta)
                            if addVal > 0 then
                                offsets.spellHit = offsets.spellHit + addVal
                                offsets.notes[#offsets.notes + 1] = ("%s +%s%%"):format(rule.displayName, ns.Format(addVal, 1))
                            end
                        elseif rule.stat == "allHit" then
                            local addSpell = math.max(0, rawVal - apiSpellDelta)
                            local addMelee = math.max(0, rawVal - apiMeleeDelta)
                            offsets.spellHit = offsets.spellHit + addSpell
                            offsets.meleeHit = offsets.meleeHit + addMelee
                            offsets.rangedHit = offsets.rangedHit + addMelee
                            if addSpell > 0 or addMelee > 0 then
                                offsets.notes[#offsets.notes + 1] = ("%s +%s%%"):format(rule.displayName, ns.Format(math.max(addSpell, addMelee), 1))
                            end
                        end
                    end
                end
            end
        end
    end

    return offsets
end

-- Non-stacking +60 Raid Resistance Buffs per Magic School
local RAID_RESIST_BUFF_RULES = {
    FIRE_RES = {
        auraSpells = {
            [19891] = true, [19899] = true, [19900] = true, -- Paladin Fire Resistance Aura
            [8184] = true, [10537] = true, [10538] = true,  -- Shaman Fire Resistance Totem
            [8185] = true, [10534] = true, [10535] = true,
        },
        auraAliases = {
            "fire resistance aura", "fire resistance totem",
            "aura des feuerwiderstands", "totem des feuerwiderstands",
            "aura de résistance au feu", "totem de résistance au feu",
            "aura de resistencia al fuego", "tótem de resistencia al fuego", "totem de resistencia al fuego",
        },
    },
    FROST_RES = {
        auraSpells = {
            [19888] = true, [19897] = true, [19898] = true, -- Paladin Frost Resistance Aura
            [8181] = true, [10478] = true, [10479] = true,  -- Shaman Frost Resistance Totem
            [8182] = true, [10476] = true, [10477] = true,
        },
        auraAliases = {
            "frost resistance aura", "frost resistance totem",
            "aura des frostwiderstands", "totem des frostwiderstands",
            "aura de résistance au givre", "totem de résistance au givre",
            "aura de resistencia a la escarcha", "tótem de resistencia a la escarcha", "totem de resistencia a la escarcha",
        },
    },
    NATURE_RES = {
        auraSpells = {
            [10595] = true, [10600] = true, [10601] = true, -- Shaman Nature Resistance Totem
            [10596] = true, [10598] = true, [10599] = true,
            [20043] = true, [20190] = true,                 -- Hunter Aspect of the Wild
        },
        auraAliases = {
            "nature resistance totem", "aspect of the wild",
            "totem des naturwiderstands", "aspekt der wildnis",
            "totem de résistance à la nature", "aspect de la nature",
            "tótem de resistencia a la naturaleza", "totem de resistencia a la naturaleza", "aspecto salvaje",
        },
    },
    SHADOW_RES = {
        auraSpells = {
            [19876] = true, [19895] = true, [19896] = true, -- Paladin Shadow Resistance Aura
            [976] = true, [10957] = true, [10958] = true,   -- Priest Shadow Protection
            [27683] = true,                                 -- Priest Prayer of Shadow Protection
        },
        auraAliases = {
            "shadow resistance aura", "shadow protection", "prayer of shadow protection",
            "aura des schattenwiderstands", "schattenschutz", "gebet des schattenschutzes",
            "aura de résistance à l'ombre", "protection contre l'ombre", "prière de protection contre l'ombre",
            "aura de resistencia a las sombras", "protección contra las sombras", "rezo de protección contra las sombras",
        },
    },
    ARCANE_RES = {
        auraSpells = {},
        auraAliases = {
            "arcane resistance aura", "arcane resistance",
            "aura des arkanwiderstands",
        },
    },
}

function Talents:GetRaidResistBuffOffsets(scale)
    local resistOffsets = {
        FIRE_RES = 0,
        FROST_RES = 0,
        NATURE_RES = 0,
        SHADOW_RES = 0,
        ARCANE_RES = 0,
    }
    local resistBuffLive = {
        FIRE_RES = false,
        FROST_RES = false,
        NATURE_RES = false,
        SHADOW_RES = false,
        ARCANE_RES = false,
    }
    local includeBuff = scale and scale.caps and (scale.caps.includeRaidResistBuff == true) or false

    for statKey, rule in pairs(RAID_RESIST_BUFF_RULES) do
        local isActive = self:IsAuraActive(rule.auraSpells, rule.auraAliases)
        resistBuffLive[statKey] = isActive and true or false
        if includeBuff and not isActive then
            resistOffsets[statKey] = 60
        end
    end

    return resistOffsets, resistBuffLive
end

function Talents:GetActiveTalentList()
    local out = {}
    if not state.readable then
        return out
    end
    for _, def in ipairs(ALL_CATALOG) do
        if def.class == ns.class then
            local rank = state.byKey[def.key] or 0
            if rank > 0 then
                out[#out + 1] = {
                    key = def.key,
                    name = def.displayName or def.fallbackName,
                    rank = rank,
                    maxRank = def.maxRank,
                }
            end
        end
    end
    return out
end

function Talents:GetSummary()
    if not state.readable then
        return "C_Traits unavailable"
    end
    local parts = {}
    for i, tree in ipairs(state.trees) do
        parts[i] = ("%s %d"):format(tree.rawName ~= "" and tree.rawName or ("Tree" .. i), tree.spent)
    end
    return #parts > 0 and table.concat(parts, " / ") or "no trees"
end

function Talents:GetDumpData()
    return {
        readable = state.readable,
        trees = state.trees,
        byKey = state.byKey,
        nodes = state.purchasedNodes,
    }
end

function Talents:Init()
    self:Refresh()
end
