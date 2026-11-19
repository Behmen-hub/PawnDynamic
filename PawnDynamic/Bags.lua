-- PawnDynamic (MIT License)
-- Bag upgrade arrows (Blizzard, Bagnon, Baganator), Quest rewards (+ gold coin), Loot rolls, and Trainer lists.

local _, ns = ...

local Bags = ns:NewModule("Bags")
local L = ns.L

local ARROW_ATLAS = "bags-greenarrow"
local GOLD_COIN_TEX = "Interface\\MoneyFrame\\UI-GoldIcon"
local RETRY_DELAY = 0.5

local function TintTexture(tex, colorHex)
    local r, g, b = ns.Scales.HexToRGB(colorHex)
    if colorHex == "40ff40" or colorHex == "33ff99" then
        tex:SetDesaturated(false)
        tex:SetVertexColor(1, 1, 1)
    else
        tex:SetDesaturated(true)
        tex:SetVertexColor(r, g, b)
    end
end

local function GetVerdictsForLink(link)
    local tracked = ns.Scales:GetTracked()
    local mainScale = tracked[1]
    local secondScale = tracked[2]

    local mainV = mainScale and ns.Upgrades:Check(link, mainScale)
    local secondV = secondScale and ns.Upgrades:Check(link, secondScale)

    local mainUp = (mainV and mainV.upgrade) and true or false
    local secondUp = (secondV and secondV.upgrade) and true or false
    local loading = (mainScale and mainV == nil) or (secondScale and secondV == nil) or false
    return mainUp, secondUp, loading, mainScale, secondScale
end

local function UpdateSecondArrow(button, anchor, mainTex, mainShown, showSecond, secondScale)
    local arrow = button.PawnDynamicSecondArrow
    if not arrow then
        if not showSecond then
            return
        end
        arrow = button:CreateTexture(nil, "OVERLAY", nil, 7)
        arrow:SetAtlas(ARROW_ATLAS, true)
        button.PawnDynamicSecondArrow = arrow
    end
    if showSecond and secondScale then
        TintTexture(arrow, secondScale.colorHex)
        arrow:ClearAllPoints()
        if mainShown and mainTex then
            arrow:SetPoint("TOPRIGHT", mainTex, "TOPLEFT", 3, 0)
        else
            arrow:SetPoint("TOPRIGHT", anchor or button, "TOPRIGHT", 0, 0)
        end
    end
    arrow:SetShown(showSecond)
end

------------------------------------------------------------------------
-- Blizzard Bags
------------------------------------------------------------------------

local hookedBagFrames = {}
local hookedBagCount = 0
local placedButtons = setmetatable({}, { __mode = "k" })
local bagRetryPending = false

local function PrepareMainArrow(button)
    local icon = button.UpgradeIcon
    if icon and not placedButtons[button] then
        placedButtons[button] = true
        icon:ClearAllPoints()
        icon:SetPoint("TOPRIGHT", button, "TOPRIGHT", 0, 0)
        icon:SetDrawLayer("OVERLAY", 6)
    end
    return icon
end

local function UpdateBagButton(button, bagID, slotID)
    local icon = PrepareMainArrow(button)
    if not icon then
        return false
    end

    local mainUp, secondUp, loading, mainScale, secondScale = false, false, false, nil, nil
    if ns.ready and ns.options.showBagArrows and bagID and slotID and C_Container and C_Container.GetContainerItemInfo then
        local info = C_Container.GetContainerItemInfo(bagID, slotID)
        local link = info and ns.PlainText(info.hyperlink)
        if link then
            mainUp, secondUp, loading, mainScale, secondScale = GetVerdictsForLink(link)
        end
    end

    if mainUp and mainScale then
        TintTexture(icon, mainScale.colorHex)
    end
    icon:SetShown(mainUp)
    UpdateSecondArrow(button, button, icon, mainUp, secondUp, secondScale)
    return loading
end

local function UpdateContainerFrameModern(frame)
    if not ns.ready or not frame.EnumerateValidItems then
        return
    end
    local loading = false
    for _, button in frame:EnumerateValidItems() do
        local bagID = button.GetBagID and button:GetBagID()
        local slotID = button.GetID and button:GetID()
        if UpdateBagButton(button, bagID, slotID) then
            loading = true
        end
    end
    if loading and not bagRetryPending then
        bagRetryPending = true
        ns.After(RETRY_DELAY, function()
            bagRetryPending = false
            Bags:RefreshBlizzardBags()
        end)
    end
end

local function HookBlizzardFrame(frame)
    if not frame or hookedBagFrames[frame] then
        return
    end
    if frame.UpdateItems and frame.EnumerateValidItems then
        hookedBagFrames[frame] = true
        hookedBagCount = hookedBagCount + 1
        hooksecurefunc(frame, "UpdateItems", ns.Safe(UpdateContainerFrameModern))
    end
end

function Bags:RefreshBlizzardBags()
    for frame in pairs(hookedBagFrames) do
        if frame:IsShown() then
            UpdateContainerFrameModern(frame)
        end
    end
end

------------------------------------------------------------------------
-- Bagnon / BagBrother Integration
------------------------------------------------------------------------

local bagnonHost = nil

local function HookBagnon()
    local host = _G.BagBrother or _G.Bagnon
    local item = type(host) == "table" and host.Item
    if type(item) ~= "table" or type(item.IsUpgrade) ~= "function" then
        return
    end
    bagnonHost = host

    local function AnswerBagnon(button)
        local icon = PrepareMainArrow(button)
        local link = ns.ready and ns.options.showBagArrows and button.info and ns.PlainText(button.info.hyperlink)
        if not link then
            UpdateSecondArrow(button, button, icon, false, false, nil)
            return false
        end
        local mainUp, secondUp, loading, mainScale, secondScale = GetVerdictsForLink(link)
        if mainUp and mainScale and icon then
            TintTexture(icon, mainScale.colorHex)
        end
        UpdateSecondArrow(button, button, icon, mainUp, secondUp, secondScale)
        if loading then
            return nil
        end
        return mainUp
    end

    item.IsUpgrade = function(button)
        local ok, res = pcall(AnswerBagnon, button)
        if not ok then
            ns.ReportError(res)
            return false
        end
        return res
    end
end

------------------------------------------------------------------------
-- Baganator Integration
------------------------------------------------------------------------

local BAGANATOR_ID = "pawndynamic"
local GIVE_UP_SECONDS = 5
local baganatorHost = nil
local baganatorWaiting = {}
local baganatorRetryPending = false

local function StillWaiting(link, loading)
    if not loading then
        baganatorWaiting[link] = nil
        return false
    end
    local now = GetTime()
    baganatorWaiting[link] = baganatorWaiting[link] or now
    return (now - baganatorWaiting[link]) < GIVE_UP_SECONDS
end

local function RefreshBaganator()
    local api = baganatorHost and baganatorHost.API
    if type(api) ~= "table" or type(api.RequestItemButtonsRefresh) ~= "function" then
        return
    end
    local reasons = type(baganatorHost.Constants) == "table" and baganatorHost.Constants.RefreshReason
    local list
    if type(reasons) == "table" and api.IsCornerWidgetActive and api.IsUpgradePluginActive then
        list = {}
        if api.IsCornerWidgetActive(BAGANATOR_ID) then
            list[#list + 1] = reasons.ItemWidgets
        end
        if api.IsUpgradePluginActive(BAGANATOR_ID) then
            list[#list + 1] = reasons.Searches
        end
    end
    api.RequestItemButtonsRefresh(list)
end

local function BaganatorInitWidget(button)
    local frame = CreateFrame("Frame", nil, button)
    local main = frame:CreateTexture(nil, "OVERLAY")
    main:SetAtlas(ARROW_ATLAS, true)
    main:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
    local second = frame:CreateTexture(nil, "OVERLAY")
    second:SetAtlas(ARROW_ATLAS, true)
    second:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
    local w, h = main:GetSize()
    w = ns.PlainNumber(w, 15)
    h = ns.PlainNumber(h, 16)
    if w <= 0 or h <= 0 then
        w, h = 15, 16
    end
    frame.main, frame.second, frame.arrowW, frame.arrowH = main, second, w, h
    frame:SetSize(w, h)
    return frame
end

local function BaganatorUpdateWidget(frame, details)
    local link = ns.ready and ns.options.showBagArrows and type(details) == "table" and ns.PlainText(details.itemLink)
    if not link then
        return false
    end
    local mainUp, secondUp, loading, mainScale, secondScale = GetVerdictsForLink(link)
    if StillWaiting(link, loading) then
        return nil
    end
    if not (mainUp or secondUp) then
        return false
    end
    if mainUp and mainScale then
        TintTexture(frame.main, mainScale.colorHex)
    end
    if secondUp and secondScale then
        TintTexture(frame.second, secondScale.colorHex)
    end
    frame.main:SetShown(mainUp)
    frame.second:SetShown(secondUp)
    local both = mainUp and secondUp
    frame:SetSize(both and (frame.arrowW * 2 - 3) or frame.arrowW, frame.arrowH)
    return true
end

local function BaganatorIsUpgrade(link)
    link = ns.PlainText(link)
    if not ns.ready or not link then
        return false
    end
    local mainUp, secondUp, loading = GetVerdictsForLink(link)
    if mainUp or secondUp then
        return true
    end
    if StillWaiting(link, loading) then
        if not baganatorRetryPending then
            baganatorRetryPending = true
            ns.After(RETRY_DELAY, function()
                baganatorRetryPending = false
                RefreshBaganator()
            end)
        end
        return nil
    end
    return false
end

local function SafeBaganatorWrapper(fn)
    return function(...)
        local ok, res = pcall(fn, ...)
        if not ok then
            ns.ReportError(res)
            return false
        end
        return res
    end
end

local function HookBaganator()
    local host = _G.Baganator
    local api = type(host) == "table" and host.API
    if baganatorHost or type(api) ~= "table" or type(api.RegisterCornerWidget) ~= "function" then
        return
    end
    baganatorHost = host
    ns.Call(api.RegisterCornerWidget, "PawnDynamic", BAGANATOR_ID, SafeBaganatorWrapper(BaganatorUpdateWidget), ns.Safe(BaganatorInitWidget), {
        corner = "top_right",
        priority = 1,
    })
    if type(api.RegisterUpgradePlugin) == "function" then
        ns.Call(api.RegisterUpgradePlugin, "PawnDynamic", BAGANATOR_ID, SafeBaganatorWrapper(BaganatorIsUpgrade))
    end
end

------------------------------------------------------------------------
-- Quest Rewards (Upgrade Arrows + Gold Coin for Best Sell Value)
------------------------------------------------------------------------

local questsHooked = false
local questTries, questRetryPending = 0, false
local MAX_QUEST_TRIES = 6
local GetItemInfo = C_Item and C_Item.GetItemInfo or _G.GetItemInfo

local function ShowAddedArrow(button, iconAnchor, showMain, mainScale, showSecond, secondScale)
    local arrow = button.PawnDynamicArrow
    if not arrow and showMain then
        arrow = button:CreateTexture(nil, "OVERLAY", nil, 7)
        arrow:SetAtlas(ARROW_ATLAS, true)
        arrow:SetPoint("TOPRIGHT", iconAnchor or button, "TOPRIGHT", 0, 0)
        button.PawnDynamicArrow = arrow
    end
    if arrow then
        if showMain and mainScale then
            TintTexture(arrow, mainScale.colorHex)
        end
        arrow:SetShown(showMain)
    end
    UpdateSecondArrow(button, iconAnchor, arrow, showMain, showSecond, secondScale)
end

local function ShowGoldCoin(button, iconAnchor, show)
    local coin = button.PawnDynamicCoin
    if not coin then
        if not show then
            return
        end
        coin = button:CreateTexture(nil, "OVERLAY", nil, 7)
        coin:SetTexture(GOLD_COIN_TEX)
        coin:SetSize(14, 14)
        coin:SetPoint("TOPRIGHT", iconAnchor or button, "TOPRIGHT", 0, 0)
        button.PawnDynamicCoin = coin
    end
    coin:SetShown(show)
end

local function ItemSellPrice(link)
    local name, _, _, _, _, _, _, _, _, _, price = GetItemInfo(link)
    if not ns.PlainText(name) then
        return nil
    end
    return ns.PlainNumber(price, 0)
end

local function BestSellingChoices(getLink, count)
    local best = {}
    if count < 2 then
        return best, false
    end
    local prices = {}
    local high, low = 0, math.huge
    for idx = 1, count do
        local link = ns.PlainText(getLink("choice", idx))
        local price = link and ItemSellPrice(link)
        if not price then
            return best, true
        end
        prices[idx] = price
        high = math.max(high, price)
        low = math.min(low, price)
    end
    if high > low then
        for idx, price in ipairs(prices) do
            if price == high then
                best[idx] = true
            end
        end
    end
    return best, false
end

local function UpdateQuestRewards()
    local frame = _G.QuestInfoFrame
    local rewards = frame and frame.rewardsFrame
    local buttons = rewards and rewards.RewardButtons
    if type(buttons) ~= "table" then
        return
    end
    local getLink = frame.questLog and _G.GetQuestLogItemLink or _G.GetQuestItemLink
    local active = ns.ready and ns.options.showQuestArrows and getLink
    local loading = false

    local choicesCount = 0
    local anyChoiceIsUpgrade = false
    if active then
        for _, btn in ipairs(buttons) do
            if btn:IsShown() and btn.objectType == "item" and btn.type == "choice" then
                choicesCount = math.max(choicesCount, btn:GetID() or 0)
                local link = ns.PlainText(getLink("choice", btn:GetID()))
                if link then
                    local mUp, sUp = GetVerdictsForLink(link)
                    if mUp or sUp then
                        anyChoiceIsUpgrade = true
                    end
                end
            end
        end
    end

    local bestSell, priceLoading = {}, false
    if active and not anyChoiceIsUpgrade and choicesCount >= 2 then
        bestSell, priceLoading = BestSellingChoices(getLink, choicesCount)
        loading = loading or priceLoading
    end

    for _, btn in ipairs(buttons) do
        local mainUp, secondUp, coin = false, false, false
        local mainScale, secondScale
        if active and btn:IsShown() and btn.objectType == "item" and btn.type then
            local link = ns.PlainText(getLink(btn.type, btn:GetID()))
            if link then
                local waiting
                mainUp, secondUp, waiting, mainScale, secondScale = GetVerdictsForLink(link)
                loading = loading or waiting
            else
                loading = true
            end
            coin = (btn.type == "choice") and (not anyChoiceIsUpgrade) and bestSell[btn:GetID()] and not mainUp and not secondUp or false
        end
        ShowAddedArrow(btn, btn.Icon, mainUp, mainScale, secondUp, secondScale)
        ShowGoldCoin(btn, btn.Icon, coin)
    end

    if loading and not questRetryPending and questTries < MAX_QUEST_TRIES then
        questTries = questTries + 1
        questRetryPending = true
        ns.After(RETRY_DELAY, function()
            questRetryPending = false
            UpdateQuestRewards()
        end)
    end
end

local function HookQuests()
    if type(_G.QuestInfo_Display) ~= "function" then
        return
    end
    questsHooked = true
    hooksecurefunc("QuestInfo_Display", ns.Safe(function()
        questTries = 0
        UpdateQuestRewards()
    end))
    ns:RegisterEvent("QUEST_ITEM_UPDATE", UpdateQuestRewards)
end

------------------------------------------------------------------------
-- DialogueUI Quest Buttons
------------------------------------------------------------------------

local duiButtons = setmetatable({}, { __mode = "k" })
local duiHooked = false

local function UpdateDuiButton(btn)
    local mainUp, secondUp, coin = false, false, false
    local mainScale, secondScale
    if ns.ready and ns.options.showQuestArrows and btn.objectType == "item" and (btn.type == "choice" or btn.type == "reward") and btn.index and _G.GetQuestItemLink then
        local link = ns.PlainText(_G.GetQuestItemLink(btn.type, btn.index))
        if link then
            mainUp, secondUp, _, mainScale, secondScale = GetVerdictsForLink(link)
        end
        if btn.type == "choice" and _G.GetNumQuestChoices then
            local count = ns.PlainNumber(_G.GetNumQuestChoices(), 0)
            local anyChoiceUp = false
            for idx = 1, count do
                local cLink = ns.PlainText(_G.GetQuestItemLink("choice", idx))
                if cLink then
                    local m, s = GetVerdictsForLink(cLink)
                    if m or s then
                        anyChoiceUp = true
                        break
                    end
                end
            end
            if not anyChoiceUp and count >= 2 then
                local bestSell = BestSellingChoices(_G.GetQuestItemLink, count)
                coin = bestSell[btn.index] and not mainUp and not secondUp or false
            end
        end
    end
    ShowAddedArrow(btn, btn.Icon, mainUp, mainScale, secondUp, secondScale)
    ShowGoldCoin(btn, btn.Icon, coin)
end

local function HookDialogueUIButtons()
    local mixin = _G.DUIDialogItemButtonMixin
    if duiHooked or type(mixin) ~= "table" or type(mixin.SetItem) ~= "function" or type(mixin.ShowUpgradeIcon) ~= "function" then
        return
    end
    duiHooked = true
    local origArrow = mixin.ShowUpgradeIcon
    mixin.ShowUpgradeIcon = function(btn, ...)
        if not (ns.ready and ns.options.showQuestArrows) then
            return origArrow(btn, ...)
        end
    end
    hooksecurefunc(mixin, "SetItem", ns.Safe(function(btn)
        duiButtons[btn] = true
        UpdateDuiButton(btn)
    end))
    if type(mixin.OnRelease) == "function" then
        hooksecurefunc(mixin, "OnRelease", ns.Safe(function(btn)
            ShowAddedArrow(btn, btn.Icon, false, nil, false, nil)
            ShowGoldCoin(btn, btn.Icon, false)
        end))
    end
end

------------------------------------------------------------------------
-- Trainer & Loot Roll Advisors
------------------------------------------------------------------------

local trainerButtons = setmetatable({}, { __mode = "k" })
local trainerHooked = false

local function UpdateTrainerButton(btn, index)
    local mainUp, secondUp = false, false
    local mainScale, secondScale
    if ns.ready and ns.options.showBagArrows and index then
        local link = ns.Tooltip and ns.Tooltip.TrainerItemLink(index)
        if link then
            mainUp, secondUp, _, mainScale, secondScale = GetVerdictsForLink(link)
        end
    end
    ShowAddedArrow(btn, btn.icon, mainUp, mainScale, secondUp, secondScale)
end

local function HookTrainer()
    if trainerHooked or type(_G.ClassTrainerFrame_InitServiceButton) ~= "function" then
        return
    end
    trainerHooked = true
    hooksecurefunc("ClassTrainerFrame_InitServiceButton", ns.Safe(function(btn, elementData)
        local data = type(elementData) == "table" and (elementData.data or elementData)
        local idx = type(data) == "table" and data.skillIndex or btn:GetID()
        trainerButtons[btn] = true
        UpdateTrainerButton(btn, idx)
    end))
end

local function UpdateGroupLootFrame(frame)
    if not frame or not frame.rollID or not frame.IconFrame then
        return
    end
    local mainUp, secondUp = false, false
    local mainScale, secondScale
    if ns.ready and ns.options.showLootAdvisor and _G.GetLootRollItemLink then
        local link = ns.PlainText(_G.GetLootRollItemLink(frame.rollID))
        if link then
            mainUp, secondUp, _, mainScale, secondScale = GetVerdictsForLink(link)
        end
    end
    ShowAddedArrow(frame.IconFrame, frame.IconFrame, mainUp, mainScale, secondUp, secondScale)
end

local function HookLootRolls()
    for i = 1, 4 do
        local gf = _G["GroupLootFrame" .. i]
        if gf and gf.HookScript then
            gf:HookScript("OnShow", ns.Safe(UpdateGroupLootFrame))
        end
    end
end

------------------------------------------------------------------------
-- Bag Scan & Chat Announce
------------------------------------------------------------------------

local announcedKeys = {}

function Bags:Scan()
    local found, seen, loading = {}, {}, false
    local tracked = ns.Scales:GetTracked()
    if C_Container and C_Container.GetContainerNumSlots and C_Container.GetContainerItemInfo then
        for bag = 0, NUM_BAG_SLOTS or 4 do
            local numSlots = C_Container.GetContainerNumSlots(bag) or 0
            for slot = 1, numSlots do
                local item = C_Container.GetContainerItemInfo(bag, slot)
                local link = item and ns.PlainText(item.hyperlink)
                if link then
                    local baseStr = ns.Parser.BaseItemString(link)
                    for _, scale in ipairs(tracked) do
                        local v = ns.Upgrades:Check(link, scale)
                        local uid = scale.id .. "|" .. tostring(baseStr)
                        if v == nil then
                            loading = true
                        elseif v and v.upgrade and not seen[uid] then
                            seen[uid] = true
                            found[#found + 1] = {
                                link = link,
                                verdict = v,
                                scale = scale,
                                uid = uid,
                            }
                        end
                    end
                end
            end
        end
    end
    return found, loading
end

local function AnnounceNewBagUpgrades()
    if not ns.ready or not ns.options.announceUpgrades then
        return
    end
    local found = Bags:Scan()
    for _, entry in ipairs(found) do
        if not announcedKeys[entry.uid] then
            announcedKeys[entry.uid] = true
            local hex = ns.Scales.ColorCode(entry.scale.colorHex)
            ns.Print((L["[%s] New upgrade: %s (%s)"]):format(
                hex .. entry.scale.name .. "|r",
                entry.link,
                ns.Upgrades.FormatGain(entry.verdict)
            ))
        end
    end
end

function Bags:PrintScanReport()
    local found, loading = self:Scan()
    if #found == 0 then
        if loading then
            ns.Print(L["Items are still loading - try again shortly."])
        else
            ns.Print(L["No upgrades found in your bags."])
        end
        return
    end
    ns.Print(ns.Count(#found, "%d upgrade in your bags - /pd scan to list.", "%d upgrades in your bags - /pd scan to list."))
    for _, entry in ipairs(found) do
        local hex = ns.Scales.ColorCode(entry.scale.colorHex)
        ns.Print(("  %s%s|r: %s (%s)"):format(hex, entry.scale.name, entry.link, ns.Upgrades.FormatGain(entry.verdict)))
    end
end

------------------------------------------------------------------------
-- Redraw & Wiring
------------------------------------------------------------------------

function Bags:Redraw()
    self:RefreshBlizzardBags()
    UpdateQuestRewards()
    for btn in pairs(duiButtons) do
        if btn:IsShown() then
            UpdateDuiButton(btn)
        end
    end
    for btn in pairs(trainerButtons) do
        if btn:IsVisible() then
            UpdateTrainerButton(btn, btn:GetID())
        end
    end
    if bagnonHost and bagnonHost.SendSignal then
        pcall(bagnonHost.SendSignal, bagnonHost, "UPDATE_ALL")
    end
    if baganatorHost then
        baganatorWaiting = {}
        ns.Call(RefreshBaganator)
    end
end

function Bags:Status()
    local parts = { ("Blizzard(%d)"):format(hookedBagCount) }
    if bagnonHost then parts[#parts + 1] = "Bagnon" end
    if baganatorHost then parts[#parts + 1] = "Baganator" end
    return table.concat(parts, "+")
end

function Bags:QuestStatus()
    return (questsHooked and "hooked" or "unhooked") .. (duiHooked and "+DialogueUI" or "")
end

function Bags:Init()
    for i = 1, 13 do
        HookBlizzardFrame(_G["ContainerFrame" .. i])
    end
    HookBlizzardFrame(_G.ContainerFrameCombinedBags)

    HookBagnon()
    HookBaganator()
    HookQuests()
    HookDialogueUIButtons()
    HookTrainer()
    HookLootRolls()

    ns:RegisterEvent("ADDON_LOADED", function(addonName)
        if addonName == "Bagnon" or addonName == "BagBrother" then
            HookBagnon()
        elseif addonName == "Baganator" then
            HookBaganator()
        elseif addonName == "DialogueUI" then
            HookDialogueUIButtons()
        elseif addonName == "Blizzard_TrainerUI" then
            HookTrainer()
        end
    end)

    ns:RegisterEvent("BAG_UPDATE_DELAYED", function()
        if ns.ready then
            ns:BagsChanged()
        end
    end)

    ns:On("REFRESH", function(bagsChanged)
        self:Redraw()
        if bagsChanged then
            AnnounceNewBagUpgrades()
        end
    end)
end
