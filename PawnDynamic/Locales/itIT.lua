-- PawnDynamic (MIT License)
-- Italian localization (itIT).

local _, ns = ...

local locale = ns:NewLocale("itIT")
if not locale then
    return
end

local L = locale.strings

L["Attributes"] = "Attributi"
L["Offense"] = "Attacco"
L["Weapon damage"] = "Danno arma"
L["Spells"] = "Incantesimi"
L["Defense"] = "Difesa"
L["Resistances"] = "Resistenze"
L["Armor types"] = "Tipi di armatura"
L["Weapon types"] = "Tipi di arma"

L["Strength"] = "Forza"
L["Agility"] = "Agilità"
L["Stamina"] = "Tempra"
L["Intellect"] = "Intelletto"
L["Spirit"] = "Spirito"
L["Attack power"] = "Potenza d'attacco"
L["Ranged attack power"] = "Potenza d'attacco a distanza"
L["Feral attack power"] = "Potenza d'attacco ferina"
L["Hit %"] = "Impatto %"
L["Crit %"] = "Critico %"
L["Expertise %"] = "Perizia %"
L["Weapon skill"] = "Abilità con le armi"
L["Haste %"] = "Celerità %"
L["Armor penetration"] = "Penetrazione armatura"
L["Main-hand DPS"] = "DPS mano primaria"
L["Main-hand min damage"] = "Danno min mano primaria"
L["Main-hand max damage"] = "Danno max mano primaria"
L["Main-hand hit damage"] = "Colpo medio mano primaria"
L["Main-hand speed"] = "Velocità mano primaria"
L["Off-hand DPS"] = "DPS mano secondaria"
L["Off-hand speed"] = "Velocità mano secondaria"
L["Ranged / wand DPS"] = "DPS a distanza / bacchetta"
L["Ranged min damage"] = "Danno min a distanza"
L["Ranged max damage"] = "Danno max a distanza"
L["Ranged hit damage"] = "Colpo medio a distanza"
L["Ranged speed"] = "Velocità a distanza"
L["Speed baseline"] = "Base velocità"
L["Spell damage"] = "Danno magico"
L["Healing"] = "Cure"
L["Arcane damage"] = "Danno Arcano"
L["Fire damage"] = "Danno da Fuoco"
L["Frost damage"] = "Danno da Gelo"
L["Nature damage"] = "Danno da Natura"
L["Shadow damage"] = "Danno da Ombra"
L["Holy damage"] = "Danno Sacro"
L["Mana per 5 sec"] = "Mana ogni 5 sec"
L["Spell penetration"] = "Penetrazione magica"
L["Armor"] = "Armatura"
L["Defense"] = "Difesa"
L["Dodge %"] = "Schivata %"
L["Parry %"] = "Parata %"
L["Block %"] = "Blocco %"
L["Block value"] = "Valore di blocco"
L["Health per 5 sec"] = "Salute ogni 5 sec"
L["Resilience"] = "Resilienza"
L["All resistances"] = "Tutte le resistenze"
L["Arcane resistance"] = "Resistenza all'Arcano"
L["Fire resistance"] = "Resistenza al Fuoco"
L["Frost resistance"] = "Resistenza al Gelo"
L["Nature resistance"] = "Resistenza alla Natura"
L["Shadow resistance"] = "Resistenza all'Ombra"
L["Include Raid Resistance Buff (+60)"] = "Includi bonus resistenza incursione (+60)"
L["Scale % stats by level (< 60)"] = "Scala % per livello (< 60)"
L["Scale % stats by level tooltip"] = "Scala proporzionalmente le statistiche percentuali (Critico %, Impatto %, Celerità %, Maestria %, Abilità armi, Difesa, Schivata %, Parata %, Blocco %) sotto il livello 60 (fattore Livello / 60, 100 % al livello 60). Disattiva per usare sempre i pesi completi durante la crescita."
L["Raid resistance buff tooltip"] = "Aggiunge +60 resistenza da Aure di Paladino, Totem di Sciamano, Aspetto della Natura o Protezione dall'Ombra quando prepari set senza buff. Torna automaticamente a 0 quando il relativo bonus è attivo su di te (nessun doppio conteggio). Tonici, juju e pozioni attivi sono rilevati automaticamente."

L["Cloth"] = "Stoffa"
L["Leather"] = "Cuoio"
L["Mail"] = "Maglia"
L["Plate"] = "Piastre"
L["Shield"] = "Scudo"
L["1H Axe"] = "Ascia 1M"
L["2H Axe"] = "Ascia 2M"
L["Bow"] = "Arco"
L["Crossbow"] = "Balestra"
L["Dagger"] = "Pugnale"
L["Fist weapon"] = "Tirapugni"
L["Gun"] = "Arma da fuoco"
L["1H Mace"] = "Mazza 1M"
L["2H Mace"] = "Mazza 2M"
L["Polearm"] = "Arma ad asta"
L["Relic"] = "Reliquia"
L["Staff"] = "Bastone"
L["1H Sword"] = "Spada 1M"
L["2H Sword"] = "Spada 2M"
L["Thrown weapon"] = "Arma da lancio"
L["Wand"] = "Bacchetta"
L["Off-hand weapon"] = "Arma mano secondaria"
L["Off-hand frill"] = "Oggetto mano secondaria"

L["Scale"] = "Profilo"
L["Weights"] = "Pesi"
L["Caps & Dynamics"] = "Cap e Dinamica"
L["Compare"] = "Confronta"
L["Options"] = "Opzioni"
L["Getting started / About"] = "Guida / Info"

L["My scales"] = "I miei profili"
L["Other scales"] = "Altri profili"
L["Starter templates"] = "Modelli iniziali"
L["Automatic"] = "Automatico"
L["Manual"] = "Manuale"
L["Auto follows your active talent tree."] = "Automatico segue l'albero dei talenti attivo."
L["Manual lets you enable and customize multiple profiles."] = "Manuale consente di attivare più profili contemporaneamente."
L["Show this scale in tooltips"] = "Mostra nel tooltip"
L["Rename"] = "Rinomina"
L["Delete"] = "Elimina"
L["Type \"%s\" to confirm deletion:"] = "Digita \"%s\" per confermare:"
L["DELETE_CONFIRM_WORD"] = "ELIMINA"
L["Type \"%s\" to permanently delete profile \"%s\":"] = "Digita \"%s\" per eliminare definitivamente il profilo \"%s\":"
L["Change color"] = "Cambia colore"
L["Reset defaults"] = "Ripristina"
L["Import"] = "Importa"
L["Export"] = "Esporta"
L["Export all"] = "Esporta tutto"
L["New"] = "Nuovo"
L["From template"] = "Da modello"
L["Copy"] = "Copia"
L["Read-only template"] = "Modello predefinito (crea una copia per personalizzare)"
L["Custom scale"] = "Profilo personalizzato"
L["No scale selected"] = "Nessun profilo selezionato"
L["OK"] = "OK"
L["Cancel"] = "Annulla"
L["Create"] = "Crea"
L["Close"] = "Chiudi"

L["Live Character Stats & Cap Status"] = "Statistiche live e stato dei cap"
L["Profile Cap Configuration"] = "Configurazione cap del profilo"
L["Cap engine active"] = "Motore dei cap attivo"
L["Talent integration active"] = "Integrazione talenti attiva"
L["Tank mode"] = "Modalità Difensore"
L["Target enemy level"] = "Livello nemico bersaglio"
L["Even level (+0)"] = "Pari livello (+0)"
L["Dungeon boss (+2)"] = "Boss spedizione (+2)"
L["Raid boss (+3)"] = "Boss incursione (+3)"
L["Hit mode"] = "Modalità impatto"
L["Melee"] = "Mischia"
L["Spell"] = "Incantesimi"
L["Avoidance detail format"] = "Manc %.1f%% · Schiv %.1f%% · Par %.1f%% · Bloc %.1f%%"
L["Avoidance detail offset format"] = "Manc %.1f%% · Schiv %.1f%% · Par %.1f%% · Bloc %.1f%% (+%.0f%%)"
L["Stat Prio Generator"] = "Generatore priorità"
L["Profile name:"] = "Nome profilo:"
L["Role:"] = "Ruolo:"
L["Tank"] = "Difensore"
L["Melee DPS"] = "DPS Mischia"
L["Ranged DPS"] = "DPS Distanza"
L["Caster DPS"] = "DPS Magico"
L["Healer"] = "Curatore"
L["Load default prio"] = "Carica predefiniti"
L["Available stats"] = "Statistiche disponibili"
L["Your priority (1 = highest)"] = "La tua priorità (1 = max)"
L["Calculated weights preview"] = "Anteprima pesi calcolati"
L["Create as new profile"] = "Crea nuovo profilo"
L["Apply to current profile"] = "Applica al profilo attuale"
L["[Synergy]"] = "[Sinergia]"
L["[Base]"] = "[Base]"
L["Prio list is empty."] = "Aggiungi almeno una statistica."
L["Target: %s (Level %d)"] = "Bersaglio: %s (Livello %d)"
L["Hit cap (%)"] = "Cap Impatto (%)"
L["Spell hit cap (%)"] = "Cap Impatto magico (%)"
L["Defense (Crit immune)"] = "Difesa (Immunità critici)"
L["Expertise cap (%)"] = "Cap Maestria (%)"
L["Armor cap (75% DR)"] = "Cap Armatura (75% Rid.)"
L["Avoidance (Uncrushable)"] = "Elusione (Immunità schiacciamento)"
L["Haste cap (GCD)"] = "Cap Celerità (GCD)"
L["Dual-wield auto-detected"] = "Doppia arma rilevata automaticamente"
L["Optional Spirit Target (0 = no limit)"] = "Obiettivo Spirito opzionale (0 = nessun limite)"
L["Spirit target tooltip"] = "Lo Spirito non ha un cap fisso in gioco. Puoi inserire un obiettivo personale per la rigenerazione mana (es. 300 per curatori). Oltre questo valore lo Spirito viene ridotto sugli oggetti. Lascia 0 per mantenere il peso completo."
L["Note: Shift into Bear Form when comparing items for an accurate 75% armor cap calculation."] = "Nota: Trasformati in Forma d'Orso durante il confronto degli oggetti per un calcolo preciso del cap armatura al 75%."
L["Current:"] = "Attuale:"
L["Active talents:"] = "Talenti attivi:"
L["Under cap"] = "Sotto il cap"
L["Cap reached (reduced)"] = "Cap raggiunto (ridotto)"
L["Cap reached (weight = 0)"] = "Cap raggiunto (peso = 0)"
L["Not active"] = "Non attivo"
L["Automatic cap mechanics note"] = "Tutti i cap meccanici (Impatto, Difesa, Maestria, Armatura, Elusione, Doppia arma e Celerità) vengono calcolati automaticamente in base al livello, al bersaglio, alle armi e ai talenti/buff attivi."
L["Compare items for %s"] = "Confronta oggetti (%s)"
L["Tooltip display"] = "Visualizzazione tooltip"
L["Only show upgrades"] = "Mostra solo miglioramenti"
L["Show values and upgrades"] = "Mostra valori e miglioramenti"
L["Show only values"] = "Mostra solo valori"
L["%s upgrade"] = "%s miglioramento"
L["upgrade - %s"] = "miglioramento - %s"
L["%s with %s"] = "%s con %s"
L["fills an empty slot"] = "riempie slot vuoto"
L["+%s points"] = "+%s punti"
L["replaces zero-score item"] = "sostituisce oggetto senza valore"
L["Main hand"] = "Mano primaria"
L["Off hand"] = "Mano secondaria"
L["replaces: %s"] = "sostituisce: %s"
L["%s to off hand"] = "%s → Mano secondaria"
L["Enter profile name:"] = "Inserisci nome profilo:"
L["Enter new name for %s:"] = "Nuovo nome per %s:"
L["Enter name for copy of %s:"] = "Nome per la copia di %s:"
L["Paste Pawn v1 string:"] = "Incolla stringa Pawn v1:"
L["Copy Pawn v1 string (Ctrl+C):"] = "Copia stringa Pawn v1 (Ctrl+C):"
L["Choose class & template:"] = "Scegli classe e modello:"
L["Overwrite existing scale?"] = "Sovrascrivere il profilo esistente?"
L["Stat weights for %s"] = "Pesi statistiche per %s"
L["Yellow values are customized."] = "I valori in giallo sono personalizzati."
L["Normalize values (like Wowhead)"] = "Normalizza valori (come Wowhead)"
L["Hide 1H upgrades"] = "Nascondi miglioramenti 1M"
L["Hide 2H upgrades"] = "Nascondi miglioramenti 2M"
L["Unusable armor & weapon types"] = "Tipi di armatura e armi inutilizzabili"
L["Unusable"] = "Inutilizzabile"
L["Select a stat or edit values directly. Press Tab for next row."] = "Modifica i pesi direttamente. Premi Tab per il campo successivo."
L["Clear value"] = "Cancella valore"
L["Left item"] = "Oggetto sinistro"
L["Right item"] = "Oggetto destro"
L["Load equipped"] = "Carica equipaggiato"
L["‹ Swap ›"] = "‹ Scambia ›"
L["Clear"] = "Pulisci"
L["Drop an item or paste an item link / ID below, or pick from equipped / bags:"] = "Trascina un oggetto, incolla link/ID o scegli da equipaggiamento / borse:"
L["Pick from equipped"] = "Dall'equipaggiamento"
L["Pick from bags"] = "Dalle borse"
L["Stat"] = "Statistica"
L["Raw EP"] = "EP base"
L["Effective (Cap Delta)"] = "Effettivo (Delta Cap)"
L["Difference"] = "Differenza"
L["Total Base Score"] = "Punteggio base totale"
L["Cap-Adjusted Score"] = "Punteggio con Cap"
L["Net Cap Loss"] = "Perdita netta Cap"
L["Verdict"] = "Verdetto"
L["Empty slot"] = "Slot vuoto"
L["Upgrade: %s"] = "Miglioramento: %s"
L["Downgrade: %s"] = "Peggioramento: %s"
L["Equal"] = "Uguale"
L["Show current (enchanted) & base values"] = "Mostra valori attuali (incantati) e base"
L["Align tooltip values right"] = "Allinea valori a destra nel tooltip"
L["Add blank line before values"] = "Aggiungi riga vuota prima dei valori"
L["Color tooltip border on upgrades"] = "Colora bordo tooltip per i miglioramenti"
L["Healing-to-SpellDamage fallback (1/3)"] = "Conversione Cure in Danno Magico (1/3)"
L["Advisors & Bags"] = "Consigli e Borse"
L["Bag upgrade arrows"] = "Frecce miglioramento nelle borse"
L["Quest reward arrows & gold coin"] = "Frecce ricompense missione e moneta d'oro"
L["Loot roll advisor"] = "Consigliere tiri bottino"
L["Announce bag upgrades in chat"] = "Annuncia miglioramenti borse in chat"
L["Dagger build (main hand only)"] = "Configurazione pugnale (solo mano primaria)"
L["Character panel button"] = "Pulsante finestra personaggio"
L["Right"] = "Destra"
L["Left"] = "Sinistra"
L["Hidden"] = "Nascosto"
L["Diagnostics"] = "Diagnostica"
L["Debug mode"] = "Modalità debug"
L["Rescan & wipe caches"] = "Scansiona e svuota cache"
L["[Cap]"] = "[Cap]"
L["Base:"] = "Base:"
L["Total gear score"] = "Punteggio totale equipaggiamento"
L["Click to open PawnDynamic"] = "Clicca per aprire PawnDynamic"
L["[%s] New upgrade: %s (%s)"] = "[%s] Nuovo miglioramento: %s (%s)"
L["%d upgrade in your bags - /pd scan to list."] = "%d miglioramento nelle borse - /pd scan per la lista."
L["%d upgrades in your bags - /pd scan to list."] = "%d miglioramenti nelle borse - /pd scan per la lista."
L["No upgrades found in your bags."] = "Nessun miglioramento trovato nelle borse."
L["Items are still loading - try again shortly."] = "Oggetti in caricamento - riprova tra poco."
L["Saved %d item - /reload to write to disk."] = "%d oggetto salvato - /reload per scrivere su disco."
L["Saved %d items - /reload to write to disk."] = "%d oggetti salvati - /reload per scrivere su disco."
L["PawnDynamic did not finish initializing."] = "PawnDynamic non ha completato l'inizializzazione."
L["Debug mode enabled."] = "Modalità debug attivata."
L["Debug mode disabled."] = "Modalità debug disattivata."
L["Caches cleared and data refreshed."] = "Cache svuotate e dati aggiornati."
L["|cffff4040Error:|r %s (see /pd status)"] = "|cffff4040Errore:|r %s (vedi /pd status)"
L["Commands: /pd (toggle UI) | /pd status | /pd scan | /pd debug [on|off|link] | /pd dump | /pd refresh"] =
    "Comandi: /pd (apri/chiudi) | /pd status | /pd scan | /pd debug [on|off|link] | /pd dump | /pd refresh"
L["Shift+Click: Toggle Tooltip"] = "Maiusc+Clic: Attiva/disattiva tooltip"

-- Getting started / About Tab
L["ABOUT_CREDITS"] = "Autore: Behmen  |  Licenza: MIT License (100% Lua Clean-Room, senza XML)"
L["ABOUT_CAP_TITLE"] = "|cff00d1ff1. Motore dinamico dei cap (Delta):|r"
L["ABOUT_CAP_INTRO"] = "Prima di valutare un oggetto, PawnDynamic sottrae le statistiche dell'oggetto equipaggiato dal totale del personaggio e calcola il sostituto rispetto ai tuoi cap:"
L["ABOUT_CAP_FORMULA"] = "Valore effettivo = f(StatsPg - VecchioOgg + NuovoOgg) - f(StatsPg - VecchioOgg)"
L["ABOUT_CAP_TARGET"] = "Livello nemico (+0 / +2 / +3 o Automatico): Formule esatte per Impatto (5% / 6% / 8%), Impatto magico (4% / 6% / 17%), Difesa immunità critici (Liv*5 + 125/135/140), Maestria (5% / 5,5% / 6,5%, Difensori fino a 14%) e Armatura (75% rid.)."
L["ABOUT_CAP_AVOIDANCE"] = "Elusione (Immunità schiacciamento 100% / 101,6% / 102,4%): Raggiunto il cap di Mancato + Schivata + Parata + Blocco, solo il blocco scende a 0; Schivata e Parata mantengono il peso (classi con scudo)."
L["ABOUT_CAP_REDUCTION"] = "Riduzione automatica oltre il cap: Doppia arma (rilevata auto.) scala l'impatto bianco fino a 24-27% e Celerità continua con peso ridotto oltre il cap GCD del 50%."
L["ABOUT_CAP_DRUID"] = "Nota per i Druidi: Trasformati in Forma d'Orso durante il confronto per calcolare esattamente il cap armatura del 75%."
L["ABOUT_TALENTS_TITLE"] = "|cff00d1ff2. Talenti e Buff live (C_Traits + UNIT_AURA):|r"
L["ABOUT_TALENTS_DESC"] = "Rileva i talenti indipendentemente dalla lingua tramite spellID / nodeID, aggiorna buff come Scudo Sacro in tempo reale senza doppio conteggio e include i talenti di impatto per scuola."
L["ABOUT_PAWN_TITLE"] = "|cff00d1ff3. Compatibilità Pawn v1:|r"
L["ABOUT_PAWN_DESC"] = "Importazione ed esportazione completa di stringhe classiche Pawn v1 nella scheda 'Profilo'."
L["ABOUT_COMMANDS_TITLE"] = "|cff00d1ff4. Comandi Slash:|r"
L["ABOUT_CMD_PD"] = "/pd  o  /pawndynamic — Apri/chiudi finestra"
L["ABOUT_CMD_STATUS"] = "/pd status — Statistiche live, cap, talenti e registro errori"
L["ABOUT_CMD_SCAN"] = "/pd scan — Elenca miglioramenti nelle borse in chat"
L["ABOUT_CMD_DEBUG"] = "/pd debug [Link] — Analisi dettagliata tooltip e statistiche"
L["ABOUT_CMD_DUMP"] = "/pd dump — Salva valori letti in SavedVariables per segnalazioni"
L["ABOUT_CMD_REFRESH"] = "/pd refresh — Svuota le cache e ricalcola tutto"

locale.scales = {
    WARRIOR = { ARMS = { name = "Armi", match = "armi" }, FURY = { name = "Furia", match = "furia" }, PROTECTION = { name = "Protezione", match = "protez" } },
    PALADIN = { HOLY = { name = "Sacro", match = "sacro" }, PROTECTION = { name = "Protezione", match = "protez" }, RETRIBUTION = { name = "Castigo", match = "castigo" } },
    HUNTER = { BEAST_MASTERY = { name = "Affinità Animale", match = "animale" }, MARKSMANSHIP = { name = "Precisione", match = "precisione" }, SURVIVAL = { name = "Sopravvivenza", match = "soprav" } },
    ROGUE = { ASSASSINATION = { name = "Assassinio", match = "assassinio" }, COMBAT = { name = "Combattimento", match = "combattimento" }, SUBTLETY = { name = "Scaltrezza", match = "scaltrezza" } },
    PRIEST = { DISCIPLINE = { name = "Disciplina", match = "disciplina" }, HOLY = { name = "Sacro", match = "sacro" }, SHADOW = { name = "Ombra", match = "ombra" }, SMITE = { name = "Punizione" } },
    SHAMAN = { ELEMENTAL = { name = "Elementale", match = "elementale" }, ENHANCEMENT = { name = "Potenziamento", match = "potenziamento" }, RESTORATION = { name = "Rigenerazione", match = "rigenerazione" } },
    MAGE = { ARCANE = { name = "Arcano", match = "arcano" }, FIRE = { name = "Fuoco", match = "fuoco" }, FROST = { name = "Gelo", match = "gelo" } },
    WARLOCK = { AFFLICTION = { name = "Afflizione", match = "afflizione" }, DEMONOLOGY = { name = "Demonologia", match = "demonologia" }, DESTRUCTION = { name = "Distruzione", match = "distruzione" } },
    DRUID = { BALANCE = { name = "Equilibrio", match = "equilibrio" }, FERAL_CAT = { name = "Aggressore Ferino", match = "ferino" }, FERAL_BEAR = { name = "Guardiano Ferino" }, RESTORATION = { name = "Rigenerazione", match = "rigenerazione" } },
}

locale.grammar = function(P)
    local NUM, UNREAD, Add = P.NUM, P.UNREAD, P.Add
    local GAP = "[^%d]-"
    local rules = {
        { "quando combatti", false }, { " contro ", false }, { " per %d+ s", false }, { "probabilità di", false },
        { "valore di blocco" .. GAP .. NUM, "BLOCK_VALUE" },
        { "penetrazione magica" .. GAP .. NUM, "SPELL_PEN" },
        { "colpo critico" .. GAP .. NUM .. "%%", "CRIT" },
        { "impatto" .. GAP .. NUM .. "%%", "HIT" },
        { "schivati o parati" .. GAP .. NUM .. "%%", "EXPERTISE", true },
        { "perizia" .. GAP .. NUM, "EXPERTISE" },
        { "schivare" .. GAP .. NUM .. "%%", "DODGE" },
        { "parare" .. GAP .. NUM .. "%%", "PARRY" },
        { "bloccare" .. GAP .. NUM .. "%%", "BLOCK" },
        { "difesa" .. GAP .. NUM, "DEFENSE" },
        { "danni e le cure degli incantesimi" .. GAP .. NUM, P.AddSpellPower },
        { "cure degli incantesimi" .. GAP .. NUM, P.AddHealing },
        { "danni degli incantesimi" .. GAP .. NUM, "SPELL_DAMAGE" },
        { "potenza magica" .. GAP .. NUM, P.AddSpellPower },
        { NUM .. GAP .. "mana ogni 5 s", "MP5" },
        { NUM .. GAP .. "salute ogni 5 s", "HP5" },
        { "potenza d'attacco a distanza" .. GAP .. NUM, "RANGED_AP" },
        { "potenza d'attacco" .. GAP .. NUM, "ATTACK_POWER" },
        { "celerità" .. GAP .. NUM .. "%%", "HASTE" },
    }
    local names = {
        ["forza"] = "STRENGTH", ["agilità"] = "AGILITY", ["tempra"] = "STAMINA",
        ["intelletto"] = "INTELLECT", ["spirito"] = "SPIRIT", ["armatura"] = "ARMOR",
        ["blocco"] = "BLOCK_VALUE", ["% blocco"] = "BLOCK", ["valore di blocco"] = "BLOCK_VALUE",
        ["difesa"] = "DEFENSE", ["schivata"] = "DODGE", ["parata"] = "PARRY",
        ["potenza d'attacco"] = "ATTACK_POWER", ["indice d'impatto"] = P.Rating("HIT"),
        ["indice di critico"] = P.Rating("CRIT"), ["indice di celerità"] = P.Rating("HASTE"),
        ["perizia"] = "EXPERTISE", ["potenza magica"] = P.AddSpellPower,
        ["tutte le resistenze"] = P.AddAllResistances,
    }
    local skip = { "usa:", "equipaggiato:", "set:", "richiede", "classi:", "razze:", "integrità", "livello oggetto", "prezzo", "unico", "vincolato", "\"" }
    local words = {
        equip = "^equipaggia: (.+)$", classes = "^classi: (.+)$", set = "^%(%d+%) set",
        range = { "^" .. NUM .. " %- " .. NUM .. " danni" }, flat = { "^" .. NUM .. " danni$" },
        dps = "%(?" .. NUM .. " danni al secondo", speed = "^velocità " .. NUM,
        negative = { "^riduce", "^diminuisce" }, also = " e ", plus = " e ", looseNumbers = true,
    }
    return { rules = rules, names = names, skip = skip, words = words }
end
