-- PawnDynamic (MIT License)
-- German localization (deDE) with full WoW Classic Forever & Classic Era tooltip rules.

local _, ns = ...

local locale = ns:NewLocale("deDE")
if not locale then
    return
end

local L = locale.strings

-- Categories & Stat Names
L["Attributes"] = "Attribute"
L["Offense"] = "Angriff"
L["Weapon damage"] = "Waffenschaden"
L["Spells"] = "Zauber"
L["Defense"] = "Verteidigung"
L["Resistances"] = "Widerstände"
L["Armor types"] = "Rüstungstypen"
L["Weapon types"] = "Waffentypen"

L["Strength"] = "Stärke"
L["Agility"] = "Beweglichkeit"
L["Stamina"] = "Ausdauer"
L["Intellect"] = "Intelligenz"
L["Spirit"] = "Willenskraft"
L["Attack power"] = "Angriffskraft"
L["Ranged attack power"] = "Distanzangriffskraft"
L["Feral attack power"] = "Wilde Angriffskraft"
L["Hit %"] = "Trefferchance %"
L["Crit %"] = "Kritisch %"
L["Expertise %"] = "Waffenkunde %"
L["Weapon skill"] = "Waffenfertigkeit"
L["Haste %"] = "Tempo %"
L["Armor penetration"] = "Rüstungsdurchschlag"
L["Main-hand DPS"] = "Waffenhand DPS"
L["Main-hand min damage"] = "Waffenhand Min-Schaden"
L["Main-hand max damage"] = "Waffenhand Max-Schaden"
L["Main-hand hit damage"] = "Waffenhand Ø-Treffer"
L["Main-hand speed"] = "Waffenhand Tempo"
L["Off-hand DPS"] = "Nebenhand DPS"
L["Off-hand speed"] = "Nebenhand Tempo"
L["Ranged / wand DPS"] = "Fernkampf / Zauberstab DPS"
L["Ranged min damage"] = "Fernkampf Min-Schaden"
L["Ranged max damage"] = "Fernkampf Max-Schaden"
L["Ranged hit damage"] = "Fernkampf Ø-Treffer"
L["Ranged speed"] = "Fernkampf Tempo"
L["Speed baseline"] = "Tempogrundwert"
L["Spell damage"] = "Zauberschaden"
L["Healing"] = "Heilung"
L["Arcane damage"] = "Arkanschaden"
L["Fire damage"] = "Feuerschaden"
L["Frost damage"] = "Frostschaden"
L["Nature damage"] = "Naturschaden"
L["Shadow damage"] = "Schattenschaden"
L["Holy damage"] = "Heiligschaden"
L["Mana per 5 sec"] = "Mana alle 5 Sek."
L["Spell penetration"] = "Zauberdurchschlag"
L["Armor"] = "Rüstung"
L["Defense"] = "Verteidigung"
L["Dodge %"] = "Ausweichen %"
L["Parry %"] = "Parieren %"
L["Block %"] = "Blocken %"
L["Block value"] = "Blockwert"
L["Health per 5 sec"] = "Gesundheit alle 5 Sek."
L["Resilience"] = "Abhärtung"
L["All resistances"] = "Alle Widerstände"
L["Arcane resistance"] = "Arkanwiderstand"
L["Fire resistance"] = "Feuerwiderstand"
L["Frost resistance"] = "Frostwiderstand"
L["Nature resistance"] = "Naturwiderstand"
L["Shadow resistance"] = "Schattenwiderstand"

L["Cloth"] = "Stoff"
L["Leather"] = "Leder"
L["Mail"] = "Schwere Rüstung"
L["Plate"] = "Platte"
L["Shield"] = "Schild"
L["1H Axe"] = "Einhandaxt"
L["2H Axe"] = "Zweihandaxt"
L["Bow"] = "Bogen"
L["Crossbow"] = "Armbrust"
L["Dagger"] = "Dolch"
L["Fist weapon"] = "Faustwaffe"
L["Gun"] = "Schusswaffe"
L["1H Mace"] = "Einhandstreitkolben"
L["2H Mace"] = "Zweihandstreitkolben"
L["Polearm"] = "Stangenwaffe"
L["Relic"] = "Relikt"
L["Staff"] = "Stab"
L["1H Sword"] = "Einhandschwert"
L["2H Sword"] = "Zweihandschwert"
L["Thrown weapon"] = "Wurfwaffe"
L["Wand"] = "Zauberstab"
L["Off-hand weapon"] = "Schildhandwaffe"
L["Off-hand frill"] = "Schildhand-Gegenstand"

-- 6 Tabs
L["Scale"] = "Bewertungsprofil"
L["Weights"] = "Gewichtung"
L["Caps & Dynamics"] = "Caps & Dynamik"
L["Compare"] = "Vergleichen"
L["Options"] = "Optionen"
L["Getting started / About"] = "Los geht's / Über"

-- UI General & Scales Tab
L["My scales"] = "Eigene Wertungen"
L["Other scales"] = "Andere Wertungen"
L["Starter templates"] = "Starter-Vorlagen"
L["Automatic"] = "Automatisch"
L["Manual"] = "Manuell"
L["Auto follows your active talent tree."] = "Automatisch folgt dem Profil deines aktiven Talentbaums."
L["Manual lets you enable and customize multiple profiles."] = "Manuell erlaubt das gleichzeitige Aktivieren mehrerer benutzerdefinierter Profile."
L["Show this scale in tooltips"] = "Im Tooltip anzeigen"
L["Rename"] = "Umbenennen"
L["Delete"] = "Löschen"
L["Change color"] = "Farbe ändern"
L["Reset defaults"] = "Standard wiederherstellen"
L["Import"] = "Importieren"
L["Export"] = "Exportieren"
L["Export all"] = "Alle exportieren"
L["New"] = "Neues"
L["From template"] = "Vorlage"
L["Copy"] = "Kopieren"
L["Read-only template"] = "Starter-Vorlage (für freie Anpassung Kopie erstellen oder Werte lokal anpassen)"
L["Custom scale"] = "Benutzerdefiniertes Profil"
L["No scale selected"] = "Kein Profil ausgewählt"
L["Enter profile name:"] = "Namen für das neue Profil eingeben:"
L["Enter new name for %s:"] = "Neuen Namen für %s eingeben:"
L["Enter name for copy of %s:"] = "Namen für Kopie von %s eingeben:"
L["Type \"%s\" to confirm deletion:"] = "Gib \"%s\" zum Bestätigen ein:"
L["DELETE_CONFIRM_WORD"] = "LÖSCHEN"
L["Type \"%s\" to permanently delete profile \"%s\":"] = "Gib \"%s\" ein, um das Profil \"%s\" endgültig zu löschen:"
L["Paste Pawn v1 string:"] = "Pawn-v1-String einfügen:"
L["Copy Pawn v1 string (Ctrl+C):"] = "Pawn-v1-String kopieren (Strg+C):"
L["Choose class & template:"] = "Klasse & Vorlage wählen:"
L["Overwrite existing scale?"] = "Vorhandenes Profil überschreiben?"
L["OK"] = "OK"
L["Cancel"] = "Abbrechen"
L["Create"] = "Erstellen"
L["Close"] = "Schließen"

-- Weights Tab
L["Stat weights for %s"] = "Werte-Gewichtung für %s"
L["Yellow values are customized."] = "Gelbe Werte wurden von dir angepasst."
L["Normalize values (like Wowhead)"] = "Werte normalisieren (wie Wowhead)"
L["Hide 1H upgrades"] = "1H-Verbesserungen ausblenden"
L["Hide 2H upgrades"] = "2H-Verbesserungen ausblenden"
L["Unusable armor & weapon types"] = "Unbenutzbare Rüstungs- & Waffentypen"
L["Unusable"] = "Unbenutzbar"
L["Select a stat or edit values directly. Press Tab for next row."] = "Werte direkt bearbeiten. Tab springt zum nächsten Feld."
L["Clear value"] = "Wert löschen"

-- Caps & Dynamics Tab
L["Live Character Stats & Cap Status"] = "Live-Charakterwerte & Cap-Fortschritt"
L["Profile Cap Configuration"] = "Cap-Konfiguration des Profils"
L["Cap engine active"] = "Cap-Engine aktiv"
L["Talent integration active"] = "Talent-Integration aktiv"
L["Tank mode"] = "Tank-Modus"
L["Include Raid Resistance Buff (+60)"] = "Raid-Widerstandsbuff (+60) einrechnen"
L["Raid resistance buff tooltip"] = "Rechnet +60 Widerstand durch Paladin-Auren, Schamanen-Totems, Aspekt der Wildnis oder Schattenschutz für ungebuffte Ausrüstungs-Sets ein. Sobald der entsprechende Raid-Buff auf dir aktiv ist, fällt dieser Offset automatisch auf 0 (keine Doppelzählung). Aktive Fläschchen, Jujus und Tränke werden automatisch erfasst."
L["Target enemy level"] = "Ziel-Gegnerstufe"
L["Even level (+0)"] = "Gleichstufig (+0)"
L["Dungeon boss (+2)"] = "Dungeon-Boss (+2)"
L["Raid boss (+3)"] = "Raid-Boss (+3)"
L["Hit mode"] = "Treffer-Modus"
L["Melee"] = "Nahkampf"
L["Spell"] = "Zauber"
L["Avoidance detail format"] = "Verf %.1f%% · Ausw %.1f%% · Par %.1f%% · Blk %.1f%%"
L["Avoidance detail offset format"] = "Verf %.1f%% · Ausw %.1f%% · Par %.1f%% · Blk %.1f%% (+%.0f%%)"
L["Stat Prio Generator"] = "Stat-Prio-Generator"
L["Profile name:"] = "Profilname:"
L["Role:"] = "Rolle:"
L["Tank"] = "Tank"
L["Melee DPS"] = "Nahkampf-DPS"
L["Ranged DPS"] = "Fernkampf-DPS"
L["Caster DPS"] = "Zauber-DPS"
L["Healer"] = "Heiler"
L["Load default prio"] = "Standard-Prio laden"
L["Available stats"] = "Verfügbare Stats"
L["Your priority (1 = highest)"] = "Deine Priorität (1 = höchste)"
L["Calculated weights preview"] = "Berechnete Gewichtungen"
L["Create as new profile"] = "Als neues Profil erstellen"
L["Apply to current profile"] = "Auf aktuelles Profil anwenden"
L["[Synergy]"] = "[Synergie]"
L["[Base]"] = "[Basis]"
L["Prio list is empty."] = "Bitte mindestens einen Stat in die Prioritätenliste aufnehmen."
L["Target: %s (Level %d)"] = "Ziel: %s (Stufe %d)"
L["Hit cap (%)"] = "Treffer-Cap (%)"
L["Spell hit cap (%)"] = "Zaubertreffer-Cap (%)"
L["Defense (Crit immune)"] = "Verteidigung (Krit-Immun)"
L["Expertise cap (%)"] = "Waffenkunde-Cap (%)"
L["Armor cap (75% DR)"] = "Rüstungs-Cap (75% DR)"
L["Avoidance (Uncrushable)"] = "Avoidance (Crushing-Immun)"
L["Haste cap (GCD)"] = "Tempo-Cap (GCD)"
L["Dual-wield auto-detected"] = "Beidhändigkeit automatisch erkannt"
L["Optional Spirit Target (0 = no limit)"] = "Optionales Wille-Ziel (0 = kein Limit)"
L["Spirit target tooltip"] = "Willenskraft hat kein festes Spiel-Cap. Trage hier optional einen eigenen Zielwert für Manaregeneration ein (z. B. 300 für Heiler). Ab diesem Wert wird zusätzliche Willenskraft auf Items abgewertet. Bei 0 behält Willenskraft immer ihren vollen Wert."
L["Note: Shift into Bear Form when comparing items for an accurate 75% armor cap calculation."] = "Hinweis: Für eine exakte Berechnung des 75 %-Rüstungs-Caps beim Vergleichen in Bärengestalt wechseln."
L["Active talents:"] = "Aktive Talente:"
L["Under cap"] = "Unter Cap"
L["Cap reached (reduced)"] = "Cap erreicht (reduziert)"
L["Cap reached (weight = 0)"] = "Cap erreicht (Gewicht = 0)"
L["Not active"] = "Nicht aktiv"
L["Automatic cap mechanics note"] = "Alle Spielmechanik-Caps (Treffer, Zaubertreffer, Verteidigung, Waffenkunde, Rüstung, Avoidance, Beidhändigkeit & Tempo) werden automatisch aus Charakterstufe, Zielstufe, Waffen und aktiven Talenten/Buffs berechnet."

-- Compare Tab
L["Compare items for %s"] = "Gegenstände vergleichen (%s)"
L["Left item"] = "Linker Gegenstand"
L["Right item"] = "Rechter Gegenstand"
L["Load equipped"] = "Angelegtes laden"
L["‹ Swap ›"] = "‹ Tauschen ›"
L["Clear"] = "Leeren"
L["Drop an item or paste an item link / ID below, or pick from equipped / bags:"] = "Item hier ablegen, Link/ID einfügen oder aus Ausrüstung/Taschen wählen:"
L["Pick from equipped"] = "Aus Ausrüstung"
L["Pick from bags"] = "Aus Taschen"
L["Stat"] = "Wert"
L["Raw EP"] = "Roh-EP"
L["Effective (Cap Delta)"] = "Effektiv (Cap-Delta)"
L["Difference"] = "Differenz"
L["Total Base Score"] = "Basis-Gesamtwertung"
L["Cap-Adjusted Score"] = "Cap-angepasste Wertung"
L["Net Cap Loss"] = "Cap-Verlust"
L["Verdict"] = "Ergebnis"
L["Empty slot"] = "Leerer Platz"
L["Upgrade: %s"] = "Verbesserung: %s"
L["Downgrade: %s"] = "Verschlechterung: %s"
L["Equal"] = "Gleichwertig"

-- Options Tab
L["Tooltip display"] = "Tooltip-Darstellung"
L["Only show upgrades"] = "Nur Verbesserungen anzeigen"
L["Show values and upgrades"] = "Werte + Verbesserungen anzeigen"
L["Show only values"] = "Nur Werte anzeigen"
L["Show current (enchanted) & base values"] = "Aktuelle (verzauberte) & Basiswerte anzeigen"
L["Align tooltip values right"] = "Werte rechtsbündig im Tooltip ausrichten"
L["Add blank line before values"] = "Leerzeile vor PawnDynamic-Werten einfügen"
L["Color tooltip border on upgrades"] = "Tooltip-Rahmen bei Upgrades grün färben"
L["Healing-to-SpellDamage fallback (1/3)"] = "Heilung zu 1/3 als Zauberschaden (Fallback)"
L["Advisors & Bags"] = "Ratgeber & Taschen"
L["Bag upgrade arrows"] = "Taschen-Pfeile (Blizzard / Bagnon / Baganator)"
L["Quest reward arrows & gold coin"] = "Quest-Belohnungspfeile & Goldmünze (Verkaufswert)"
L["Loot roll advisor"] = "Plünder-/Würfel-Ratgeber"
L["Announce bag upgrades in chat"] = "Neue Taschen-Upgrades im Chat melden"
L["Dagger build (main hand only)"] = "Dolch-Build (nur Dolch in Waffenhand)"
L["Character panel button"] = "Schaltfläche im Charakterfenster"
L["Right"] = "Rechts"
L["Left"] = "Links"
L["Hidden"] = "Ausgeblendet"
L["Diagnostics"] = "Diagnose"
L["Debug mode"] = "Debug-Modus"
L["Rescan & wipe caches"] = "Cache leeren & neu scannen"

-- Tooltips, Bags & Commands
L["%s upgrade"] = "%s Verbesserung"
L["upgrade - %s"] = "Verbesserung - %s"
L["%s with %s"] = "%s mit %s"
L["fills an empty slot"] = "belegt leeren Platz"
L["+%s points"] = "+%s Punkte"
L["replaces zero-score item"] = "ersetzt Gegenstand ohne Wert"
L["[Cap]"] = "[Cap]"
L["Base:"] = "Basis:"
L["Current:"] = "Aktuell:"
L["Total gear score"] = "Gesamtwertung der Ausrüstung"
L["Click to open PawnDynamic"] = "Klicken, um PawnDynamic zu öffnen"
L["[%s] New upgrade: %s (%s)"] = "[%s] Neues Upgrade: %s (%s)"
L["%d upgrade in your bags - /pd scan to list."] = "%d Verbesserung in deinen Taschen - /pd scan zum Auflisten."
L["%d upgrades in your bags - /pd scan to list."] = "%d Verbesserungen in deinen Taschen - /pd scan zum Auflisten."
L["No upgrades found in your bags."] = "Keine Verbesserungen in deinen Taschen gefunden."
L["Items are still loading - try again shortly."] = "Gegenstände laden noch - bitte kurz warten."
L["Saved %d item - /reload to write to disk."] = "%d Gegenstand gespeichert - /reload zum Schreiben auf Festplatte."
L["Saved %d items - /reload to write to disk."] = "%d Gegenstände gespeichert - /reload zum Schreiben auf Festplatte."
L["PawnDynamic did not finish initializing."] = "PawnDynamic wurde noch nicht fertig initialisiert."
L["Debug mode enabled."] = "Debug-Modus aktiviert."
L["Debug mode disabled."] = "Debug-Modus deaktiviert."
L["Caches cleared and data refreshed."] = "Caches geleert und Daten neu eingelesen."
L["|cffff4040Error:|r %s (see /pd status)"] = "|cffff4040Fehler:|r %s (siehe /pd status)"
L["Commands: /pd (toggle UI) | /pd status | /pd scan | /pd debug [on|off|link] | /pd dump | /pd refresh"] =
    "Befehle: /pd (Fenster) | /pd status | /pd scan | /pd debug [on|off|Link] | /pd dump | /pd refresh"
L["Shift+Click: Toggle Tooltip"] = "Umschalt+Klick: Tooltip umschalten"

-- Getting started / About Tab
L["ABOUT_CREDITS"] = "Autor: Behmen  |  Lizenz: MIT License (100% Clean-Room Lua, ohne XML)"
L["ABOUT_CAP_TITLE"] = "|cff00d1ff1. Dynamische Delta-Cap-Engine:|r"
L["ABOUT_CAP_INTRO"] = "Vor jeder Item-Bewertung zieht PawnDynamic die Stats des aktuell getragenen Items vom Charakterwert ab und rechnet das neue Item gegen deine mechanischen Caps:"
L["ABOUT_CAP_FORMULA"] = "Effektiver Wert = f(CharWert - AltesItem + NeuesItem) - f(CharWert - AltesItem)"
L["ABOUT_CAP_TARGET"] = "Ziel-Gegnerstufe (+0 / +2 / +3 oder Automatisch): Exakte Formeln für Treffer-Cap (5% / 6% / 8%), Zaubertreffer-Cap (4% / 6% / 17%), Verteidigung Krit-Immun (Stufe*5 + 125/135/140), Waffenkunde-Cap (5% / 5,5% / 6,5%, Tanks bis 14%) und Rüstungs-Cap (75% DR)."
L["ABOUT_CAP_AVOIDANCE"] = "Avoidance (Crushing-Immun 100% / 101,6% / 102,4%): Erreicht Verfehlen + Ausweichen + Parieren + Blocken das Cap, fällt nur Blockwertung auf 0; Ausweichen & Parieren behalten ihren Wert (nur für Schild-Klassen)."
L["ABOUT_CAP_REDUCTION"] = "Automatische Reduzierung darüber: Beidhändigkeit (automatisch erkannt) skaliert White-Hit bis 24-27% mit, Tempo wirkt über dem 50%-GCD-Cap abgeschwächt weiter."
L["ABOUT_CAP_DRUID"] = "Druiden-Hinweis: Für eine exakte Berechnung des 75 %-Rüstungs-Caps beim Vergleichen in Bärengestalt wechseln."
L["ABOUT_TALENTS_TITLE"] = "|cff00d1ff2. Talente & Live-Buffs (C_Traits + UNIT_AURA):|r"
L["ABOUT_TALENTS_DESC"] = "Erkennt Talente sprachunabhängig per spellID / nodeID, aktualisiert Buffs wie Heiliger Schild live über Spieler-Auren ohne Doppelzählung und berücksichtigt schulspezifische Zaubertreffer-Talente."
L["ABOUT_PAWN_TITLE"] = "|cff00d1ff3. Pawn-v1-Kompatibilität:|r"
L["ABOUT_PAWN_DESC"] = "Voller Import & Export klassischer Pawn-v1-Strings im Reiter 'Bewertungsprofil'."
L["ABOUT_COMMANDS_TITLE"] = "|cff00d1ff4. Slash-Befehle:|r"
L["ABOUT_CMD_PD"] = "/pd  oder  /pawndynamic — Fenster öffnen/schließen"
L["ABOUT_CMD_STATUS"] = "/pd status — Live-Charakterwerte, Caps, Talente & Fehlerprotokoll"
L["ABOUT_CMD_SCAN"] = "/pd scan — Alle Taschen-Upgrades im Chat auflisten"
L["ABOUT_CMD_DEBUG"] = "/pd debug [Link] — Detaillierte Tooltip- & Stat-Analyse"
L["ABOUT_CMD_DUMP"] = "/pd dump — Gelesene Werte für Fehleranalyse in SavedVariables sichern"
L["ABOUT_CMD_REFRESH"] = "/pd refresh — Caches leeren & alles neu berechnen"

-- Scale Names (German)
locale.scales = {
    WARRIOR = {
        ARMS = { name = "Waffen", match = "waffen" },
        FURY = { name = "Furor", match = "furor" },
        PROTECTION = { name = "Schutz", match = "schutz" },
    },
    PALADIN = {
        HOLY = { name = "Heilig", match = "heilig" },
        PROTECTION = { name = "Schutz", match = "schutz" },
        RETRIBUTION = { name = "Vergeltung", match = "vergelt" },
    },
    HUNTER = {
        BEAST_MASTERY = { name = "Tierherrschaft", match = "tierherr" },
        MARKSMANSHIP = { name = "Treffsicherheit", match = "treffsicher" },
        SURVIVAL = { name = "Überleben (Nahkampf)", match = "berleben" },
    },
    ROGUE = {
        ASSASSINATION = { name = "Meucheln", match = "meucheln" },
        COMBAT = { name = "Kampf", match = "kampf" },
        SUBTLETY = { name = "Täuschung", match = "uschung" },
    },
    PRIEST = {
        DISCIPLINE = { name = "Disziplin", match = "disziplin" },
        HOLY = { name = "Heilig", match = "heilig" },
        SHADOW = { name = "Schatten", match = "schatten" },
        SMITE = { name = "Züchtigung (Smite)" },
    },
    SHAMAN = {
        ELEMENTAL = { name = "Elementar", match = "elementar" },
        ENHANCEMENT = { name = "Verstärkung", match = "verst" },
        RESTORATION = { name = "Wiederherstellung", match = "wiederher" },
    },
    MAGE = {
        ARCANE = { name = "Arkan", match = "arkan" },
        FIRE = { name = "Feuer", match = "feuer" },
        FROST = { name = "Frost", match = "frost" },
    },
    WARLOCK = {
        AFFLICTION = { name = "Gebrechen", match = "gebrechen" },
        DEMONOLOGY = { name = "Dämonologie", match = "dämon" },
        DESTRUCTION = { name = "Zerstörung", match = "zerst" },
    },
    DRUID = {
        BALANCE = { name = "Gleichgewicht", match = "gleichgewicht" },
        FERAL_CAT = { name = "Wildheit (Katze)", match = "wild" },
        FERAL_BEAR = { name = "Wildheit (Bär)" },
        RESTORATION = { name = "Wiederherstellung", match = "wiederher" },
    },
}

-- Talent Aliases (Fallback when spellID/nodeID is unavailable)
locale.talents = {
    ["arcane blast"] = { "arkanschlag" },
    ["mental dexterity"] = { "geistige gewandtheit", "mentale gewandtheit" },
    ["mental quickness"] = { "geistige schnelligkeit", "mentale schnelligkeit" },
    ["careful aim"] = { "sorgfältiges zielen" },
    ["champion of the light"] = { "champion des lichts", "streiter des lichts" },
    ["spiritual guidance"] = { "geistige führung" },
    ["living spirit"] = { "lebendiger geist" },
    ["holy guidance"] = { "heilige führung" },
    ["holy shield"] = { "heiliger schild" },
    ["redoubt"] = { "verschanzen" },
    ["shield block"] = { "schildblock" },
    ["shadow focus"] = { "schattenfokus" },
    ["focused power"] = { "fokussierte macht" },
    ["suppression"] = { "unterdrückung" },
    ["arcane focus"] = { "arkanfokus" },
    ["elemental precision"] = { "elementare präzision" },
    ["nature's guidance"] = { "führung der natur" },
    ["balance of power"] = { "gleichgewicht der kräfte" },
}

-- German Tooltip Grammar (Forever + Classic Era)
locale.grammar = function(P)
    local NUM, UNREAD, Add = P.NUM, P.UNREAD, P.Add
    local GAP = "[^%d]-"

    local SCHOOLS = {
        arkan = "ARCANE", arkanzauber = "ARCANE", arkanzaubern = "ARCANE", arkaneffekte = "ARCANE",
        feuer = "FIRE", feuerzauber = "FIRE", feuerzaubern = "FIRE", feuereffekte = "FIRE",
        frost = "FROST", frostzauber = "FROST", frostzaubern = "FROST", frosteffekte = "FROST",
        natur = "NATURE", naturzauber = "NATURE", naturzaubern = "NATURE", natureffekte = "NATURE",
        schatten = "SHADOW", schattenzauber = "SHADOW", schattenzaubern = "SHADOW", schatteneffekte = "SHADOW",
        heilig = "HOLY", heiligzauber = "HOLY", heiligzaubern = "HOLY", heiligeffekte = "HOLY",
    }

    local WEAPON_SKILLS = {
        ["äxte"] = 0, ["zweihandäxte"] = 1, ["bögen"] = 2, ["schusswaffen"] = 3,
        ["streitkolben"] = 4, ["zweihandstreitkolben"] = 5, ["stangenwaffen"] = 6,
        ["schwerter"] = 7, ["zweihandschwerter"] = 8, ["stäbe"] = 10,
        ["faustwaffen"] = 13, ["dolche"] = 15, ["wurfwaffen"] = 16, ["armbrüste"] = 18,
    }

    local function SchoolDamageRule(stats, prefix, value)
        local p = prefix:lower()
        for token, school in pairs(SCHOOLS) do
            if p:find(token, 1, true) then
                Add(stats, school .. "_DAMAGE", value)
                return
            end
        end
        if p:find("magisch", 1, true) then
            Add(stats, "SPELL_DAMAGE", value)
            return
        end
        return false
    end

    local rules = {
        -- Conditional / Procs (ignored)
        { "im kampf gegen", false },
        { "gegen untote", false },
        { "gegen dämonen", false },
        { "gegen wildtiere", false },
        { "gegen drachkin", false },
        { "gegen elementare", false },
        { "%d+ sek%. lang", false },
        { "für %d+ sek", false },
        { "hat eine chance", false },
        { "chance bei treffer", false },
        { "chance, bei", false },
        { "eine chance,", false },

        -- Block Value (Forever & Classic)
        { "blockwert eures schildes um " .. NUM, "BLOCK_VALUE" },
        { "blockwert des schildes um " .. NUM, "BLOCK_VALUE" },
        { "schildblockwert" .. GAP .. NUM, "BLOCK_VALUE" },
        { "blockwert" .. GAP .. NUM, "BLOCK_VALUE" },

        -- Spell Penetration
        { "zauber durchdringen " .. NUM .. " zauberwiderst", "SPELL_PEN" },
        { "magiewiderstände der ziele eurer zauber um " .. NUM, "SPELL_PEN", true },
        { "magischen widerstände eurer ziele um " .. NUM, "SPELL_PEN", true },
        { "zauberdurchschlagskraft" .. GAP .. NUM, "SPELL_PEN" },

        -- Single-spell modifiers
        { "eures zaubers", UNREAD },
        { "eurer fähigkeit", UNREAD },

        -- Crit (Melee, Ranged, Spell, Combined)
        { "kritische trefferchance aller eurer angriffe und zauber um " .. NUM .. "%%", "CRIT" },
        { "kritischen treffer durch zauber zu erzielen, um " .. NUM .. "%%", "CRIT" },
        { "kritischen treffer zu erzielen, um " .. NUM .. "%%", "CRIT" },
        { "kritische trefferchance um " .. NUM .. "%%", "CRIT" },
        { "kritische trefferwertung um " .. NUM, P.Rating("CRIT") },

        -- Hit (Melee, Ranged, Spell, Combined)
        { "trefferchance mit allen angriffen und zaubern um " .. NUM .. "%%", "HIT" },
        { "chance mit zaubern zu treffen um " .. NUM .. "%%", "HIT" },
        { "trefferchance um " .. NUM .. "%%", "HIT" },
        { "trefferwertung um " .. NUM, P.Rating("HIT") },
        { "zaubertrefferwertung um " .. NUM, P.Rating("HIT") },

        -- Expertise (Forever & Classic)
        { "gegner euren angriffen ausweichen oder sie parieren, um " .. NUM .. "%%", "EXPERTISE", true },
        { "angriffe pariert werden oder ihnen ausgewichen wird, um " .. NUM .. "%%", "EXPERTISE", true },
        { "waffenkundewertung um " .. NUM, P.Rating("EXPERTISE") },
        { "waffenkunde" .. GAP .. NUM .. "%%", "EXPERTISE" },
        { "waffenkunde" .. GAP .. NUM, "EXPERTISE" },

        -- Avoidance & Defense
        { "einem angriff auszuweichen, um " .. NUM .. "%%", "DODGE" },
        { "chance auszuweichen" .. GAP .. NUM .. "%%", "DODGE" },
        { "ausweichwertung um " .. NUM, P.Rating("DODGE") },
        { "einen angriff zu parieren, um " .. NUM .. "%%", "PARRY" },
        { "chance zu parieren" .. GAP .. NUM .. "%%", "PARRY" },
        { "parierwertung um " .. NUM, P.Rating("PARRY") },
        { "angriffe mit einem schild zu blocken, um " .. NUM .. "%%", "BLOCK" },
        { "chance zu blocken" .. GAP .. NUM .. "%%", "BLOCK" },
        { "blockwertung um " .. NUM, P.Rating("BLOCK") },
        { "verteidigung %+" .. NUM, "DEFENSE" },
        { "verteidigungswertung um " .. NUM, P.Rating("DEFENSE") },
        { "verteidigung um " .. NUM, "DEFENSE" },

        -- Weapon skills
        { "^erhöhte ([%aäöüß%- ]+) %+" .. NUM, P.Skill(WEAPON_SKILLS) },
        { "^([%aäöüß%- ]+) %+" .. NUM, P.Skill(WEAPON_SKILLS) },
        { "waffenfertigkeit" .. GAP .. NUM, "WEAPON_SKILL" },

        -- Dual Healing + Damage
        { "verursachte heilung um bis zu " .. NUM .. " und den verursachten schaden um bis zu " .. NUM, function(stats, healing, damage)
            Add(stats, "HEALING", healing)
            Add(stats, "SPELL_DAMAGE", damage)
        end },
        -- Combined Spell Damage & Healing
        { "schaden und heilung um bis zu " .. NUM, P.AddSpellPower },
        { "schaden und die heilung.-um bis zu " .. NUM, P.AddSpellPower },
        { "zaubermacht um " .. NUM, P.AddSpellPower },
        -- Healing only
        { "verursachte heilung um bis zu " .. NUM, P.AddHealing },
        { "heilung um bis zu " .. NUM, P.AddHealing },
        { "heilkraft um " .. NUM, P.AddHealing },
        -- Pure Spell Damage (no healing)
        { "von magischen zaubern und effekten verursachten schaden um bis zu " .. NUM, "SPELL_DAMAGE" },
        { "durch magische zauber und effekte verursachten schaden um bis zu " .. NUM, "SPELL_DAMAGE" },
        -- School Spell Damage (Forever & Classic wording)
        { "von (%a+).-zaubern und %-?effekten verursachten schaden um bis zu " .. NUM, SchoolDamageRule },
        { "durch (%a+).-zauber und %-?effekte.-zugefügten schaden um bis zu " .. NUM, SchoolDamageRule },
        { "durch (%a+).-zauber und %-?effekte.-verursachten schaden um bis zu " .. NUM, SchoolDamageRule },
        { "zauberschaden um bis zu " .. NUM, "SPELL_DAMAGE" },

        -- Regeneration
        { "alle 5 sek%. " .. NUM .. " mana", "MP5" },
        { NUM .. " mana alle 5 sek", "MP5" },
        { "stellt " .. NUM .. " gesundheit alle 5 sek", "HP5" },
        { "alle 5 sek%. " .. NUM .. " gesundheit", "HP5" },
        { NUM .. " gesundheit alle 5 sek", "HP5" },

        -- Attack Power & Feral AP
        { "%+" .. NUM .. " angriffskraft in katzengestalt", "FERAL_AP" },
        { "angriffskraft in katzengestalt.-um " .. NUM, "FERAL_AP" },
        { "distanzangriffskraft um " .. NUM, "RANGED_AP" },
        { "%+" .. NUM .. " distanzangriffskraft", "RANGED_AP" },
        { "angriffskraft um " .. NUM, "ATTACK_POWER" },
        { "%+" .. NUM .. " angriffskraft", "ATTACK_POWER" },

        -- Haste (Combined Forever & Classic)
        { "angriffs%- und zaubertempo um " .. NUM .. "%%", "HASTE" },
        { "angriffs%-? und zaubertempo" .. GAP .. NUM .. "%%", "HASTE" },
        { "zaubertempo um " .. NUM .. "%%", "HASTE" },
        { "angriffstempo um " .. NUM .. "%%", "HASTE" },
        { "tempowertung um " .. NUM, P.Rating("HASTE") },
        { "tempo" .. GAP .. NUM .. "%%", "HASTE" },

        -- Armor Penetration
        { "ignorieren " .. NUM .. " rüstung", "ARMOR_PEN" },
        { "rüstungsdurchschlag.-um " .. NUM, "ARMOR_PEN" },
    }

    local names = {
        ["stärke"] = "STRENGTH",
        ["beweglichkeit"] = "AGILITY",
        ["ausdauer"] = "STAMINA",
        ["intelligenz"] = "INTELLECT",
        ["willenskraft"] = "SPIRIT",
        ["alle werte"] = P.AddAllStats,
        ["rüstung"] = "ARMOR",
        ["blocken"] = "BLOCK_VALUE",
        ["% blocken"] = "BLOCK",
        ["blockwert"] = "BLOCK_VALUE",
        ["schildblockwert"] = "BLOCK_VALUE",
        ["blockchance"] = "BLOCK",
        ["blockwertung"] = P.Rating("BLOCK"),
        ["verteidigung"] = "DEFENSE",
        ["verteidigungswertung"] = P.Rating("DEFENSE"),
        ["ausweichen"] = "DODGE",
        ["% ausweichen"] = "DODGE",
        ["ausweichwertung"] = P.Rating("DODGE"),
        ["parieren"] = "PARRY",
        ["% parieren"] = "PARRY",
        ["parierwertung"] = P.Rating("PARRY"),
        ["angriffskraft"] = "ATTACK_POWER",
        ["distanzangriffskraft"] = "RANGED_AP",
        ["wilde angriffskraft"] = "FERAL_AP",
        ["treffer"] = "HIT",
        ["% trefferchance"] = "HIT",
        ["trefferchance"] = "HIT",
        ["trefferwert"] = P.Rating("HIT"),
        ["trefferwertung"] = P.Rating("HIT"),
        ["zaubertrefferwertung"] = P.Rating("HIT"),
        ["kritisch"] = "CRIT",
        ["% kritische trefferchance"] = "CRIT",
        ["kritische trefferchance"] = "CRIT",
        ["kritischer trefferwert"] = P.Rating("CRIT"),
        ["kritische trefferwertung"] = P.Rating("CRIT"),
        ["kritische zaubertrefferwertung"] = P.Rating("CRIT"),
        ["waffenkunde"] = "EXPERTISE",
        ["% waffenkunde"] = "EXPERTISE",
        ["waffenkundewertung"] = P.Rating("EXPERTISE"),
        ["waffenfertigkeit"] = "WEAPON_SKILL",
        ["tempo"] = "HASTE",
        ["% tempo"] = "HASTE",
        ["tempowertung"] = P.Rating("HASTE"),
        ["zaubertempowertung"] = P.Rating("HASTE"),
        ["rüstungsdurchschlagwertung"] = "ARMOR_PEN",
        ["zaubermacht"] = P.AddSpellPower,
        ["zauberschaden"] = "SPELL_DAMAGE",
        ["zauberschaden und heilung"] = P.AddSpellPower,
        ["schadenszauber und heilzauber"] = P.AddSpellPower,
        ["heilzauber"] = P.AddHealing,
        ["heilung"] = P.AddHealing,
        ["mana alle 5 sek"] = "MP5",
        ["mana alle 5 sekunden"] = "MP5",
        ["gesundheit alle 5 sek"] = "HP5",
        ["hp"] = "HP5",
        ["zauberdurchschlagskraft"] = "SPELL_PEN",
        ["zu allen widerstandsarten"] = P.AddAllResistances,
        ["alle widerstandsarten"] = P.AddAllResistances,
        ["abhärtungswertung"] = "RESILIENCE",
        ["pvp-abhärtung"] = "RESILIENCE",
        ["arkanwiderstand"] = "ARCANE_RES",
        ["feuerwiderstand"] = "FIRE_RES",
        ["frostwiderstand"] = "FROST_RES",
        ["naturwiderstand"] = "NATURE_RES",
        ["schattenwiderstand"] = "SHADOW_RES",
        ["arkanzauberschaden"] = "ARCANE_DAMAGE",
        ["arkanschaden"] = "ARCANE_DAMAGE",
        ["feuerzauberschaden"] = "FIRE_DAMAGE",
        ["feuerschaden"] = "FIRE_DAMAGE",
        ["frostzauberschaden"] = "FROST_DAMAGE",
        ["frostschaden"] = "FROST_DAMAGE",
        ["naturzauberschaden"] = "NATURE_DAMAGE",
        ["naturschaden"] = "NATURE_DAMAGE",
        ["schattenzauberschaden"] = "SHADOW_DAMAGE",
        ["schattenschaden"] = "SHADOW_DAMAGE",
        ["heiligzauberschaden"] = "HOLY_DAMAGE",
        ["heiligschaden"] = "HOLY_DAMAGE",
    }

    local skip = {
        "benutzen:", "trefferchance:", "set:", "benötigt", "klassen:", "völker:",
        "haltbarkeit", "gegenstandsstufe", "verkaufspreis", "einzigartig", "wird beim",
        "seelengebunden", "\"", "entzaubern",
    }

    local words = {
        equip = "^anlegen: (.+)$",
        classes = "^klassen: (.+)$",
        set = "^%(%d+%) set",
        range = { "^" .. NUM .. " %- " .. NUM .. " [%aäöüß ]-schaden$" },
        flat = { "^" .. NUM .. " [%aäöüß ]-schaden$" },
        dps = "%(?" .. NUM .. " schaden pro sekunde",
        speed = "^[tg]e[ms][pc][oh]w?i?n?d?i?g?k?e?i?t? " .. NUM,
        negative = { "^verringert", "^reduziert", "^senkt" },
        also = " und ",
        plus = " und ",
        name = function(name)
            name = name:gsub("%.$", "")
            name = name:gsub("^p%. ", ""):gsub("^zu ", "")
            return name
        end,
        looseNumbers = true,
    }
    words.speed = "^tempo " .. NUM
    words.speedAlt = "^geschwindigkeit " .. NUM

    return { rules = rules, names = names, skip = skip, words = words }
end
