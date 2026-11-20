-- PawnDynamic (MIT License)
-- Item tooltip integration via TooltipDataProcessor with OnTooltipSetItem fallback.

local _, ns = ...

local Tooltip = ns:NewModule("Tooltip")
local L = ns.L

local WATCHED = {
    GameTooltip = true,
    ItemRefTooltip = true,
    ShoppingTooltip1 = true,
    ShoppingTooltip2 = true,
}

local addedTooltips = setmetatable({}, { __mode = "k" })
local trainerTries = {}
local RETRY_DELAY, MAX_TRIES = 0.5, 4

local function DisplayedLink(tooltip, data)
    local link = type(data) == "table" and ns.PlainText(data.hyperlink)
    if not link and TooltipUtil and TooltipUtil.GetDisplayedItem then
        local ok, _, itemLink = pcall(TooltipUtil.GetDisplayedItem, tooltip)
        if ok then
            link = ns.PlainText(itemLink)
        end
    end
    if not link and tooltip.GetItem then
        local ok, _, itemLink = pcall(tooltip.GetItem, tooltip)
        if ok then
            link = ns.PlainText(itemLink)
        end
    end
    return link
end

local function ShowsWornItem(tooltip, link)
    local name = tooltip.GetName and tooltip:GetName()
    if name == "ShoppingTooltip1" or name == "ShoppingTooltip2" then
        return true, nil
    end
    if tooltip.GetPrimaryTooltipInfo then
        local ok, source = pcall(tooltip.GetPrimaryTooltipInfo, tooltip)
        if ok and type(source) == "table" then
            if source.getterName == "GetInventoryItem" then
                local unit = type(source.getterArgs) == "table" and ns.Plain(source.getterArgs[1])
                local slotID = type(source.getterArgs) == "table" and ns.PlainNumber(source.getterArgs[2])
                return unit == "player", slotID
            elseif source.getterName then
                return false, nil
            end
        end
    end
    return ns.Upgrades:IsWorn(link), nil
end

local function SetTooltipBorderGreen(tooltip, isUpgrade)
    if not ns.options.colorTooltipBorder or not isUpgrade then
        return
    end
    if tooltip.NineSlice and tooltip.NineSlice.SetBorderColor then
        pcall(tooltip.NineSlice.SetBorderColor, tooltip.NineSlice, 0.2, 1.0, 0.6, 1.0)
    elseif tooltip.SetBackdropBorderColor then
        pcall(tooltip.SetBackdropBorderColor, tooltip, 0.2, 1.0, 0.6, 1.0)
    end
end

local function ResetTooltipBorder(tooltip)
    if not ns.options or not ns.options.colorTooltipBorder then
        return
    end
    if tooltip.NineSlice and tooltip.NineSlice.SetBorderColor then
        pcall(tooltip.NineSlice.SetBorderColor, tooltip.NineSlice, 1, 1, 1, 1)
    end
end

local function FormatScoreValue(verdict, worn, colorHex)
    local mode = ns.options.tooltipMode or "VALUES_AND_UPGRADES"
    local baseStr = ns.Format(verdict.score)
    local capSuffix = verdict.anyCapped and (" |cffffaa40" .. L["[Cap]"] .. "|r") or ""

    if ns.options.showCurrentValues and verdict.currentScore and math.abs(verdict.currentScore - verdict.score) >= 0.05 then
        baseStr = ("%s %s / %s %s"):format(L["Base:"], baseStr, L["Current:"], ns.Format(verdict.currentScore))
    end

    if mode == "VALUES_ONLY" then
        if verdict.score == 0 and (not verdict.currentScore or verdict.currentScore == 0) then
            return nil
        end
        return baseStr .. capSuffix
    end

    if verdict.upgrade and not worn then
        local gain = ns.Upgrades.FormatGain(verdict, true)
        local gainMsg = (verdict.gain and L["%s upgrade"] or L["upgrade - %s"]):format(gain)
        if verdict.partner then
            gainMsg = L["%s with %s"]:format(gainMsg, verdict.partner)
        end
        if verdict.replaceNote and verdict.replaceNote ~= "" then
            gainMsg = gainMsg .. " " .. verdict.replaceNote
        end
        if mode == "UPGRADES_ONLY" then
            return ("%s%s|r%s"):format(colorHex, gainMsg, capSuffix)
        end
        return ("%s  %s%s|r%s"):format(baseStr, colorHex, gainMsg, capSuffix)
    end

    if mode == "VALUES_AND_UPGRADES" and (verdict.score ~= 0 or worn) then
        return baseStr .. capSuffix
    end

    if mode == "UPGRADES_ONLY" and worn and verdict.score ~= 0 then
        return baseStr .. capSuffix
    end

    return nil
end

local function AddScoreLines(tooltip, link, worn, wornSlot)
    if addedTooltips[tooltip] then
        return false
    end
    local tracked = ns.Scales:GetTracked()
    if #tracked == 0 then
        return false
    end

    local verdicts = {}
    for i, scale in ipairs(tracked) do
        local v = ns.Upgrades:Check(link, scale, wornSlot)
        if v == nil then
            return nil
        elseif v == false then
            return false
        end
        verdicts[i] = v
    end

    local linesToAdd = {}
    local anyUpgrade = false
    for i, scale in ipairs(tracked) do
        local v = verdicts[i]
        local hex = ns.Scales.ColorCode(scale.colorHex)
        local valueText = FormatScoreValue(v, worn, hex)
        if valueText then
            if v.upgrade and not worn then
                anyUpgrade = true
            end
            linesToAdd[#linesToAdd + 1] = {
                left = hex .. scale.name .. "|r",
                right = valueText,
            }
        end
    end

    if #linesToAdd == 0 then
        return false
    end

    if ns.options.blankLine then
        tooltip:AddLine(" ")
    end

    for _, line in ipairs(linesToAdd) do
        if ns.options.alignRight then
            tooltip:AddDoubleLine(line.left, line.right, 1, 1, 1, 1, 1, 1)
        else
            tooltip:AddLine(line.left .. ":  " .. line.right, 1, 1, 1, false)
        end
    end

    addedTooltips[tooltip] = true
    if not worn and anyUpgrade then
        SetTooltipBorderGreen(tooltip, true)
    end
    return true
end

local function OnTooltipItem(tooltip, data)
    if not ns.ready or not ns.options then
        return
    end
    local name = tooltip and tooltip.GetName and tooltip:GetName()
    if not name or not WATCHED[name] then
        return
    end
    local link = DisplayedLink(tooltip, data)
    if not link then
        return
    end
    local worn, wornSlot = ShowsWornItem(tooltip, link)
    AddScoreLines(tooltip, link, worn, wornSlot)
end

------------------------------------------------------------------------
-- Trainer & DialogueUI Tooltips
------------------------------------------------------------------------

local function TryCall(fn, ...)
    if type(fn) ~= "function" then
        return nil
    end
    local ok, res = pcall(fn, ...)
    return ok and res or nil
end

local function ExtractItemLink(val)
    val = ns.PlainText(val)
    return val and val:find("item:", 1, true) and val or nil
end

function Tooltip.TrainerItemLink(index)
    index = ns.PlainNumber(index)
    if not index or index < 1 then
        return nil
    end
    local link = ExtractItemLink(TryCall(_G.GetTrainerServiceItemLink, index))
    if link then
        return link
    end
    local data = C_TooltipInfo and TryCall(C_TooltipInfo.GetTrainerService, index)
    if type(data) ~= "table" then
        return nil
    end
    link = ExtractItemLink(data.hyperlink)
    local id = ns.PlainNumber(data.id)
    if link or not id then
        return link
    end
    if Enum and Enum.TooltipDataType and ns.Plain(data.type) == Enum.TooltipDataType.Item then
        return "item:" .. id
    end
    local output = C_TradeSkillUI and TryCall(C_TradeSkillUI.GetRecipeOutputItemData, id)
    if type(output) ~= "table" then
        return nil
    end
    link = ExtractItemLink(output.hyperlink)
    local itemID = ns.PlainNumber(output.itemID)
    if not link and itemID and itemID > 0 then
        link = "item:" .. itemID
    end
    return link
end

local function OnTrainerService(tooltip, index)
    if not ns.ready or addedTooltips[tooltip] then
        return
    end
    local link = Tooltip.TrainerItemLink(index)
    if not link then
        return
    end
    local res = AddScoreLines(tooltip, link, false)
    if res then
        trainerTries[index] = nil
        if tooltip:IsShown() then
            tooltip:Show()
        end
    elseif res == nil and (trainerTries[index] or 0) < MAX_TRIES then
        trainerTries[index] = (trainerTries[index] or 0) + 1
        local owner = tooltip.GetOwner and tooltip:GetOwner()
        ns.After(RETRY_DELAY, function()
            if tooltip:IsShown() and (not tooltip.GetOwner or tooltip:GetOwner() == owner) then
                tooltip:SetTrainerService(index)
            end
        end)
    end
end

local dialogueUIHooked = false

local function OnDialogueUIItem(tooltip, itemID, itemLink)
    if not ns.ready then
        return false
    end
    local link = ns.PlainText(itemLink)
    if not link then
        itemID = ns.PlainNumber(itemID)
        if itemID and itemID > 0 then
            link = "item:" .. itemID
        end
    end
    if not link then
        return false
    end
    return AddScoreLines(tooltip, link, ns.Upgrades:IsWorn(link)) == true
end

local function HookDialogueUI()
    local api = _G.DialogueUIAPI
    if dialogueUIHooked or type(api) ~= "table" or type(api.AddItemTooltipProcessorExternal) ~= "function" then
        return
    end
    dialogueUIHooked = true
    local safeFn = ns.Safe(OnDialogueUIItem)
    api.AddItemTooltipProcessorExternal(function(...)
        return safeFn(...) == true
    end)
end

------------------------------------------------------------------------
-- Initialization & Status
------------------------------------------------------------------------

local hookMode = "unhooked"
local trainerHooked = false

function Tooltip:Status()
    return hookMode .. (trainerHooked and "+trainer" or "") .. (dialogueUIHooked and "+DialogueUI" or "")
end

function Tooltip:Init()
    local handler = ns.Safe(OnTooltipItem)
    if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall and Enum and Enum.TooltipDataType then
        TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, handler)
        hookMode = "TooltipDataProcessor"
    else
        for name in pairs(WATCHED) do
            local tt = _G[name]
            if tt and tt.HookScript then
                tt:HookScript("OnTooltipSetItem", handler)
                hookMode = "OnTooltipSetItem"
            end
        end
    end

    for name in pairs(WATCHED) do
        local tt = _G[name]
        if tt and tt.HookScript then
            tt:HookScript("OnTooltipCleared", function(self)
                addedTooltips[self] = nil
                ResetTooltipBorder(self)
            end)
        end
    end

    if GameTooltip and type(GameTooltip.SetTrainerService) == "function" then
        hooksecurefunc(GameTooltip, "SetTrainerService", ns.Safe(OnTrainerService))
        trainerHooked = true
    end

    HookDialogueUI()
    ns:RegisterEvent("ADDON_LOADED", function(addonName)
        if addonName == "DialogueUI" then
            HookDialogueUI()
        end
    end)
end
