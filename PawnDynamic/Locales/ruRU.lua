-- PawnDynamic (MIT License)
-- Russian localization (ruRU).

local _, ns = ...

local locale = ns:NewLocale("ruRU")
if not locale then
    return
end

local L = locale.strings

L["Attributes"] = "Характеристики"
L["Offense"] = "Нападение"
L["Weapon damage"] = "Урон оружия"
L["Spells"] = "Заклинания"
L["Defense"] = "Защита"
L["Resistances"] = "Сопротивления"
L["Armor types"] = "Типы брони"
L["Weapon types"] = "Типы оружия"

L["Strength"] = "Сила"
L["Agility"] = "Ловкость"
L["Stamina"] = "Выносливость"
L["Intellect"] = "Интеллект"
L["Spirit"] = "Дух"
L["Attack power"] = "Сила атаки"
L["Ranged attack power"] = "Сила атаки дальн. боя"
L["Feral attack power"] = "Сила атаки (зверь)"
L["Hit %"] = "Меткость %"
L["Crit %"] = "Крит %"
L["Expertise %"] = "Мастерство %"
L["Weapon skill"] = "Навык владения оружием"
L["Haste %"] = "Скорость %"
L["Armor penetration"] = "Пробивание брони"
L["Main-hand DPS"] = "УВС прав. руки"
L["Main-hand min damage"] = "Мин. урон прав. руки"
L["Main-hand max damage"] = "Макс. урон прав. руки"
L["Main-hand hit damage"] = "Ср. удар прав. руки"
L["Main-hand speed"] = "Скорость прав. руки"
L["Off-hand DPS"] = "УВС лев. руки"
L["Off-hand speed"] = "Скорость лев. руки"
L["Ranged / wand DPS"] = "УВС дальн. боя / жезла"
L["Ranged min damage"] = "Мин. урон дальн. боя"
L["Ranged max damage"] = "Макс. урон дальн. боя"
L["Ranged hit damage"] = "Ср. удар дальн. боя"
L["Ranged speed"] = "Скорость дальн. боя"
L["Speed baseline"] = "База скорости"
L["Spell damage"] = "Урон от заклинаний"
L["Healing"] = "Исцеление"
L["Arcane damage"] = "Урон тайной магии"
L["Fire damage"] = "Урон огнем"
L["Frost damage"] = "Урон льдом"
L["Nature damage"] = "Урон силами природы"
L["Shadow damage"] = "Урон темной магии"
L["Holy damage"] = "Урон светлой магии"
L["Mana per 5 sec"] = "Мана раз в 5 сек."
L["Spell penetration"] = "Проникающая способность"
L["Armor"] = "Броня"
L["Defense"] = "Защита"
L["Dodge %"] = "Уклонение %"
L["Parry %"] = "Парирование %"
L["Block %"] = "Блок %"
L["Block value"] = "Показатель блокирования"
L["Health per 5 sec"] = "Здоровье раз в 5 сек."
L["Resilience"] = "Устойчивость"
L["All resistances"] = "Все виды сопротивления"
L["Arcane resistance"] = "Сопр. тайной магии"
L["Fire resistance"] = "Сопр. огню"
L["Frost resistance"] = "Сопр. льду"
L["Nature resistance"] = "Сопр. природе"
L["Shadow resistance"] = "Сопр. темной магии"
L["Include Raid Resistance Buff (+60)"] = "Учитывать рейдовый бафф сопротивления (+60)"
L["Scale % stats by level (< 60)"] = "Масштаб % от уровня (< 60)"
L["Scale % stats by level tooltip"] = "Пропорционально снижает вес процентных характеристик (Крит %, Меткость %, Скорость %, Мастерство %, Навык оружия, Защита, Уклонение %, Парирование %, Блок %) ниже 60-го уровня (множитель Уровень / 60, ровно 100 % на 60-м уровне). Отключите, чтобы всегда использовать полные веса."
L["Raid resistance buff tooltip"] = "Добавляет +60 к сопротивлению от аур паладина, тотемов шамана, Духа дикой природы или Защиты от темной магии при подборе экипировки без баффов. Автоматически снижается до 0, пока соответствующий бафф активен на вас (без двойного учета). Активные настои, джуджу и зелья учитываются автоматически."

L["Cloth"] = "Ткань"
L["Leather"] = "Кожа"
L["Mail"] = "Кольчуга"
L["Plate"] = "Латы"
L["Shield"] = "Щит"

L["Scale"] = "Профиль"
L["Weights"] = "Веса"
L["Caps & Dynamics"] = "Капы и Динамика"
L["Compare"] = "Сравнение"
L["Options"] = "Настройки"
L["Getting started / About"] = "Справка / О моде"

L["My scales"] = "Мои профили"
L["Other scales"] = "Другие профили"
L["Starter templates"] = "Шаблоны"
L["Automatic"] = "Авто"
L["Manual"] = "Вручную"
L["Show this scale in tooltips"] = "Показывать в подсказке"
L["Rename"] = "Переименовать"
L["Delete"] = "Удалить"
L["Type \"%s\" to confirm deletion:"] = "Введите \"%s\" для подтверждения:"
L["DELETE_CONFIRM_WORD"] = "УДАЛИТЬ"
L["Type \"%s\" to permanently delete profile \"%s\":"] = "Введите \"%s\", чтобы навсегда удалить профиль \"%s\":"
L["Change color"] = "Цвет"
L["Reset defaults"] = "Сброс"
L["Import"] = "Импорт"
L["Export"] = "Экспорт"
L["Export all"] = "Экспорт всех"
L["New"] = "Новый"
L["From template"] = "Из шаблона"
L["Copy"] = "Копировать"
L["OK"] = "ОК"
L["Cancel"] = "Отмена"
L["Create"] = "Создать"
L["Close"] = "Закрыть"
L["%s upgrade"] = "%s улучшение"
L["upgrade - %s"] = "улучшение - %s"
L["%s with %s"] = "%s с %s"
L["fills an empty slot"] = "заполняет пустой слот"
L["+%s points"] = "+%s очк."
L["replaces zero-score item"] = "заменяет пустой предмет"
L["Main hand"] = "Правая рука"
L["Off hand"] = "Левая рука"
L["replaces: %s"] = "заменяет: %s"
L["%s to off hand"] = "%s → Левая рука"

L["Live Character Stats & Cap Status"] = "Текущие характеристики и капы"
L["Profile Cap Configuration"] = "Настройка капов профиля"
L["Cap engine active"] = "Система капов активна"
L["Talent integration active"] = "Учет талантов активен"
L["Tank mode"] = "Режим танка"
L["Target enemy level"] = "Уровень цели"
L["Even level (+0)"] = "Равный уровень (+0)"
L["Dungeon boss (+2)"] = "Босс подземелья (+2)"
L["Raid boss (+3)"] = "Рейдовый босс (+3)"
L["Hit mode"] = "Режим меткости"
L["Melee"] = "Ближний бой"
L["Spell"] = "Заклинания"
L["Avoidance detail format"] = "Пром %.1f%% · Укл %.1f%% · Пар %.1f%% · Блок %.1f%%"
L["Avoidance detail offset format"] = "Пром %.1f%% · Укл %.1f%% · Пар %.1f%% · Блок %.1f%% (+%.0f%%)"
L["Stat Prio Generator"] = "Генератор приоритетов"
L["Profile name:"] = "Имя профиля:"
L["Role:"] = "Роль:"
L["Tank"] = "Танк"
L["Melee DPS"] = "Боец (ближн.)"
L["Ranged DPS"] = "Боец (дальн.)"
L["Caster DPS"] = "Боец (закл.)"
L["Healer"] = "Лекарь"
L["Load default prio"] = "Загрузить стандарт"
L["Available stats"] = "Доступные статы"
L["Your priority (1 = highest)"] = "Ваш приоритет (1 = высш.)"
L["Drag to reorder"] = "Перетащите для сортировки"
L["Click + on the left to add stats."] = "Нажмите + слева, чтобы добавить характеристики."
L["Calculated weights preview"] = "Расчетные веса"
L["Create as new profile"] = "Создать новый профиль"
L["Apply to current profile"] = "Применить к профилю"
L["[Synergy]"] = "[Синергия]"
L["[Base]"] = "[База]"
L["Prio list is empty."] = "Добавьте хотя бы одну характеристику."
L["Target: %s (Level %d)"] = "Цель: %s (Ур. %d)"
L["Hit cap (%)"] = "Кап меткости (%)"
L["Spell hit cap (%)"] = "Кап меткости закл. (%)"
L["Defense (Crit immune)"] = "Защита (иммунитет к криту)"
L["Expertise cap (%)"] = "Кап мастерства (%)"
L["Armor cap (75% DR)"] = "Кап брони (75% сниж.)"
L["Avoidance (Uncrushable)"] = "Уклонение (иммунитет к сокрушению)"
L["Haste cap (GCD)"] = "Кап скорости (ГКД)"
L["Dual-wield auto-detected"] = "Бой двумя оружиями распознан автоматически"
L["Optional Spirit Target (0 = no limit)"] = "Необязательная цель духа (0 = без лимита)"
L["Spirit target tooltip"] = "У духа нет жесткого игрового капа. При желании укажите личную цель для восполнения маны (напр. 300 для лекарей). Дух сверх этого значения оценивается ниже. Оставьте 0 для полного веса духа."
L["Note: Shift into Bear Form when comparing items for an accurate 75% armor cap calculation."] = "Примечание: при сравнении предметов перейдите в облик медведя для точного расчета капа брони в 75%."
L["Current:"] = "Текущий:"
L["Active talents:"] = "Активные таланты:"
L["Under cap"] = "Ниже капа"
L["Cap reached (reduced)"] = "Кап достигнут (снижено)"
L["Cap reached (weight = 0)"] = "Кап достигнут (вес = 0)"
L["Not active"] = "Неактивно"
L["Automatic cap mechanics note"] = "Все игровые капы (меткость, защита, мастерство, броня, блок, бой двумя оружиями и скорость) рассчитываются автоматически по уровню персонажа, выбранной цели, оружию и активным талантам/эффектам."

-- Weapon types & UI strings
L["1H Axe"] = "Одноручный топор"
L["2H Axe"] = "Двуручный топор"
L["Bow"] = "Лук"
L["Crossbow"] = "Арбалет"
L["Dagger"] = "Кинжал"
L["Fist weapon"] = "Кистевое"
L["Gun"] = "Огнестрельное"
L["1H Mace"] = "Одноручное дробящее"
L["2H Mace"] = "Двуручное дробящее"
L["Polearm"] = "Древковое"
L["Relic"] = "Реликвия"
L["Staff"] = "Посох"
L["1H Sword"] = "Одноручный меч"
L["2H Sword"] = "Двуручный меч"
L["Thrown weapon"] = "Метательное"
L["Wand"] = "Жезл"
L["Off-hand weapon"] = "Оружие в левой руке"
L["Off-hand frill"] = "Левая рука (предмет)"

L["Auto follows your active talent tree."] = "Автоматически следует за вашей активной веткой талантов."
L["Manual lets you enable and customize multiple profiles."] = "Вручную позволяет включать и настраивать несколько профилей сразу."
L["Read-only template"] = "Шаблон только для чтения (создайте копию или изменяйте веса локально)"
L["Custom scale"] = "Пользовательский профиль"
L["No scale selected"] = "Профиль не выбран"
L["Enter profile name:"] = "Введите имя профиля:"
L["Enter new name for %s:"] = "Новое имя для %s:"
L["Enter name for copy of %s:"] = "Имя копии %s:"
L["Paste Pawn v1 string:"] = "Вставьте строку Pawn v1:"
L["Copy Pawn v1 string (Ctrl+C):"] = "Скопируйте строку Pawn v1 (Ctrl+C):"
L["Choose class & template:"] = "Выберите класс и шаблон:"
L["Overwrite existing scale?"] = "Перезаписать существующий профиль?"

L["Stat weights for %s"] = "Веса характеристик для %s"
L["Yellow values are customized."] = "Желтые значения изменены вами."
L["Normalize values (like Wowhead)"] = "Нормализовать веса (как Wowhead)"
L["Hide 1H upgrades"] = "Скрыть 1Р улучшения"
L["Hide 2H upgrades"] = "Скрыть 2Р улучшения"
L["Unusable armor & weapon types"] = "Недоступные типы брони и оружия"
L["Unusable"] = "Недоступно"
L["Select a stat or edit values directly. Press Tab for next row."] = "Редактируйте веса напрямую. Tab — переход к следующему полю."
L["Clear value"] = "Очистить"

L["Compare items for %s"] = "Сравнение предметов для %s"
L["Left item"] = "Левый предмет"
L["Right item"] = "Правый предмет"
L["Load equipped"] = "Надетый"
L["‹ Swap ›"] = "‹ Обмен ›"
L["Clear"] = "Очистить"
L["Drop an item or paste an item link / ID below, or pick from equipped / bags:"] = "Перетащите предмет, вставьте ссылку/ID или выберите из надетого/сумок:"
L["Pick from equipped"] = "Из надетого"
L["Pick from bags"] = "Из сумок"
L["Stat"] = "Характеристика"
L["Raw EP"] = "Базовый EP"
L["Effective (Cap Delta)"] = "Эффектив. (Дельта капа)"
L["Difference"] = "Разница"
L["Total Base Score"] = "Общий базовый рейтинг"
L["Cap-Adjusted Score"] = "Рейтинг с учетом капов"
L["Net Cap Loss"] = "Потеря из-за капов"
L["Verdict"] = "Итог"
L["Empty slot"] = "Пустой слот"
L["Upgrade: %s"] = "Улучшение: %s"
L["Downgrade: %s"] = "Ухудшение: %s"
L["Equal"] = "Равнозначно"

L["Tooltip display"] = "Отображение подсказки"
L["Only show upgrades"] = "Только улучшения"
L["Show values and upgrades"] = "Оценки и улучшения"
L["Show only values"] = "Только оценки"
L["Show current (enchanted) & base values"] = "Текущие (с чарами) и базовые оценки"
L["Align tooltip values right"] = "Выровнять значения по правому краю"
L["Add blank line before values"] = "Пустая строка перед оценками"
L["Color tooltip border on upgrades"] = "Подсвечивать рамку улучшений"
L["Healing-to-SpellDamage fallback (1/3)"] = "Учитывать 1/3 лечения как силу закл."
L["Advisors & Bags"] = "Советники и сумки"
L["Bag upgrade arrows"] = "Стрелки улучшений в сумках"
L["Quest reward arrows & gold coin"] = "Стрелки наград заданий и лучшая цена"
L["Loot roll advisor"] = "Советник бросков добычи"
L["Announce bag upgrades in chat"] = "Сообщать об улучшениях в сумках в чат"
L["Dagger build (main hand only)"] = "Билд с кинжалом (только прав. рука)"
L["Character panel button"] = "Кнопка в окне персонажа"
L["Right"] = "Справа"
L["Left"] = "Слева"
L["Hidden"] = "Скрыта"
L["Diagnostics"] = "Диагностика"
L["Debug mode"] = "Режим отладки"
L["Rescan & wipe caches"] = "Сбросить кэш и сканировать"

L["[Cap]"] = "[Кап]"
L["Base:"] = "База:"
L["Total gear score"] = "Общий рейтинг экипировки"
L["Click to open PawnDynamic"] = "Нажмите, чтобы открыть PawnDynamic"
L["[%s] New upgrade: %s (%s)"] = "[%s] Новое улучшение: %s (%s)"
L["%d upgrade in your bags - /pd scan to list."] = "%d улучшение в сумках — /pd scan для списка."
L["%d upgrades in your bags - /pd scan to list."] = "%d улучшений в сумках — /pd scan для списка."
L["No upgrades found in your bags."] = "Улучшений в сумках не найдено."
L["Items are still loading - try again shortly."] = "Предметы еще загружаются — повторите позже."
L["Saved %d item - /reload to write to disk."] = "Сохранен %d предмет — /reload для записи."
L["Saved %d items - /reload to write to disk."] = "Сохранено %d предм. — /reload для записи."
L["PawnDynamic did not finish initializing."] = "PawnDynamic не завершил инициализацию."
L["Debug mode enabled."] = "Режим отладки включен."
L["Debug mode disabled."] = "Режим отладки выключен."
L["Caches cleared and data refreshed."] = "Кэш очищен, данные обновлены."
L["|cffff4040Error:|r %s (see /pd status)"] = "|cffff4040Ошибка:|r %s (см. /pd status)"
L["Commands: /pd (toggle UI) | /pd status | /pd scan | /pd debug [on|off|link] | /pd dump | /pd refresh"] =
    "Команды: /pd (окно) | /pd status | /pd scan | /pd debug [on|off|ссылка] | /pd dump | /pd refresh"
L["Shift+Click: Toggle Tooltip"] = "Shift+Клик: Подсказка"

-- Getting started / About Tab
L["ABOUT_CREDITS"] = "Автор: Behmen  |  Лицензия: MIT License (100% Clean-Room Lua, без XML)"
L["ABOUT_CAP_TITLE"] = "|cff00d1ff1. Динамический движок капов (Delta):|r"
L["ABOUT_CAP_INTRO"] = "Перед оценкой предмета PawnDynamic вычитает характеристики надетого предмета из общих параметров персонажа и рассчитывает замену относительно ваших капов:"
L["ABOUT_CAP_FORMULA"] = "Эфф. ценность = f(Перс - СтарыйПредмет + НовыйПредмет) - f(Перс - СтарыйПредмет)"
L["ABOUT_CAP_TARGET"] = "Уровень цели (+0 / +2 / +3 или Авто): Точные формулы для Меткости (5% / 6% / 8%), Меткости заклинаний (4% / 6% / 17%), Защиты от крита (Ур*5 + 125/135/140), Мастерства (5% / 5,5% / 6,5%, танки до 14%) и Брони (75% сниж.)."
L["ABOUT_CAP_AVOIDANCE"] = "Уклонение (Анти-сокрушение 100% / 101,6% / 102,4%): При достижении капа Промах + Уклонение + Парирование + Блок лишь блок падает до 0; Уклонение и Парирование сохраняют вес (классы со щитом)."
L["ABOUT_CAP_REDUCTION"] = "Авто-снижение сверх капа: Бой двумя оружиями (определяется авто.) учитывает белую меткость до 24-27%, а Скорость продолжает действовать со сниженным весом выше 50% GCD."
L["ABOUT_CAP_DRUID"] = "Примечание для друидов: Перейдите в облик медведя при сравнении для точного расчета 75% капа брони."
L["ABOUT_TALENTS_TITLE"] = "|cff00d1ff2. Таланты и живые баффы (C_Traits + UNIT_AURA):|r"
L["ABOUT_TALENTS_DESC"] = "Определяет таланты независимо от языка по spellID / nodeID, обновляет баффы вроде Щита небес через ауры без двойного учета и учитывает таланты меткости по школам магии."
L["ABOUT_PAWN_TITLE"] = "|cff00d1ff3. Совместимость с Pawn v1:|r"
L["ABOUT_PAWN_DESC"] = "Полный импорт и экспорт классических строк Pawn v1 на вкладке «Профиль»."
L["ABOUT_COMMANDS_TITLE"] = "|cff00d1ff4. Слэш-команды:|r"
L["ABOUT_CMD_PD"] = "/pd  или  /pawndynamic — Открыть/закрыть окно"
L["ABOUT_CMD_STATUS"] = "/pd status — Живые статы, капы, таланты и журнал ошибок"
L["ABOUT_CMD_SCAN"] = "/pd scan — Показать все улучшения в сумках в чате"
L["ABOUT_CMD_DEBUG"] = "/pd debug [Ссылка] — Подробный анализ подсказки и статов"
L["ABOUT_CMD_DUMP"] = "/pd dump — Сохранить считанные значения в SavedVariables"
L["ABOUT_CMD_REFRESH"] = "/pd refresh — Сбросить кэш и пересчитать все данные"

locale.scales = {
    WARRIOR = { ARMS = { name = "Оружие", match = "оружие" }, FURY = { name = "Неистовство", match = "неистов" }, PROTECTION = { name = "Защита", match = "защита" } },
    PALADIN = { HOLY = { name = "Свет", match = "свет" }, PROTECTION = { name = "Защита", match = "защита" }, RETRIBUTION = { name = "Воздаяние", match = "воздаян" } },
    HUNTER = { BEAST_MASTERY = { name = "Повелитель зверей", match = "звер" }, MARKSMANSHIP = { name = "Стрельба", match = "стрельб" }, SURVIVAL = { name = "Выживание", match = "выживан" } },
    ROGUE = { ASSASSINATION = { name = "Ликвидация", match = "ликвид" }, COMBAT = { name = "Бой", match = "бой" }, SUBTLETY = { name = "Скрытность", match = "скрыт" } },
    PRIEST = { DISCIPLINE = { name = "Послушание", match = "послуш" }, HOLY = { name = "Свет", match = "свет" }, SHADOW = { name = "Тьма", match = "тьма" }, SMITE = { name = "Кара" } },
    SHAMAN = { ELEMENTAL = { name = "Стихии", match = "стих" }, ENHANCEMENT = { name = "Совершенствование", match = "соверш" }, RESTORATION = { name = "Исцеление", match = "исцел" } },
    MAGE = { ARCANE = { name = "Тайная магия", match = "тайн" }, FIRE = { name = "Огонь", match = "огон" }, FROST = { name = "Лед", match = "лед" } },
    WARLOCK = { AFFLICTION = { name = "Колдовство", match = "колдов" }, DEMONOLOGY = { name = "Демонология", match = "демон" }, DESTRUCTION = { name = "Разрушение", match = "разруш" } },
    DRUID = { BALANCE = { name = "Баланс", match = "баланс" }, FERAL_CAT = { name = "Сила зверя (Кот)", match = "звер" }, FERAL_BEAR = { name = "Сила зверя (Медведь)" }, RESTORATION = { name = "Исцеление", match = "исцел" } },
}

locale.grammar = function(P)
    local NUM = P.NUM
    local GAP = "[^%d]-"
    local rules = {
        { "в бою с", false }, { "против ", false }, { " на %d+ сек", false }, { "вероятность ", false },
        { "показатель блокирования" .. GAP .. NUM, "BLOCK_VALUE" },
        { "проникающая способность заклинаний" .. GAP .. NUM, "SPELL_PEN" },
        { "критического удара" .. GAP .. NUM .. "%%", "CRIT" },
        { "меткости" .. GAP .. NUM .. "%%", "HIT" },
        { "уклонения и парирования" .. GAP .. NUM .. "%%", "EXPERTISE", true },
        { "мастерств" .. GAP .. NUM, "EXPERTISE" },
        { "уклониться" .. GAP .. NUM .. "%%", "DODGE" },
        { "парировать" .. GAP .. NUM .. "%%", "PARRY" },
        { "блокировать" .. GAP .. NUM .. "%%", "BLOCK" },
        { "защит" .. GAP .. NUM, "DEFENSE" },
        { "силу заклинаний" .. GAP .. NUM, P.AddSpellPower },
        { "исцеления" .. GAP .. NUM, P.AddHealing },
        { "урона от заклинаний" .. GAP .. NUM, "SPELL_DAMAGE" },
        { NUM .. GAP .. "маны раз в 5 сек", "MP5" },
        { NUM .. GAP .. "здоровья раз в 5 сек", "HP5" },
        { "силы атаки в дальнем бою" .. GAP .. NUM, "RANGED_AP" },
        { "силу атаки" .. GAP .. NUM, "ATTACK_POWER" },
        { "силы атаки" .. GAP .. NUM, "ATTACK_POWER" },
        { "скорост" .. GAP .. NUM .. "%%", "HASTE" },
    }
    local names = {
        ["к силе"] = "STRENGTH", ["силе"] = "STRENGTH", ["сила"] = "STRENGTH",
        ["к ловкости"] = "AGILITY", ["ловкости"] = "AGILITY", ["ловкость"] = "AGILITY",
        ["к выносливости"] = "STAMINA", ["выносливости"] = "STAMINA", ["выносливость"] = "STAMINA",
        ["к интеллекту"] = "INTELLECT", ["интеллекту"] = "INTELLECT", ["интеллект"] = "INTELLECT",
        ["к духу"] = "SPIRIT", ["духу"] = "SPIRIT", ["дух"] = "SPIRIT",
        ["брони"] = "ARMOR", ["броня"] = "ARMOR",
        ["к блокированию"] = "BLOCK_VALUE", ["показатель блокирования"] = "BLOCK_VALUE",
        ["к защите"] = "DEFENSE", ["уклонению"] = "DODGE", ["парированию"] = "PARRY",
        ["силе атаки"] = "ATTACK_POWER", ["рейтингу меткости"] = P.Rating("HIT"),
        ["рейтингу критического удара"] = P.Rating("CRIT"), ["рейтингу скорости"] = P.Rating("HASTE"),
        ["мастерству"] = "EXPERTISE", ["силе заклинаний"] = P.AddSpellPower,
        ["ко всем видам сопротивления"] = P.AddAllResistances,
    }
    local skip = { "использование:", "вероятность при попадании:", "комплект:", "требуется", "классы:", "расы:", "прочность", "уровень предмета", "цена продажи", "уникальный", "становится", "\"" }
    local words = {
        equip = "^если на персонаже: (.+)$", classes = "^классы: (.+)$", set = "^%(%d+%) комплект",
        range = { "^урон: " .. NUM .. " %- " .. NUM }, flat = { "^урон: " .. NUM .. "$" },
        dps = "%(?" .. NUM .. " ед%. урона в секунду", speed = "^скорость " .. NUM,
        negative = { "^уменьшает", "^снижает" }, also = " и ", plus = " и ", looseNumbers = true,
    }
    return { rules = rules, names = names, skip = skip, words = words }
end
