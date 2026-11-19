-- PawnDynamic (MIT License)
-- Slot comparison, weapon-pair bag partner matching, and dynamic Cap-Delta upgrade advisor.

local _, ns = ...

local Upgrades = ns:NewModule("Upgrades")
local L = ns.L

local MAIN_SLOT, OFF_SLOT = 16, 17
local MIN_GAIN_PCT = 2.0
local MIN_GAIN_POINTS = 0.1
local ARMOR_CLASS = 4
local WEAPON_CLASS = 2
local DAGGER_SUBCLASS = 15

local FIXED_SLOTS = {
    INVTYPE_HEAD = { 1 },
    INVTYPE_NECK = { 2 },
    INVTYPE_SHOULDER = { 3 },
    INVTYPE_CHEST = { 5 },
    INVTYPE_ROBE = { 5 },
    INVTYPE_WAIST = { 6 },
    INVTYPE_LEGS = { 7 },
    INVTYPE_FEET = { 8 },
    INVTYPE_WRIST = { 9 },
    INVTYPE_HAND = { 10 },
    INVTYPE_FINGER = { 11, 12 },
    INVTYPE_TRINKET = { 13, 14 },
    INVTYPE_CLOAK = { 15 },
    INVTYPE_RANGED = { 18 },
    INVTYPE_RANGEDRIGHT = { 18 },
    INVTYPE_THROWN = { 18 },
    INVTYPE_RELIC = { 18 },
}

local MAIN_HAND_LOCS = { INVTYPE_WEAPON = true, INVTYPE_WEAPONMAINHAND = true }
local OFF_HAND_LOCS = { INVTYPE_WEAPONOFFHAND = true, INVTYPE_SHIELD = true, INVTYPE_HOLDABLE = true }

local ARMOR_PROFICIENCY = {
    WARRIOR = { [1] = 1, [2] = 1, [3] = 1, [4] = 40, [6] = 1 },
    PALADIN = { [1] = 1, [2] = 1, [3] = 1, [4] = 40, [6] = 1 },
    HUNTER  = { [1] = 1, [2] = 1, [3] = 40 },
    SHAMAN  = { [1] = 1, [2] = 1, [3] = 40, [6] = 1 },
    ROGUE   = { [1] = 1, [2] = 1 },
    DRUID   = { [1] = 1, [2] = 1 },
    MAGE    = { [1] = 1 },
    PRIEST  = { [1] = 1 },
    WARLOCK = { [1] = 1 },
}

local function PlayerLevel()
    return ns.PlainNumber(UnitLevel and UnitLevel("player"), 1)
end

local function CanDualWield()
    if type(_G.CanDualWield) == "function" then
        local ok, res = pcall(_G.CanDualWield)
        if ok then
            return ns.Plain(res) and true or false
        end
    end
    return ns.class == "ROGUE" or ((ns.class == "WARRIOR" or ns.class == "HUNTER") and PlayerLevel() >= 20)
end

local function EquippedInfo(slot)
    local link = ns.PlainText(GetInventoryItemLink and GetInventoryItemLink("player", slot))
    if not link then
        return nil, false
    end
    local info = ns.Parser:Get(link)
    if info == nil then
        return nil, true
    end
    return info or nil, false
end

local function IsWeapon(info)
    return info and info.classID == WEAPON_CLASS
end

local function MainHandAllowed(info)
    if ns.class == "ROGUE" and ns.char and ns.char.daggers then
        return IsWeapon(info) and info.subclassID == DAGGER_SUBCLASS
    end
    return true
end

function Upgrades:IsUsable(info, scale)
    if not info or info.unusable or (info.minLevel or 0) > PlayerLevel() then
        return false
    end
    if not info.colored and info.classID == ARMOR_CLASS then
        local sub = info.subclassID
        if sub and ((sub >= 1 and sub <= 4) or sub == 6) then
            local req = ARMOR_PROFICIENCY[ns.class] and ARMOR_PROFICIENCY[ns.class][sub]
            if not req or PlayerLevel() < req then
                return false
            end
        end
    end
    if scale then
        if scale.unusableTypes and info.itemTypeKey and scale.unusableTypes[info.itemTypeKey] then
            return false
        end
        local loc = info.equipLoc
        if scale.hide2H and loc == "INVTYPE_2HWEAPON" then
            return false
        end
        if scale.hide1H and (MAIN_HAND_LOCS[loc] or OFF_HAND_LOCS[loc]) then
            return false
        end
        if scale.unusableTypes and scale.unusableTypes.IsOffHand and loc == "INVTYPE_WEAPONOFFHAND" then
            return false
        end
        if scale.unusableTypes and scale.unusableTypes.IsFrill and loc == "INVTYPE_HOLDABLE" then
            return false
        end
    end
    return true
end

function Upgrades:IsWorn(link)
    local target = ns.Parser.BaseItemString(link)
    if not target then
        return false
    end
    for slot = 1, 18 do
        local worn = ns.PlainText(GetInventoryItemLink and GetInventoryItemLink("player", slot))
        if worn and ns.Parser.BaseItemString(worn) == target then
            return true
        end
    end
    return false
end

------------------------------------------------------------------------
-- Bag Weapon Partner Lookup (for 1H / 2H transitions)
------------------------------------------------------------------------

local partnerCache, partnerGen, partnerBagGen = {}, 0, 0

local function ReadBagPartners(scale, replacedPair)
    if partnerGen ~= ns.generation or partnerBagGen ~= ns.bagGeneration then
        partnerCache, partnerGen, partnerBagGen = {}, ns.generation, ns.bagGeneration
    end
    local cacheKey = scale.id
    if partnerCache[cacheKey] then
        return partnerCache[cacheKey]
    end

    local partners = { main = {}, off = {} }
    partnerCache[cacheKey] = partners
    local dual = CanDualWield()
    local seen = {}

    if C_Container and C_Container.GetContainerNumSlots and C_Container.GetContainerItemInfo then
        for bag = 0, NUM_BAG_SLOTS or 4 do
            local numSlots = C_Container.GetContainerNumSlots(bag) or 0
            for slot = 1, numSlots do
                local item = C_Container.GetContainerItemInfo(bag, slot)
                local link = item and ns.PlainText(item.hyperlink)
                local info = link and ns.Parser:Get(link)
                if info and not seen[info.itemString] and Upgrades:IsUsable(info, scale) then
                    seen[info.itemString] = true
                    local loc = info.equipLoc
                    if MAIN_HAND_LOCS[loc] and MainHandAllowed(info) then
                        local score = ns.Scales:ScoreItem(info, scale, { hand = "main", replacedItems = replacedPair })
                        partners.main[#partners.main + 1] = { info = info, score = score }
                    end
                    if loc == "INVTYPE_SHIELD" or loc == "INVTYPE_HOLDABLE"
                        or (dual and (loc == "INVTYPE_WEAPONOFFHAND" or loc == "INVTYPE_WEAPON")) then
                        local score = ns.Scales:ScoreItem(info, scale, { hand = "off", replacedItems = replacedPair })
                        partners.off[#partners.off + 1] = { info = info, score = score }
                    end
                end
            end
        end
    end
    return partners
end

local function BestPartner(hand, excludeItemString, scale, replacedPair)
    local best
    local list = ReadBagPartners(scale, replacedPair)[hand]
    for _, entry in ipairs(list) do
        if entry.info.itemString ~= excludeItemString and entry.score > 0 and (not best or entry.score > best.score) then
            best = entry
        end
    end
    return best
end

------------------------------------------------------------------------
-- Dominance & Evaluation
------------------------------------------------------------------------

local function StrictlyDominates(newInfo, oldInfo, scale)
    if not oldInfo or #oldInfo.unread > 0 or oldInfo.hasProcOrUse then
        return false
    end
    local weights = ns.Caps:GetEffectiveWeights(scale)
    local better = false

    local function Compare(a, b, w)
        if not w or w == 0 then
            return true
        end
        a, b = a or 0, b or 0
        if w < 0 then
            a, b = b, a
        end
        if a < b then
            return false
        end
        if a > b then
            better = true
        end
        return true
    end

    for statKey, w in pairs(weights) do
        if not Compare(newInfo.stats[statKey], oldInfo.stats[statKey], w) then
            return false
        end
    end

    local dpsKey = newInfo.ranged and "RANGED_DPS" or "MELEE_DPS"
    local hitKey = newInfo.ranged and "RANGED_HIT" or "MELEE_HIT"
    local spdKey = newInfo.ranged and "RANGED_SPEED" or "MELEE_SPEED"
    if not Compare(newInfo.dps, oldInfo.dps, weights[dpsKey])
        or not Compare(newInfo.hit, oldInfo.hit, weights[hitKey])
        or not Compare(newInfo.speed, oldInfo.speed, weights[spdKey]) then
        return false
    end

    for subID, val in pairs(oldInfo.skills or {}) do
        if ((newInfo.skills and newInfo.skills[subID]) or 0) < val then
            return false
        end
    end
    return better
end

local function EvaluateItem(link, scale)
    local info = ns.Parser:Get(link)
    if not info then
        return info
    end

    local loc = info.equipLoc
    local usable = Upgrades:IsUsable(info, scale)
    local slots = FIXED_SLOTS[loc]

    local score = 0
    local currentScore = nil
    local rawScore = 0
    local anyCapped = false
    local baselineScore = 0
    local candidateScore = 0
    local chosenSlot = nil
    local partner = nil
    local empty = false
    local blind = false
    local dominant = false
    local replacedItems = {}

    if slots then
        local weakestWorn
        local weakestVal
        for _, slotID in ipairs(slots) do
            local worn, loading = EquippedInfo(slotID)
            if loading then
                return nil
            end
            local wornVal = 0
            if worn then
                wornVal = ns.Scales:ScoreItem(worn, scale, { replacedItems = { worn } })
            end
            if not weakestVal or wornVal < weakestVal or (wornVal == weakestVal and not worn) then
                weakestVal = wornVal
                chosenSlot = slotID
                weakestWorn = worn
            end
        end

        baselineScore = weakestVal or 0
        replacedItems = weakestWorn and { weakestWorn } or {}
        local evalRes
        score, evalRes = ns.Scales:ScoreItem(info, scale, { replacedItems = replacedItems })
        rawScore = evalRes and evalRes.rawScore or score
        anyCapped = evalRes and evalRes.anyCapped or false

        if info.isEnchanted then
            currentScore = ns.Scales:ScoreItem(info, scale, { replacedItems = replacedItems, useCurrent = true })
        end

        candidateScore = score
        empty = not weakestWorn
        dominant = StrictlyDominates(info, weakestWorn, scale)
        blind = weakestWorn and baselineScore <= 0
            and (loc == "INVTYPE_TRINKET" or loc == "INVTYPE_RELIC" or #weakestWorn.unread > 0 or weakestWorn.hasProcOrUse)
            or false

    elseif loc == "INVTYPE_2HWEAPON" or MAIN_HAND_LOCS[loc] or OFF_HAND_LOCS[loc] then
        local main, mainLoading = EquippedInfo(MAIN_SLOT)
        local off, offLoading = EquippedInfo(OFF_SLOT)
        if mainLoading or offLoading then
            return nil
        end

        replacedItems = {}
        if main then replacedItems[#replacedItems + 1] = main end
        if off then replacedItems[#replacedItems + 1] = off end

        local mainScore = main and ns.Scales:ScoreItem(main, scale, { hand = "main", replacedItems = replacedItems }) or 0
        local offScore = off and ns.Scales:ScoreItem(off, scale, { hand = "off", replacedItems = replacedItems }) or 0
        local twoHanded = main and main.equipLoc == "INVTYPE_2HWEAPON"
        local dual = CanDualWield()

        baselineScore = mainScore + offScore
        empty = not main and not off

        if loc == "INVTYPE_2HWEAPON" then
            local evalRes
            score, evalRes = ns.Scales:ScoreItem(info, scale, { hand = "main", replacedItems = replacedItems })
            rawScore = evalRes and evalRes.rawScore or score
            anyCapped = evalRes and evalRes.anyCapped or false
            if info.isEnchanted then
                currentScore = ns.Scales:ScoreItem(info, scale, { hand = "main", replacedItems = replacedItems, useCurrent = true })
            end
            candidateScore = score
            chosenSlot = MAIN_SLOT
            usable = usable and MainHandAllowed(info)

        elseif MAIN_HAND_LOCS[loc] then
            local canOffHand = (loc == "INVTYPE_WEAPON") and main and not twoHanded and dual and not (scale.unusableTypes and scale.unusableTypes.IsOffHand)
            if MainHandAllowed(info) then
                local evalRes
                score, evalRes = ns.Scales:ScoreItem(info, scale, { hand = "main", replacedItems = replacedItems })
                rawScore = evalRes and evalRes.rawScore or score
                anyCapped = evalRes and evalRes.anyCapped or false
                if info.isEnchanted then
                    currentScore = ns.Scales:ScoreItem(info, scale, { hand = "main", replacedItems = replacedItems, useCurrent = true })
                end
                candidateScore = score + offScore
                chosenSlot = MAIN_SLOT

                if twoHanded then
                    partner = BestPartner("off", info.itemString, scale, replacedItems)
                    if partner then
                        candidateScore = score + partner.score
                    end
                elseif main and dual and main.equipLoc == "INVTYPE_WEAPON" and not (scale.unusableTypes and scale.unusableTypes.IsOffHand) then
                    local swappedOff = ns.Scales:ScoreItem(main, scale, { hand = "off", replacedItems = replacedItems })
                    if score + swappedOff > candidateScore then
                        candidateScore = score + swappedOff
                    end
                end
            elseif canOffHand then
                local evalRes
                score, evalRes = ns.Scales:ScoreItem(info, scale, { hand = "off", replacedItems = replacedItems })
                rawScore = evalRes and evalRes.rawScore or score
                anyCapped = evalRes and evalRes.anyCapped or false
                candidateScore = 0
                chosenSlot = OFF_SLOT
            else
                local evalRes
                score, evalRes = ns.Scales:ScoreItem(info, scale, { hand = "off", replacedItems = replacedItems })
                rawScore = evalRes and evalRes.rawScore or score
                anyCapped = evalRes and evalRes.anyCapped or false
                candidateScore = 0
                chosenSlot = MAIN_SLOT
                usable = false
            end

            if canOffHand then
                local offVal = ns.Scales:ScoreItem(info, scale, { hand = "off", replacedItems = replacedItems })
                local paired = mainScore + offVal
                if paired > candidateScore then
                    candidateScore = paired
                    chosenSlot = OFF_SLOT
                    score = offVal
                end
            end
        else
            if loc == "INVTYPE_WEAPONOFFHAND" and not dual then
                usable = false
            end
            local evalRes
            score, evalRes = ns.Scales:ScoreItem(info, scale, { hand = "off", replacedItems = replacedItems })
            rawScore = evalRes and evalRes.rawScore or score
            anyCapped = evalRes and evalRes.anyCapped or false
            if info.isEnchanted then
                currentScore = ns.Scales:ScoreItem(info, scale, { hand = "off", replacedItems = replacedItems, useCurrent = true })
            end
            chosenSlot = OFF_SLOT
            if twoHanded then
                partner = BestPartner("main", info.itemString, scale, replacedItems)
                candidateScore = (partner and partner.score or 0) + score
            else
                candidateScore = mainScore + score
            end
        end
    else
        return false
    end

    local verdict = {
        score = score,
        currentScore = currentScore,
        rawScore = rawScore,
        anyCapped = anyCapped,
        baselineScore = baselineScore,
        candidateScore = candidateScore,
        slot = chosenSlot,
        usable = usable,
        upgrade = false,
        empty = empty,
        blind = blind,
    }

    if usable and not blind and (candidateScore > baselineScore + 0.01 or (dominant and candidateScore > baselineScore)) then
        local points = candidateScore - baselineScore
        if baselineScore > 0 then
            verdict.gain = (points / baselineScore) * 100
        elseif not empty and baselineScore <= 0 then
            verdict.points = points
        end
        verdict.upgrade = empty or dominant
            or ((not verdict.gain or verdict.gain >= MIN_GAIN_PCT) and points >= MIN_GAIN_POINTS)
        if verdict.upgrade and partner then
            verdict.partner = partner.info.name
        end
    end

    return verdict
end

------------------------------------------------------------------------
-- Verdict Cache & Public API
------------------------------------------------------------------------

local verdictCaches, cacheGen, cacheBagGen = {}, 0, 0

function Upgrades:Check(link, scale)
    local key = ns.Parser.FullItemString(link)
    if not key then
        return false
    end
    if cacheGen ~= ns.generation or cacheBagGen ~= ns.bagGeneration then
        verdictCaches, cacheGen, cacheBagGen = {}, ns.generation, ns.bagGeneration
    end
    scale = scale or ns.Scales:GetSelected()
    if not scale then
        return false
    end
    local scaleCache = verdictCaches[scale.id]
    if not scaleCache then
        scaleCache = {}
        verdictCaches[scale.id] = scaleCache
    end
    local cached = scaleCache[key]
    if cached == nil then
        cached = EvaluateItem(link, scale)
        if cached ~= nil then
            scaleCache[key] = cached
        end
    end
    return cached
end

function Upgrades:CheckAllTracked(link)
    local tracked = ns.Scales:GetTracked()
    local results = {}
    for i, scale in ipairs(tracked) do
        local v = self:Check(link, scale)
        if v == nil then
            return nil
        end
        results[i] = { scale = scale, verdict = v }
    end
    return results
end

function Upgrades.FormatGain(verdict, skipPartner)
    if not verdict then
        return ""
    end
    local text
    if verdict.gain then
        text = ("+%d%%"):format(math.max(1, math.floor(verdict.gain + 0.5)))
    elseif verdict.empty then
        text = L["fills an empty slot"]
    elseif verdict.points then
        text = L["+%s points"]:format(ns.Format(verdict.points))
    else
        text = L["replaces zero-score item"]
    end
    if verdict.partner and not skipPartner then
        text = L["%s with %s"]:format(text, verdict.partner)
    end
    return text
end

------------------------------------------------------------------------
-- Detailed Two-Item Comparison with Cap-Delta Breakdown (UI Tab 4)
------------------------------------------------------------------------

function Upgrades:CompareItems(leftLink, rightLink, scale)
    scale = scale or ns.Scales:GetSelected()
    if not scale then
        return nil
    end

    local leftInfo = leftLink and ns.Parser:Get(leftLink) or nil
    local rightInfo = rightLink and ns.Parser:Get(rightLink) or nil
    if not leftInfo and not rightInfo then
        return nil
    end

    local refInfo = leftInfo or rightInfo
    local slots = FIXED_SLOTS[refInfo.equipLoc]
    local replaced = {}
    if slots then
        local weakestWorn, weakestVal
        for _, slotID in ipairs(slots) do
            local worn = EquippedInfo(slotID)
            local val = worn and ns.Scales:ScoreItem(worn, scale, { replacedItems = { worn } }) or 0
            if not weakestVal or val < weakestVal then
                weakestVal = val
                weakestWorn = worn
            end
        end
        if weakestWorn then
            replaced[1] = weakestWorn
        end
    elseif refInfo.equipLoc == "INVTYPE_2HWEAPON" or MAIN_HAND_LOCS[refInfo.equipLoc] or OFF_HAND_LOCS[refInfo.equipLoc] then
        local m = EquippedInfo(MAIN_SLOT)
        local o = EquippedInfo(OFF_SLOT)
        if m then replaced[#replaced + 1] = m end
        if o then replaced[#replaced + 1] = o end
    end

    local useCur = ns.options and ns.options.showCurrentValues
    local leftEval = leftInfo and ns.Caps:EvaluateItemDelta(leftInfo, replaced, scale, { useCurrent = useCur, allowSelfSubtract = false })
        or { totalScore = 0, rawScore = 0, contributions = {} }
    local rightEval = rightInfo and ns.Caps:EvaluateItemDelta(rightInfo, replaced, scale, { useCurrent = useCur, allowSelfSubtract = false })
        or { totalScore = 0, rawScore = 0, contributions = {} }

    local statOrder = {}
    local seenStat = {}
    for _, group in ipairs(ns.Parser.statGroups) do
        for _, statKey in ipairs(group) do
            if leftEval.contributions[statKey] or rightEval.contributions[statKey] then
                statOrder[#statOrder + 1] = statKey
                seenStat[statKey] = true
            end
        end
    end
    for statKey in pairs(leftEval.contributions) do
        if not seenStat[statKey] then
            statOrder[#statOrder + 1] = statKey
            seenStat[statKey] = true
        end
    end
    for statKey in pairs(rightEval.contributions) do
        if not seenStat[statKey] then
            statOrder[#statOrder + 1] = statKey
            seenStat[statKey] = true
        end
    end

    local rows = {}
    for _, statKey in ipairs(statOrder) do
        local lc = leftEval.contributions[statKey]
        local rc = rightEval.contributions[statKey]
        rows[#rows + 1] = {
            statKey = statKey,
            label = ns.Parser.statLabels[statKey] or statKey,
            leftVal = lc and lc.rawAmount or 0,
            rightVal = rc and rc.rawAmount or 0,
            leftRawEP = lc and lc.rawEP or 0,
            rightRawEP = rc and rc.rawEP or 0,
            leftEffEP = lc and lc.effectiveEP or 0,
            rightEffEP = rc and rc.effectiveEP or 0,
            leftCapped = lc and lc.capped or false,
            rightCapped = rc and rc.capped or false,
        }
    end

    local diffEff = rightEval.totalScore - leftEval.totalScore
    local diffPct = leftEval.totalScore > 0 and (diffEff / leftEval.totalScore * 100) or nil

    return {
        leftInfo = leftInfo,
        rightInfo = rightInfo,
        leftRaw = leftEval.rawScore,
        leftEff = leftEval.totalScore,
        rightRaw = rightEval.rawScore,
        rightEff = rightEval.totalScore,
        diffEff = diffEff,
        diffPct = diffPct,
        rows = rows,
    }
end
