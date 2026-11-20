-- PawnDynamic (MIT License)
-- Modern ElvUI-inspired Two-Column Window (pure Lua, no XML) with 6 tabs.

local _, ns = ...

local UI = ns:NewModule("UI")
local L = ns.L

local FONT = STANDARD_TEXT_FONT or "Fonts\\FRIZQT__.TTF"
local WIN_W, WIN_H = 940, 700
local LEFT_W = 235
local RIGHT_W = WIN_W - LEFT_W - 28
local ACCENT = { 0.00, 0.82, 1.00 }
local EMERALD = { 0.20, 1.00, 0.60 }
local CUSTOM_COLOR = { 1.00, 0.82, 0.10 }
local BORDER_IDLE = { 0.20, 0.22, 0.27 }
local BG_DARK = { 0.055, 0.058, 0.075, 0.96 }
local BG_PANEL = { 0.09, 0.095, 0.12, 0.95 }
local BG_WIDGET = { 0.13, 0.14, 0.175, 1.0 }

local ITEM_QUALITY_COLORS = _G.ITEM_QUALITY_COLORS

------------------------------------------------------------------------
-- Pure-Lua Flat UI Primitives (Zero XML Templates)
------------------------------------------------------------------------

local function CreateLabel(parent, size, r, g, b, justify)
    local fs = parent:CreateFontString(nil, "OVERLAY")
    fs:SetFont(FONT, size or 12, "")
    fs:SetTextColor(r or 0.90, g or 0.92, b or 0.95)
    fs:SetJustifyH(justify or "LEFT")
    fs:SetJustifyV("MIDDLE")
    return fs
end

local function FitText(fs, maxWidth, baseSize)
    local sz = baseSize or 12
    fs:SetFont(FONT, sz, "")
    while sz > 8 and (ns.PlainNumber(fs:GetStringWidth(), 0)) > maxWidth do
        sz = sz - 1
        fs:SetFont(FONT, sz, "")
    end
end

local function StylePanel(frame, r, g, b, a)
    if not frame._bg then
        frame._bg = frame:CreateTexture(nil, "BACKGROUND")
        frame._bg:SetAllPoints()
    end
    frame._bg:SetColorTexture(r or BG_PANEL[1], g or BG_PANEL[2], b or BG_PANEL[3], a or 1)

    if not frame._edges then
        frame._edges = {}
        for i = 1, 4 do
            frame._edges[i] = frame:CreateTexture(nil, "BORDER")
        end
        frame._edges[1]:SetPoint("TOPLEFT")
        frame._edges[1]:SetPoint("TOPRIGHT")
        frame._edges[1]:SetHeight(1)
        frame._edges[2]:SetPoint("BOTTOMLEFT")
        frame._edges[2]:SetPoint("BOTTOMRIGHT")
        frame._edges[2]:SetHeight(1)
        frame._edges[3]:SetPoint("TOPLEFT")
        frame._edges[3]:SetPoint("BOTTOMLEFT")
        frame._edges[3]:SetWidth(1)
        frame._edges[4]:SetPoint("TOPRIGHT")
        frame._edges[4]:SetPoint("BOTTOMRIGHT")
        frame._edges[4]:SetWidth(1)
    end

    function frame:SetBorderColor(br, bg, bb, ba)
        for i = 1, 4 do
            self._edges[i]:SetColorTexture(br, bg, bb, ba or 1)
        end
    end
    frame:SetBorderColor(BORDER_IDLE[1], BORDER_IDLE[2], BORDER_IDLE[3], 1)
end

local function CreateFlatButton(parent, width, height, text, onClick)
    local btn = CreateFrame("Button", nil, parent)
    btn:SetSize(width, height or 24)
    StylePanel(btn, BG_WIDGET[1], BG_WIDGET[2], BG_WIDGET[3], 1)
    btn.text = CreateLabel(btn, 11, 0.92, 0.94, 0.98, "CENTER")
    btn.text:SetPoint("CENTER")
    btn.text:SetText(text or "")
    if text and text ~= "" then
        FitText(btn.text, width - 10, 11)
    end

    btn:SetScript("OnEnter", function(self)
        if not self._disabled then
            self:SetBorderColor(ACCENT[1], ACCENT[2], ACCENT[3], 1)
        end
    end)
    btn:SetScript("OnLeave", function(self)
        if self._selected then
            local c = self._accent or ACCENT
            self:SetBorderColor(c[1], c[2], c[3], 1)
        else
            self:SetBorderColor(BORDER_IDLE[1], BORDER_IDLE[2], BORDER_IDLE[3], 1)
        end
    end)
    btn:SetScript("OnClick", function(self, mouseBtn)
        if not self._disabled and onClick then
            ns.Call(onClick, self, mouseBtn)
        end
    end)

    function btn:SetSelected(selected, color)
        self._selected = selected
        local c = color or ACCENT
        self._accent = c
        if selected then
            self:SetBorderColor(c[1], c[2], c[3], 1)
            self._bg:SetColorTexture(0.10, 0.17, 0.22, 1)
            self.text:SetTextColor(c[1], c[2], c[3])
        else
            self:SetBorderColor(BORDER_IDLE[1], BORDER_IDLE[2], BORDER_IDLE[3], 1)
            self._bg:SetColorTexture(BG_WIDGET[1], BG_WIDGET[2], BG_WIDGET[3], 1)
            self.text:SetTextColor(self._disabled and 0.42 or 0.92, self._disabled and 0.44 or 0.94, self._disabled and 0.48 or 0.98)
        end
    end

    function btn:SetDisabledState(disabled)
        self._disabled = disabled and true or false
        if self._disabled then
            self.text:SetTextColor(0.42, 0.44, 0.48)
        elseif not self._selected then
            self.text:SetTextColor(0.92, 0.94, 0.98)
        end
    end

    return btn
end

local function CreateCheckButton(parent, width, labelText, onToggle)
    local btn = CreateFrame("Button", nil, parent)
    btn:SetSize(width or 220, 20)

    local box = CreateFrame("Frame", nil, btn)
    box:SetSize(14, 14)
    box:SetPoint("LEFT", 0, 0)
    StylePanel(box, 0.08, 0.08, 0.11, 1)
    btn.box = box

    btn.mark = box:CreateTexture(nil, "OVERLAY")
    btn.mark:SetPoint("TOPLEFT", 3, -3)
    btn.mark:SetPoint("BOTTOMRIGHT", -3, 3)
    btn.mark:SetColorTexture(EMERALD[1], EMERALD[2], EMERALD[3], 1)

    btn.text = CreateLabel(btn, 11, 0.88, 0.90, 0.94)
    btn.text:SetPoint("LEFT", box, "RIGHT", 7, 0)
    btn.text:SetText(labelText or "")
    FitText(btn.text, (width or 220) - 24, 11)

    btn:SetScript("OnEnter", function(self)
        self.box:SetBorderColor(ACCENT[1], ACCENT[2], ACCENT[3], 1)
    end)
    btn:SetScript("OnLeave", function(self)
        self.box:SetBorderColor(BORDER_IDLE[1], BORDER_IDLE[2], BORDER_IDLE[3], 1)
    end)
    btn:SetScript("OnClick", function(self)
        if onToggle then
            ns.Call(onToggle, self)
        end
    end)

    function btn:SetCheckedState(checked)
        self.mark:SetShown(checked and true or false)
    end

    return btn
end

local function CreateEditBox(parent, width, height, justify, onCommit)
    local eb = CreateFrame("EditBox", nil, parent)
    eb:SetSize(width, height or 20)
    eb:SetFont(FONT, 11, "")
    eb:SetJustifyH(justify or "LEFT")
    eb:SetTextInsets(5, 5, 0, 0)
    eb:SetAutoFocus(false)
    eb:SetTextColor(0.95, 0.96, 0.98)
    StylePanel(eb, 0.07, 0.075, 0.095, 1)

    eb:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
    end)
    eb:SetScript("OnEscapePressed", function(self)
        self._cancelled = true
        self:ClearFocus()
    end)
    eb:SetScript("OnEditFocusGained", function(self)
        self:SetBorderColor(ACCENT[1], ACCENT[2], ACCENT[3], 1)
        self:HighlightText()
    end)
    eb:SetScript("OnEditFocusLost", function(self)
        self:SetBorderColor(BORDER_IDLE[1], BORDER_IDLE[2], BORDER_IDLE[3], 1)
        self:HighlightText(0, 0)
        if self._cancelled then
            self._cancelled = nil
            if self._onCancel then
                ns.Call(self._onCancel, self)
            end
        elseif onCommit then
            ns.Call(onCommit, self, self:GetText())
        end
    end)
    return eb
end

local function CreateScrollArea(parent, width, height)
    local container = CreateFrame("Frame", nil, parent)
    container:SetSize(width, height)

    local sf = CreateFrame("ScrollFrame", nil, container)
    sf:SetPoint("TOPLEFT", 0, 0)
    sf:SetPoint("BOTTOMRIGHT", -10, 0)
    sf:EnableMouseWheel(true)
    if sf.SetClipsChildren then
        sf:SetClipsChildren(true)
    end

    local child = CreateFrame("Frame", nil, sf)
    child:SetWidth(width - 12)
    child:SetHeight(1)
    sf:SetScrollChild(child)

    local track = CreateFrame("Slider", nil, container)
    track:SetOrientation("VERTICAL")
    track:SetPoint("TOPRIGHT", 0, 0)
    track:SetPoint("BOTTOMRIGHT", 0, 0)
    track:SetWidth(6)
    track:SetMinMaxValues(0, 0)
    track:SetValueStep(20)
    track:SetValue(0)
    StylePanel(track, 0.07, 0.075, 0.095, 0.9)

    local thumb = track:CreateTexture(nil, "OVERLAY")
    thumb:SetSize(6, 28)
    thumb:SetColorTexture(0.28, 0.34, 0.42, 1)
    track:SetThumbTexture(thumb)

    local function UpdateBounds()
        local maxScroll = math.max(0, child:GetHeight() - sf:GetHeight())
        track:SetMinMaxValues(0, maxScroll)
        track:SetShown(maxScroll > 1)
        local cur = sf:GetVerticalScroll()
        if cur > maxScroll then
            sf:SetVerticalScroll(maxScroll)
            track:SetValue(maxScroll)
        end
    end

    track:SetScript("OnValueChanged", function(_, val)
        sf:SetVerticalScroll(val)
    end)
    sf:SetScript("OnMouseWheel", function(_, delta)
        local _, maxVal = track:GetMinMaxValues()
        local nextVal = math.min(maxVal, math.max(0, sf:GetVerticalScroll() - delta * 28))
        sf:SetVerticalScroll(nextVal)
        track:SetValue(nextVal)
    end)

    container.scrollFrame = sf
    container.content = child
    container.UpdateBounds = UpdateBounds
    return container
end

------------------------------------------------------------------------
-- Modal Dialogs (Text Prompt, Import/Export Multi-Line, Color Picker, Template Picker)
------------------------------------------------------------------------

local modalBackdrop

local function EnsureModalHost()
    if modalBackdrop then
        return modalBackdrop
    end
    local f = CreateFrame("Frame", nil, UI.frame)
    f:SetAllPoints()
    f:SetFrameLevel(UI.frame:GetFrameLevel() + 30)
    f:EnableMouse(true)
    local dim = f:CreateTexture(nil, "BACKGROUND")
    dim:SetAllPoints()
    dim:SetColorTexture(0, 0, 0, 0.65)

    local box = CreateFrame("Frame", nil, f)
    box:SetPoint("CENTER")
    box:SetSize(460, 180)
    StylePanel(box, 0.08, 0.085, 0.11, 0.99)
    box:SetBorderColor(ACCENT[1], ACCENT[2], ACCENT[3], 1)

    f.box = box
    f.title = CreateLabel(box, 13, ACCENT[1], ACCENT[2], ACCENT[3])
    f.title:SetPoint("TOPLEFT", 14, -12)

    f.prompt = CreateLabel(box, 11, 0.88, 0.90, 0.94)
    f.prompt:SetPoint("TOPLEFT", 14, -36)
    f.prompt:SetWidth(432)
    f.prompt:SetWordWrap(true)

    f.singleInput = CreateEditBox(box, 432, 24, "LEFT")
    f.singleInput:SetPoint("TOPLEFT", 14, -68)

    f.multiScroll = CreateFrame("ScrollFrame", nil, box)
    f.multiScroll:SetPoint("TOPLEFT", 14, -60)
    f.multiScroll:SetSize(432, 130)
    StylePanel(f.multiScroll, 0.05, 0.055, 0.07, 1)

    f.multiInput = CreateFrame("EditBox", nil, f.multiScroll)
    f.multiInput:SetMultiLine(true)
    f.multiInput:SetAutoFocus(false)
    f.multiInput:SetFont(FONT, 11, "")
    f.multiInput:SetWidth(420)
    f.multiInput:SetTextColor(0.95, 0.96, 0.98)
    f.multiInput:SetScript("OnEscapePressed", function() f:Hide() end)
    f.multiScroll:SetScrollChild(f.multiInput)

    f.errorText = CreateLabel(box, 11, 1.0, 0.35, 0.35)
    f.errorText:SetPoint("BOTTOMLEFT", 14, 42)
    f.errorText:SetWidth(432)

    f.okBtn = CreateFlatButton(box, 95, 24, L["OK"], function()
        if f._onConfirm then
            local keep = f._onConfirm()
            if not keep then
                f:Hide()
            end
        else
            f:Hide()
        end
    end)
    f.okBtn:SetPoint("BOTTOMRIGHT", -116, 12)

    f.cancelBtn = CreateFlatButton(box, 95, 24, L["Cancel"], function()
        f:Hide()
    end)
    f.cancelBtn:SetPoint("BOTTOMRIGHT", -14, 12)

    f.dynamicWidgets = {}
    f:Hide()
    modalBackdrop = f
    return f
end

local function ClearModalExtras(m)
    for _, w in ipairs(m.dynamicWidgets) do
        w:Hide()
    end
    wipe(m.dynamicWidgets)
    m.errorText:SetText("")
    m.singleInput:SetScript("OnTextChanged", nil)
    m.okBtn:SetDisabledState(false)
end

function UI:ShowPrompt(titleText, promptText, initialValue, onConfirm, requiredWord)
    local m = EnsureModalHost()
    ClearModalExtras(m)
    m.box:SetSize(460, 155)
    m.title:SetText(titleText)
    m.prompt:SetText(promptText)
    m.multiScroll:Hide()
    m.singleInput:ClearAllPoints()
    m.singleInput:SetPoint("TOPLEFT", 14, -68)
    m.singleInput:SetWidth(432)
    m.singleInput:Show()
    m.singleInput:SetText(initialValue or "")
    m.okBtn:Show()
    m.okBtn.text:SetText(L["OK"])
    m.cancelBtn.text:SetText(L["Cancel"])
    if requiredWord and requiredWord ~= "" then
        local targetWord = ns.Lower(ns.Trim(requiredWord))
        local function UpdateConfirmState()
            local current = ns.Lower(ns.Trim(m.singleInput:GetText() or ""))
            m.okBtn:SetDisabledState(current ~= targetWord)
        end
        m.singleInput:SetScript("OnTextChanged", UpdateConfirmState)
        UpdateConfirmState()
    end
    m._onConfirm = function()
        if m.okBtn._disabled then
            return true
        end
        local ok, err = onConfirm(m.singleInput:GetText())
        if ok == false then
            m.errorText:SetText(err or "Invalid input")
            return true
        end
        return false
    end
    m.singleInput:SetScript("OnEnterPressed", function()
        if not m.okBtn._disabled then
            m.okBtn:Click()
        end
    end)
    m:Show()
    m.singleInput:SetFocus()
end

function UI:ShowItemPicker(sideKey, fromBags)
    local m = EnsureModalHost()
    ClearModalExtras(m)
    local list = {}
    local seen = {}

    if fromBags then
        if C_Container and C_Container.GetContainerNumSlots and C_Container.GetContainerItemInfo then
            for bag = 0, NUM_BAG_SLOTS or 4 do
                for slot = 1, C_Container.GetContainerNumSlots(bag) or 0 do
                    local item = C_Container.GetContainerItemInfo(bag, slot)
                    local lnk = item and ns.PlainText(item.hyperlink)
                    local info = lnk and ns.Parser:Get(lnk)
                    if info and not seen[info.fullItemString] then
                        seen[info.fullItemString] = true
                        list[#list + 1] = info
                    end
                end
            end
        end
    else
        for slot = 1, 18 do
            local lnk = ns.PlainText(GetInventoryItemLink("player", slot))
            local info = lnk and ns.Parser:Get(lnk)
            if info then
                list[#list + 1] = info
            end
        end
    end

    m.box:SetSize(520, 360)
    m.title:SetText(fromBags and L["Pick from bags"] or L["Pick from equipped"])
    m.prompt:SetText(#list > 0 and (fromBags and L["Pick from bags"] or L["Pick from equipped"]) or L["Empty slot"])
    m.singleInput:Hide()
    m.multiScroll:Hide()
    m.okBtn:Hide()
    m.cancelBtn.text:SetText(L["Close"])
    m._onConfirm = nil

    local scroll = CreateScrollArea(m.box, 492, 245)
    scroll:SetPoint("TOPLEFT", 14, -56)
    StylePanel(scroll, 0.055, 0.06, 0.08, 1)
    m.dynamicWidgets[#m.dynamicWidgets + 1] = scroll

    local y = -4
    for _, info in ipairs(list) do
        local qc = ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[info.quality]
        local hex = qc and qc.hex or "|cffffffff"
        local btn = CreateFlatButton(scroll.content, 470, 22, hex .. info.name .. "|r  |cff8892a0(" .. tostring(info.equipLoc) .. ")|r", function()
            ns.char[sideKey] = info.link
            m:Hide()
            UI:Refresh()
        end)
        btn:SetPoint("TOPLEFT", 4, y)
        btn.text:SetJustifyH("LEFT")
        btn.text:ClearAllPoints()
        btn.text:SetPoint("LEFT", 8, 0)
        y = y - 24
    end
    scroll.content:SetHeight(math.max(235, -y + 6))
    scroll:UpdateBounds()
    m:Show()
end

function UI:ShowMultiLineDialog(titleText, promptText, initialText, readOnly, onConfirm)
    local m = EnsureModalHost()
    ClearModalExtras(m)
    m.box:SetSize(520, 260)
    m.title:SetText(titleText)
    m.prompt:SetText(promptText)
    m.singleInput:Hide()
    m.multiScroll:SetSize(492, 136)
    m.multiInput:SetWidth(480)
    m.multiScroll:Show()
    m.multiInput:SetText(initialText or "")
    if readOnly then
        m.okBtn:Hide()
        m.cancelBtn.text:SetText(L["Close"])
        m._onConfirm = nil
    else
        m.okBtn:Show()
        m.okBtn.text:SetText(L["Import"])
        m.cancelBtn.text:SetText(L["Cancel"])
        m._onConfirm = function()
            local ok, err = onConfirm(m.multiInput:GetText())
            if ok == false then
                m.errorText:SetText(err or "Import failed")
                return true
            end
            return false
        end
    end
    m:Show()
    m.multiInput:SetFocus()
    if readOnly then
        m.multiInput:HighlightText()
    end
end

function UI:ShowColorDialog(scale)
    local m = EnsureModalHost()
    ClearModalExtras(m)
    m.box:SetSize(340, 185)
    m.title:SetText(L["Change color"])
    m.prompt:SetText(scale.name)
    m.singleInput:Hide()
    m.multiScroll:Hide()
    m.okBtn:Hide()
    m.cancelBtn.text:SetText(L["Close"])
    m._onConfirm = nil

    for idx, c in ipairs(ns.Scales.COLOR_PALETTE) do
        local col = (idx - 1) % 6
        local row = math.floor((idx - 1) / 6)
        local sw = CreateFlatButton(m.box, 44, 30, "", function()
            ns.Scales:SetProperty(scale.id, "colorHex", c.hex)
            ns:Changed(false)
            m:Hide()
            UI:Refresh()
        end)
        sw:SetPoint("TOPLEFT", 24 + col * 50, -64 - row * 38)
        local fill = sw:CreateTexture(nil, "ARTWORK")
        fill:SetPoint("TOPLEFT", 4, -4)
        fill:SetPoint("BOTTOMRIGHT", -4, 4)
        fill:SetColorTexture(c.r, c.g, c.b, 1)
        if scale.colorHex == c.hex then
            sw:SetBorderColor(1, 1, 1, 1)
        end
        m.dynamicWidgets[#m.dynamicWidgets + 1] = sw
    end
    m:Show()
end

function UI:ShowTemplateDialog()
    local m = EnsureModalHost()
    ClearModalExtras(m)
    local catalog = ns.Scales:GetStarterCatalog()
    local chosen = catalog[1]

    m.box:SetSize(520, 360)
    m.title:SetText(L["From template"])
    m.prompt:SetText(L["Choose class & template:"])
    m.multiScroll:Hide()
    m.singleInput:Show()
    m.singleInput:SetText(chosen and (chosen.name .. " Copy") or "New Profile")
    m.singleInput:ClearAllPoints()
    m.singleInput:SetPoint("TOPLEFT", 14, -56)
    m.singleInput:SetWidth(492)

    local scroll = CreateScrollArea(m.box, 492, 200)
    scroll:SetPoint("TOPLEFT", 14, -90)
    StylePanel(scroll, 0.055, 0.06, 0.08, 1)
    m.dynamicWidgets[#m.dynamicWidgets + 1] = scroll

    local buttons = {}
    local y = -4
    for _, tpl in ipairs(catalog) do
        local btn = CreateFlatButton(scroll.content, 470, 22, ("%s - %s"):format(tpl.class, tpl.name), function(self)
            chosen = tpl
            for _, b in ipairs(buttons) do
                b:SetSelected(b == self)
            end
            m.singleInput:SetText(tpl.name .. " Custom")
        end)
        btn:SetPoint("TOPLEFT", 4, y)
        btn.text:SetJustifyH("LEFT")
        btn.text:ClearAllPoints()
        btn.text:SetPoint("LEFT", 8, 0)
        if tpl == chosen then
            btn:SetSelected(true)
        end
        buttons[#buttons + 1] = btn
        y = y - 24
    end
    scroll.content:SetHeight(math.max(190, -y + 6))
    scroll:UpdateBounds()

    m.okBtn:Show()
    m.okBtn.text:SetText(L["Create"])
    m.cancelBtn.text:SetText(L["Cancel"])
    m._onConfirm = function()
        if not chosen then
            return true
        end
        local s, err = ns.Scales:CreateFromTemplate(m.singleInput:GetText(), chosen.id)
        if not s then
            m.errorText:SetText(err or "Invalid name")
            return true
        end
        UI:Refresh()
        return false
    end
    m:Show()
end

------------------------------------------------------------------------
-- Stat-Prio-Generator Dialog
------------------------------------------------------------------------

local prioModal

function UI:ShowPrioGeneratorDialog()
    if not ns.PrioGenerator then
        return
    end
    local PG = ns.PrioGenerator
    local selectedScale = ns.Scales and ns.Scales:GetSelected()
    local curClass = (selectedScale and selectedScale.class) or ns.class or "WARRIOR"
    if not PG.CLASS_ROLES[curClass] then
        curClass = ns.class or "WARRIOR"
    end
    local curRole = PG:GetDefaultRoleForClass(curClass, selectedScale)
    local curPrioList = PG:GetDefaultPrioList(curClass, curRole)

    if not prioModal then
        local f = CreateFrame("Frame", nil, UI.frame)
        f:SetAllPoints()
        f:SetFrameLevel(UI.frame:GetFrameLevel() + 35)
        f:EnableMouse(true)

        local dim = f:CreateTexture(nil, "BACKGROUND")
        dim:SetAllPoints()
        dim:SetColorTexture(0, 0, 0, 0.68)

        local box = CreateFrame("Frame", nil, f)
        box:SetPoint("CENTER")
        box:SetSize(868, 566)
        StylePanel(box, 0.075, 0.08, 0.105, 0.99)
        box:SetBorderColor(ACCENT[1], ACCENT[2], ACCENT[3], 1)

        local title = CreateLabel(box, 14, ACCENT[1], ACCENT[2], ACCENT[3])
        title:SetPoint("TOPLEFT", 16, -12)
        title:SetText(L["Stat Prio Generator"])

        local xBtn = CreateFlatButton(box, 24, 22, "X", function()
            f:Hide()
        end)
        xBtn:SetPoint("TOPRIGHT", -12, -10)

        local nameLbl = CreateLabel(box, 11, 0.88, 0.90, 0.94)
        nameLbl:SetPoint("TOPLEFT", 16, -42)
        nameLbl:SetText(L["Profile name:"])

        local nameBox = CreateEditBox(box, 230, 22, "LEFT")
        nameBox:SetPoint("LEFT", nameLbl, "RIGHT", 8, 0)

        local roleLbl = CreateLabel(box, 11, 0.88, 0.90, 0.94)
        roleLbl:SetPoint("TOPLEFT", 16, -74)
        roleLbl:SetText(L["Role:"])

        local roleBtns = {}
        for i = 1, 5 do
            local rb = CreateFlatButton(box, 110, 22, "", nil)
            rb:SetPoint("TOPLEFT", 72 + (i - 1) * 116, -70)
            rb:Hide()
            roleBtns[i] = rb
        end

        local resetBtn = CreateFlatButton(box, 185, 22, L["Load default prio"], nil)
        resetBtn:SetPoint("TOPRIGHT", -16, -70)
        FitText(resetBtn.text, 175, 11)

        -- Left Column: Available Stats
        local availHdr = CreateLabel(box, 12, ACCENT[1], ACCENT[2], ACCENT[3])
        availHdr:SetPoint("TOPLEFT", 16, -104)
        availHdr:SetText(L["Available stats"])

        local availScroll = CreateScrollArea(box, 256, 384)
        availScroll:SetPoint("TOPLEFT", 16, -124)
        StylePanel(availScroll, 0.055, 0.06, 0.08, 1)

        -- Middle Column: Priority List
        local prioHdr = CreateLabel(box, 12, EMERALD[1], EMERALD[2], EMERALD[3])
        prioHdr:SetPoint("TOPLEFT", 284, -104)
        prioHdr:SetText(L["Your priority (1 = highest)"])

        local prioScroll = CreateScrollArea(box, 294, 384)
        prioScroll:SetPoint("TOPLEFT", 284, -124)
        StylePanel(prioScroll, 0.055, 0.06, 0.08, 1)

        -- Right Column: Calculated Weights Preview
        local prevHdr = CreateLabel(box, 12, ACCENT[1], ACCENT[2], ACCENT[3])
        prevHdr:SetPoint("TOPLEFT", 590, -104)
        prevHdr:SetText(L["Calculated weights preview"])

        local prevScroll = CreateScrollArea(box, 262, 384)
        prevScroll:SetPoint("TOPLEFT", 590, -124)
        StylePanel(prevScroll, 0.055, 0.06, 0.08, 1)

        local errLbl = CreateLabel(box, 11, 1.0, 0.35, 0.35)
        errLbl:SetPoint("BOTTOMLEFT", 16, 44)
        errLbl:SetWidth(520)

        local createBtn = CreateFlatButton(box, 200, 26, L["Create as new profile"], nil)
        createBtn:SetPoint("BOTTOMLEFT", 16, 12)
        FitText(createBtn.text, 190, 11)

        local applyBtn = CreateFlatButton(box, 220, 26, L["Apply to current profile"], nil)
        applyBtn:SetPoint("LEFT", createBtn, "RIGHT", 10, 0)
        FitText(applyBtn.text, 210, 11)

        local cancelBtn = CreateFlatButton(box, 110, 26, L["Cancel"], function()
            f:Hide()
        end)
        cancelBtn:SetPoint("BOTTOMRIGHT", -16, 12)

        f.box = box
        f.nameBox = nameBox
        f.roleBtns = roleBtns
        f.resetBtn = resetBtn
        f.availScroll = availScroll
        f.prioScroll = prioScroll
        f.prevScroll = prevScroll
        f.errLbl = errLbl
        f.createBtn = createBtn
        f.applyBtn = applyBtn
        f.availPool = {}
        f.prioPool = {}
        f.prevPool = {}
        f:Hide()
        prioModal = f
    end

    local f = prioModal
    f.errLbl:SetText("")

    local function DefaultProfileName(cls, role)
        local rLbl = L[PG.ROLE_LABELS[role] or "Custom scale"]
        return rLbl .. " Prio"
    end
    f.nameBox:SetText(DefaultProfileName(curClass, curRole))

    local function RefreshDialog()
        -- 1. Role buttons
        local validRoles = PG:GetValidRolesForClass(curClass)
        for i, rb in ipairs(f.roleBtns) do
            local r = validRoles[i]
            if r then
                rb:Show()
                rb.text:SetText(L[PG.ROLE_LABELS[r] or r])
                FitText(rb.text, 102, 11)
                rb:SetSelected(curRole == r, EMERALD)
                rb:SetScript("OnClick", function()
                    curRole = r
                    curPrioList = PG:GetDefaultPrioList(curClass, curRole)
                    f.nameBox:SetText(DefaultProfileName(curClass, curRole))
                    f.errLbl:SetText("")
                    RefreshDialog()
                end)
            else
                rb:Hide()
            end
        end

        -- 2. Left Column: Available Stats (exclude already chosen)
        local chosenSet = {}
        for _, sk in ipairs(curPrioList) do
            chosenSet[sk] = true
        end
        local availAll = PG:GetAvailableStats(curClass, curRole)
        local availFiltered = {}
        for _, sk in ipairs(availAll) do
            if not chosenSet[sk] then
                availFiltered[#availFiltered + 1] = sk
            end
        end

        local ay = -4
        for idx, sk in ipairs(availFiltered) do
            local row = f.availPool[idx]
            if not row then
                row = CreateFrame("Button", nil, f.availScroll.content)
                row:SetSize(236, 22)
                StylePanel(row, 0.085, 0.09, 0.115, 1)
                row.lbl = CreateLabel(row, 11, 0.88, 0.90, 0.95)
                row.lbl:SetPoint("LEFT", 8, 0)
                row.lbl:SetWidth(196)
                row.addSign = CreateLabel(row, 12, EMERALD[1], EMERALD[2], EMERALD[3], "CENTER")
                row.addSign:SetPoint("RIGHT", -6, 0)
                row.addSign:SetText("+")
                row:SetScript("OnEnter", function(self) self:SetBorderColor(ACCENT[1], ACCENT[2], ACCENT[3], 1) end)
                row:SetScript("OnLeave", function(self) self:SetBorderColor(BORDER_IDLE[1], BORDER_IDLE[2], BORDER_IDLE[3], 1) end)
                f.availPool[idx] = row
            end
            row:SetPoint("TOPLEFT", 4, ay)
            row:Show()
            row.lbl:SetText((ns.Parser and ns.Parser.statLabels[sk]) or sk)
            FitText(row.lbl, 194, 11)
            row:SetScript("OnClick", function()
                curPrioList[#curPrioList + 1] = sk
                f.errLbl:SetText("")
                RefreshDialog()
            end)
            ay = ay - 24
        end
        for i = #availFiltered + 1, #f.availPool do
            f.availPool[i]:Hide()
        end
        f.availScroll.content:SetHeight(math.max(376, -ay + 6))
        f.availScroll:UpdateBounds()

        -- 3. Middle Column: Ordered Priority List (1..N)
        local py = -4
        for idx, sk in ipairs(curPrioList) do
            local row = f.prioPool[idx]
            if not row then
                row = CreateFrame("Frame", nil, f.prioScroll.content)
                row:SetSize(274, 24)
                StylePanel(row, 0.085, 0.095, 0.12, 1)
                row.rankLbl = CreateLabel(row, 11, EMERALD[1], EMERALD[2], EMERALD[3], "RIGHT")
                row.rankLbl:SetPoint("LEFT", 4, 0)
                row.rankLbl:SetWidth(24)
                row.lbl = CreateLabel(row, 11, 0.94, 0.95, 0.98)
                row.lbl:SetPoint("LEFT", 32, 0)
                row.lbl:SetWidth(166)
                row.upBtn = CreateFlatButton(row, 20, 18, "^", nil)
                row.upBtn:SetPoint("RIGHT", -48, 0)
                row.dnBtn = CreateFlatButton(row, 20, 18, "v", nil)
                row.dnBtn:SetPoint("RIGHT", -25, 0)
                row.rmBtn = CreateFlatButton(row, 20, 18, "x", nil)
                row.rmBtn:SetPoint("RIGHT", -2, 0)
                f.prioPool[idx] = row
            end
            row:SetPoint("TOPLEFT", 4, py)
            row:Show()
            row.rankLbl:SetText(idx .. ".")
            row.lbl:SetText((ns.Parser and ns.Parser.statLabels[sk]) or sk)
            FitText(row.lbl, 164, 11)
            row.upBtn:SetDisabledState(idx == 1)
            row.upBtn:SetScript("OnClick", function()
                if idx > 1 then
                    curPrioList[idx], curPrioList[idx - 1] = curPrioList[idx - 1], curPrioList[idx]
                    RefreshDialog()
                end
            end)
            row.dnBtn:SetDisabledState(idx == #curPrioList)
            row.dnBtn:SetScript("OnClick", function()
                if idx < #curPrioList then
                    curPrioList[idx], curPrioList[idx + 1] = curPrioList[idx + 1], curPrioList[idx]
                    RefreshDialog()
                end
            end)
            row.rmBtn:SetScript("OnClick", function()
                table.remove(curPrioList, idx)
                RefreshDialog()
            end)
            py = py - 26
        end
        for i = #curPrioList + 1, #f.prioPool do
            f.prioPool[i]:Hide()
        end
        f.prioScroll.content:SetHeight(math.max(376, -py + 6))
        f.prioScroll:UpdateBounds()

        -- 4. Right Column: Live Weights Preview
        local payload = PG:BuildProfilePayload(curClass, curRole, curPrioList, f.nameBox:GetText())
        local previewItems = {}
        for sk, wVal in pairs(payload.weights) do
            previewItems[#previewItems + 1] = {
                key = sk,
                weight = wVal,
                source = payload.sources[sk],
                rank = payload.rankOf[sk],
            }
        end
        table.sort(previewItems, function(a, b)
            local ar = a.rank or 999
            local br = b.rank or 999
            if ar ~= br then
                return ar < br
            end
            if a.weight ~= b.weight then
                return a.weight > b.weight
            end
            return a.key < b.key
        end)

        local vy = -4
        for idx, item in ipairs(previewItems) do
            local row = f.prevPool[idx]
            if not row then
                row = CreateFrame("Frame", nil, f.prevScroll.content)
                row:SetSize(242, 20)
                row.lbl = CreateLabel(row, 10, 0.90, 0.92, 0.95)
                row.lbl:SetPoint("LEFT", 4, 0)
                row.lbl:SetWidth(128)
                row.tag = CreateLabel(row, 9, ACCENT[1], ACCENT[2], ACCENT[3], "RIGHT")
                row.tag:SetPoint("RIGHT", -56, 0)
                row.tag:SetWidth(58)
                row.val = CreateLabel(row, 10, 1, 1, 1, "RIGHT")
                row.val:SetPoint("RIGHT", -4, 0)
                row.val:SetWidth(50)
                f.prevPool[idx] = row
            end
            row:SetPoint("TOPLEFT", 4, vy)
            row:Show()
            row.lbl:SetText((ns.Parser and ns.Parser.statLabels[item.key]) or item.key)
            FitText(row.lbl, 126, 10)
            if item.source == "synergy" then
                row.tag:SetText(L["[Synergy]"])
                row.tag:SetTextColor(ACCENT[1], ACCENT[2], ACCENT[3])
            elseif item.source == "base" then
                row.tag:SetText(L["[Base]"])
                row.tag:SetTextColor(0.62, 0.66, 0.74)
            elseif item.rank then
                row.tag:SetText(("#%d"):format(item.rank))
                row.tag:SetTextColor(EMERALD[1], EMERALD[2], EMERALD[3])
            else
                row.tag:SetText("")
            end
            row.val:SetText((("%.3f"):format(item.weight):gsub("0+$", ""):gsub("%.$", "")))
            vy = vy - 21
        end
        for i = #previewItems + 1, #f.prevPool do
            f.prevPool[i]:Hide()
        end
        f.prevScroll.content:SetHeight(math.max(376, -vy + 6))
        f.prevScroll:UpdateBounds()

        -- 5. Apply Button state
        local sel = ns.Scales and ns.Scales:GetSelected()
        local canApply = sel and (not sel.isStarter) and true or false
        f.applyBtn:SetDisabledState(not canApply)
    end

    f.resetBtn:SetScript("OnClick", function()
        curPrioList = PG:GetDefaultPrioList(curClass, curRole)
        f.errLbl:SetText("")
        RefreshDialog()
    end)

    f.createBtn:SetScript("OnClick", function()
        local scale, err = PG:CreateProfile(f.nameBox:GetText(), curClass, curRole, curPrioList)
        if not scale then
            f.errLbl:SetText(err or "Failed to create profile")
            return
        end
        f:Hide()
        UI:Refresh()
    end)

    f.applyBtn:SetScript("OnClick", function()
        local sel = ns.Scales and ns.Scales:GetSelected()
        if not sel or sel.isStarter then
            return
        end
        local scale, err = PG:ApplyToProfile(sel.id, curClass, curRole, curPrioList)
        if not scale then
            f.errLbl:SetText(err or "Failed to apply weights")
            return
        end
        f:Hide()
        UI:Refresh()
    end)

    RefreshDialog()
    f:Show()
end

------------------------------------------------------------------------
-- Tab Builders
------------------------------------------------------------------------

local function BuildScaleTab(parent)
    local tab = CreateFrame("Frame", nil, parent)
    tab:SetAllPoints()

    tab.header = CreateLabel(tab, 15, 1, 1, 1)
    tab.header:SetPoint("TOPLEFT", 4, -4)

    tab.typeBadge = CreateLabel(tab, 11, 0.65, 0.68, 0.75)
    tab.typeBadge:SetPoint("TOPLEFT", 4, -26)

    -- Mode Switcher (Automatic vs Manual)
    local modePanel = CreateFrame("Frame", nil, tab)
    modePanel:SetPoint("TOPLEFT", 4, -52)
    modePanel:SetSize(RIGHT_W - 8, 92)
    StylePanel(modePanel, 0.08, 0.085, 0.11, 1)

    local autoBtn = CreateFlatButton(modePanel, 180, 26, L["Automatic"], function()
        ns.Scales:SetAutoMode(true)
        UI:Refresh()
    end)
    autoBtn:SetPoint("TOPLEFT", 10, -10)
    local autoDesc = CreateLabel(modePanel, 10, 0.72, 0.75, 0.80)
    autoDesc:SetPoint("LEFT", autoBtn, "RIGHT", 12, 0)
    autoDesc:SetWidth(RIGHT_W - 220)
    autoDesc:SetText(L["Auto follows your active talent tree."])

    local manBtn = CreateFlatButton(modePanel, 180, 26, L["Manual"], function()
        ns.Scales:SetAutoMode(false)
        UI:Refresh()
    end)
    manBtn:SetPoint("TOPLEFT", 10, -48)
    local manDesc = CreateLabel(modePanel, 10, 0.72, 0.75, 0.80)
    manDesc:SetPoint("LEFT", manBtn, "RIGHT", 12, 0)
    manDesc:SetWidth(RIGHT_W - 220)
    manDesc:SetText(L["Manual lets you enable and customize multiple profiles."])

    -- Selected Profile Actions
    local actPanel = CreateFrame("Frame", nil, tab)
    actPanel:SetPoint("TOPLEFT", 4, -156)
    actPanel:SetSize(RIGHT_W - 8, 120)
    StylePanel(actPanel, 0.08, 0.085, 0.11, 1)

    local showCheck = CreateCheckButton(actPanel, 280, L["Show this scale in tooltips"], function()
        local s = ns.Scales:GetSelected()
        if s then
            ns.Scales:SetVisible(s.id, not ns.Scales:IsVisible(s.id))
            UI:Refresh()
        end
    end)
    showCheck:SetPoint("TOPLEFT", 12, -12)

    local renameBtn = CreateFlatButton(actPanel, 130, 26, L["Rename"], function()
        local s = ns.Scales:GetSelected()
        if s and not s.isStarter then
            UI:ShowPrompt(L["Rename"], (L["Enter new name for %s:"]):format(s.name), s.name, function(newName)
                if not ns.Scales:Rename(s.id, newName) then
                    return false, "Invalid or duplicate name"
                end
                UI:Refresh()
            end)
        end
    end)
    renameBtn:SetPoint("TOPLEFT", 12, -46)

    local delBtn = CreateFlatButton(actPanel, 130, 26, L["Delete"], function()
        local s = ns.Scales:GetSelected()
        if s and not s.isStarter then
            local confirmWord = L["DELETE_CONFIRM_WORD"]
            if not confirmWord or confirmWord == "DELETE_CONFIRM_WORD" then
                confirmWord = "DELETE"
            end
            local prompt = (L["Type \"%s\" to permanently delete profile \"%s\":"]):format(confirmWord, s.name)
            UI:ShowPrompt(L["Delete"], prompt, "", function(txt)
                if ns.Lower(ns.Trim(txt or "")) ~= ns.Lower(ns.Trim(confirmWord)) then
                    return false, (L["Type \"%s\" to confirm deletion:"]):format(confirmWord)
                end
                ns.Scales:Delete(s.id)
                UI:Refresh()
            end, confirmWord)
        end
    end)
    delBtn:SetPoint("LEFT", renameBtn, "RIGHT", 8, 0)

    local colorBtn = CreateFlatButton(actPanel, 130, 26, L["Change color"], function()
        local s = ns.Scales:GetSelected()
        if s then
            UI:ShowColorDialog(s)
        end
    end)
    colorBtn:SetPoint("LEFT", delBtn, "RIGHT", 8, 0)

    local resetBtn = CreateFlatButton(actPanel, 165, 26, L["Reset defaults"], function()
        local s = ns.Scales:GetSelected()
        if s and s.isStarter then
            ns.Scales:ResetStarter(s.id)
            UI:Refresh()
        end
    end)
    resetBtn:SetPoint("TOPLEFT", 12, -80)

    -- Create & Share Panel
    local sharePanel = CreateFrame("Frame", nil, tab)
    sharePanel:SetPoint("TOPLEFT", 4, -288)
    sharePanel:SetSize(RIGHT_W - 8, 128)
    StylePanel(sharePanel, 0.08, 0.085, 0.11, 1)

    local createHdr = CreateLabel(sharePanel, 12, ACCENT[1], ACCENT[2], ACCENT[3])
    createHdr:SetPoint("TOPLEFT", 12, -10)
    createHdr:SetText(L["New"] .. " / " .. L["Copy"] .. " / " .. L["Import"] .. " / " .. L["Export"])

    local newBtn = CreateFlatButton(sharePanel, 130, 26, L["New"], function()
        UI:ShowPrompt(L["New"], L["Enter profile name:"], "", function(name)
            local s, err = ns.Scales:CreateEmpty(name)
            if not s then
                return false, err
            end
            UI:Refresh()
        end)
    end)
    newBtn:SetPoint("TOPLEFT", 12, -34)

    local tplBtn = CreateFlatButton(sharePanel, 130, 26, L["From template"], function()
        UI:ShowTemplateDialog()
    end)
    tplBtn:SetPoint("LEFT", newBtn, "RIGHT", 8, 0)

    local copyBtn = CreateFlatButton(sharePanel, 130, 26, L["Copy"], function()
        local s = ns.Scales:GetSelected()
        if s then
            UI:ShowPrompt(L["Copy"], (L["Enter name for copy of %s:"]):format(s.name), s.name .. " Copy", function(name)
                local res, err = ns.Scales:Copy(s.id, name)
                if not res then
                    return false, err
                end
                UI:Refresh()
            end)
        end
    end)
    copyBtn:SetPoint("LEFT", tplBtn, "RIGHT", 8, 0)

    local prioGenBtn = CreateFlatButton(sharePanel, 180, 26, L["Stat Prio Generator"], function()
        UI:ShowPrioGeneratorDialog()
    end)
    prioGenBtn:SetPoint("LEFT", copyBtn, "RIGHT", 8, 0)
    FitText(prioGenBtn.text, 170, 12)

    local importBtn = CreateFlatButton(sharePanel, 130, 26, L["Import"], function()
        UI:ShowMultiLineDialog(L["Import"], L["Paste Pawn v1 string:"], "", false, function(text)
            local ok, res = ns.ImportExport:Import(text, false)
            if not ok and type(res) == "string" and res:sub(1, 7) == "EXISTS:" then
                local existingName = res:sub(8)
                ns.After(0, function()
                    UI:ShowPrompt(L["Overwrite existing scale?"], (L["Type \"%s\" to confirm deletion:"]):format(existingName), existingName, function(confirmTxt)
                        if confirmTxt ~= existingName then
                            return false, "Cancelled"
                        end
                        local ok2, res2 = ns.ImportExport:Import(text, true)
                        if not ok2 then
                            return false, res2
                        end
                        UI:Refresh()
                    end)
                end)
                return false, ""
            elseif not ok then
                return false, res
            end
            UI:Refresh()
        end)
    end)
    importBtn:SetPoint("TOPLEFT", 12, -74)

    local exportBtn = CreateFlatButton(sharePanel, 130, 26, L["Export"], function()
        local s = ns.Scales:GetSelected()
        if s then
            local tag = ns.ImportExport:Export(s.id) or ""
            UI:ShowMultiLineDialog(L["Export"], L["Copy Pawn v1 string (Ctrl+C):"], tag, true)
        end
    end)
    exportBtn:SetPoint("LEFT", importBtn, "RIGHT", 8, 0)

    local exportAllBtn = CreateFlatButton(sharePanel, 130, 26, L["Export all"], function()
        local tags = ns.ImportExport:ExportAll() or ""
        UI:ShowMultiLineDialog(L["Export all"], L["Copy Pawn v1 string (Ctrl+C):"], tags, true)
    end)
    exportAllBtn:SetPoint("LEFT", exportBtn, "RIGHT", 8, 0)

    function tab:Refresh()
        local s = ns.Scales:GetSelected()
        local isAuto = ns.char and ns.char.autoMode
        autoBtn:SetSelected(isAuto, EMERALD)
        manBtn:SetSelected(not isAuto, ACCENT)

        if not s then
            self.header:SetText(L["No scale selected"])
            self.typeBadge:SetText("")
            return
        end

        local hex = ns.Scales.ColorCode(s.colorHex)
        self.header:SetText(hex .. s.name .. "|r")
        self.typeBadge:SetText(s.isStarter and L["Read-only template"] or L["Custom scale"])

        showCheck:SetCheckedState(ns.Scales:IsVisible(s.id))
        renameBtn:SetDisabledState(s.isStarter)
        delBtn:SetDisabledState(s.isStarter)
        resetBtn:SetDisabledState(not s.isStarter)
    end

    return tab
end

local function BuildWeightsTab(parent)
    local tab = CreateFrame("Frame", nil, parent)
    tab:SetAllPoints()

    tab.header = CreateLabel(tab, 14, 1, 1, 1)
    tab.header:SetPoint("TOPLEFT", 4, -4)

    tab.hint = CreateLabel(tab, 10, 0.72, 0.75, 0.80)
    tab.hint:SetPoint("TOPLEFT", 4, -24)
    tab.hint:SetText(L["Yellow values are customized."] .. "  " .. L["Select a stat or edit values directly. Press Tab for next row."])

    local scroll = CreateScrollArea(tab, RIGHT_W - 8, 476)
    scroll:SetPoint("TOPLEFT", 4, -44)
    StylePanel(scroll, 0.075, 0.08, 0.105, 1)

    local content = scroll.content
    local statRows = {}
    local editOrder = {}
    local y = -8

    local function FormatWeight(v)
        if not v or math.abs(v) < 0.0001 then
            return "0"
        end
        return (("%.3f"):format(v):gsub("0+$", ""):gsub("%.$", ""))
    end

    for _, group in ipairs(ns.Parser.statGroups) do
        local gHdr = CreateLabel(content, 12, ACCENT[1], ACCENT[2], ACCENT[3])
        gHdr:SetPoint("TOPLEFT", 10, y)
        gHdr:SetText(group.name)
        y = y - 20

        for idx, statKey in ipairs(group) do
            local col = (idx - 1) % 2
            local rowX = 10 + col * 290
            if col == 0 and idx > 1 then
                y = y - 24
            end

            local row = CreateFrame("Frame", nil, content)
            row:SetSize(280, 22)
            row:SetPoint("TOPLEFT", rowX, y)

            row.label = CreateLabel(row, 11, 0.88, 0.90, 0.94)
            row.label:SetPoint("LEFT", 0, 0)
            row.label:SetText(ns.Parser.statLabels[statKey] or statKey)
            FitText(row.label, 178, 11)

            local eb = CreateEditBox(row, 68, 18, "RIGHT", function(self, txt)
                local s = ns.Scales:GetSelected()
                if not s then return end
                local num = tonumber((txt:gsub(",", ".")))
                if num then
                    ns.Scales:SetWeight(s.id, statKey, num)
                end
                UI:Refresh()
            end)
            eb:SetPoint("RIGHT", -22, 0)
            eb._onCancel = function() UI:Refresh() end
            eb._tabIndex = #editOrder + 1
            eb:SetScript("OnTabPressed", function(self)
                local step = IsShiftKeyDown() and -1 or 1
                local nextBox = editOrder[(self._tabIndex - 1 + step) % #editOrder + 1]
                if nextBox then
                    nextBox:SetFocus()
                end
            end)

            local clrBtn = CreateFlatButton(row, 18, 18, "x", function()
                local s = ns.Scales:GetSelected()
                if s then
                    ns.Scales:SetWeight(s.id, statKey, 0)
                    UI:Refresh()
                end
            end)
            clrBtn:SetPoint("RIGHT", 0, 0)

            row.statKey = statKey
            row.box = eb
            statRows[#statRows + 1] = row
            editOrder[#editOrder + 1] = eb
        end
        y = y - 30
    end

    -- Weapon / Armor Unusable Types
    local typeHdr = CreateLabel(content, 12, ACCENT[1], ACCENT[2], ACCENT[3])
    typeHdr:SetPoint("TOPLEFT", 10, y)
    typeHdr:SetText(L["Unusable armor & weapon types"])
    y = y - 22

    local typeChecks = {}
    local allTypes = {}
    for _, t in ipairs(ns.Parser.armorTypeKeys) do allTypes[#allTypes + 1] = t end
    for _, t in ipairs(ns.Parser.weaponTypeKeys) do allTypes[#allTypes + 1] = t end

    for idx, t in ipairs(allTypes) do
        local col = (idx - 1) % 3
        local tx = 10 + col * 192
        if col == 0 and idx > 1 then
            y = y - 22
        end
        local chk = CreateCheckButton(content, 185, t.label, function()
            local s = ns.Scales:GetSelected()
            if s then
                local cur = s.unusableTypes and s.unusableTypes[t.key]
                ns.Scales:SetUnusableType(s.id, t.key, not cur)
                UI:Refresh()
            end
        end)
        chk:SetPoint("TOPLEFT", tx, y)
        chk._typeKey = t.key
        typeChecks[#typeChecks + 1] = chk
    end
    y = y - 30

    content:SetHeight(math.max(466, -y + 10))
    scroll:UpdateBounds()

    -- Bottom Bar: Normalization & 1H/2H filters
    local normChk = CreateCheckButton(tab, 260, L["Normalize values (like Wowhead)"], function()
        local s = ns.Scales:GetSelected()
        if s then
            local isNorm = (type(s.normalizeFactor) == "number" and s.normalizeFactor > 0) or (s.normalizeFactor == true)
            local nextVal = nil
            if not isNorm then
                nextVal = 1
            end
            ns.Scales:SetProperty(s.id, "normalizeFactor", nextVal)
            UI:Refresh()
        end
    end)
    normChk:SetPoint("TOPLEFT", 4, -530)

    local hide1HChk = CreateCheckButton(tab, 200, L["Hide 1H upgrades"], function()
        local s = ns.Scales:GetSelected()
        if s then
            ns.Scales:SetProperty(s.id, "hide1H", not s.hide1H)
            ns:Changed(false)
            UI:Refresh()
        end
    end)
    hide1HChk:SetPoint("LEFT", normChk, "RIGHT", 12, 0)

    local hide2HChk = CreateCheckButton(tab, 200, L["Hide 2H upgrades"], function()
        local s = ns.Scales:GetSelected()
        if s then
            ns.Scales:SetProperty(s.id, "hide2H", not s.hide2H)
            ns:Changed(false)
            UI:Refresh()
        end
    end)
    hide2HChk:SetPoint("TOPLEFT", 4, -554)

    function tab:Refresh()
        local s = ns.Scales:GetSelected()
        if not s then
            self.header:SetText(L["No scale selected"])
            return
        end
        self.header:SetText((L["Stat weights for %s"]):format(ns.Scales.ColorCode(s.colorHex) .. s.name .. "|r"))

        for _, row in ipairs(statRows) do
            local val = s.weights[row.statKey] or 0
            if not row.box:HasFocus() then
                row.box:SetText(FormatWeight(val))
            end
            local isCust = s.isStarter and s.overrides and s.overrides[row.statKey] ~= nil
            if isCust then
                row.box:SetTextColor(CUSTOM_COLOR[1], CUSTOM_COLOR[2], CUSTOM_COLOR[3])
            else
                row.box:SetTextColor(0.95, 0.96, 0.98)
            end
            local dim = (val ~= 0) and 0.92 or 0.45
            row.label:SetTextColor(dim, dim, dim)
        end

        for _, chk in ipairs(typeChecks) do
            chk:SetCheckedState(s.unusableTypes and s.unusableTypes[chk._typeKey])
        end

        normChk:SetCheckedState((type(s.normalizeFactor) == "number" and s.normalizeFactor > 0) or (s.normalizeFactor == true))
        hide1HChk:SetCheckedState(s.hide1H)
        hide2HChk:SetCheckedState(s.hide2H)
    end

    return tab
end

local function BuildCapsTab(parent)
    local tab = CreateFrame("Frame", nil, parent)
    tab:SetAllPoints()

    local liveHdr = CreateLabel(tab, 13, ACCENT[1], ACCENT[2], ACCENT[3])
    liveHdr:SetPoint("TOPLEFT", 4, -4)
    liveHdr:SetText(L["Live Character Stats & Cap Status"])

    local targetBadge = CreateLabel(tab, 11, EMERALD[1], EMERALD[2], EMERALD[3], "RIGHT")
    targetBadge:SetPoint("TOPRIGHT", -6, -5)
    targetBadge:SetWidth(330)

    -- Live Cap Bars Box (clipped scroll area prevents bars from pushing down footers/config)
    local livePanel = CreateFrame("Frame", nil, tab)
    livePanel:SetPoint("TOPLEFT", 4, -24)
    livePanel:SetSize(RIGHT_W - 8, 276)
    StylePanel(livePanel, 0.075, 0.08, 0.105, 1)

    local barsScroll = CreateScrollArea(livePanel, RIGHT_W - 16, 224)
    barsScroll:SetPoint("TOPLEFT", 4, -6)

    local capBars = {}
    for i = 1, 12 do
        local col = (i - 1) % 2
        local row = math.floor((i - 1) / 2)
        local x = 6 + col * 320
        local y = -4 - row * 48

        local item = CreateFrame("Frame", nil, barsScroll.content)
        item:SetSize(308, 42)
        item:SetPoint("TOPLEFT", x, y)

        item.title = CreateLabel(item, 11, 0.92, 0.94, 0.98)
        item.title:SetPoint("TOPLEFT", 0, 0)
        item.title:SetWidth(160)
        if item.title.SetWordWrap then item.title:SetWordWrap(false) end

        item.valText = CreateLabel(item, 10, 0.85, 0.88, 0.92, "RIGHT")
        item.valText:SetPoint("TOPRIGHT", 0, 0)
        item.valText:SetWidth(146)
        if item.valText.SetWordWrap then item.valText:SetWordWrap(false) end

        local barBg = CreateFrame("Frame", nil, item)
        barBg:SetPoint("TOPLEFT", 0, -14)
        barBg:SetSize(308, 10)
        StylePanel(barBg, 0.04, 0.045, 0.06, 1)

        local fill = barBg:CreateTexture(nil, "ARTWORK")
        fill:SetPoint("TOPLEFT", 1, -1)
        fill:SetPoint("BOTTOMLEFT", 1, 1)
        fill:SetWidth(1)
        fill:SetColorTexture(ACCENT[1], ACCENT[2], ACCENT[3], 0.9)

        item.detail = CreateLabel(item, 9, 0.65, 0.68, 0.75)
        item.detail:SetPoint("TOPLEFT", 0, -26)
        item.detail:SetWidth(308)
        item.detail:SetHeight(11)
        if item.detail.SetWordWrap then item.detail:SetWordWrap(false) end

        item.fill = fill
        item.barW = 306
        capBars[i] = item
    end

    local talentLine = CreateLabel(livePanel, 10, 0.72, 0.90, 0.80)
    talentLine:SetPoint("BOTTOMLEFT", 10, 6)
    talentLine:SetWidth(RIGHT_W - 28)
    talentLine:SetWordWrap(true)

    local druidBearHint = CreateLabel(livePanel, 10, 1.00, 0.80, 0.30)
    druidBearHint:SetPoint("BOTTOMLEFT", talentLine, "TOPLEFT", 0, 3)
    druidBearHint:SetWidth(RIGHT_W - 28)
    druidBearHint:SetWordWrap(true)
    druidBearHint:SetText(L["Note: Shift into Bear Form when comparing items for an accurate 75% armor cap calculation."])
    druidBearHint:Hide()

    -- Simplified Automatic Cap Configuration Box
    local cfgHdr = CreateLabel(tab, 13, ACCENT[1], ACCENT[2], ACCENT[3])
    cfgHdr:SetPoint("TOPLEFT", 4, -308)
    cfgHdr:SetText(L["Profile Cap Configuration"])

    local cfgPanel = CreateFrame("Frame", nil, tab)
    cfgPanel:SetPoint("TOPLEFT", 4, -326)
    cfgPanel:SetSize(RIGHT_W - 8, 274)
    StylePanel(cfgPanel, 0.075, 0.08, 0.105, 1)

    local capChecks = {}
    local checkSpecs = {
        { key = "enableCaps", label = L["Cap engine active"], x = 12, y = -10 },
        { key = "useTalents", label = L["Talent integration active"], x = 302, y = -10 },
        { key = "tankExpertiseMode", label = L["Tank mode"], x = 12, y = -32 },
    }
    for _, spec in ipairs(checkSpecs) do
        local chk = CreateCheckButton(cfgPanel, 280, spec.label, function()
            local s = ns.Scales:GetSelected()
            if s then
                ns.Scales:SetCapOption(s.id, spec.key, not s.caps[spec.key])
                ns:Changed(false)
                UI:Refresh()
            end
        end)
        chk:SetPoint("TOPLEFT", spec.x, spec.y)
        chk._capKey = spec.key
        capChecks[#capChecks + 1] = chk
    end

    local raidResistChk = CreateCheckButton(cfgPanel, 310, L["Include Raid Resistance Buff (+60)"], function()
        local s = ns.Scales:GetSelected()
        if s then
            ns.Scales:SetCapOption(s.id, "includeRaidResistBuff", not (s.caps and s.caps.includeRaidResistBuff))
            ns:Changed(false)
            UI:Refresh()
        end
    end)
    raidResistChk:SetPoint("TOPLEFT", 12, -54)
    raidResistChk:SetScript("OnEnter", function(self)
        self.box:SetBorderColor(ACCENT[1], ACCENT[2], ACCENT[3], 1)
        if GameTooltip then
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText(L["Include Raid Resistance Buff (+60)"], 1, 1, 1)
            GameTooltip:AddLine(L["Raid resistance buff tooltip"], 0.85, 0.90, 0.96, true)
            GameTooltip:Show()
        end
    end)
    raidResistChk:SetScript("OnLeave", function(self)
        self.box:SetBorderColor(BORDER_IDLE[1], BORDER_IDLE[2], BORDER_IDLE[3], 1)
        if GameTooltip then
            GameTooltip:Hide()
        end
    end)
    raidResistChk:Hide()

    local scaleLevelChk = CreateCheckButton(cfgPanel, 356, L["Scale % stats by level (< 60)"], function()
        local s = ns.Scales:GetSelected()
        if s then
            local cur = (s.caps == nil) or (s.caps.scalePercentByLevel ~= false)
            ns.Scales:SetCapOption(s.id, "scalePercentByLevel", not cur)
            ns:Changed(false)
            UI:Refresh()
        end
    end)
    scaleLevelChk:SetPoint("TOPLEFT", 302, -32)
    scaleLevelChk:SetScript("OnEnter", function(self)
        self.box:SetBorderColor(ACCENT[1], ACCENT[2], ACCENT[3], 1)
        if GameTooltip then
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            GameTooltip:SetText(L["Scale % stats by level (< 60)"], 1, 1, 1)
            GameTooltip:AddLine(L["Scale % stats by level tooltip"], 0.85, 0.90, 0.96, true)
            GameTooltip:Show()
        end
    end)
    scaleLevelChk:SetScript("OnLeave", function(self)
        self.box:SetBorderColor(BORDER_IDLE[1], BORDER_IDLE[2], BORDER_IDLE[3], 1)
        if GameTooltip then
            GameTooltip:Hide()
        end
    end)

    local targetHdr = CreateLabel(cfgPanel, 11, ACCENT[1], ACCENT[2], ACCENT[3])
    targetHdr:SetPoint("TOPLEFT", 12, -56)
    targetHdr:SetText(L["Target enemy level"])

    local targetButtons = {}
    local targetModes = {
        { mode = "auto", label = L["Automatic"] },
        { mode = 0, label = L["Even level (+0)"] },
        { mode = 2, label = L["Dungeon boss (+2)"] },
        { mode = 3, label = L["Raid boss (+3)"] },
    }
    for idx, tSpec in ipairs(targetModes) do
        local btn = CreateFlatButton(cfgPanel, 140, 22, tSpec.label, function()
            local s = ns.Scales:GetSelected()
            if s then
                ns.Scales:SetCapOption(s.id, "targetMode", tSpec.mode)
                ns:Changed(false)
                UI:Refresh()
            end
        end)
        btn:SetPoint("TOPLEFT", 12 + (idx - 1) * 148, -73)
        btn._targetMode = tSpec.mode
        targetButtons[#targetButtons + 1] = btn
    end

    local hitModeHdr = CreateLabel(cfgPanel, 11, ACCENT[1], ACCENT[2], ACCENT[3])
    hitModeHdr:SetPoint("TOPLEFT", 12, -106)
    hitModeHdr:SetWidth(140)
    hitModeHdr:SetText(L["Hit mode"])
    FitText(hitModeHdr, 136, 11)

    local hitModeButtons = {}
    local hitModeSpecs = {
        { mode = "auto", label = L["Automatic"] },
        { mode = "melee", label = L["Melee"] },
        { mode = "spell", label = L["Spell"] },
    }
    for idx, hSpec in ipairs(hitModeSpecs) do
        local btn = CreateFlatButton(cfgPanel, 140, 22, hSpec.label, function()
            local s = ns.Scales:GetSelected()
            if s then
                ns.Scales:SetCapOption(s.id, "hitMode", hSpec.mode)
                ns:Changed(false)
                UI:Refresh()
            end
        end)
        btn:SetPoint("TOPLEFT", 12 + idx * 148, -102)
        btn._hitMode = hSpec.mode
        hitModeButtons[#hitModeButtons + 1] = btn
    end

    -- Optional Spirit target block (hidden for non-mana classes unless Spirit is weighted)
    local spiritFrame = CreateFrame("Frame", nil, cfgPanel)
    spiritFrame:SetPoint("TOPLEFT", 12, -132)
    spiritFrame:SetSize(RIGHT_W - 32, 62)
    spiritFrame:EnableMouse(true)

    local function ShowSpiritTooltip(self)
        if not GameTooltip then return end
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(L["Optional Spirit Target (0 = no limit)"], 1, 1, 1)
        GameTooltip:AddLine(L["Spirit target tooltip"], 0.85, 0.90, 0.96, true)
        GameTooltip:Show()
    end
    local function HideSpiritTooltip()
        if GameTooltip then
            GameTooltip:Hide()
        end
    end
    spiritFrame:SetScript("OnEnter", ShowSpiritTooltip)
    spiritFrame:SetScript("OnLeave", HideSpiritTooltip)

    local spiritLbl = CreateLabel(spiritFrame, 11, 0.88, 0.90, 0.94)
    spiritLbl:SetPoint("TOPLEFT", 0, -3)
    spiritLbl:SetWidth(272)
    spiritLbl:SetText(L["Optional Spirit Target (0 = no limit)"])
    FitText(spiritLbl, 270, 11)

    local spiritBox = CreateEditBox(spiritFrame, 76, 20, "RIGHT", function(self, txt)
        local s = ns.Scales:GetSelected()
        if not s then return end
        local num = tonumber((txt:gsub(",", ".")))
        if num then
            ns.Scales:SetCapOption(s.id, "spiritTarget", math.max(0, num))
            ns:Changed(false)
        end
        UI:Refresh()
    end)
    spiritBox:SetPoint("TOPLEFT", 278, 0)
    spiritBox._onCancel = function() UI:Refresh() end
    spiritBox:SetScript("OnEnter", ShowSpiritTooltip)
    spiritBox:SetScript("OnLeave", HideSpiritTooltip)

    local spiritCurLbl = CreateLabel(spiritFrame, 10, EMERALD[1], EMERALD[2], EMERALD[3])
    spiritCurLbl:SetPoint("LEFT", spiritBox, "RIGHT", 10, 0)
    spiritCurLbl:SetWidth(180)
    spiritCurLbl:Hide()

    local spiritHelpLbl = CreateLabel(spiritFrame, 9, 0.65, 0.72, 0.80)
    spiritHelpLbl:SetPoint("TOPLEFT", 0, -22)
    spiritHelpLbl:SetWidth(RIGHT_W - 32)
    spiritHelpLbl:SetWordWrap(true)
    spiritHelpLbl:SetJustifyV("TOP")
    spiritHelpLbl:SetText(L["Spirit target tooltip"])

    local mechNote = CreateLabel(cfgPanel, 9, 0.70, 0.75, 0.82)
    mechNote:SetPoint("TOPLEFT", spiritFrame, "BOTTOMLEFT", 0, -6)
    mechNote:SetWidth(RIGHT_W - 32)
    mechNote:SetWordWrap(true)
    mechNote:SetJustifyV("TOP")
    mechNote:SetText(L["Automatic cap mechanics note"])

    local SHIELD_CLASSES = {
        WARRIOR = true,
        PALADIN = true,
        SHAMAN = true,
    }

    local function ShouldShowCapRow(r, s, st, rc)
        local cls = (s and s.class) or ns.class
        local playerCls = ns.class or cls
        local w = (s and s.weights) or {}
        local isTankMode = ((s and s.caps and s.caps.tankExpertiseMode == true)
            or (s and (s.isTank == true or s.role == "TANK"))) and true or false
        local isTiebreakerArmor = (w.ARMOR == 0.01) and not isTankMode
            and not (s and s.overrides and s.overrides.ARMOR ~= nil)
        local hasArmorWeight = (not isTiebreakerArmor) and ((w.ARMOR or 0) > 0)
        local hasDefenseWeight = ((w.DEFENSE or 0) > 0)

        if r.key == "BLOCK" then
            if not SHIELD_CLASSES[playerCls] or not SHIELD_CLASSES[cls] then
                return false
            end
            if s and s.unusableTypes and (s.unusableTypes.IsShield or s.unusableTypes.INVTYPE_SHIELD) then
                return false
            end
            local ohLink = GetInventoryItemLink and GetInventoryItemLink("player", 17)
            if ohLink and C_Item and C_Item.GetItemInfoInstant then
                local _, _, _, equipLoc = C_Item.GetItemInfoInstant(ohLink)
                equipLoc = ns.Plain and ns.Plain(equipLoc) or equipLoc
                if equipLoc == "INVTYPE_HOLDABLE" then
                    return false
                end
            end
            return true
        elseif r.key == "DEFENSE" then
            return isTankMode or hasDefenseWeight
        elseif r.key == "ARMOR" then
            return isTankMode or hasArmorWeight
        elseif r.key == "EXPERTISE" then
            if (w.EXPERTISE or 0) > 0 or isTankMode then
                return true
            end
            if cls == "MAGE" or cls == "PRIEST" or cls == "WARLOCK" or cls == "HUNTER"
                or rc.hitKind ~= "melee" then
                return false
            end
            return true
        elseif r.key == "HIT" then
            if s and s.caps and (s.caps.hitMode == "melee" or s.caps.hitMode == "spell") then
                return true
            end
            if rc.hitKind == "spell" then
                local hasSpellWeight = (w.HIT or 0) > 0 or (w.SPELL_DAMAGE or 0) > 0 or (w.HEALING or 0) > 0
                    or (w.ARCANE_DAMAGE or 0) > 0 or (w.FIRE_DAMAGE or 0) > 0 or (w.FROST_DAMAGE or 0) > 0
                    or (w.NATURE_DAMAGE or 0) > 0 or (w.SHADOW_DAMAGE or 0) > 0 or (w.HOLY_DAMAGE or 0) > 0
                if (cls == "WARRIOR" or cls == "ROGUE" or cls == "HUNTER") and not hasSpellWeight then
                    return false
                end
                if (s and s.role == "HEALER") and (w.HIT or 0) <= 0 and (w.SPELL_DAMAGE or 0) <= 0 then
                    return false
                end
                return true
            else
                if cls == "MAGE" or cls == "PRIEST" or cls == "WARLOCK" then
                    return (w.MELEE_HIT or 0) > 0 or (w.RANGED_HIT or 0) > 0
                        or (w.ATTACK_POWER or 0) > 0 or (w.RANGED_AP or 0) > 0
                        or (w.STRENGTH or 0) > 0 or (w.AGILITY or 0) > 0
                        or (w.EXPERTISE or 0) > 0
                end
                return true
            end
        elseif r.key == "SPIRIT" then
            return (rc.spiritTarget or 0) > 0 and ((cls ~= "WARRIOR" and cls ~= "ROGUE") or (w.SPIRIT or 0) > 0)
        end

        return true
    end

    local targetNames = {
        [0] = L["Even level (+0)"],
        [2] = L["Dungeon boss (+2)"],
        [3] = L["Raid boss (+3)"],
    }

    function tab:Refresh()
        local s = ns.Scales:GetSelected()
        if not s then return end

        local rows, st, rc = ns.Caps:GetLiveCapStatus(s)
        st = st or {}
        rc = rc or {}

        local curMode = (s.caps and s.caps.targetMode ~= nil) and s.caps.targetMode or "auto"
        local tOffset = tonumber(rc.targetOffset) or 0
        local tLabel = targetNames[tOffset] or L["Even level (+0)"]
        if curMode == "auto" then
            tLabel = tLabel .. " (" .. L["Automatic"] .. ")"
        end
        local enemyLv = tonumber(rc.enemyLevel) or UnitLevel("player") or 60
        targetBadge:SetText((L["Target: %s (Level %d)"]):format(tLabel, enemyLv))
        FitText(targetBadge, 330, 11)

        -- Filter irrelevant cap bars & dynamically reflow remaining bars without gaps
        local visibleRows = {}
        for _, r in ipairs(rows) do
            if ShouldShowCapRow(r, s, st, rc) then
                visibleRows[#visibleRows + 1] = r
            end
        end

        local numVisible = #visibleRows
        local rowStep = 48

        for i, bar in ipairs(capBars) do
            local r = visibleRows[i]
            if r then
                local col = (i - 1) % 2
                local rowIdx = math.floor((i - 1) / 2)
                bar:SetHeight(42)
                bar:ClearAllPoints()
                bar:SetPoint("TOPLEFT", 6 + col * 320, -4 - rowIdx * rowStep)
                bar:Show()
                bar.title:SetText(r.label)
                FitText(bar.title, 160, 11)
                if r.isResistance then
                    if (r.offset or 0) > 0 then
                        bar.valText:SetText(("%d (+%d) / %d (%s)"):format(
                            math.floor(r.current + 0.5),
                            math.floor(r.offset + 0.5),
                            math.floor(r.cap + 0.5),
                            r.statusText or ""
                        ))
                    else
                        bar.valText:SetText(("%d / %d (%s)"):format(
                            math.floor(r.current + 0.5),
                            math.floor(r.cap + 0.5),
                            r.statusText or ""
                        ))
                    end
                else
                    bar.valText:SetText(("%s / %s%s (%s)"):format(
                        ns.Format(r.current, 1),
                        ns.Format(r.cap, 1),
                        r.unit or "",
                        r.statusText or ""
                    ))
                end
                FitText(bar.valText, 146, 10)
                local pct = (r.cap and r.cap > 0) and math.min(1, math.max(0.02, r.current / r.cap)) or 0.02
                bar.fill:SetWidth(math.max(2, math.floor(bar.barW * pct)))
                if r.state == "HARD" then
                    bar.fill:SetColorTexture(1.0, 0.30, 0.30, 0.95)
                    bar.valText:SetTextColor(1.0, 0.40, 0.40)
                elseif r.state == "SOFT" then
                    bar.fill:SetColorTexture(1.0, 0.72, 0.15, 0.95)
                    bar.valText:SetTextColor(1.0, 0.80, 0.25)
                else
                    bar.fill:SetColorTexture(EMERALD[1], EMERALD[2], EMERALD[3], 0.9)
                    bar.valText:SetTextColor(0.80, 0.92, 0.88)
                end
                bar.detail:SetText(r.detail or "")
                FitText(bar.detail, 306, 9)
                bar.detail:Show()
            else
                bar:Hide()
            end
        end

        local totalRows = math.max(1, math.ceil(numVisible / 2))
        barsScroll.content:SetHeight(math.max(214, totalRows * rowStep + 6))
        barsScroll:UpdateBounds()

        local talList = ns.Talents and ns.Talents:GetActiveTalentList() or {}
        local tParts = {}
        for _, t in ipairs(talList) do
            tParts[#tParts + 1] = ("%s (%d/%d)"):format(t.name, t.rank, t.maxRank)
        end
        local talStr = #tParts > 0 and table.concat(tParts, ", ") or L["Not active"]
        local line = L["Active talents:"] .. " " .. talStr .. "  |  WeaponSkill: +" .. tostring(st.weaponSkillBonus or 0)
        if st.dualWielding and rc.hitKind == "melee" then
            line = line .. "  |  " .. L["Dual-wield auto-detected"]
        end
        if rc.offsetNotes and #rc.offsetNotes > 0 then
            line = line .. "\n|cff88d8ff+ " .. table.concat(rc.offsetNotes, ", ") .. "|r"
        end
        talentLine:SetText(line)

        -- Druid Bear / Dire Bear Form hint
        local w = s.weights or {}
        local isTankMode = ((s.caps and s.caps.tankExpertiseMode == true)
            or (s.isTank == true or s.role == "TANK")) and true or false
        local isTiebreakerArmor = (w.ARMOR == 0.01) and not isTankMode
            and not (s.overrides and s.overrides.ARMOR ~= nil)
        local hasArmorWeight = (not isTiebreakerArmor) and ((w.ARMOR or 0) > 0)
        local formID = ns.PlainNumber and ns.PlainNumber(GetShapeshiftFormID and GetShapeshiftFormID(), 0) or 0
        if ns.class == "DRUID" and (isTankMode or hasArmorWeight) and formID ~= 5 and formID ~= 8 then
            druidBearHint:Show()
        else
            druidBearHint:Hide()
        end

        for _, chk in ipairs(capChecks) do
            chk:SetCheckedState(s.caps and s.caps[chk._capKey])
        end

        local scaleLvlOn = (s.caps == nil) or (s.caps.scalePercentByLevel ~= false)
        scaleLevelChk:SetCheckedState(scaleLvlOn)
        local lvlPct = math.floor((tonumber(rc.levelScaleFactor) or 1.0) * 100 + 0.5)
        scaleLevelChk.text:SetText(("%s (%d%%)"):format(L["Scale % stats by level (< 60)"], lvlPct))
        FitText(scaleLevelChk.text, 332, 11)

        local extraY = 0
        if rc.anyResistWeighted then
            raidResistChk:SetCheckedState(s.caps and s.caps.includeRaidResistBuff)
            raidResistChk:Show()
            extraY = -20
        else
            raidResistChk:Hide()
        end

        targetHdr:ClearAllPoints()
        targetHdr:SetPoint("TOPLEFT", 12, -56 + extraY)
        for idx, btn in ipairs(targetButtons) do
            btn:ClearAllPoints()
            btn:SetPoint("TOPLEFT", 12 + (idx - 1) * 148, -73 + extraY)
            btn:SetSelected(curMode == btn._targetMode, EMERALD)
        end

        hitModeHdr:ClearAllPoints()
        hitModeHdr:SetPoint("TOPLEFT", 12, -106 + extraY)
        local curHitMode = (s.caps and s.caps.hitMode) or "auto"
        for idx, btn in ipairs(hitModeButtons) do
            btn:ClearAllPoints()
            btn:SetPoint("TOPLEFT", 12 + idx * 148, -102 + extraY)
            btn:SetSelected(curHitMode == btn._hitMode, EMERALD)
        end

        spiritFrame:ClearAllPoints()
        spiritFrame:SetPoint("TOPLEFT", 12, -132 + extraY)

        -- Context-aware Spirit target visibility
        local cls = s.class or ns.class
        local showSpirit = (cls ~= "WARRIOR" and cls ~= "ROGUE") or ((w.SPIRIT or 0) > 0)
        mechNote:ClearAllPoints()
        if showSpirit then
            spiritFrame:Show()
            local spTarget = tonumber(s.caps and s.caps.spiritTarget) or 0
            if not spiritBox:HasFocus() then
                spiritBox:SetText(tostring(spTarget))
            end
            if spTarget > 0 then
                spiritCurLbl:SetText(("%s %d"):format(L["Current:"], math.floor((st.spirit or 0) + 0.5)))
                spiritCurLbl:Show()
            else
                spiritCurLbl:Hide()
            end
            mechNote:SetPoint("TOPLEFT", spiritFrame, "BOTTOMLEFT", 0, -6)
        else
            spiritFrame:Hide()
            mechNote:SetPoint("TOPLEFT", 12, -134 + extraY)
        end
    end

    return tab
end

local function BuildCompareTab(parent)
    local tab = CreateFrame("Frame", nil, parent)
    tab:SetAllPoints()

    tab.header = CreateLabel(tab, 14, 1, 1, 1)
    tab.header:SetPoint("TOPLEFT", 4, -4)

    local hint = CreateLabel(tab, 10, 0.72, 0.75, 0.80)
    hint:SetPoint("TOPLEFT", 4, -22)
    hint:SetText(L["Drop an item or paste an item link / ID below, or pick from equipped / bags:"])

    local function MakeSlotBox(x, sideKey, titleText)
        local box = CreateFrame("Frame", nil, tab)
        box:SetSize(296, 106)
        box:SetPoint("TOPLEFT", x, -42)
        StylePanel(box, 0.08, 0.085, 0.11, 1)

        local title = CreateLabel(box, 11, ACCENT[1], ACCENT[2], ACCENT[3])
        title:SetPoint("TOPLEFT", 8, -6)
        title:SetText(titleText)

        local iconBtn = CreateFrame("Button", nil, box)
        iconBtn:SetSize(38, 38)
        iconBtn:SetPoint("TOPLEFT", 8, -24)
        StylePanel(iconBtn, 0.05, 0.055, 0.07, 1)
        local tex = iconBtn:CreateTexture(nil, "ARTWORK")
        tex:SetPoint("TOPLEFT", 2, -2)
        tex:SetPoint("BOTTOMRIGHT", -2, 2)
        iconBtn.tex = tex

        local function AcceptCursor()
            if GetCursorInfo then
                local kind, id, link = GetCursorInfo()
                if kind == "item" and (link or id) then
                    ns.char[sideKey] = link or ("item:" .. tostring(id))
                    ClearCursor()
                    UI:Refresh()
                end
            end
        end
        iconBtn:SetScript("OnReceiveDrag", AcceptCursor)
        iconBtn:SetScript("OnClick", AcceptCursor)
        iconBtn:SetScript("OnEnter", function(self)
            local lnk = ns.char and ns.char[sideKey]
            if lnk then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                pcall(GameTooltip.SetHyperlink, GameTooltip, lnk)
                GameTooltip:Show()
            end
        end)
        iconBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

        local itemName = CreateLabel(box, 11, 0.92, 0.94, 0.98)
        itemName:SetPoint("TOPLEFT", 52, -24)
        itemName:SetWidth(236)

        local scoreSummary = CreateLabel(box, 10, 0.80, 0.85, 0.90)
        scoreSummary:SetPoint("TOPLEFT", 52, -42)
        scoreSummary:SetWidth(236)

        local input = CreateEditBox(box, 128, 20, "LEFT", function(self, txt)
            txt = ns.Trim(txt)
            if txt ~= "" then
                local link = ns.Parser.FullItemString(txt) or (tonumber(txt) and ("item:" .. txt))
                if link then
                    ns.char[sideKey] = link
                    UI:Refresh()
                end
            end
        end)
        input:SetPoint("BOTTOMLEFT", 8, 8)

        local eqPick = CreateFlatButton(box, 72, 20, L["Pick from equipped"], function()
            UI:ShowItemPicker(sideKey, false)
        end)
        eqPick:SetPoint("LEFT", input, "RIGHT", 4, 0)

        local bagPick = CreateFlatButton(box, 72, 20, L["Pick from bags"], function()
            UI:ShowItemPicker(sideKey, true)
        end)
        bagPick:SetPoint("LEFT", eqPick, "RIGHT", 4, 0)

        box.iconBtn = iconBtn
        box.itemName = itemName
        box.scoreSummary = scoreSummary
        box.input = input
        return box
    end

    local leftBox = MakeSlotBox(4, "compareLeft", L["Left item"])
    local rightBox = MakeSlotBox(342, "compareRight", L["Right item"])

    local swapBtn = CreateFlatButton(tab, 90, 22, L["‹ Swap ›"], function()
        local tmp = ns.char.compareLeft
        ns.char.compareLeft = ns.char.compareRight
        ns.char.compareRight = tmp
        UI:Refresh()
    end)
    swapBtn:SetPoint("TOPLEFT", 236, -154)

    local clearBtn = CreateFlatButton(tab, 90, 22, L["Clear"], function()
        ns.char.compareLeft = nil
        ns.char.compareRight = nil
        UI:Refresh()
    end)
    clearBtn:SetPoint("LEFT", swapBtn, "RIGHT", 12, 0)

    local verdictBanner = CreateLabel(tab, 12, EMERALD[1], EMERALD[2], EMERALD[3], "CENTER")
    verdictBanner:SetPoint("TOPLEFT", 4, -182)
    verdictBanner:SetWidth(RIGHT_W - 8)

    local tableScroll = CreateScrollArea(tab, RIGHT_W - 8, 366)
    tableScroll:SetPoint("TOPLEFT", 4, -206)
    StylePanel(tableScroll, 0.075, 0.08, 0.105, 1)

    local tableRows = {}

    local function EnsureRow(idx)
        if tableRows[idx] then
            return tableRows[idx]
        end
        local r = CreateFrame("Frame", nil, tableScroll.content)
        r:SetSize(RIGHT_W - 26, 20)
        r:SetPoint("TOPLEFT", 6, -6 - (idx - 1) * 21)

        r.stat = CreateLabel(r, 11, 0.90, 0.92, 0.95)
        r.stat:SetPoint("LEFT", 2, 0)
        r.stat:SetWidth(165)

        r.leftEP = CreateLabel(r, 11, 0.85, 0.88, 0.92, "RIGHT")
        r.leftEP:SetPoint("LEFT", 172, 0)
        r.leftEP:SetWidth(135)

        r.rightEP = CreateLabel(r, 11, 0.85, 0.88, 0.92, "RIGHT")
        r.rightEP:SetPoint("LEFT", 315, 0)
        r.rightEP:SetWidth(135)

        r.diff = CreateLabel(r, 11, 0.95, 0.95, 0.95, "RIGHT")
        r.diff:SetPoint("LEFT", 458, 0)
        r.diff:SetWidth(120)

        tableRows[idx] = r
        return r
    end

    function tab:Refresh()
        local s = ns.Scales:GetSelected()
        if not s then return end
        self.header:SetText((L["Compare items for %s"]):format(ns.Scales.ColorCode(s.colorHex) .. s.name .. "|r"))

        local lLink = ns.char.compareLeft
        local rLink = ns.char.compareRight
        local cmp = ns.Upgrades:CompareItems(lLink, rLink, s)

        local function UpdateBox(box, info, raw, eff)
            if info then
                box.iconBtn.tex:SetTexture(info.icon)
                local qc = ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[info.quality]
                local hex = qc and qc.hex or "|cffffffff"
                box.itemName:SetText(hex .. info.name .. "|r")
                box.scoreSummary:SetText(("%s %s  |  %s %s"):format(
                    L["Raw EP"], ns.Format(raw or 0),
                    L["Effective (Cap Delta)"], ns.Format(eff or 0)
                ))
            else
                box.iconBtn.tex:SetTexture(nil)
                box.itemName:SetText(L["Empty slot"])
                box.scoreSummary:SetText("")
            end
        end

        UpdateBox(leftBox, cmp and cmp.leftInfo, cmp and cmp.leftRaw, cmp and cmp.leftEff)
        UpdateBox(rightBox, cmp and cmp.rightInfo, cmp and cmp.rightRaw, cmp and cmp.rightEff)

        for _, row in ipairs(tableRows) do
            row:Hide()
        end

        if not cmp then
            verdictBanner:SetText("")
            tableScroll.content:SetHeight(290)
            tableScroll:UpdateBounds()
            return
        end

        if cmp.diffEff > 0.05 then
            local g = cmp.diffPct and ("+%d%% (+%s EP)"):format(math.floor(cmp.diffPct + 0.5), ns.Format(cmp.diffEff)) or ("+" .. ns.Format(cmp.diffEff) .. " EP")
            verdictBanner:SetText((L["Upgrade: %s"]):format(g))
            verdictBanner:SetTextColor(EMERALD[1], EMERALD[2], EMERALD[3])
        elseif cmp.diffEff < -0.05 then
            local g = cmp.diffPct and ("%d%% (%s EP)"):format(math.floor(cmp.diffPct + 0.5), ns.Format(cmp.diffEff)) or (ns.Format(cmp.diffEff) .. " EP")
            verdictBanner:SetText((L["Downgrade: %s"]):format(g))
            verdictBanner:SetTextColor(1.0, 0.35, 0.35)
        else
            verdictBanner:SetText(L["Equal"])
            verdictBanner:SetTextColor(0.85, 0.88, 0.92)
        end

        local hdr = EnsureRow(1)
        hdr:Show()
        hdr.stat:SetText(L["Stat"])
        hdr.stat:SetTextColor(ACCENT[1], ACCENT[2], ACCENT[3])
        hdr.leftEP:SetText(L["Left item"] .. " (Eff / Roh)")
        hdr.leftEP:SetTextColor(ACCENT[1], ACCENT[2], ACCENT[3])
        hdr.rightEP:SetText(L["Right item"] .. " (Eff / Roh)")
        hdr.rightEP:SetTextColor(ACCENT[1], ACCENT[2], ACCENT[3])
        hdr.diff:SetText(L["Difference"])
        hdr.diff:SetTextColor(ACCENT[1], ACCENT[2], ACCENT[3])

        local idx = 1
        for _, r in ipairs(cmp.rows) do
            idx = idx + 1
            local uiRow = EnsureRow(idx)
            uiRow:Show()
            uiRow.stat:SetText(r.label)
            uiRow.stat:SetTextColor(0.90, 0.92, 0.95)
            local lCap = r.leftCapped and " |cffffaa40[Cap]|r" or ""
            local rCap = r.rightCapped and " |cffffaa40[Cap]|r" or ""
            uiRow.leftEP:SetText(("%s (%s)%s"):format(ns.Format(r.leftEffEP), ns.Format(r.leftRawEP), lCap))
            uiRow.rightEP:SetText(("%s (%s)%s"):format(ns.Format(r.rightEffEP), ns.Format(r.rightRawEP), rCap))
            local d = r.rightEffEP - r.leftEffEP
            uiRow.diff:SetText((d > 0 and "+" or "") .. ns.Format(d))
            if d > 0.05 then
                uiRow.diff:SetTextColor(EMERALD[1], EMERALD[2], EMERALD[3])
            elseif d < -0.05 then
                uiRow.diff:SetTextColor(1.0, 0.35, 0.35)
            else
                uiRow.diff:SetTextColor(0.70, 0.72, 0.78)
            end
        end

        -- Totals row
        idx = idx + 1
        local tot = EnsureRow(idx)
        tot:Show()
        tot.stat:SetText(L["Cap-Adjusted Score"])
        tot.stat:SetTextColor(1, 1, 1)
        tot.leftEP:SetText(("%s (%s)"):format(ns.Format(cmp.leftEff), ns.Format(cmp.leftRaw)))
        tot.rightEP:SetText(("%s (%s)"):format(ns.Format(cmp.rightEff), ns.Format(cmp.rightRaw)))
        tot.diff:SetText((cmp.diffEff > 0 and "+" or "") .. ns.Format(cmp.diffEff))

        tableScroll.content:SetHeight(math.max(290, idx * 21 + 14))
        tableScroll:UpdateBounds()
    end

    return tab
end

local function BuildOptionsTab(parent)
    local tab = CreateFrame("Frame", nil, parent)
    tab:SetAllPoints()

    local ttHdr = CreateLabel(tab, 13, ACCENT[1], ACCENT[2], ACCENT[3])
    ttHdr:SetPoint("TOPLEFT", 8, -8)
    ttHdr:SetText(L["Tooltip display"])

    local modeButtons = {}
    local modes = {
        { id = "UPGRADES_ONLY", label = L["Only show upgrades"] },
        { id = "VALUES_AND_UPGRADES", label = L["Show values and upgrades"] },
        { id = "VALUES_ONLY", label = L["Show only values"] },
    }
    for i, m in ipairs(modes) do
        local btn = CreateFlatButton(tab, 185, 24, m.label, function()
            ns.options.tooltipMode = m.id
            ns:Changed(false)
            UI:Refresh()
        end)
        btn:SetPoint("TOPLEFT", 8 + (i - 1) * 195, -30)
        btn._mode = m.id
        modeButtons[#modeButtons + 1] = btn
    end

    local checks = {}
    local optList = {
        { key = "showCurrentValues", label = L["Show current (enchanted) & base values"] },
        { key = "alignRight", label = L["Align tooltip values right"] },
        { key = "blankLine", label = L["Add blank line before values"] },
        { key = "colorTooltipBorder", label = L["Color tooltip border on upgrades"] },
        { key = "healingToDamageFallback", label = L["Healing-to-SpellDamage fallback (1/3)"], wipe = true },
        { key = "showBagArrows", label = L["Bag upgrade arrows"] },
        { key = "showQuestArrows", label = L["Quest reward arrows & gold coin"] },
        { key = "showLootAdvisor", label = L["Loot roll advisor"] },
        { key = "announceUpgrades", label = L["Announce bag upgrades in chat"] },
        { key = "debug", label = L["Debug mode"] },
    }
    local y = -70
    for _, o in ipairs(optList) do
        local chk = CreateCheckButton(tab, 420, o.label, function()
            ns.options[o.key] = not ns.options[o.key]
            if o.wipe and ns.Parser then
                ns.Parser:Wipe()
            end
            ns:Changed(true)
            UI:Refresh()
        end)
        chk:SetPoint("TOPLEFT", 8, y)
        chk._optKey = o.key
        checks[#checks + 1] = chk
        y = y - 24
    end

    local daggerChk
    if ns.class == "ROGUE" then
        daggerChk = CreateCheckButton(tab, 420, L["Dagger build (main hand only)"], function()
            ns.char.daggers = not ns.char.daggers
            ns:Changed(false)
            UI:Refresh()
        end)
        daggerChk:SetPoint("TOPLEFT", 8, y)
        y = y - 28
    end

    local btnPosHdr = CreateLabel(tab, 12, ACCENT[1], ACCENT[2], ACCENT[3])
    btnPosHdr:SetPoint("TOPLEFT", 8, y - 6)
    btnPosHdr:SetText(L["Character panel button"])

    local posButtons = {}
    local posList = {
        { id = "RIGHT", label = L["Right"] },
        { id = "LEFT", label = L["Left"] },
        { id = "HIDDEN", label = L["Hidden"] },
    }
    for i, p in ipairs(posList) do
        local b = CreateFlatButton(tab, 110, 22, p.label, function()
            ns.options.buttonPosition = p.id
            UI:UpdatePaperDollButton()
            UI:Refresh()
        end)
        b:SetPoint("TOPLEFT", 8 + (i - 1) * 118, y - 28)
        b._pos = p.id
        posButtons[#posButtons + 1] = b
    end

    local rescanBtn = CreateFlatButton(tab, 220, 26, L["Rescan & wipe caches"], function()
        if ns.Parser then ns.Parser:Wipe() end
        if ns.Talents then ns.Talents:Refresh() end
        if ns.Scales then ns.Scales:OnTalentsChanged() end
        ns:Changed(true)
        ns.Print(L["Caches cleared and data refreshed."])
        UI:Refresh()
    end)
    rescanBtn:SetPoint("TOPLEFT", 8, y - 66)

    function tab:Refresh()
        for _, btn in ipairs(modeButtons) do
            btn:SetSelected(ns.options.tooltipMode == btn._mode, ACCENT)
        end
        for _, chk in ipairs(checks) do
            chk:SetCheckedState(ns.options[chk._optKey])
        end
        if daggerChk then
            daggerChk:SetCheckedState(ns.char.daggers)
        end
        for _, b in ipairs(posButtons) do
            b:SetSelected(ns.options.buttonPosition == b._pos, EMERALD)
        end
    end

    return tab
end

local function BuildAboutTab(parent)
    local tab = CreateFrame("Frame", nil, parent)
    tab:SetAllPoints()

    local hdr = CreateLabel(tab, 16, ACCENT[1], ACCENT[2], ACCENT[3])
    hdr:SetPoint("TOPLEFT", 8, -8)
    hdr:SetText("PawnDynamic  v" .. ns.version .. "  (WoW Classic Forever - Interface 16001)")

    local body = CreateLabel(tab, 11, 0.88, 0.90, 0.94)
    body:SetPoint("TOPLEFT", 8, -38)
    body:SetWidth(RIGHT_W - 24)
    body:SetWordWrap(true)
    body:SetJustifyV("TOP")
    body:SetText(
        L["ABOUT_CREDITS"] .. "\n\n"
        .. L["ABOUT_CAP_TITLE"] .. "\n"
        .. L["ABOUT_CAP_INTRO"] .. "\n"
        .. "  " .. L["ABOUT_CAP_FORMULA"] .. "\n\n"
        .. "• " .. L["ABOUT_CAP_TARGET"] .. "\n"
        .. "• " .. L["ABOUT_CAP_AVOIDANCE"] .. "\n"
        .. "• " .. L["ABOUT_CAP_REDUCTION"] .. "\n"
        .. "• " .. L["ABOUT_CAP_DRUID"] .. "\n\n"
        .. L["ABOUT_TALENTS_TITLE"] .. "\n"
        .. L["ABOUT_TALENTS_DESC"] .. "\n\n"
        .. L["ABOUT_PAWN_TITLE"] .. "\n"
        .. L["ABOUT_PAWN_DESC"] .. "\n\n"
        .. L["ABOUT_COMMANDS_TITLE"] .. "\n"
        .. "• " .. L["ABOUT_CMD_PD"] .. "\n"
        .. "• " .. L["ABOUT_CMD_STATUS"] .. "\n"
        .. "• " .. L["ABOUT_CMD_SCAN"] .. "\n"
        .. "• " .. L["ABOUT_CMD_DEBUG"] .. "\n"
        .. "• " .. L["ABOUT_CMD_DUMP"] .. "\n"
        .. "• " .. L["ABOUT_CMD_REFRESH"]
    )

    function tab:Refresh() end
    return tab
end

------------------------------------------------------------------------
-- Main Frame & Character Sheet Button
------------------------------------------------------------------------

function UI:BuildMainFrame()
    local f = CreateFrame("Frame", "PawnDynamicFrame", UIParent)
    f:SetSize(WIN_W, WIN_H)
    f:SetPoint("CENTER")
    f:SetFrameStrata("DIALOG")
    f:SetClampedToScreen(true)
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    StylePanel(f, BG_DARK[1], BG_DARK[2], BG_DARK[3], BG_DARK[4])
    tinsert(_G.UISpecialFrames, "PawnDynamicFrame")
    self.frame = f

    -- Top Title Bar
    local titleBar = CreateFrame("Frame", nil, f)
    titleBar:SetPoint("TOPLEFT", 1, -1)
    titleBar:SetPoint("TOPRIGHT", -1, -1)
    titleBar:SetHeight(32)
    StylePanel(titleBar, 0.08, 0.085, 0.11, 1)

    local titleText = CreateLabel(titleBar, 14, 1, 1, 1)
    titleText:SetPoint("LEFT", 12, 0)
    titleText:SetText("|cff00d1ffPawn|r|cffffffffDynamic|r  |cff8892a0v" .. ns.version .. "|r")

    local closeBtn = CreateFlatButton(titleBar, 24, 22, "X", function()
        f:Hide()
    end)
    closeBtn:SetPoint("RIGHT", -6, 0)

    -- Left Column (Grouped Profile List)
    local leftCol = CreateFrame("Frame", nil, f)
    leftCol:SetPoint("TOPLEFT", 10, -40)
    leftCol:SetSize(LEFT_W, WIN_H - 92)
    StylePanel(leftCol, 0.07, 0.075, 0.095, 1)

    local listHdr = CreateLabel(leftCol, 12, ACCENT[1], ACCENT[2], ACCENT[3])
    listHdr:SetPoint("TOPLEFT", 10, -8)
    listHdr:SetText(L["Scale"])

    local listScroll = CreateScrollArea(leftCol, LEFT_W - 12, WIN_H - 134)
    listScroll:SetPoint("TOPLEFT", 6, -28)
    self.leftScroll = listScroll
    self.leftPool = {}

    local shiftHint = CreateLabel(leftCol, 9, 0.60, 0.64, 0.72)
    shiftHint:SetPoint("BOTTOMLEFT", 8, 6)
    shiftHint:SetText(L["Shift+Click: Toggle Tooltip"])

    -- Right Content Area
    local rightArea = CreateFrame("Frame", nil, f)
    rightArea:SetPoint("TOPLEFT", leftCol, "TOPRIGHT", 8, 0)
    rightArea:SetSize(RIGHT_W, WIN_H - 92)
    StylePanel(rightArea, 0.07, 0.075, 0.095, 1)

    self.tabs = {
        { id = 1, label = L["Scale"], page = BuildScaleTab(rightArea) },
        { id = 2, label = L["Weights"], page = BuildWeightsTab(rightArea) },
        { id = 3, label = L["Caps & Dynamics"], page = BuildCapsTab(rightArea) },
        { id = 4, label = L["Compare"], page = BuildCompareTab(rightArea) },
        { id = 5, label = L["Options"], page = BuildOptionsTab(rightArea) },
        { id = 6, label = L["Getting started / About"], page = BuildAboutTab(rightArea) },
    }

    -- 6 Bottom Tabs
    self.tabButtons = {}
    local tabW = math.floor((WIN_W - 20 - 5 * 6) / 6)
    for i, t in ipairs(self.tabs) do
        local tb = CreateFlatButton(f, tabW, 28, t.label, function()
            UI:SelectTab(i)
        end)
        tb:SetPoint("BOTTOMLEFT", 10 + (i - 1) * (tabW + 6), 10)
        self.tabButtons[i] = tb
        t.page:Hide()
    end

    f:SetScript("OnShow", function()
        UI:Refresh()
    end)

    self:SelectTab(1)
    f:Hide()
end

function UI:SelectTab(tabIdx)
    self.activeTab = tabIdx
    for i, t in ipairs(self.tabs) do
        local isSel = (i == tabIdx)
        t.page:SetShown(isSel)
        self.tabButtons[i]:SetSelected(isSel, ACCENT)
    end
    self:Refresh()
end

function UI:RefreshLeftList()
    if not self.leftScroll then
        return
    end
    for _, item in ipairs(self.leftPool) do
        item:Hide()
    end

    local myScales, otherScales, starterScales = ns.Scales:GetGrouped()
    local selected = ns.Scales:GetSelected()
    local entries = {}

    local function PushHeader(title)
        entries[#entries + 1] = { isHeader = true, text = title }
    end
    local function PushScale(s)
        entries[#entries + 1] = { scale = s }
    end

    PushHeader(L["My scales"])
    for _, s in ipairs(myScales) do PushScale(s) end
    if #otherScales > 0 then
        PushHeader(L["Other scales"])
        for _, s in ipairs(otherScales) do PushScale(s) end
    end
    PushHeader(L["Starter templates"])
    for _, s in ipairs(starterScales) do PushScale(s) end

    local y = -4
    for i, entry in ipairs(entries) do
        local row = self.leftPool[i]
        if not row then
            row = CreateFrame("Button", nil, self.leftScroll.content)
            row:SetSize(LEFT_W - 26, 22)
            row.bg = row:CreateTexture(nil, "BACKGROUND")
            row.bg:SetAllPoints()
            row.dot = row:CreateTexture(nil, "ARTWORK")
            row.dot:SetSize(8, 8)
            row.dot:SetPoint("LEFT", 6, 0)
            row.label = CreateLabel(row, 11, 0.90, 0.92, 0.95)
            row.label:SetPoint("LEFT", 20, 0)
            row.label:SetPoint("RIGHT", -4, 0)
            self.leftPool[i] = row
        end

        row:ClearAllPoints()
        row:SetPoint("TOPLEFT", 2, y)
        row:Show()

        if entry.isHeader then
            row.dot:Hide()
            row.bg:SetColorTexture(0.05, 0.055, 0.075, 0.85)
            row.label:ClearAllPoints()
            row.label:SetPoint("LEFT", 6, 0)
            row.label:SetText(entry.text)
            row.label:SetTextColor(ACCENT[1], ACCENT[2], ACCENT[3])
            row:SetScript("OnClick", nil)
        else
            local s = entry.scale
            local isSel = selected and selected.id == s.id
            local isVis = ns.Scales:IsVisible(s.id)
            local r, g, b = ns.Scales.HexToRGB(s.colorHex)
            row.dot:Show()
            row.dot:SetColorTexture(r, g, b, isVis and 1 or 0.35)
            row.label:ClearAllPoints()
            row.label:SetPoint("LEFT", 20, 0)
            row.label:SetPoint("RIGHT", -4, 0)
            row.label:SetText(s.name)
            if isSel then
                row.bg:SetColorTexture(0.12, 0.22, 0.28, 0.95)
                row.label:SetTextColor(1, 1, 1)
            else
                row.bg:SetColorTexture(0.09, 0.095, 0.12, 0.6)
                row.label:SetTextColor(isVis and 0.90 or 0.55, isVis and 0.92 or 0.57, isVis and 0.95 or 0.62)
            end
            row:SetScript("OnClick", function()
                if IsShiftKeyDown() then
                    ns.Scales:SetVisible(s.id, not ns.Scales:IsVisible(s.id))
                end
                ns.Scales:SelectForEdit(s.id)
                UI:Refresh()
            end)
        end
        y = y - 23
    end

    self.leftScroll.content:SetHeight(math.max(400, -y + 8))
    self.leftScroll:UpdateBounds()
end

function UI:Refresh()
    if not self.frame or not self.frame:IsShown() then
        return
    end
    self:RefreshLeftList()
    local curTab = self.tabs[self.activeTab or 1]
    if curTab and curTab.page and curTab.page.Refresh then
        curTab.page:Refresh()
    end
end

function UI:Toggle()
    if not self.frame then
        self:BuildMainFrame()
    end
    self.frame:SetShown(not self.frame:IsShown())
end

------------------------------------------------------------------------
-- Character Sheet Button (PaperDollItemsFrame / PaperDollFrame)
------------------------------------------------------------------------

function UI:UpdatePaperDollButton()
    local parent = _G.PaperDollItemsFrame or _G.PaperDollFrame
    if not parent then
        return
    end
    if not self.charButton then
        local btn = CreateFlatButton(parent, 86, 20, "PawnDynamic", function()
            UI:Toggle()
        end)
        btn:SetScript("OnEnter", function(self)
            self:SetBorderColor(ACCENT[1], ACCENT[2], ACCENT[3], 1)
            GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
            GameTooltip:ClearLines()
            GameTooltip:AddLine("|cff00d1ffPawnDynamic|r", 1, 1, 1)
            GameTooltip:AddLine(L["Click to open PawnDynamic"], 0.85, 0.88, 0.92)
            if ns.ready then
                local tracked = ns.Scales:GetTracked()
                if #tracked > 0 then
                    GameTooltip:AddLine(" ")
                    GameTooltip:AddLine(L["Total gear score"] .. ":", 1, 1, 1)
                    for _, s in ipairs(tracked) do
                        local total = 0
                        for slot = 1, 18 do
                            local lnk = ns.PlainText(GetInventoryItemLink("player", slot))
                            if lnk then
                                local info = ns.Parser:Get(lnk)
                                if info then
                                    total = total + ns.Scales:ScoreItem(info, s, { replacedItems = { info } })
                                end
                            end
                        end
                        GameTooltip:AddDoubleLine(ns.Scales.ColorCode(s.colorHex) .. s.name .. "|r", ns.Format(total), 1, 1, 1, 1, 1, 1)
                    end
                end
            end
            GameTooltip:Show()
        end)
        btn:SetScript("OnLeave", function(self)
            self:SetBorderColor(BORDER_IDLE[1], BORDER_IDLE[2], BORDER_IDLE[3], 1)
            GameTooltip:Hide()
        end)
        self.charButton = btn
    end

    local pos = ns.options and ns.options.buttonPosition or "RIGHT"
    self.charButton:ClearAllPoints()
    if pos == "HIDDEN" then
        self.charButton:Hide()
    elseif pos == "LEFT" then
        local anchor = _G.CharacterWristSlot or parent
        self.charButton:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", -2, -10)
        self.charButton:Show()
    else
        local anchor = _G.CharacterTrinket1Slot or parent
        self.charButton:SetPoint("TOPRIGHT", anchor, "BOTTOMRIGHT", 2, -10)
        self.charButton:Show()
    end
end

function UI:Init()
    self:UpdatePaperDollButton()
    ns:On("REFRESH", function()
        self:Refresh()
    end)
end
