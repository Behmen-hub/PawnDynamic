-- PawnDynamic (MIT License)
-- Traditional Chinese localization (zhTW).

local _, ns = ...

local locale = ns:NewLocale("zhTW")
if not locale then
    return
end

local L = locale.strings

L["Attributes"] = "基礎屬性"
L["Offense"] = "進攻"
L["Weapon damage"] = "武器傷害"
L["Spells"] = "法術"
L["Defense"] = "防禦"
L["Resistances"] = "抗性"
L["Armor types"] = "護甲類型"
L["Weapon types"] = "武器類型"

L["Strength"] = "力量"
L["Agility"] = "敏捷"
L["Stamina"] = "耐力"
L["Intellect"] = "智力"
L["Spirit"] = "精神"
L["Attack power"] = "攻擊強度"
L["Ranged attack power"] = "遠程攻擊強度"
L["Feral attack power"] = "野性攻擊強度"
L["Hit %"] = "命中 %"
L["Crit %"] = "致命一擊 %"
L["Expertise %"] = "精準 %"
L["Weapon skill"] = "武器技能"
L["Haste %"] = "加速 %"
L["Armor penetration"] = "護甲穿透"
L["Main-hand DPS"] = "主手秒傷"
L["Off-hand DPS"] = "副手秒傷"
L["Ranged / wand DPS"] = "遠程 / 魔杖秒傷"
L["Spell damage"] = "法術傷害"
L["Healing"] = "治療效果"
L["Mana per 5 sec"] = "每5秒法力"
L["Spell penetration"] = "法術穿透"
L["Armor"] = "護甲"
L["Defense"] = "防禦技能"
L["Dodge %"] = "閃躲 %"
L["Parry %"] = "招架 %"
L["Block %"] = "格擋 %"
L["Block value"] = "格擋值"
L["Health per 5 sec"] = "每5秒生命"
L["All resistances"] = "所有抗性"
L["Arcane resistance"] = "秘法抗性"
L["Fire resistance"] = "火焰抗性"
L["Frost resistance"] = "冰霜抗性"
L["Nature resistance"] = "自然抗性"
L["Shadow resistance"] = "暗影抗性"
L["Include Raid Resistance Buff (+60)"] = "計入團隊抗性增益 (+60)"
L["Scale % stats by level (< 60)"] = "依等級縮放百分比屬性 (< 60級)"
L["Scale % stats by level tooltip"] = "在60級以下時，依角色等級比例縮放百分比屬性（致命一擊 %、命中 %、加速 %、精準 %、武器技能、防禦技能、閃躲 %、招架 %、格擋 %）（係數為 等級 / 60，60級時為 100%）。取消勾選則升級期間亦採用完整權重。"
L["Raid resistance buff tooltip"] = "在規劃未套用增益配裝時，預先計入聖騎士光環、薩滿圖騰、野性守護或暗影防護提供的 +60 抗性。當對應團隊增益已在你身上啟用時會自動降為 0（避免重複計算）。已啟用的精煉、魂能與藥水會自動偵測。"

L["Scale"] = "評分配置"
L["Weights"] = "屬性權重"
L["Caps & Dynamics"] = "上限與動態"
L["Compare"] = "比較"
L["Options"] = "選項"
L["Getting started / About"] = "入門 / 關於"

L["My scales"] = "我的配置"
L["Other scales"] = "其他配置"
L["Starter templates"] = "預設範本"
L["Automatic"] = "自動"
L["Manual"] = "手動"
L["Show this scale in tooltips"] = "在提示中顯示"
L["Rename"] = "重新命名"
L["Delete"] = "刪除"
L["Type \"%s\" to confirm deletion:"] = "輸入 \"%s\" 以確認："
L["DELETE_CONFIRM_WORD"] = "刪除"
L["Type \"%s\" to permanently delete profile \"%s\":"] = "輸入 \"%s\" 以永久刪除設定檔 \"%s\"："
L["Change color"] = "變更顏色"
L["Reset defaults"] = "恢復預設"
L["Import"] = "匯入"
L["Export"] = "匯出"
L["Export all"] = "全部匯出"
L["New"] = "新增"
L["From template"] = "從範本"
L["Copy"] = "複製"
L["OK"] = "確定"
L["Cancel"] = "取消"
L["Create"] = "建立"
L["Close"] = "關閉"
L["%s upgrade"] = "%s 升級"
L["upgrade - %s"] = "升級 - %s"
L["%s with %s"] = "%s (搭配 %s)"
L["fills an empty slot"] = "填滿空欄位"
L["+%s points"] = "+%s 分"
L["replaces zero-score item"] = "取代無評分裝備"
L["Main hand"] = "主手"
L["Off hand"] = "副手"
L["replaces: %s"] = "取代: %s"
L["%s to off hand"] = "%s → 副手"

L["Live Character Stats & Cap Status"] = "即時角色屬性與門檻進度"
L["Profile Cap Configuration"] = "配置門檻設定"
L["Cap engine active"] = "啟用動態門檻引擎"
L["Talent integration active"] = "啟用天賦連動"
L["Tank mode"] = "坦克模式"
L["Target enemy level"] = "目標敵人等級"
L["Even level (+0)"] = "同級目標 (+0)"
L["Dungeon boss (+2)"] = "地下城首領 (+2)"
L["Raid boss (+3)"] = "團隊首領 (+3)"
L["Hit mode"] = "命中模式"
L["Melee"] = "近戰"
L["Spell"] = "法術"
L["Avoidance detail format"] = "未中 %.1f%% · 閃躲 %.1f%% · 招架 %.1f%% · 格擋 %.1f%%"
L["Avoidance detail offset format"] = "未中 %.1f%% · 閃躲 %.1f%% · 招架 %.1f%% · 格擋 %.1f%% (+%.0f%%)"
L["Stat Prio Generator"] = "屬性優先級生成器"
L["Profile name:"] = "配置名稱:"
L["Role:"] = "職責:"
L["Tank"] = "坦克"
L["Melee DPS"] = "近戰輸出"
L["Ranged DPS"] = "遠程輸出"
L["Caster DPS"] = "法系輸出"
L["Healer"] = "治療"
L["Load default prio"] = "載入預設"
L["Available stats"] = "可用屬性"
L["Your priority (1 = highest)"] = "你的優先級 (1 = 最高)"
L["Drag to reorder"] = "拖曳以調整順序"
L["Click + on the left to add stats."] = "點擊左側的 + 新增屬性。"
L["Calculated weights preview"] = "計算權重預覽"
L["Create as new profile"] = "建立為新配置"
L["Apply to current profile"] = "套用到目前配置"
L["[Synergy]"] = "[連動]"
L["[Base]"] = "[基礎]"
L["Prio list is empty."] = "請至少新增一個屬性至優先級清單。"
L["Target: %s (Level %d)"] = "目標: %s (等級 %d)"
L["Hit cap (%)"] = "命中門檻 (%)"
L["Spell hit cap (%)"] = "法術命中門檻 (%)"
L["Defense (Crit immune)"] = "防禦技能 (免爆)"
L["Expertise cap (%)"] = "精準門檻 (%)"
L["Armor cap (75% DR)"] = "護甲門檻 (75% 減傷)"
L["Avoidance (Uncrushable)"] = "圓桌閃招 (免碾壓)"
L["Haste cap (GCD)"] = "加速門檻 (GCD)"
L["Dual-wield auto-detected"] = "已自動偵測雙持"
L["Optional Spirit Target (0 = no limit)"] = "可選精神目標 (0 = 無限制)"
L["Spirit target tooltip"] = "精神沒有固定的遊戲上限。可依需求填寫個人回魔目標值（例如治療職業填 300）。超過該目標值後，裝備上的額外精神權重會降低。維持為 0 則始終保留精神的完整權重。"
L["Note: Shift into Bear Form when comparing items for an accurate 75% armor cap calculation."] = "提示：比較裝備時請切換至熊形態，以準確計算 75% 護甲減傷門檻。"
L["Current:"] = "目前:"
L["Active talents:"] = "啟用的天賦:"
L["Under cap"] = "未達門檻"
L["Cap reached (reduced)"] = "已達門檻 (權重降低)"
L["Cap reached (weight = 0)"] = "已達門檻 (權重 = 0)"
L["Not active"] = "未啟用"
L["Automatic cap mechanics note"] = "所有遊戲機制門檻（命中、法術命中、防禦、精準、護甲、圓桌格擋、雙持與加速）皆根據角色等級、目標等級、裝備武器及啟用的天賦/增益自動計算。"

-- Additional Stat, Armor, Weapon & UI strings
L["Main-hand min damage"] = "主手最小傷害"
L["Main-hand max damage"] = "主手最大傷害"
L["Main-hand hit damage"] = "主手平均傷害"
L["Main-hand speed"] = "主手速度"
L["Off-hand speed"] = "副手速度"
L["Ranged min damage"] = "遠程最小傷害"
L["Ranged max damage"] = "遠程最大傷害"
L["Ranged hit damage"] = "遠程平均傷害"
L["Ranged speed"] = "遠程速度"
L["Speed baseline"] = "基準速度"
L["Arcane damage"] = "秘法傷害"
L["Fire damage"] = "火焰傷害"
L["Frost damage"] = "冰霜傷害"
L["Nature damage"] = "自然傷害"
L["Shadow damage"] = "暗影傷害"
L["Holy damage"] = "神聖傷害"
L["Resilience"] = "韌性"
L["Cloth"] = "布甲"
L["Leather"] = "皮甲"
L["Mail"] = "鎖甲"
L["Plate"] = "鎧甲"
L["Shield"] = "盾牌"
L["1H Axe"] = "單手斧"
L["2H Axe"] = "雙手斧"
L["Bow"] = "弓"
L["Crossbow"] = "弩"
L["Dagger"] = "匕首"
L["Fist weapon"] = "拳套"
L["Gun"] = "槍械"
L["1H Mace"] = "單手錘"
L["2H Mace"] = "雙手錘"
L["Polearm"] = "長柄武器"
L["Relic"] = "聖物"
L["Staff"] = "法杖"
L["1H Sword"] = "單手劍"
L["2H Sword"] = "雙手劍"
L["Thrown weapon"] = "投擲武器"
L["Wand"] = "魔杖"
L["Off-hand weapon"] = "副手武器"
L["Off-hand frill"] = "副手物品"

L["Auto follows your active talent tree."] = "自動模式會跟隨你目前啟用的天賦樹預設配置。"
L["Manual lets you enable and customize multiple profiles."] = "手動模式允許同時啟用並自訂多個評分配置。"
L["Read-only template"] = "唯讀範本（請建立複本以自由編輯，或局部調整權重）"
L["Custom scale"] = "自訂配置"
L["No scale selected"] = "未選擇任何配置"
L["Enter profile name:"] = "輸入配置名稱:"
L["Enter new name for %s:"] = "輸入 %s 的新名稱:"
L["Enter name for copy of %s:"] = "輸入 %s 複本的名稱:"
L["Paste Pawn v1 string:"] = "貼上 Pawn v1 字串:"
L["Copy Pawn v1 string (Ctrl+C):"] = "複製 Pawn v1 字串 (Ctrl+C):"
L["Choose class & template:"] = "選擇職業和範本:"
L["Overwrite existing scale?"] = "覆寫現有配置？"

L["Stat weights for %s"] = "%s 的屬性權重"
L["Yellow values are customized."] = "黃色數值為你自訂的值。"
L["Normalize values (like Wowhead)"] = "標準化權重 (類似 Wowhead)"
L["Hide 1H upgrades"] = "隱藏單手武器升級"
L["Hide 2H upgrades"] = "隱藏雙手武器升級"
L["Unusable armor & weapon types"] = "無法使用的護甲與武器類型"
L["Unusable"] = "無法使用"
L["Select a stat or edit values directly. Press Tab for next row."] = "直接編輯屬性權重，按 Tab 跳至下一欄。"
L["Clear value"] = "清除數值"

L["Compare items for %s"] = "為 %s 比較裝備"
L["Left item"] = "左側裝備"
L["Right item"] = "右側裝備"
L["Load equipped"] = "載入已裝備"
L["‹ Swap ›"] = "‹ 交換 ›"
L["Clear"] = "清空"
L["Drop an item or paste an item link / ID below, or pick from equipped / bags:"] = "在下方拖入裝備、貼上物品連結/ID，或從已裝備/背包選擇:"
L["Pick from equipped"] = "從已裝備選擇"
L["Pick from bags"] = "從背包選擇"
L["Stat"] = "屬性"
L["Raw EP"] = "基礎 EP"
L["Effective (Cap Delta)"] = "有效分 (門檻增量)"
L["Difference"] = "差值"
L["Total Base Score"] = "基礎總分"
L["Cap-Adjusted Score"] = "門檻修正總分"
L["Net Cap Loss"] = "門檻淨損失"
L["Verdict"] = "結論"
L["Empty slot"] = "空欄位"
L["Upgrade: %s"] = "升級: %s"
L["Downgrade: %s"] = "降級: %s"
L["Equal"] = "持平"

L["Tooltip display"] = "提示顯示"
L["Only show upgrades"] = "僅顯示升級"
L["Show values and upgrades"] = "顯示評分與升級"
L["Show only values"] = "僅顯示評分"
L["Show current (enchanted) & base values"] = "同時顯示目前（含附魔）與基礎分"
L["Align tooltip values right"] = "提示中數值靠右對齊"
L["Add blank line before values"] = "在數值前加入空白行"
L["Color tooltip border on upgrades"] = "裝備為升級時突顯提示邊框"
L["Healing-to-SpellDamage fallback (1/3)"] = "治療效果換算為 1/3 法術傷害"
L["Advisors & Bags"] = "助手與背包"
L["Bag upgrade arrows"] = "背包升級箭頭"
L["Quest reward arrows & gold coin"] = "任務獎勵箭頭與最高售價金幣標記"
L["Loot roll advisor"] = "戰利品擲骰顧問"
L["Announce bag upgrades in chat"] = "在聊天視窗通知背包升級"
L["Dagger build (main hand only)"] = "匕首流（僅主手使用匕首）"
L["Character panel button"] = "角色面板按鈕"
L["Right"] = "右側"
L["Left"] = "左側"
L["Hidden"] = "隱藏"
L["Diagnostics"] = "診斷"
L["Debug mode"] = "偵錯模式"
L["Rescan & wipe caches"] = "重新掃描並清空快取"

L["[Cap]"] = "[門檻]"
L["Base:"] = "基礎:"
L["Total gear score"] = "裝備總評分"
L["Click to open PawnDynamic"] = "點擊開啟 PawnDynamic"
L["[%s] New upgrade: %s (%s)"] = "[%s] 新升級: %s (%s)"
L["%d upgrade in your bags - /pd scan to list."] = "背包中有 %d 件升級 — /pd scan 查看詳情"
L["%d upgrades in your bags - /pd scan to list."] = "背包中有 %d 件升級 — /pd scan 查看詳情"
L["No upgrades found in your bags."] = "背包中未發現可升級裝備。"
L["Items are still loading - try again shortly."] = "物品資料仍在載入中，請稍後再試。"
L["Saved %d item - /reload to write to disk."] = "已儲存 %d 件物品 — /reload 寫入磁碟"
L["Saved %d items - /reload to write to disk."] = "已儲存 %d 件物品 — /reload 寫入磁碟"
L["PawnDynamic did not finish initializing."] = "PawnDynamic 尚未完成初始化。"
L["Debug mode enabled."] = "偵錯模式已啟用。"
L["Debug mode disabled."] = "偵錯模式已關閉。"
L["Caches cleared and data refreshed."] = "快取已清空且資料已重新整理。"
L["|cffff4040Error:|r %s (see /pd status)"] = "|cffff4040錯誤:|r %s (查看 /pd status)"
L["Commands: /pd (toggle UI) | /pd status | /pd scan | /pd debug [on|off|link] | /pd dump | /pd refresh"] =
    "指令: /pd (開關介面) | /pd status | /pd scan | /pd debug [on|off|連結] | /pd dump | /pd refresh"
L["Shift+Click: Toggle Tooltip"] = "Shift+點擊: 切換提示顯示"

-- Getting started / About Tab
L["ABOUT_CREDITS"] = "作者: Behmen  |  授權條款: MIT License (100% Clean-Room Lua，無 XML)"
L["ABOUT_CAP_TITLE"] = "|cff00d1ff1. 動態門檻引擎 (Delta):|r"
L["ABOUT_CAP_INTRO"] = "在評估裝備之前，PawnDynamic 會先從角色總屬性中扣除目前已裝備物品的屬性，再結合你的各項遊戲門檻計算新裝備的淨收益："
L["ABOUT_CAP_FORMULA"] = "有效價值 = f(角色屬性 - 舊裝備 + 新裝備) - f(角色屬性 - 舊裝備)"
L["ABOUT_CAP_TARGET"] = "目標敵人等級 (+0 / +2 / +3 或自動): 精確計算命中 (5% / 6% / 8%)、法術命中 (4% / 6% / 17%)、防禦免爆 (等級*5 + 125/135/140)、精準 (5% / 5.5% / 6.5%，坦克最高 14%) 與護甲 (75% 減傷)。"
L["ABOUT_CAP_AVOIDANCE"] = "圓桌閃招 (免碾壓 100% / 101.6% / 102.4%): 當未命中 + 閃躲 + 招架 + 格擋達到門檻後，僅格擋權重降為 0；閃躲與招架仍保留價值（僅限持盾職業）。"
L["ABOUT_CAP_REDUCTION"] = "超限自動遞減: 雙持（自動偵測）會按 24-27% 縮放普攻命中價值，加速在超過 50% GCD 門檻後仍按衰減權重生效。"
L["ABOUT_CAP_DRUID"] = "德魯伊提示: 比較裝備時請切換至熊形態，以準確計算 75% 護甲減傷門檻。"
L["ABOUT_TALENTS_TITLE"] = "|cff00d1ff2. 天賦與即時增益 (C_Traits + UNIT_AURA):|r"
L["ABOUT_TALENTS_DESC"] = "透過 spellID / nodeID 跨語言偵測天賦，依據玩家光環即時更新神聖之盾等增益且杜絕重複計算，並納入各系法術命中天賦。"
L["ABOUT_PAWN_TITLE"] = "|cff00d1ff3. Pawn v1 相容性:|r"
L["ABOUT_PAWN_DESC"] = "在「評分配置」分頁完整支援經典 Pawn v1 字串的匯入與匯出。"
L["ABOUT_COMMANDS_TITLE"] = "|cff00d1ff4. 斜線指令:|r"
L["ABOUT_CMD_PD"] = "/pd  或  /pawndynamic — 開啟/關閉主視窗"
L["ABOUT_CMD_STATUS"] = "/pd status — 查看即時角色屬性、門檻、天賦及錯誤紀錄"
L["ABOUT_CMD_SCAN"] = "/pd scan — 在聊天視窗列出背包內所有升級裝備"
L["ABOUT_CMD_DEBUG"] = "/pd debug [物品連結] — 查看詳細的滑鼠提示與屬性解析"
L["ABOUT_CMD_DUMP"] = "/pd dump — 將解析資料儲存至 SavedVariables 用於排查回報"
L["ABOUT_CMD_REFRESH"] = "/pd refresh — 清空快取並重新計算全部資料"

locale.scales = {
    WARRIOR = { ARMS = { name = "武器", match = "武器" }, FURY = { name = "狂怒", match = "狂怒" }, PROTECTION = { name = "防護", match = "防護" } },
    PALADIN = { HOLY = { name = "神聖", match = "神聖" }, PROTECTION = { name = "防護", match = "防護" }, RETRIBUTION = { name = "懲戒", match = "懲戒" } },
    HUNTER = { BEAST_MASTERY = { name = "野獸控制", match = "野獸" }, MARKSMANSHIP = { name = "射擊", match = "射擊" }, SURVIVAL = { name = "生存", match = "生存" } },
    ROGUE = { ASSASSINATION = { name = "刺殺", match = "刺殺" }, COMBAT = { name = "戰鬥", match = "戰鬥" }, SUBTLETY = { name = "敏銳", match = "敏銳" } },
    PRIEST = { DISCIPLINE = { name = "戒律", match = "戒律" }, HOLY = { name = "神聖", match = "神聖" }, SHADOW = { name = "暗影", match = "暗影" }, SMITE = { name = "懲擊" } },
    SHAMAN = { ELEMENTAL = { name = "元素", match = "元素" }, ENHANCEMENT = { name = "增強", match = "增強" }, RESTORATION = { name = "恢復", match = "恢復" } },
    MAGE = { ARCANE = { name = "秘法", match = "秘法" }, FIRE = { name = "火焰", match = "火焰" }, FROST = { name = "冰霜", match = "冰霜" } },
    WARLOCK = { AFFLICTION = { name = "痛苦", match = "痛苦" }, DEMONOLOGY = { name = "惡魔學識", match = "惡魔" }, DESTRUCTION = { name = "毀滅", match = "毀滅" } },
    DRUID = { BALANCE = { name = "平衡", match = "平衡" }, FERAL_CAT = { name = "野性戰鬥 (貓)", match = "野性" }, FERAL_BEAR = { name = "野性戰鬥 (熊)" }, RESTORATION = { name = "恢復", match = "恢復" } },
}

locale.grammar = function(P)
    local NUM = P.NUM
    local GAP = "[^%d]-"
    local rules = {
        { "與.-作戰時", false }, { "持續%d+秒", false }, { "機率", false },
        { "格擋值提高" .. GAP .. NUM, "BLOCK_VALUE" },
        { "法術穿透" .. GAP .. NUM, "SPELL_PEN" },
        { "致命一擊機率提高" .. NUM .. "%%", "CRIT" },
        { "命中機率提高" .. NUM .. "%%", "HIT" },
        { "閃躲或招架的機率" .. GAP .. NUM .. "%%", "EXPERTISE", true },
        { "精準" .. GAP .. NUM, "EXPERTISE" },
        { "閃躲攻擊的機率提高" .. NUM .. "%%", "DODGE" },
        { "招架攻擊的機率提高" .. NUM .. "%%", "PARRY" },
        { "格擋攻擊的機率提高" .. NUM .. "%%", "BLOCK" },
        { "防禦技能提高" .. NUM, "DEFENSE" },
        { "法術和魔法效果所造成的傷害和治療效果" .. GAP .. NUM, P.AddSpellPower },
        { "法術和魔法效果所造成的治療效果" .. GAP .. NUM, P.AddHealing },
        { "法術和魔法效果所造成的傷害" .. GAP .. NUM, "SPELL_DAMAGE" },
        { "法術能量提高" .. NUM, P.AddSpellPower },
        { "每5秒恢復" .. NUM .. "點法力", "MP5" },
        { "每5秒恢復" .. NUM .. "點生命", "HP5" },
        { "遠程攻擊強度提高" .. NUM, "RANGED_AP" },
        { "攻擊強度提高" .. NUM, "ATTACK_POWER" },
        { "攻擊速度和施法速度提高" .. NUM .. "%%", "HASTE" },
        { "加速" .. GAP .. NUM .. "%%", "HASTE" },
    }
    local names = {
        ["力量"] = "STRENGTH", ["敏捷"] = "AGILITY", ["耐力"] = "STAMINA",
        ["智力"] = "INTELLECT", ["精神"] = "SPIRIT", ["護甲"] = "ARMOR",
        ["格擋值"] = "BLOCK_VALUE", ["防禦"] = "DEFENSE", ["閃躲"] = "DODGE", ["招架"] = "PARRY",
        ["攻擊強度"] = "ATTACK_POWER", ["命中等級"] = P.Rating("HIT"),
        ["致命一擊等級"] = P.Rating("CRIT"), ["加速等級"] = P.Rating("HASTE"),
        ["精準"] = "EXPERTISE", ["法術能量"] = P.AddSpellPower, ["所有抗性"] = P.AddAllResistances,
    }
    local skip = { "使用：", "擊中時可能：", "套裝：", "需要", "職業：", "種族：", "耐久度", "物品等級", "售價", "唯一", "拾取後綁定", "裝備後綁定", "\"" }
    local words = {
        equip = "^裝備：(.+)$", classes = "^職業：(.+)$", set = "^%(%d+%) 套裝",
        range = { "^" .. NUM .. " %- " .. NUM .. "點.*傷害" }, flat = { "^" .. NUM .. "點.*傷害$" },
        dps = "%(每秒傷害" .. NUM .. "%)", speed = "^速度 " .. NUM,
        negative = { "^降低", "^減少" }, also = "，並", plus = "和", looseNumbers = false,
    }
    return { rules = rules, names = names, skip = skip, words = words }
end
