-- PawnDynamic (MIT License)
-- Simplified Chinese localization (zhCN).

local _, ns = ...

local locale = ns:NewLocale("zhCN")
if not locale then
    return
end

local L = locale.strings

L["Attributes"] = "基础属性"
L["Offense"] = "进攻"
L["Weapon damage"] = "武器伤害"
L["Spells"] = "法术"
L["Defense"] = "防御"
L["Resistances"] = "抗性"
L["Armor types"] = "护甲类型"
L["Weapon types"] = "武器类型"

L["Strength"] = "力量"
L["Agility"] = "敏捷"
L["Stamina"] = "耐力"
L["Intellect"] = "智力"
L["Spirit"] = "精神"
L["Attack power"] = "攻击强度"
L["Ranged attack power"] = "远程攻击强度"
L["Feral attack power"] = "野性攻击强度"
L["Hit %"] = "命中 %"
L["Crit %"] = "暴击 %"
L["Expertise %"] = "精准 %"
L["Weapon skill"] = "武器技能"
L["Haste %"] = "急速 %"
L["Armor penetration"] = "护甲穿透"
L["Main-hand DPS"] = "主手秒伤"
L["Off-hand DPS"] = "副手秒伤"
L["Ranged / wand DPS"] = "远程 / 魔杖秒伤"
L["Spell damage"] = "法术伤害"
L["Healing"] = "治疗效果"
L["Mana per 5 sec"] = "每5秒法力"
L["Spell penetration"] = "法术穿透"
L["Armor"] = "护甲"
L["Defense"] = "防御技能"
L["Dodge %"] = "躲闪 %"
L["Parry %"] = "招架 %"
L["Block %"] = "格挡 %"
L["Block value"] = "格挡值"
L["Health per 5 sec"] = "每5秒生命"
L["All resistances"] = "所有抗性"
L["Arcane resistance"] = "奥术抗性"
L["Fire resistance"] = "火焰抗性"
L["Frost resistance"] = "冰霜抗性"
L["Nature resistance"] = "自然抗性"
L["Shadow resistance"] = "暗影抗性"
L["Include Raid Resistance Buff (+60)"] = "计入团队抗性增益 (+60)"
L["Scale % stats by level (< 60)"] = "按等级缩放百分比属性 (< 60级)"
L["Scale % stats by level tooltip"] = "在60级以下时，按角色等级比例缩放百分比属性（暴击 %、命中 %、急速 %、精准 %、武器技能、防御技能、躲闪 %、招架 %、格挡 %）（系数为 等级 / 60，60级时为 100%）。取消勾选则升级期间也按完整权重计算。"
L["Raid resistance buff tooltip"] = "在规划未加增益配装时，提前计入圣骑士光环、萨满图腾、野性守护或暗影防护提供的 +60 抗性。当对应团队增益已激活时自动降为 0（避免重复计算）。已激活的合剂、魂能和药水会自动检测。"

L["Scale"] = "评分配置"
L["Weights"] = "属性权重"
L["Caps & Dynamics"] = "阈值与动态"
L["Compare"] = "对比"
L["Options"] = "选项"
L["Getting started / About"] = "入门 / 关于"

L["My scales"] = "我的配置"
L["Other scales"] = "其他配置"
L["Starter templates"] = "默认模板"
L["Automatic"] = "自动"
L["Manual"] = "手动"
L["Show this scale in tooltips"] = "在提示中显示"
L["Rename"] = "重命名"
L["Delete"] = "删除"
L["Type \"%s\" to confirm deletion:"] = "输入 \"%s\" 以确认："
L["DELETE_CONFIRM_WORD"] = "删除"
L["Type \"%s\" to permanently delete profile \"%s\":"] = "输入 \"%s\" 以永久删除配置文件 \"%s\"："
L["Change color"] = "更改颜色"
L["Reset defaults"] = "恢复默认"
L["Import"] = "导入"
L["Export"] = "导出"
L["Export all"] = "全部导出"
L["New"] = "新建"
L["From template"] = "从模板"
L["Copy"] = "复制"
L["OK"] = "确定"
L["Cancel"] = "取消"
L["Create"] = "创建"
L["Close"] = "关闭"
L["%s upgrade"] = "%s 提升"
L["upgrade - %s"] = "提升 - %s"
L["%s with %s"] = "%s (搭配 %s)"
L["fills an empty slot"] = "填充空栏位"
L["+%s points"] = "+%s 分"
L["replaces zero-score item"] = "替换无评分装备"
L["Main hand"] = "主手"
L["Off hand"] = "副手"
L["replaces: %s"] = "替换: %s"
L["%s to off hand"] = "%s → 副手"

L["Live Character Stats & Cap Status"] = "实时角色属性与阈值进度"
L["Profile Cap Configuration"] = "配置阈值设置"
L["Cap engine active"] = "启用动态阈值引擎"
L["Talent integration active"] = "启用天赋联动"
L["Tank mode"] = "坦克模式"
L["Target enemy level"] = "目标敌人等级"
L["Even level (+0)"] = "同级目标 (+0)"
L["Dungeon boss (+2)"] = "地下城首领 (+2)"
L["Raid boss (+3)"] = "团队首领 (+3)"
L["Hit mode"] = "命中模式"
L["Melee"] = "近战"
L["Spell"] = "法术"
L["Avoidance detail format"] = "未中 %.1f%% · 躲闪 %.1f%% · 招架 %.1f%% · 格挡 %.1f%%"
L["Avoidance detail offset format"] = "未中 %.1f%% · 躲闪 %.1f%% · 招架 %.1f%% · 格挡 %.1f%% (+%.0f%%)"
L["Stat Prio Generator"] = "属性优先级生成器"
L["Profile name:"] = "配置名称:"
L["Role:"] = "职责:"
L["Tank"] = "坦克"
L["Melee DPS"] = "近战输出"
L["Ranged DPS"] = "远程输出"
L["Caster DPS"] = "法系输出"
L["Healer"] = "治疗"
L["Load default prio"] = "加载默认"
L["Available stats"] = "可用属性"
L["Your priority (1 = highest)"] = "你的优先级 (1 = 最高)"
L["Drag to reorder"] = "拖动以调整顺序"
L["Click + on the left to add stats."] = "点击左侧的 + 添加属性。"
L["Calculated weights preview"] = "计算权重预览"
L["Create as new profile"] = "创建为新配置"
L["Apply to current profile"] = "应用到当前配置"
L["[Synergy]"] = "[联动]"
L["[Base]"] = "[基础]"
L["Prio list is empty."] = "请至少添加一个属性到优先级列表。"
L["Target: %s (Level %d)"] = "目标: %s (等级 %d)"
L["Hit cap (%)"] = "命中阈值 (%)"
L["Spell hit cap (%)"] = "法术命中阈值 (%)"
L["Defense (Crit immune)"] = "防御等级 (免爆)"
L["Expertise cap (%)"] = "精准阈值 (%)"
L["Armor cap (75% DR)"] = "护甲阈值 (75% 减伤)"
L["Avoidance (Uncrushable)"] = "圆桌满避 (免碾压)"
L["Haste cap (GCD)"] = "急速阈值 (GCD)"
L["Dual-wield auto-detected"] = "已自动检测双持"
L["Optional Spirit Target (0 = no limit)"] = "可选精神目标 (0 = 无限制)"
L["Spirit target tooltip"] = "精神没有固定的游戏上限。可根据需要填写个人回蓝目标值（例如治疗职业填 300）。超过该目标值后，装备上的额外精神权重会被降低。保持为 0 则始终保留精神的全部权重。"
L["Note: Shift into Bear Form when comparing items for an accurate 75% armor cap calculation."] = "提示：比较装备时请切换至熊形态，以准确计算 75% 护甲减伤阈值。"
L["Current:"] = "当前:"
L["Active talents:"] = "激活的天赋:"
L["Under cap"] = "未达阈值"
L["Cap reached (reduced)"] = "已达阈值 (权重降低)"
L["Cap reached (weight = 0)"] = "已达阈值 (权重 = 0)"
L["Not active"] = "未激活"
L["Automatic cap mechanics note"] = "所有游戏机制阈值（命中、法术命中、防御、精准、护甲、圆桌格挡、双持与急速）均根据角色等级、目标等级、装备武器和激活的天赋/增益自动计算。"

-- Additional Stat, Armor, Weapon & UI strings
L["Main-hand min damage"] = "主手最小伤害"
L["Main-hand max damage"] = "主手最大伤害"
L["Main-hand hit damage"] = "主手平均伤害"
L["Main-hand speed"] = "主手速度"
L["Off-hand speed"] = "副手速度"
L["Ranged min damage"] = "远程最小伤害"
L["Ranged max damage"] = "远程最大伤害"
L["Ranged hit damage"] = "远程平均伤害"
L["Ranged speed"] = "远程速度"
L["Speed baseline"] = "基准速度"
L["Arcane damage"] = "奥术伤害"
L["Fire damage"] = "火焰伤害"
L["Frost damage"] = "冰霜伤害"
L["Nature damage"] = "自然伤害"
L["Shadow damage"] = "暗影伤害"
L["Holy damage"] = "神圣伤害"
L["Resilience"] = "韧性"
L["Cloth"] = "布甲"
L["Leather"] = "皮甲"
L["Mail"] = "锁甲"
L["Plate"] = "板甲"
L["Shield"] = "盾牌"
L["1H Axe"] = "单手斧"
L["2H Axe"] = "双手斧"
L["Bow"] = "弓"
L["Crossbow"] = "弩"
L["Dagger"] = "匕首"
L["Fist weapon"] = "拳套"
L["Gun"] = "枪械"
L["1H Mace"] = "单手锤"
L["2H Mace"] = "双手锤"
L["Polearm"] = "长柄武器"
L["Relic"] = "圣物"
L["Staff"] = "法杖"
L["1H Sword"] = "单手剑"
L["2H Sword"] = "双手剑"
L["Thrown weapon"] = "投掷武器"
L["Wand"] = "魔杖"
L["Off-hand weapon"] = "副手武器"
L["Off-hand frill"] = "副手物品"

L["Auto follows your active talent tree."] = "自动模式会跟随你当前激活的天赋树默认配置。"
L["Manual lets you enable and customize multiple profiles."] = "手动模式允许同时启用并自定义多个评分配置。"
L["Read-only template"] = "只读模板（请创建副本以自由编辑，或局部调整权重）"
L["Custom scale"] = "自定义配置"
L["No scale selected"] = "未选择任何配置"
L["Enter profile name:"] = "输入配置名称:"
L["Enter new name for %s:"] = "输入 %s 的新名称:"
L["Enter name for copy of %s:"] = "输入 %s 副本的名称:"
L["Paste Pawn v1 string:"] = "粘贴 Pawn v1 字符串:"
L["Copy Pawn v1 string (Ctrl+C):"] = "复制 Pawn v1 字符串 (Ctrl+C):"
L["Choose class & template:"] = "选择职业和模板:"
L["Overwrite existing scale?"] = "覆盖现有配置？"

L["Stat weights for %s"] = "%s 的属性权重"
L["Yellow values are customized."] = "黄色数值为你自定义的值。"
L["Normalize values (like Wowhead)"] = "标准化权重 (类似 Wowhead)"
L["Hide 1H upgrades"] = "隐藏单手武器提升"
L["Hide 2H upgrades"] = "隐藏双手武器提升"
L["Unusable armor & weapon types"] = "不可用的护甲与武器类型"
L["Unusable"] = "不可用"
L["Select a stat or edit values directly. Press Tab for next row."] = "直接编辑属性权重，按 Tab 跳转到下一栏。"
L["Clear value"] = "清除数值"

L["Compare items for %s"] = "为 %s 对比装备"
L["Left item"] = "左侧装备"
L["Right item"] = "右侧装备"
L["Load equipped"] = "读取已装备"
L["‹ Swap ›"] = "‹ 交换 ›"
L["Clear"] = "清空"
L["Drop an item or paste an item link / ID below, or pick from equipped / bags:"] = "在下方拖入装备、粘贴物品链接/ID，或从已装备/背包选择:"
L["Pick from equipped"] = "从已装备选择"
L["Pick from bags"] = "从背包选择"
L["Stat"] = "属性"
L["Raw EP"] = "基础 EP"
L["Effective (Cap Delta)"] = "有效分 (阈值增量)"
L["Difference"] = "差值"
L["Total Base Score"] = "基础总分"
L["Cap-Adjusted Score"] = "阈值修正总分"
L["Net Cap Loss"] = "阈值净损失"
L["Verdict"] = "结论"
L["Empty slot"] = "空栏位"
L["Upgrade: %s"] = "提升: %s"
L["Downgrade: %s"] = "降低: %s"
L["Equal"] = "持平"

L["Tooltip display"] = "提示显示"
L["Only show upgrades"] = "仅显示提升"
L["Show values and upgrades"] = "显示评分与提升"
L["Show only values"] = "仅显示评分"
L["Show current (enchanted) & base values"] = "同时显示当前（含附魔）和基础分"
L["Align tooltip values right"] = "提示中数值右对齐"
L["Add blank line before values"] = "在数值前添加空行"
L["Color tooltip border on upgrades"] = "装备为提升时高亮提示边框"
L["Healing-to-SpellDamage fallback (1/3)"] = "治疗效果折算为 1/3 法术伤害"
L["Advisors & Bags"] = "助手与背包"
L["Bag upgrade arrows"] = "背包升级箭头"
L["Quest reward arrows & gold coin"] = "任务奖励箭头与最高售价金币标记"
L["Loot roll advisor"] = "战利品骰子顾问"
L["Announce bag upgrades in chat"] = "在聊天框通告背包提升"
L["Dagger build (main hand only)"] = "匕首流（仅主手使用匕首）"
L["Character panel button"] = "角色面板按钮"
L["Right"] = "右侧"
L["Left"] = "左侧"
L["Hidden"] = "隐藏"
L["Diagnostics"] = "诊断"
L["Debug mode"] = "调试模式"
L["Rescan & wipe caches"] = "重新扫描并清空缓存"

L["[Cap]"] = "[阈值]"
L["Base:"] = "基础:"
L["Total gear score"] = "装备总评分"
L["Click to open PawnDynamic"] = "点击打开 PawnDynamic"
L["[%s] New upgrade: %s (%s)"] = "[%s] 新提升: %s (%s)"
L["%d upgrade in your bags - /pd scan to list."] = "背包中有 %d 件提升 — /pd scan 查看详情"
L["%d upgrades in your bags - /pd scan to list."] = "背包中有 %d 件提升 — /pd scan 查看详情"
L["No upgrades found in your bags."] = "背包中未发现可提升装备。"
L["Items are still loading - try again shortly."] = "物品数据仍在加载中，请稍后再试。"
L["Saved %d item - /reload to write to disk."] = "已保存 %d 件物品 — /reload 写入磁盘"
L["Saved %d items - /reload to write to disk."] = "已保存 %d 件物品 — /reload 写入磁盘"
L["PawnDynamic did not finish initializing."] = "PawnDynamic 尚未完成初始化。"
L["Debug mode enabled."] = "调试模式已启用。"
L["Debug mode disabled."] = "调试模式已关闭。"
L["Caches cleared and data refreshed."] = "缓存已清空且数据已刷新。"
L["|cffff4040Error:|r %s (see /pd status)"] = "|cffff4040错误:|r %s (查看 /pd status)"
L["Commands: /pd (toggle UI) | /pd status | /pd scan | /pd debug [on|off|link] | /pd dump | /pd refresh"] =
    "命令: /pd (开关界面) | /pd status | /pd scan | /pd debug [on|off|链接] | /pd dump | /pd refresh"
L["Shift+Click: Toggle Tooltip"] = "Shift+点击: 切换提示显示"

-- Getting started / About Tab
L["ABOUT_CREDITS"] = "作者: Behmen  |  许可证: MIT License (100% Clean-Room Lua，无 XML)"
L["ABOUT_CAP_TITLE"] = "|cff00d1ff1. 动态阈值引擎 (Delta):|r"
L["ABOUT_CAP_INTRO"] = "在评估装备之前，PawnDynamic 会先从角色总属性中扣除当前已装备物品的属性，再结合你的各项游戏阈值计算新装备的净收益："
L["ABOUT_CAP_FORMULA"] = "有效价值 = f(角色属性 - 旧装备 + 新装备) - f(角色属性 - 旧装备)"
L["ABOUT_CAP_TARGET"] = "目标敌人等级 (+0 / +2 / +3 或自动): 精确计算命中 (5% / 6% / 8%)、法术命中 (4% / 6% / 17%)、防御免爆 (等级*5 + 125/135/140)、精准 (5% / 5.5% / 6.5%，坦克最高 14%) 与护甲 (75% 减伤)。"
L["ABOUT_CAP_AVOIDANCE"] = "圆桌满避 (免碾压 100% / 101.6% / 102.4%): 当未命中 + 躲闪 + 招架 + 格挡达到阈值后，仅格挡权重降为 0；躲闪与招架仍保留价值（仅限持盾职业）。"
L["ABOUT_CAP_REDUCTION"] = "超限自动递减: 双持（自动检测）会按 24-27% 缩放普攻命中价值，急速在超过 50% GCD 阈值后仍按衰减权重生效。"
L["ABOUT_CAP_DRUID"] = "德鲁伊提示: 对比装备时请切换至熊形态，以准确计算 75% 护甲减伤阈值。"
L["ABOUT_TALENTS_TITLE"] = "|cff00d1ff2. 天赋与实时增益 (C_Traits + UNIT_AURA):|r"
L["ABOUT_TALENTS_DESC"] = "通过 spellID / nodeID 跨语言识别天赋，依托玩家光环实时更新神圣之盾等增益且杜绝重复计算，并纳入各系法术命中天赋。"
L["ABOUT_PAWN_TITLE"] = "|cff00d1ff3. Pawn v1 兼容性:|r"
L["ABOUT_PAWN_DESC"] = "在“评分配置”页完整支持经典 Pawn v1 字符串的导入与导出。"
L["ABOUT_COMMANDS_TITLE"] = "|cff00d1ff4. 斜杠命令:|r"
L["ABOUT_CMD_PD"] = "/pd  或  /pawndynamic — 打开/关闭主窗口"
L["ABOUT_CMD_STATUS"] = "/pd status — 查看实时角色属性、阈值、天赋及错误日志"
L["ABOUT_CMD_SCAN"] = "/pd scan — 在聊天窗口列出背包内所有提升装备"
L["ABOUT_CMD_DEBUG"] = "/pd debug [物品链接] — 查看详细的鼠标提示与属性解析"
L["ABOUT_CMD_DUMP"] = "/pd dump — 将解析数据保存至 SavedVariables 用于排查反馈"
L["ABOUT_CMD_REFRESH"] = "/pd refresh — 清空缓存并重新计算全部数据"

locale.scales = {
    WARRIOR = { ARMS = { name = "武器", match = "武器" }, FURY = { name = "狂怒", match = "狂怒" }, PROTECTION = { name = "防护", match = "防护" } },
    PALADIN = { HOLY = { name = "神圣", match = "神圣" }, PROTECTION = { name = "防护", match = "防护" }, RETRIBUTION = { name = "惩戒", match = "惩戒" } },
    HUNTER = { BEAST_MASTERY = { name = "野兽控制", match = "野兽" }, MARKSMANSHIP = { name = "射击", match = "射击" }, SURVIVAL = { name = "生存", match = "生存" } },
    ROGUE = { ASSASSINATION = { name = "刺杀", match = "刺杀" }, COMBAT = { name = "战斗", match = "战斗" }, SUBTLETY = { name = "敏锐", match = "敏锐" } },
    PRIEST = { DISCIPLINE = { name = "戒律", match = "戒律" }, HOLY = { name = "神圣", match = "神圣" }, SHADOW = { name = "暗影", match = "暗影" }, SMITE = { name = "惩击" } },
    SHAMAN = { ELEMENTAL = { name = "元素", match = "元素" }, ENHANCEMENT = { name = "增强", match = "增强" }, RESTORATION = { name = "恢复", match = "恢复" } },
    MAGE = { ARCANE = { name = "奥术", match = "奥术" }, FIRE = { name = "火焰", match = "火焰" }, FROST = { name = "冰霜", match = "冰霜" } },
    WARLOCK = { AFFLICTION = { name = "痛苦", match = "痛苦" }, DEMONOLOGY = { name = "恶魔学识", match = "恶魔" }, DESTRUCTION = { name = "毁灭", match = "毁灭" } },
    DRUID = { BALANCE = { name = "平衡", match = "平衡" }, FERAL_CAT = { name = "野性战斗 (猫)", match = "野性" }, FERAL_BEAR = { name = "野性战斗 (熊)" }, RESTORATION = { name = "恢复", match = "恢复" } },
}

locale.grammar = function(P)
    local NUM = P.NUM
    local GAP = "[^%d]-"
    local rules = {
        { "与.-作战时", false }, { "持续%d+秒", false }, { "几率", false },
        { "格挡值提高" .. GAP .. NUM, "BLOCK_VALUE" },
        { "法术穿透" .. GAP .. NUM, "SPELL_PEN" },
        { "暴击几率提高" .. NUM .. "%%", "CRIT" },
        { "命中几率提高" .. NUM .. "%%", "HIT" },
        { "躲闪或招架的几率" .. GAP .. NUM .. "%%", "EXPERTISE", true },
        { "精准" .. GAP .. NUM, "EXPERTISE" },
        { "躲闪攻击的几率提高" .. NUM .. "%%", "DODGE" },
        { "招架攻击的几率提高" .. NUM .. "%%", "PARRY" },
        { "格挡攻击的几率提高" .. NUM .. "%%", "BLOCK" },
        { "防御技能提高" .. NUM, "DEFENSE" },
        { "法术和魔法效果所造成的伤害和治疗效果" .. GAP .. NUM, P.AddSpellPower },
        { "法术和魔法效果所造成的治疗效果" .. GAP .. NUM, P.AddHealing },
        { "法术和魔法效果所造成的伤害" .. GAP .. NUM, "SPELL_DAMAGE" },
        { "法术强度提高" .. NUM, P.AddSpellPower },
        { "每5秒恢复" .. NUM .. "点法力", "MP5" },
        { "每5秒恢复" .. NUM .. "点生命", "HP5" },
        { "远程攻击强度提高" .. NUM, "RANGED_AP" },
        { "攻击强度提高" .. NUM, "ATTACK_POWER" },
        { "攻击速度和施法速度提高" .. NUM .. "%%", "HASTE" },
        { "急速" .. GAP .. NUM .. "%%", "HASTE" },
    }
    local names = {
        ["力量"] = "STRENGTH", ["敏捷"] = "AGILITY", ["耐力"] = "STAMINA",
        ["智力"] = "INTELLECT", ["精神"] = "SPIRIT", ["护甲"] = "ARMOR",
        ["格挡值"] = "BLOCK_VALUE", ["防御"] = "DEFENSE", ["躲闪"] = "DODGE", ["招架"] = "PARRY",
        ["攻击强度"] = "ATTACK_POWER", ["命中等级"] = P.Rating("HIT"),
        ["暴击等级"] = P.Rating("CRIT"), ["急速等级"] = P.Rating("HASTE"),
        ["精准"] = "EXPERTISE", ["法术强度"] = P.AddSpellPower, ["所有抗性"] = P.AddAllResistances,
    }
    local skip = { "使用：", "击中时可能：", "套装：", "需要", "职业：", "种族：", "耐久度", "物品等级", "售价", "唯一", "拾取后绑定", "装备后绑定", "\"" }
    local words = {
        equip = "^装备：(.+)$", classes = "^职业：(.+)$", set = "^%(%d+%) 套装",
        range = { "^" .. NUM .. " %- " .. NUM .. "点.*伤害" }, flat = { "^" .. NUM .. "点.*伤害$" },
        dps = "%(每秒伤害" .. NUM .. "%)", speed = "^速度 " .. NUM,
        negative = { "^降低", "^减少" }, also = "，并", plus = "和", looseNumbers = false,
    }
    return { rules = rules, names = names, skip = skip, words = words }
end
