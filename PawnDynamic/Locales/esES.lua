-- PawnDynamic (MIT License)
-- Spanish localization (esES / esMX).

local _, ns = ...

local locale = ns:NewLocale("esES", "esMX")
if not locale then
    return
end

local L = locale.strings

L["Attributes"] = "Atributos"
L["Offense"] = "Ofensiva"
L["Weapon damage"] = "Daño de arma"
L["Spells"] = "Hechizos"
L["Defense"] = "Defensa"
L["Resistances"] = "Resistencias"
L["Armor types"] = "Tipos de armadura"
L["Weapon types"] = "Tipos de arma"

L["Strength"] = "Fuerza"
L["Agility"] = "Agilidad"
L["Stamina"] = "Aguante"
L["Intellect"] = "Intelecto"
L["Spirit"] = "Espíritu"
L["Attack power"] = "Poder de ataque"
L["Ranged attack power"] = "Poder de ataque a distancia"
L["Feral attack power"] = "Poder de ataque feral"
L["Hit %"] = "Golpe %"
L["Crit %"] = "Crítico %"
L["Expertise %"] = "Pericia %"
L["Weapon skill"] = "Habilidad con armas"
L["Haste %"] = "Celeridad %"
L["Armor penetration"] = "Penetración de armadura"
L["Main-hand DPS"] = "DPS mano principal"
L["Main-hand min damage"] = "Daño mín. mano principal"
L["Main-hand max damage"] = "Daño máx. mano principal"
L["Main-hand hit damage"] = "Golpe medio mano principal"
L["Main-hand speed"] = "Velocidad mano principal"
L["Off-hand DPS"] = "DPS mano secundaria"
L["Off-hand speed"] = "Velocidad mano secundaria"
L["Ranged / wand DPS"] = "DPS distancia / varita"
L["Ranged min damage"] = "Daño mín. distancia"
L["Ranged max damage"] = "Daño máx. distancia"
L["Ranged hit damage"] = "Golpe medio distancia"
L["Ranged speed"] = "Velocidad a distancia"
L["Speed baseline"] = "Base de velocidad"
L["Spell damage"] = "Daño con hechizos"
L["Healing"] = "Sanación"
L["Arcane damage"] = "Daño Arcano"
L["Fire damage"] = "Daño de Fuego"
L["Frost damage"] = "Daño de Escarcha"
L["Nature damage"] = "Daño de Naturaleza"
L["Shadow damage"] = "Daño de Sombras"
L["Holy damage"] = "Daño Sagrado"
L["Mana per 5 sec"] = "Maná cada 5 s"
L["Spell penetration"] = "Penetración de hechizos"
L["Armor"] = "Armadura"
L["Defense"] = "Defensa"
L["Dodge %"] = "Esquivar %"
L["Parry %"] = "Parar %"
L["Block %"] = "Bloquear %"
L["Block value"] = "Valor de bloqueo"
L["Health per 5 sec"] = "Salud cada 5 s"
L["Resilience"] = "Temple"
L["All resistances"] = "Todas las resistencias"
L["Arcane resistance"] = "Resistencia a Arcano"
L["Fire resistance"] = "Resistencia al Fuego"
L["Frost resistance"] = "Resistencia a Escarcha"
L["Nature resistance"] = "Resistencia a Naturaleza"
L["Shadow resistance"] = "Resistencia a Sombras"
L["Include Raid Resistance Buff (+60)"] = "Incluir beneficio de resistencia de banda (+60)"
L["Scale % stats by level (< 60)"] = "Escalar % por nivel (< 60)"
L["Scale % stats by level tooltip"] = "Escala proporcionalmente las estadísticas porcentuales (Crítico %, Golpe %, Celeridad %, Pericia %, Habilidad con armas, Defensa, Esquiva %, Parada %, Bloqueo %) por debajo del nivel 60 (factor Nivel / 60, 100 % al nivel 60). Desactívalo para aplicar siempre el peso completo mientras subes de nivel."
L["Raid resistance buff tooltip"] = "Añade +60 de resistencia de auras de paladín, tótems de chamán, Aspecto salvaje o Protección contra las sombras al planificar equipo sin beneficios. Baja automáticamente a 0 cuando el beneficio de banda ya está activo (sin doble conteo). Frascos, jujus y pociones activos se detectan automáticamente."

L["Cloth"] = "Tela"
L["Leather"] = "Cuero"
L["Mail"] = "Malla"
L["Plate"] = "Placas"
L["Shield"] = "Escudo"
L["1H Axe"] = "Hacha 1M"
L["2H Axe"] = "Hacha 2M"
L["Bow"] = "Arco"
L["Crossbow"] = "Ballesta"
L["Dagger"] = "Daga"
L["Fist weapon"] = "Arma de puño"
L["Gun"] = "Arma de fuego"
L["1H Mace"] = "Maza 1M"
L["2H Mace"] = "Maza 2M"
L["Polearm"] = "Arma de asta"
L["Relic"] = "Reliquia"
L["Staff"] = "Bastón"
L["1H Sword"] = "Espada 1M"
L["2H Sword"] = "Espada 2M"
L["Thrown weapon"] = "Arma arrojadiza"
L["Wand"] = "Varita"
L["Off-hand weapon"] = "Arma mano izq."
L["Off-hand frill"] = "Objeto mano izq."

L["Scale"] = "Perfil"
L["Weights"] = "Pesos"
L["Caps & Dynamics"] = "Caps y Dinámica"
L["Compare"] = "Comparar"
L["Options"] = "Opciones"
L["Getting started / About"] = "Inicio / Acerca de"

L["My scales"] = "Mis perfiles"
L["Other scales"] = "Otros perfiles"
L["Starter templates"] = "Plantillas iniciales"
L["Automatic"] = "Automático"
L["Manual"] = "Manual"
L["Auto follows your active talent tree."] = "Automático sigue el árbol de talentos activo."
L["Manual lets you enable and customize multiple profiles."] = "Manual permite activar y editar varios perfiles."
L["Show this scale in tooltips"] = "Mostrar en la descripción"
L["Rename"] = "Renombrar"
L["Delete"] = "Eliminar"
L["Change color"] = "Cambiar color"
L["Reset defaults"] = "Restablecer"
L["Import"] = "Importar"
L["Export"] = "Exportar"
L["Export all"] = "Exportar todo"
L["New"] = "Nuevo"
L["From template"] = "Plantilla"
L["Copy"] = "Copiar"
L["Read-only template"] = "Plantilla de solo lectura (haz una copia para personalizar libremente)"
L["Custom scale"] = "Perfil personalizado"
L["No scale selected"] = "Ningún perfil seleccionado"
L["Enter profile name:"] = "Nombre del perfil:"
L["Enter new name for %s:"] = "Nuevo nombre para %s:"
L["Enter name for copy of %s:"] = "Nombre para la copia de %s:"
L["Type \"%s\" to confirm deletion:"] = "Escribe \"%s\" para confirmar:"
L["DELETE_CONFIRM_WORD"] = "ELIMINAR"
L["Type \"%s\" to permanently delete profile \"%s\":"] = "Escribe \"%s\" para eliminar permanentemente el perfil \"%s\":"
L["Paste Pawn v1 string:"] = "Pega la cadena Pawn v1:"
L["Copy Pawn v1 string (Ctrl+C):"] = "Copia la cadena Pawn v1 (Ctrl+C):"
L["Choose class & template:"] = "Elige clase y plantilla:"
L["Overwrite existing scale?"] = "¿Sobrescribir el perfil existente?"
L["OK"] = "Aceptar"
L["Cancel"] = "Cancelar"
L["Create"] = "Crear"
L["Close"] = "Cerrar"

L["Stat weights for %s"] = "Pesos para %s"
L["Yellow values are customized."] = "Los valores amarillos han sido editados."
L["Normalize values (like Wowhead)"] = "Normalizar valores (como Wowhead)"
L["Hide 1H upgrades"] = "Ocultar mejoras 1M"
L["Hide 2H upgrades"] = "Ocultar mejoras 2M"
L["Unusable armor & weapon types"] = "Tipos de armadura y arma inutilizables"
L["Unusable"] = "Inutilizable"
L["Select a stat or edit values directly. Press Tab for next row."] = "Edita los valores directamente. Tab pasa al siguiente campo."
L["Clear value"] = "Borrar"

L["Live Character Stats & Cap Status"] = "Estadísticas en vivo y estado de caps"
L["Profile Cap Configuration"] = "Configuración de caps del perfil"
L["Cap engine active"] = "Motor de caps activo"
L["Talent integration active"] = "Integración de talentos activa"
L["Tank mode"] = "Modo Tanque"
L["Target enemy level"] = "Nivel del enemigo objetivo"
L["Even level (+0)"] = "Mismo nivel (+0)"
L["Dungeon boss (+2)"] = "Jefe de mazmorra (+2)"
L["Raid boss (+3)"] = "Jefe de banda (+3)"
L["Hit mode"] = "Modo de golpe"
L["Melee"] = "Cuerpo a cuerpo"
L["Spell"] = "Hechizos"
L["Avoidance detail format"] = "Fall %.1f%% · Esq %.1f%% · Par %.1f%% · Bloq %.1f%%"
L["Avoidance detail offset format"] = "Fall %.1f%% · Esq %.1f%% · Par %.1f%% · Bloq %.1f%% (+%.0f%%)"
L["Stat Prio Generator"] = "Generador de prioridades"
L["Profile name:"] = "Nombre:"
L["Role:"] = "Rol:"
L["Tank"] = "Tanque"
L["Melee DPS"] = "DPS Cuerpo a cuerpo"
L["Ranged DPS"] = "DPS Distancia"
L["Caster DPS"] = "DPS Hechizos"
L["Healer"] = "Sanador"
L["Load default prio"] = "Cargar por defecto"
L["Available stats"] = "Estadísticas disponibles"
L["Your priority (1 = highest)"] = "Tu prioridad (1 = mayor)"
L["Drag to reorder"] = "Arrastra para reordenar"
L["Click + on the left to add stats."] = "Haz clic en + a la izquierda para añadir atributos."
L["Calculated weights preview"] = "Vista previa de pesos"
L["Create as new profile"] = "Crear perfil nuevo"
L["Apply to current profile"] = "Aplicar al perfil actual"
L["[Synergy]"] = "[Sinergia]"
L["[Base]"] = "[Base]"
L["Prio list is empty."] = "Añade al menos una estadística."
L["Target: %s (Level %d)"] = "Objetivo: %s (Nivel %d)"
L["Hit cap (%)"] = "Cap de Golpe (%)"
L["Spell hit cap (%)"] = "Cap de Golpe hechizos (%)"
L["Defense (Crit immune)"] = "Defensa (Inmune a críticos)"
L["Expertise cap (%)"] = "Cap de Pericia (%)"
L["Armor cap (75% DR)"] = "Cap de Armadura (75% Red.)"
L["Avoidance (Uncrushable)"] = "Evasión (Inmune a aplastamiento)"
L["Haste cap (GCD)"] = "Cap de Celeridad (GCD)"
L["Dual-wield auto-detected"] = "Doble empuñadura detectada automáticamente"
L["Optional Spirit Target (0 = no limit)"] = "Objetivo de Espíritu opcional (0 = sin límite)"
L["Spirit target tooltip"] = "El Espíritu no tiene un cap fijo en el juego. Opcionalmente indica un objetivo personal de regeneración de maná (ej. 300 para sanadores). El Espíritu por encima de ese valor se reduce en objetos. Déjalo en 0 para mantener su peso completo."
L["Note: Shift into Bear Form when comparing items for an accurate 75% armor cap calculation."] = "Nota: Cambia a forma de oso al comparar objetos para calcular con exactitud el cap de armadura del 75 %."
L["Active talents:"] = "Talentos activos:"
L["Under cap"] = "Bajo cap"
L["Cap reached (reduced)"] = "Cap alcanzado (reducido)"
L["Cap reached (weight = 0)"] = "Cap alcanzado (peso = 0)"
L["Not active"] = "Inactivo"
L["Automatic cap mechanics note"] = "Todos los caps mecánicos (Golpe, Golpe hechizos, Defensa, Pericia, Armadura, Evasión, Doble empuñadura y Celeridad) se calculan automáticamente según tu nivel, el nivel del objetivo, tus armas y talentos/beneficios activos."

L["Compare items for %s"] = "Comparar objetos (%s)"
L["Left item"] = "Objeto izquierdo"
L["Right item"] = "Objeto derecho"
L["Load equipped"] = "Cargar equipado"
L["‹ Swap ›"] = "‹ Intercambiar ›"
L["Clear"] = "Limpiar"
L["Drop an item or paste an item link / ID below, or pick from equipped / bags:"] = "Suelta un objeto, pega enlace/ID o elige de equipo/bolsas:"
L["Pick from equipped"] = "De equipo"
L["Pick from bags"] = "De bolsas"
L["Stat"] = "Estadística"
L["Raw EP"] = "EP bruto"
L["Effective (Cap Delta)"] = "Efectivo (Delta Cap)"
L["Difference"] = "Diferencia"
L["Total Base Score"] = "Puntuación base total"
L["Cap-Adjusted Score"] = "Puntuación ajustada al cap"
L["Net Cap Loss"] = "Pérdida por cap"
L["Verdict"] = "Veredicto"
L["Empty slot"] = "Ranura vacía"
L["Upgrade: %s"] = "Mejora: %s"
L["Downgrade: %s"] = "Peor: %s"
L["Equal"] = "Igual"

L["Tooltip display"] = "Mostrar en descripción"
L["Only show upgrades"] = "Solo mejoras"
L["Show values and upgrades"] = "Valores y mejoras"
L["Show only values"] = "Solo valores"
L["Show current (enchanted) & base values"] = "Mostrar valores actuales y base"
L["Align tooltip values right"] = "Alinear a la derecha"
L["Add blank line before values"] = "Línea en blanco antes de valores"
L["Color tooltip border on upgrades"] = "Colorear borde de descripción"
L["Healing-to-SpellDamage fallback (1/3)"] = "Curación a daño con hechizos (1/3)"
L["Advisors & Bags"] = "Asistentes y Bolsas"
L["Bag upgrade arrows"] = "Flechas en bolsas (Blizzard / Bagnon / Baganator)"
L["Quest reward arrows & gold coin"] = "Flechas en misiones y moneda de oro"
L["Loot roll advisor"] = "Asistente de botín"
L["Announce bag upgrades in chat"] = "Avisar mejoras en el chat"
L["Dagger build (main hand only)"] = "Dagas en mano principal"
L["Character panel button"] = "Botón en panel de personaje"
L["Right"] = "Derecha"
L["Left"] = "Izquierda"
L["Hidden"] = "Oculto"
L["Diagnostics"] = "Diagnóstico"
L["Debug mode"] = "Modo depuración"
L["Rescan & wipe caches"] = "Limpiar caché y reescanear"

L["%s upgrade"] = "%s mejora"
L["upgrade - %s"] = "mejora - %s"
L["%s with %s"] = "%s con %s"
L["fills an empty slot"] = "ocupa ranura vacía"
L["+%s points"] = "+%s puntos"
L["replaces zero-score item"] = "reemplaza objeto sin valor"
L["Main hand"] = "Mano derecha"
L["Off hand"] = "Mano izquierda"
L["replaces: %s"] = "reemplaza: %s"
L["%s to off hand"] = "%s → Mano izquierda"
L["[Cap]"] = "[Cap]"
L["Base:"] = "Base:"
L["Current:"] = "Actual:"
L["Total gear score"] = "Puntuación total del equipo"
L["Click to open PawnDynamic"] = "Clic para abrir PawnDynamic"
L["[%s] New upgrade: %s (%s)"] = "[%s] Nueva mejora: %s (%s)"
L["%d upgrade in your bags - /pd scan to list."] = "%d mejora en tus bolsas - /pd scan."
L["%d upgrades in your bags - /pd scan to list."] = "%d mejoras en tus bolsas - /pd scan."
L["No upgrades found in your bags."] = "No hay mejoras en tus bolsas."
L["Items are still loading - try again shortly."] = "Los objetos aún se están cargando."
L["Saved %d item - /reload to write to disk."] = "%d objeto guardado - /reload para guardar."
L["Saved %d items - /reload to write to disk."] = "%d objetos guardados - /reload para guardar."
L["PawnDynamic did not finish initializing."] = "PawnDynamic no terminó de iniciarse."
L["Debug mode enabled."] = "Modo depuración activado."
L["Debug mode disabled."] = "Modo depuración desactivado."
L["Caches cleared and data refreshed."] = "Cachés limpiadas y datos actualizados."
L["|cffff4040Error:|r %s (see /pd status)"] = "|cffff4040Error:|r %s (ver /pd status)"
L["Commands: /pd (toggle UI) | /pd status | /pd scan | /pd debug [on|off|link] | /pd dump | /pd refresh"] =
    "Comandos: /pd (ventana) | /pd status | /pd scan | /pd debug [on|off|enlace] | /pd dump | /pd refresh"
L["Shift+Click: Toggle Tooltip"] = "Mayús+Clic: Activar tooltip"

-- Getting started / About Tab
L["ABOUT_CREDITS"] = "Autor: Behmen  |  Licencia: MIT License (100% Lua Clean-Room, sin XML)"
L["ABOUT_CAP_TITLE"] = "|cff00d1ff1. Motor dinámico de límites (Delta):|r"
L["ABOUT_CAP_INTRO"] = "Antes de puntuar un objeto, PawnDynamic resta las estadísticas de tu objeto equipado y evalúa el reemplazo frente a tus límites mecánicos:"
L["ABOUT_CAP_FORMULA"] = "Valor efectivo = f(StatsPerso - ObjetoActual + NuevoObjeto) - f(StatsPerso - ObjetoActual)"
L["ABOUT_CAP_TARGET"] = "Nivel del objetivo (+0 / +2 / +3 o Automático): Fórmulas exactas para Golpe (5% / 6% / 8%), Golpe con hechizos (4% / 6% / 17%), Defensa inmune a críticos (Nivel*5 + 125/135/140), Pericia (5% / 5,5% / 6,5%, Tanques hasta 14%) y Armadura (75% RD)."
L["ABOUT_CAP_AVOIDANCE"] = "Evasión (Inmune a aplastamiento 100% / 101,6% / 102,4%): Al alcanzar Fallo + Esquiva + Parada + Bloqueo el límite, solo el bloqueo cae a 0; Esquiva y Parada mantienen su peso (clases con escudo)."
L["ABOUT_CAP_REDUCTION"] = "Reducción automática por encima: Doble empuñadura (auto-detectada) escala golpe blanco hasta 24-27%, y Celeridad sigue con peso reducido sobre el límite de 50% GCD."
L["ABOUT_CAP_DRUID"] = "Nota para Druidas: Cambia a Forma de oso al comparar objetos para calcular exactamente el límite del 75% de armadura."
L["ABOUT_TALENTS_TITLE"] = "|cff00d1ff2. Talentos y Beneficios en vivo (C_Traits + UNIT_AURA):|r"
L["ABOUT_TALENTS_DESC"] = "Detecta talentos sin depender del idioma por spellID / nodeID, actualiza beneficios como Escudo sagrado en tiempo real sin doble conteo e incluye talentos de golpe por escuela."
L["ABOUT_PAWN_TITLE"] = "|cff00d1ff3. Compatibilidad con Pawn v1:|r"
L["ABOUT_PAWN_DESC"] = "Importación y exportación completa de cadenas clásicas de Pawn v1 en la pestaña 'Perfil'."
L["ABOUT_COMMANDS_TITLE"] = "|cff00d1ff4. Comandos Slash:|r"
L["ABOUT_CMD_PD"] = "/pd  o  /pawndynamic — Abrir/cerrar ventana"
L["ABOUT_CMD_STATUS"] = "/pd status — Estadísticas en vivo, límites, talentos y errores"
L["ABOUT_CMD_SCAN"] = "/pd scan — Listar mejoras de las bolsas en el chat"
L["ABOUT_CMD_DEBUG"] = "/pd debug [Enlace] — Análisis detallado de tooltip y estadísticas"
L["ABOUT_CMD_DUMP"] = "/pd dump — Guardar valores leídos en SavedVariables para depuración"
L["ABOUT_CMD_REFRESH"] = "/pd refresh — Limpiar cachés y recalcular todo"

locale.scales = {
    WARRIOR = {
        ARMS = { name = "Armas", match = "armas" },
        FURY = { name = "Furia", match = "furia" },
        PROTECTION = { name = "Protección", match = "protecci" },
    },
    PALADIN = {
        HOLY = { name = "Sagrado", match = "sagrado" },
        PROTECTION = { name = "Protección", match = "protecci" },
        RETRIBUTION = { name = "Reprensión", match = "reprensi" },
    },
    HUNTER = {
        BEAST_MASTERY = { name = "Bestias", match = "bestias" },
        MARKSMANSHIP = { name = "Puntería", match = "punter" },
        SURVIVAL = { name = "Supervivencia (melé)", match = "supervivencia" },
    },
    ROGUE = {
        ASSASSINATION = { name = "Asesinato", match = "asesinato" },
        COMBAT = { name = "Combate", match = "combate" },
        SUBTLETY = { name = "Sutileza", match = "sutileza" },
    },
    PRIEST = {
        DISCIPLINE = { name = "Disciplina", match = "disciplina" },
        HOLY = { name = "Sagrado", match = "sagrado" },
        SHADOW = { name = "Sombras", match = "sombra" },
        SMITE = { name = "Punición" },
    },
    SHAMAN = {
        ELEMENTAL = { name = "Elemental", match = "elemental" },
        ENHANCEMENT = { name = "Mejora", match = "mejora" },
        RESTORATION = { name = "Restauración", match = "restauraci" },
    },
    MAGE = {
        ARCANE = { name = "Arcano", match = "arcano" },
        FIRE = { name = "Fuego", match = "fuego" },
        FROST = { name = "Escarcha", match = "escarcha" },
    },
    WARLOCK = {
        AFFLICTION = { name = "Aflicción", match = "aflicci" },
        DEMONOLOGY = { name = "Demonología", match = "demonolog" },
        DESTRUCTION = { name = "Destrucción", match = "destrucci" },
    },
    DRUID = {
        BALANCE = { name = "Equilibrio", match = "equilibrio" },
        FERAL_CAT = { name = "Feral (felino)", match = "feral" },
        FERAL_BEAR = { name = "Feral (oso)" },
        RESTORATION = { name = "Restauración", match = "restauraci" },
    },
}

locale.talents = {
    ["arcane blast"] = { "explosión arcana" },
    ["mental dexterity"] = { "maña mental" },
    ["mental quickness"] = { "presura mental" },
    ["careful aim"] = { "afinar la puntería" },
    ["champion of the light"] = { "campeón de la luz", "adalid de la luz" },
    ["spiritual guidance"] = { "guía espiritual" },
    ["living spirit"] = { "espíritu vivo" },
    ["holy shield"] = { "escudo sagrado" },
    ["redoubt"] = { "reducto", "escudo de defensa" },
    ["shield block"] = { "bloquear con escudo" },
    ["shadow focus"] = { "enfoque de las sombras" },
    ["focused power"] = { "poder enfocado" },
    ["suppression"] = { "supresión" },
    ["arcane focus"] = { "enfoque arcano" },
    ["elemental precision"] = { "precisión elemental" },
    ["nature's guidance"] = { "guía de la naturaleza" },
    ["balance of power"] = { "equilibrio de poder" },
}

locale.grammar = function(P)
    local NUM, UNREAD, Add = P.NUM, P.UNREAD, P.Add
    local GAP = "[^%d]-"

    local SCHOOLS = {
        arcano = "ARCANE", arcanos = "ARCANE", fuego = "FIRE", escarcha = "FROST",
        naturaleza = "NATURE", sombras = "SHADOW", sombra = "SHADOW", sagrado = "HOLY", sagrados = "HOLY",
    }

    local WEAPON_SKILLS = {
        ["hachas"] = 0, ["hachas de dos manos"] = 1, ["arcos"] = 2, ["armas de fuego"] = 3,
        ["mazas"] = 4, ["mazas de dos manos"] = 5, ["armas de asta"] = 6,
        ["espadas"] = 7, ["espadas de dos manos"] = 8, ["bastones"] = 10,
        ["armas de puño"] = 13, ["dagas"] = 15, ["armas arrojadizas"] = 16, ["ballestas"] = 18,
    }

    local function SchoolDamage(stats, school, value)
        if school == "mágicos" then
            Add(stats, "SPELL_DAMAGE", value)
            return
        end
        school = school:gsub("^de la ", ""):gsub("^del ", ""):gsub("^de ", "")
        local key = SCHOOLS[school]
        if key then
            Add(stats, key .. "_DAMAGE", value)
        else
            return false
        end
    end

    local rules = {
        { "al combatir", false }, { "al enfrentarte", false }, { "al luchar", false },
        { " contra ", false }, { " durante %d+ ?s", false }, { "%% de probabilidad", false },
        { "una probabilidad", false }, { "probabilidad de que", false },
        { " de tus? ", UNREAD },
        { "valor de bloqueo" .. GAP .. NUM, "BLOCK_VALUE" },
        { "resistencias mágicas de los objetivos de tus hechizos" .. GAP .. NUM, "SPELL_PEN", true },
        { "penetración de hechizos" .. GAP .. NUM, "SPELL_PEN" },
        { "golpe crítico" .. GAP .. NUM .. "%%", "CRIT" },
        { "alcanzar el objetivo" .. GAP .. NUM .. "%%", "HIT" },
        { "probabilidad de golpe" .. GAP .. NUM .. "%%", "HIT" },
        { "esquivados? o parados?" .. GAP .. NUM .. "%%", "EXPERTISE", true },
        { "parados? o esquivados?" .. GAP .. NUM .. "%%", "EXPERTISE", true },
        { "pericia" .. GAP .. NUM, "EXPERTISE" },
        { "probabilidad de esquivar" .. GAP .. NUM .. "%%", "DODGE" },
        { "probabilidad de parar" .. GAP .. NUM .. "%%", "PARRY" },
        { "probabilidad de bloquear" .. GAP .. NUM .. "%%", "BLOCK" },
        { "^defensa aumentada %+" .. NUM, "DEFENSE" },
        { "defensa" .. GAP .. NUM, "DEFENSE" },
        { "^(.-) aumentad[ao]s? %+" .. NUM, P.Skill(WEAPON_SKILLS) },
        { "daño y la curación de los hechizos" .. GAP .. NUM, P.AddSpellPower },
        { "daño y la sanación de los hechizos" .. GAP .. NUM, P.AddSpellPower },
        { "la curación de los hechizos" .. GAP .. NUM, P.AddHealing },
        { "la sanación de los hechizos" .. GAP .. NUM, P.AddHealing },
        { "daño causado por los hechizos (.-) y los efectos" .. GAP .. NUM, SchoolDamage },
        { "daño infligido por los hechizos (.-) y los efectos" .. GAP .. NUM, SchoolDamage },
        { "poder con hechizos" .. GAP .. NUM, P.AddSpellPower },
        { "daño con hechizos" .. GAP .. NUM, "SPELL_DAMAGE" },
        { NUM .. GAP .. "maná cada 5 s", "MP5" },
        { NUM .. GAP .. "salud cada 5 s", "HP5" },
        { NUM .. GAP .. "poder de ataque" .. GAP .. "felin", "FERAL_AP" },
        { "poder de ataque a distancia" .. GAP .. NUM, "RANGED_AP" },
        { "poder de ataque" .. GAP .. NUM, "ATTACK_POWER" },
        { "velocidad de ataque y de lanzamiento" .. GAP .. NUM .. "%%", "HASTE" },
        { "velocidad de lanzamiento" .. GAP .. NUM .. "%%", "HASTE" },
        { "velocidad de ataque" .. GAP .. NUM .. "%%", "HASTE" },
        { "celeridad" .. GAP .. NUM .. "%%", "HASTE" },
    }

    local names = {
        ["fuerza"] = "STRENGTH", ["agilidad"] = "AGILITY", ["aguante"] = "STAMINA",
        ["intelecto"] = "INTELLECT", ["espíritu"] = "SPIRIT", ["todas las estadísticas"] = P.AddAllStats,
        ["armadura"] = "ARMOR", ["bloquear"] = "BLOCK_VALUE", ["bloqueo"] = "BLOCK_VALUE",
        ["% bloquear"] = "BLOCK", ["% bloqueo"] = "BLOCK", ["valor de bloqueo"] = "BLOCK_VALUE",
        ["defensa"] = "DEFENSE", ["esquivar"] = "DODGE", ["% esquivar"] = "DODGE",
        ["parar"] = "PARRY", ["% parar"] = "PARRY",
        ["poder de ataque"] = "ATTACK_POWER", ["poder de ataque a distancia"] = "RANGED_AP",
        ["golpe"] = "HIT", ["índice de golpe"] = P.Rating("HIT"),
        ["crítico"] = "CRIT", ["golpe crítico"] = "CRIT", ["índice de golpe crítico"] = P.Rating("CRIT"),
        ["celeridad"] = "HASTE", ["índice de celeridad"] = P.Rating("HASTE"),
        ["pericia"] = "EXPERTISE", ["poder con hechizos"] = P.AddSpellPower,
        ["daño con hechizos"] = "SPELL_DAMAGE", ["curación"] = P.AddHealing, ["sanación"] = P.AddHealing,
        ["maná cada 5 s"] = "MP5", ["salud cada 5 s"] = "HP5",
        ["penetración de hechizos"] = "SPELL_PEN", ["todas las resistencias"] = P.AddAllResistances,
        ["resistencia arcano"] = "ARCANE_RES", ["resistencia fuego"] = "FIRE_RES",
        ["resistencia escarcha"] = "FROST_RES", ["resistencia naturaleza"] = "NATURE_RES",
        ["resistencia sombras"] = "SHADOW_RES",
    }

    local skip = {
        "uso:", "probabilidad al acertar:", "probabilidad al golpear:", "conjunto:",
        "requiere", "necesitas", "clases:", "razas:", "durabilidad", "nivel de objeto",
        "precio de venta", "único", "única", "se liga", "ligado", "\"",
    }

    local words = {
        equip = "^equipar: (.+)$",
        classes = "^clases: (.+)$",
        set = "^%(%d+%) conjunto",
        range = { "^" .. NUM .. " %- " .. NUM .. " [%a ]-daño" },
        flat = { "^" .. NUM .. " [%a ]-daño$" },
        dps = "%(?" .. NUM .. " daño por segundo",
        speed = "^velocidad " .. NUM,
        negative = { "^reduce", "^disminuye" },
        also = " y tu ",
        plus = " y ",
        name = function(name)
            name = name:gsub("^p%. ", ""):gsub("^de ", "")
            name = name:gsub("^resistencia a la ", "resistencia "):gsub("^resistencia al ", "resistencia ")
                :gsub("^resistencia a ", "resistencia ")
            return name
        end,
        looseNumbers = true,
    }

    return { rules = rules, names = names, skip = skip, words = words }
end
