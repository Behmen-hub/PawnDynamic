-- PawnDynamic (MIT License)
-- Clean-room implementation for World of Warcraft: Classic Forever (Interface 16001).

local ADDON_NAME, ns = ...
_G.PawnDynamic = ns

ns.name = ADDON_NAME
ns.version = (C_AddOns and C_AddOns.GetAddOnMetadata and C_AddOns.GetAddOnMetadata(ADDON_NAME, "Version")) or "1.2.0-beta"

------------------------------------------------------------------------
-- Generation & State Flags
------------------------------------------------------------------------

ns.generation = 1
ns.bagGeneration = 1
ns.ready = false
ns.errors = {}
ns.modules = {}

local MAX_SESSION_ERRORS = 30
local CHAT_PREFIX = "|cff00d1ffPawn|r|cffffffffDynamic|r: "

------------------------------------------------------------------------
-- Secret-Value Guard & Type Sanitizers
------------------------------------------------------------------------

local issecretvalue = _G.issecretvalue

function ns.Plain(value)
    if issecretvalue and issecretvalue(value) then
        return nil
    end
    return value
end

function ns.PlainText(value)
    value = ns.Plain(value)
    if type(value) == "string" and value ~= "" then
        return value
    end
    return nil
end

function ns.PlainNumber(value, default)
    value = ns.Plain(value)
    if type(value) == "number" then
        return value
    end
    if type(value) == "string" then
        local num = tonumber(value)
        if num then
            return num
        end
    end
    return default
end

------------------------------------------------------------------------
-- Output & Formatting
------------------------------------------------------------------------

function ns.Print(...)
    local count = select("#", ...)
    local parts = {}
    for i = 1, count do
        parts[i] = tostring(select(i, ...))
    end
    local msg = CHAT_PREFIX .. table.concat(parts, " ")
    if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
        DEFAULT_CHAT_FRAME:AddMessage(msg)
    elseif print then
        print(msg)
    end
end

function ns.DebugPrint(...)
    if ns.options and ns.options.debug then
        ns.Print("|cff888899[Debug]|r", ...)
    end
end

function ns.Format(value, digits)
    value = tonumber(value) or 0
    if math.abs(value) < 0.005 then
        return "0"
    end
    if digits ~= nil then
        local fmt = "%." .. tostring(digits) .. "f"
        local out = fmt:format(value)
        if digits > 0 then
            out = out:gsub("0+$", ""):gsub("%.$", "")
        end
        return out
    end
    if math.abs(value) < 0.95 then
        return (("%.2f"):format(value):gsub("0+$", ""):gsub("%.$", ""))
    end
    if math.abs(value - math.floor(value + 0.5)) < 0.05 then
        return ("%d"):format(math.floor(value + 0.5))
    end
    return ("%.1f"):format(value)
end

function ns.Trim(text)
    if type(text) ~= "string" then
        return ""
    end
    return (text:gsub("^%s+", ""):gsub("%s+$", ""))
end

------------------------------------------------------------------------
-- Protected Execution & Session Error Log
------------------------------------------------------------------------

function ns.ReportError(err)
    local msg = tostring(err)
    local stamp = date and date("%H:%M:%S") or "00:00:00"
    local entry = ("[%s] %s"):format(stamp, msg)
    if #ns.errors < MAX_SESSION_ERRORS then
        ns.errors[#ns.errors + 1] = entry
    end
    if #ns.errors == 1 then
        local L = ns.L
        local fmt = L and L["|cffff4040Error:|r %s (see /pd status)"] or "|cffff4040Error:|r %s (see /pd status)"
        ns.Print(fmt:format(msg))
    end
end

local function GuardResult(ok, ...)
    if ok then
        return ...
    end
    ns.ReportError((...))
    return nil
end

function ns.Call(fn, ...)
    if type(fn) ~= "function" then
        return nil
    end
    return GuardResult(pcall(fn, ...))
end

function ns.Safe(fn)
    return function(...)
        return GuardResult(pcall(fn, ...))
    end
end

function ns.After(delay, fn)
    if C_Timer and C_Timer.After then
        C_Timer.After(delay, ns.Safe(fn))
    end
end

------------------------------------------------------------------------
-- Event & Internal Message Bus
------------------------------------------------------------------------

local eventFrame = CreateFrame("Frame")
local eventHandlers = {}
local messageHandlers = {}

local function DispatchList(list, ...)
    for i = 1, #list do
        ns.Call(list[i], ...)
    end
end

eventFrame:SetScript("OnEvent", function(_, event, ...)
    local list = eventHandlers[event]
    if list then
        DispatchList(list, ...)
    end
end)

local function IsValidEventName(event)
    if C_EventUtils and C_EventUtils.IsEventValid then
        local ok, valid = pcall(C_EventUtils.IsEventValid, event)
        if ok then
            return valid
        end
    end
    return true
end

function ns:RegisterEvent(event, fn)
    if type(event) ~= "string" or type(fn) ~= "function" then
        return false
    end
    if not IsValidEventName(event) then
        return false
    end
    local list = eventHandlers[event]
    if not list then
        list = {}
        eventHandlers[event] = list
        local ok = pcall(eventFrame.RegisterEvent, eventFrame, event)
        if not ok then
            eventHandlers[event] = nil
            return false
        end
    end
    list[#list + 1] = fn
    return true
end

function ns:On(message, fn)
    if type(message) ~= "string" or type(fn) ~= "function" then
        return
    end
    local list = messageHandlers[message]
    if not list then
        list = {}
        messageHandlers[message] = list
    end
    list[#list + 1] = fn
end

function ns:Fire(message, ...)
    local list = messageHandlers[message]
    if list then
        DispatchList(list, ...)
    end
end

------------------------------------------------------------------------
-- Module Registry
------------------------------------------------------------------------

function ns:NewModule(name)
    if self[name] then
        return self[name]
    end
    local mod = { name = name }
    self.modules[#self.modules + 1] = mod
    self[name] = mod
    return mod
end

------------------------------------------------------------------------
-- Two-Stage Generation Caching with 0.1s Debounce
------------------------------------------------------------------------

local refreshPending = false
local bagRefreshPending = false

local function ScheduleRefresh()
    if refreshPending or not ns.ready then
        return
    end
    refreshPending = true
    ns.After(0.1, function()
        refreshPending = false
        local fireBags = bagRefreshPending
        bagRefreshPending = false
        ns:Fire("REFRESH", fireBags)
    end)
end

function ns:Changed(includeBags)
    self.generation = self.generation + 1
    if includeBags then
        self.bagGeneration = self.bagGeneration + 1
        bagRefreshPending = true
    end
    ScheduleRefresh()
end

function ns:BagsChanged()
    self.bagGeneration = self.bagGeneration + 1
    bagRefreshPending = true
    ScheduleRefresh()
end

------------------------------------------------------------------------
-- SavedVariables & Character Identification (UnitGUID)
------------------------------------------------------------------------

ns.defaultOptions = {
    tooltipMode = "VALUES_AND_UPGRADES", -- "UPGRADES_ONLY", "VALUES_AND_UPGRADES", "VALUES_ONLY"
    showCurrentValues = true,
    alignRight = true,
    blankLine = true,
    colorTooltipBorder = true,
    showBagArrows = true,
    showQuestArrows = true,
    showLootAdvisor = true,
    announceUpgrades = false,
    healingToDamageFallback = true,
    buttonPosition = "RIGHT", -- "RIGHT", "LEFT", "HIDDEN"
    debug = false,
}

local function ApplyDefaults(dst, src)
    for k, v in pairs(src) do
        if dst[k] == nil then
            dst[k] = v
        end
    end
    return dst
end

function ns:GetCharacterKey()
    local rawName = ns.PlainText(UnitName and UnitName("player")) or "Unknown"
    local realm = ns.PlainText(GetRealmName and GetRealmName()) or "Realm"
    local displayName = rawName .. " - " .. realm
    local guid = UnitGUID and ns.PlainText(UnitGUID("player"))
    if guid then
        return guid, displayName, guid
    end
    return displayName, displayName, nil
end

function ns:InitDB()
    if type(_G.PawnDynamicDB) ~= "table" then
        _G.PawnDynamicDB = {}
    end
    local db = _G.PawnDynamicDB
    db.options = ApplyDefaults(type(db.options) == "table" and db.options or {}, self.defaultOptions)
    db.customScales = type(db.customScales) == "table" and db.customScales or {}
    db.scaleOverrides = type(db.scaleOverrides) == "table" and db.scaleOverrides or {}
    db.chars = type(db.chars) == "table" and db.chars or {}

    local charKey, displayName, guid = self:GetCharacterKey()
    if type(db.chars[charKey]) ~= "table" then
        db.chars[charKey] = {}
    end
    local char = db.chars[charKey]
    char.name = displayName
    char.class = self.class
    char.guid = guid
    if char.autoMode == nil then
        char.autoMode = true
    end
    if type(char.visibleScales) ~= "table" then
        char.visibleScales = {}
    end
    if char.daggers == nil then
        char.daggers = false
    end

    db.sessionErrors = self.errors

    self.db = db
    self.options = db.options
    self.charKey = charKey
    self.char = char
end

------------------------------------------------------------------------
-- Lifecycle & Core Events
------------------------------------------------------------------------

ns:RegisterEvent("PLAYER_LOGIN", function()
    ns.class = select(2, UnitClass("player")) or "WARRIOR"
    ns:InitDB()

    for _, mod in ipairs(ns.modules) do
        if type(mod.Init) == "function" then
            ns.Call(mod.Init, mod)
        end
    end

    ns.ready = true
    ns:Fire("REFRESH", true)
end)

ns:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", function()
    ns:Changed(false)
end)

local function OnSkillsOrLevelChanged()
    if ns.Parser then
        ns.Parser:Wipe()
    end
    ns:Changed(false)
end

ns:RegisterEvent("PLAYER_LEVEL_UP", function()
    ns.After(0.5, OnSkillsOrLevelChanged)
end)

for _, ev in ipairs({
    "SKILL_LINES_CHANGED",
    "LEARNED_SPELL_IN_SKILL_LINE",
    "LEARNED_SPELL_IN_TAB",
    "UNIT_STATS",
    "UNIT_RESISTANCES",
    "UNIT_DEFENSE",
    "UNIT_ATTACK_POWER",
    "UNIT_RANGEDDAMAGE",
    "UNIT_AURA",
    "UPDATE_SHAPESHIFT_FORM",
    "COMBAT_RATING_UPDATE",
    "MASTERY_UPDATE",
}) do
    ns:RegisterEvent(ev, function(unit)
        if unit == nil or unit == "player" then
            ns:Changed(false)
        end
    end)
end

for _, ev in ipairs({
    "TRAIT_CONFIG_UPDATED",
    "TRAIT_CONFIG_LIST_UPDATED",
    "TRAIT_TREE_CURRENCY_INFO_UPDATED",
    "ACTIVE_COMBAT_CONFIG_CHANGED",
    "ACTIVE_TALENT_GROUP_CHANGED",
    "PLAYER_TALENT_UPDATE",
}) do
    ns:RegisterEvent(ev, function()
        if not ns.ready then
            return
        end
        if ns.Talents and ns.Talents.Refresh then
            ns.Talents:Refresh()
        end
        if ns.Scales and ns.Scales.OnTalentsChanged then
            ns.Scales:OnTalentsChanged()
        end
        ns:Changed(false)
    end)
end

------------------------------------------------------------------------
-- Status Report & Slash Commands (/pd, /pawndynamic)
------------------------------------------------------------------------

local function PrintStatus()
    local _, build = GetBuildInfo()
    local level = ns.PlainNumber(UnitLevel and UnitLevel("player"), 0)
    local tracked = ns.Scales and ns.Scales:GetTracked() or {}
    local names = {}
    for i, s in ipairs(tracked) do
        names[i] = s.name
    end
    local scaleText = #names > 0 and table.concat(names, ", ") or "none"

    ns.Print(("v%s (Interface %s) | %s Level %d | Key: %s"):format(
        ns.version,
        tostring(build or "16001"),
        tostring(ns.class),
        level,
        tostring(ns.charKey)
    ))
    ns.Print(("Mode: %s | Tracked scales: %s"):format(
        ns.char.autoMode and "Automatic (Talents)" or "Manual",
        scaleText
    ))
    if ns.Talents and ns.Talents.GetSummary then
        ns.Print("Talents: " .. ns.Talents:GetSummary())
    end
    if ns.Caps and ns.Caps.GetCharacterStats then
        local st = ns.Caps:GetCharacterStats()
        ns.Print(("Stats: Hit %.2f%% | SpellHit %.2f%% | Crit %.2f%% | Def %d | Exp %.2f%% | Armor %d (%.1f%% DR) | Avoid %.2f%%"):format(
            st.meleeHit or 0,
            st.spellHit or 0,
            st.crit or 0,
            st.defense or 0,
            st.expertise or 0,
            st.armor or 0,
            st.armorDR or 0,
            st.avoidanceBase or 0
        ))
        local refScale = tracked[1] or (ns.Scales and ns.Scales:GetSelected())
        if refScale and ns.Caps.GetResolvedCapsForLevel then
            local rc = ns.Caps:GetResolvedCapsForLevel(refScale)
            ns.Print(("Target: +%d (Lv %d) | HitCap %.1f%% | DefCap %d | AvoidCap %.1f%% | DualWield: %s"):format(
                rc.targetOffset or 0,
                rc.enemyLevel or st.level,
                rc.hitHard or 0,
                rc.defHard or 0,
                rc.avoidanceCap or 102.4,
                rc.dwSoftCap and "yes" or "no"
            ))
        end
    end
    local bagStatus = ns.Bags and ns.Bags.Status and ns.Bags:Status() or "n/a"
    local questStatus = ns.Bags and ns.Bags.QuestStatus and ns.Bags:QuestStatus() or "n/a"
    local tooltipStatus = ns.Tooltip and ns.Tooltip.Status and ns.Tooltip:Status() or "n/a"
    ns.Print(("Hooks: bags=%s | quests=%s | tooltips=%s"):format(bagStatus, questStatus, tooltipStatus))
    ns.Print(("Generation: %d (bags %d)"):format(ns.generation, ns.bagGeneration))

    if #ns.errors == 0 then
        ns.Print("Errors this session: 0")
    else
        ns.Print(("|cffff4040Errors this session: %d|r"):format(#ns.errors))
        for _, err in ipairs(ns.errors) do
            ns.Print("  " .. err)
        end
    end
end

SLASH_PAWNDYNAMIC1 = "/pawndynamic"
SLASH_PAWNDYNAMIC2 = "/pd"

SlashCmdList.PAWNDYNAMIC = ns.Safe(function(msg)
    if not ns.ready then
        ns.Print(ns.L["PawnDynamic did not finish initializing."])
        for _, err in ipairs(ns.errors) do
            ns.Print("  " .. err)
        end
        return
    end

    msg = ns.Trim(msg or "")
    local cmd, rest = msg:match("^(%S*)%s*(.-)$")
    cmd = (cmd or ""):lower()
    rest = ns.Trim(rest or "")

    if cmd == "" or cmd == "ui" or cmd == "show" then
        if ns.UI and ns.UI.Toggle then
            ns.UI:Toggle()
        end
    elseif cmd == "debug" then
        local lowerRest = rest:lower()
        if lowerRest == "on" then
            ns.options.debug = true
            ns.Print(ns.L["Debug mode enabled."])
        elseif lowerRest == "off" then
            ns.options.debug = false
            ns.Print(ns.L["Debug mode disabled."])
        elseif ns.Parser and ns.Parser.DebugItem then
            ns.Parser:DebugItem(rest)
        end
    elseif cmd == "status" then
        PrintStatus()
    elseif cmd == "scan" then
        if ns.Bags and ns.Bags.PrintScanReport then
            ns.Bags:PrintScanReport()
        end
    elseif cmd == "dump" then
        if ns.Parser and ns.Parser.DumpAll then
            ns.Parser:DumpAll()
        end
    elseif cmd == "refresh" then
        if ns.Parser and ns.Parser.Wipe then
            ns.Parser:Wipe()
        end
        if ns.Talents and ns.Talents.Refresh then
            ns.Talents:Refresh()
        end
        if ns.Scales and ns.Scales.OnTalentsChanged then
            ns.Scales:OnTalentsChanged()
        end
        ns:Changed(true)
        ns.Print(ns.L["Caches cleared and data refreshed."])
    elseif cmd == "help" then
        ns.Print(ns.L["Commands: /pd (toggle UI) | /pd status | /pd scan | /pd debug [on|off|link] | /pd dump | /pd refresh"])
    else
        if ns.UI and ns.UI.Toggle then
            ns.UI:Toggle()
        end
    end
end)
