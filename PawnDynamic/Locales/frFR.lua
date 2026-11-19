-- PawnDynamic (MIT License)
-- French localization (frFR).

local _, ns = ...

local locale = ns:NewLocale("frFR")
if not locale then
    return
end

local L = locale.strings

L["Attributes"] = "Attributs"
L["Offense"] = "Attaque"
L["Weapon damage"] = "Dégâts d'arme"
L["Spells"] = "Sorts"
L["Defense"] = "Défense"
L["Resistances"] = "Résistances"
L["Armor types"] = "Types d'armure"
L["Weapon types"] = "Types d'arme"

L["Strength"] = "Force"
L["Agility"] = "Agilité"
L["Stamina"] = "Endurance"
L["Intellect"] = "Intelligence"
L["Spirit"] = "Esprit"
L["Attack power"] = "Puissance d'attaque"
L["Ranged attack power"] = "Puiss. d'attaque à distance"
L["Feral attack power"] = "Puiss. d'attaque farouche"
L["Hit %"] = "Toucher %"
L["Crit %"] = "Critique %"
L["Expertise %"] = "Expertise %"
L["Weapon skill"] = "Compétence d'arme"
L["Haste %"] = "Hâte %"
L["Armor penetration"] = "Pénétration d'armure"
L["Main-hand DPS"] = "DPS main droite"
L["Main-hand min damage"] = "Dégâts min main droite"
L["Main-hand max damage"] = "Dégâts max main droite"
L["Main-hand hit damage"] = "Coup moyen main droite"
L["Main-hand speed"] = "Vitesse main droite"
L["Off-hand DPS"] = "DPS main gauche"
L["Off-hand speed"] = "Vitesse main gauche"
L["Ranged / wand DPS"] = "DPS distance / baguette"
L["Ranged min damage"] = "Dégâts min distance"
L["Ranged max damage"] = "Dégâts max distance"
L["Ranged hit damage"] = "Coup moyen distance"
L["Ranged speed"] = "Vitesse à distance"
L["Speed baseline"] = "Base de vitesse"
L["Spell damage"] = "Dégâts des sorts"
L["Healing"] = "Soins"
L["Arcane damage"] = "Dégâts des Arcanes"
L["Fire damage"] = "Dégâts de Feu"
L["Frost damage"] = "Dégâts de Givre"
L["Nature damage"] = "Dégâts de Nature"
L["Shadow damage"] = "Dégâts d'Ombre"
L["Holy damage"] = "Dégâts du Sacré"
L["Mana per 5 sec"] = "Mana toutes les 5 s"
L["Spell penetration"] = "Pénétration des sorts"
L["Armor"] = "Armure"
L["Defense"] = "Défense"
L["Dodge %"] = "Esquive %"
L["Parry %"] = "Parade %"
L["Block %"] = "Blocage %"
L["Block value"] = "Valeur de blocage"
L["Health per 5 sec"] = "Vie toutes les 5 s"
L["Resilience"] = "Résilience"
L["All resistances"] = "Toutes les résistances"
L["Arcane resistance"] = "Résistance aux Arcanes"
L["Fire resistance"] = "Résistance au Feu"
L["Frost resistance"] = "Résistance au Givre"
L["Nature resistance"] = "Résistance à la Nature"
L["Shadow resistance"] = "Résistance à l'Ombre"
L["Include Raid Resistance Buff (+60)"] = "Inclure le buff de résistance de raid (+60)"
L["Raid resistance buff tooltip"] = "Ajoute +60 de résistance via auras de paladin, totems de chaman, Aspect de la nature ou Protection contre l'ombre pour planifier un équipement non buffé. Passe automatiquement à 0 lorsque le buff de raid correspondant est actif sur vous (aucun double comptage). Flacons, jujus et potions actifs sont détectés automatiquement."

L["Cloth"] = "Tissu"
L["Leather"] = "Cuir"
L["Mail"] = "Mailles"
L["Plate"] = "Plaques"
L["Shield"] = "Bouclier"
L["1H Axe"] = "Hache 1M"
L["2H Axe"] = "Hache 2M"
L["Bow"] = "Arc"
L["Crossbow"] = "Arbalète"
L["Dagger"] = "Dague"
L["Fist weapon"] = "Arme de pugilat"
L["Gun"] = "Fusil"
L["1H Mace"] = "Masse 1M"
L["2H Mace"] = "Masse 2M"
L["Polearm"] = "Arme d'hast"
L["Relic"] = "Relique"
L["Staff"] = "Bâton"
L["1H Sword"] = "Épée 1M"
L["2H Sword"] = "Épée 2M"
L["Thrown weapon"] = "Arme de jet"
L["Wand"] = "Baguette"
L["Off-hand weapon"] = "Arme main gauche"
L["Off-hand frill"] = "Objet main gauche"

L["Scale"] = "Profil"
L["Weights"] = "Pondérations"
L["Caps & Dynamics"] = "Caps & Dynamique"
L["Compare"] = "Comparer"
L["Options"] = "Options"
L["Getting started / About"] = "Premiers pas / À propos"

L["My scales"] = "Mes profils"
L["Other scales"] = "Autres profils"
L["Starter templates"] = "Modèles de départ"
L["Automatic"] = "Automatique"
L["Manual"] = "Manuel"
L["Auto follows your active talent tree."] = "Automatique suit le modèle de votre arbre de talents actif."
L["Manual lets you enable and customize multiple profiles."] = "Manuel vous permet d'activer et de personnaliser plusieurs profils."
L["Show this scale in tooltips"] = "Afficher dans l'infobulle"
L["Rename"] = "Renommer"
L["Delete"] = "Supprimer"
L["Change color"] = "Couleur"
L["Reset defaults"] = "Réinitialiser"
L["Import"] = "Importer"
L["Export"] = "Exporter"
L["Export all"] = "Tout exporter"
L["New"] = "Nouveau"
L["From template"] = "Modèle"
L["Copy"] = "Copier"
L["Read-only template"] = "Modèle de départ (créez une copie pour tout personnaliser)"
L["Custom scale"] = "Profil personnalisé"
L["No scale selected"] = "Aucun profil sélectionné"
L["Enter profile name:"] = "Nom du profil :"
L["Enter new name for %s:"] = "Nouveau nom pour %s :"
L["Enter name for copy of %s:"] = "Nom de la copie de %s :"
L["Type \"%s\" to confirm deletion:"] = "Tapez \"%s\" pour confirmer :"
L["DELETE_CONFIRM_WORD"] = "SUPPRIMER"
L["Type \"%s\" to permanently delete profile \"%s\":"] = "Tapez \"%s\" pour supprimer définitivement le profil \"%s\" :"
L["Paste Pawn v1 string:"] = "Coller la chaîne Pawn v1 :"
L["Copy Pawn v1 string (Ctrl+C):"] = "Copier la chaîne Pawn v1 (Ctrl+C) :"
L["Choose class & template:"] = "Choisir classe & modèle :"
L["Overwrite existing scale?"] = "Écraser le profil existant ?"
L["OK"] = "OK"
L["Cancel"] = "Annuler"
L["Create"] = "Créer"
L["Close"] = "Fermer"

L["Stat weights for %s"] = "Pondérations pour %s"
L["Yellow values are customized."] = "Les valeurs en jaune ont été modifiées."
L["Normalize values (like Wowhead)"] = "Normaliser les valeurs"
L["Hide 1H upgrades"] = "Masquer les améliorations 1M"
L["Hide 2H upgrades"] = "Masquer les améliorations 2M"
L["Unusable armor & weapon types"] = "Types d'armures et d'armes inutilisables"
L["Unusable"] = "Inutilisable"
L["Select a stat or edit values directly. Press Tab for next row."] = "Modifiez directement les valeurs. Tab passe au champ suivant."
L["Clear value"] = "Effacer"

L["Live Character Stats & Cap Status"] = "Statistiques en direct & état des caps"
L["Profile Cap Configuration"] = "Configuration des caps du profil"
L["Cap engine active"] = "Moteur de caps actif"
L["Talent integration active"] = "Intégration des talents active"
L["Tank mode"] = "Mode Tank"
L["Target enemy level"] = "Niveau de la cible"
L["Even level (+0)"] = "Même niveau (+0)"
L["Dungeon boss (+2)"] = "Boss de donjon (+2)"
L["Raid boss (+3)"] = "Boss de raid (+3)"
L["Hit mode"] = "Mode de toucher"
L["Melee"] = "Mêlée"
L["Spell"] = "Sorts"
L["Avoidance detail format"] = "Raté %.1f%% · Esq %.1f%% · Par %.1f%% · Bloq %.1f%%"
L["Avoidance detail offset format"] = "Raté %.1f%% · Esq %.1f%% · Par %.1f%% · Bloq %.1f%% (+%.0f%%)"
L["Stat Prio Generator"] = "Générateur de priorité"
L["Profile name:"] = "Nom du profil :"
L["Role:"] = "Rôle :"
L["Tank"] = "Tank"
L["Melee DPS"] = "DPS Mêlée"
L["Ranged DPS"] = "DPS Distance"
L["Caster DPS"] = "DPS Sorts"
L["Healer"] = "Soigneur"
L["Load default prio"] = "Charger défaut"
L["Available stats"] = "Stats disponibles"
L["Your priority (1 = highest)"] = "Votre priorité (1 = max)"
L["Calculated weights preview"] = "Aperçu des poids calculés"
L["Create as new profile"] = "Créer nouveau profil"
L["Apply to current profile"] = "Appliquer au profil actuel"
L["[Synergy]"] = "[Synergie]"
L["[Base]"] = "[Base]"
L["Prio list is empty."] = "Veuillez ajouter au moins une statistique."
L["Target: %s (Level %d)"] = "Cible : %s (Niveau %d)"
L["Hit cap (%)"] = "Cap Toucher (%)"
L["Spell hit cap (%)"] = "Cap Toucher sorts (%)"
L["Defense (Crit immune)"] = "Défense (Immunité critique)"
L["Expertise cap (%)"] = "Cap Expertise (%)"
L["Armor cap (75% DR)"] = "Cap Armure (75% Réd.)"
L["Avoidance (Uncrushable)"] = "Évitement (Immunité écrasement)"
L["Haste cap (GCD)"] = "Cap Hâte (GCD)"
L["Dual-wield auto-detected"] = "Ambidextrie détectée automatiquement"
L["Optional Spirit Target (0 = no limit)"] = "Objectif d'Esprit optionnel (0 = sans limite)"
L["Spirit target tooltip"] = "L'Esprit n'a pas de cap fixe en jeu. Saisissez si besoin un objectif personnel de régénération de mana (ex. 300 pour les soigneurs). L'Esprit au-delà de ce seuil est dévalué sur les objets. Laissez à 0 pour conserver toute sa valeur."
L["Note: Shift into Bear Form when comparing items for an accurate 75% armor cap calculation."] = "Remarque : Passez en forme d'ours pour comparer les objets afin d'obtenir un calcul exact du cap d'armure à 75 %."
L["Active talents:"] = "Talents actifs :"
L["Under cap"] = "Sous le cap"
L["Cap reached (reduced)"] = "Cap atteint (réduit)"
L["Cap reached (weight = 0)"] = "Cap atteint (poids = 0)"
L["Not active"] = "Inactif"
L["Automatic cap mechanics note"] = "Tous les caps mécaniques (Toucher, Toucher sorts, Défense, Expertise, Armure, Évitement, Ambidextrie et Hâte) sont calculés automatiquement selon votre niveau, la cible choisie, vos armes et vos talents/buffs actifs."

L["Compare items for %s"] = "Comparer des objets (%s)"
L["Left item"] = "Objet de gauche"
L["Right item"] = "Objet de droite"
L["Load equipped"] = "Charger équipé"
L["‹ Swap ›"] = "‹ Échanger ›"
L["Clear"] = "Vider"
L["Drop an item or paste an item link / ID below, or pick from equipped / bags:"] = "Déposez un objet, collez un lien/ID ou sélectionnez dans votre équipement/sacs :"
L["Pick from equipped"] = "Équipement"
L["Pick from bags"] = "Sacs"
L["Stat"] = "Statistique"
L["Raw EP"] = "EP brut"
L["Effective (Cap Delta)"] = "Effectif (Delta Cap)"
L["Difference"] = "Différence"
L["Total Base Score"] = "Score total de base"
L["Cap-Adjusted Score"] = "Score ajusté au cap"
L["Net Cap Loss"] = "Perte de cap"
L["Verdict"] = "Verdict"
L["Empty slot"] = "Emplacement vide"
L["Upgrade: %s"] = "Amélioration : %s"
L["Downgrade: %s"] = "Régression : %s"
L["Equal"] = "Équivalent"

L["Tooltip display"] = "Affichage infobulle"
L["Only show upgrades"] = "Afficher uniquement les améliorations"
L["Show values and upgrades"] = "Afficher scores et améliorations"
L["Show only values"] = "Afficher uniquement les scores"
L["Show current (enchanted) & base values"] = "Afficher valeurs actuelles et de base"
L["Align tooltip values right"] = "Aligner les valeurs à droite"
L["Add blank line before values"] = "Ajouter une ligne vide avant les valeurs"
L["Color tooltip border on upgrades"] = "Colorer la bordure de l'infobulle"
L["Healing-to-SpellDamage fallback (1/3)"] = "Soins vers dégâts des sorts (1/3)"
L["Advisors & Bags"] = "Conseillers & Sacs"
L["Bag upgrade arrows"] = "Flèches d'amélioration dans les sacs"
L["Quest reward arrows & gold coin"] = "Flèches de quête & pièce d'or"
L["Loot roll advisor"] = "Conseiller de butin"
L["Announce bag upgrades in chat"] = "Annoncer les améliorations dans le chat"
L["Dagger build (main hand only)"] = "Spé Dagues (main droite uniquement)"
L["Character panel button"] = "Bouton fiche de personnage"
L["Right"] = "Droite"
L["Left"] = "Gauche"
L["Hidden"] = "Masqué"
L["Diagnostics"] = "Diagnostic"
L["Debug mode"] = "Mode débogage"
L["Rescan & wipe caches"] = "Vider le cache et rescanner"

L["%s upgrade"] = "%s amélioration"
L["upgrade - %s"] = "amélioration - %s"
L["%s with %s"] = "%s avec %s"
L["fills an empty slot"] = "remplit un emplacement vide"
L["+%s points"] = "+%s points"
L["replaces zero-score item"] = "remplace un objet sans valeur"
L["[Cap]"] = "[Cap]"
L["Base:"] = "Base :"
L["Current:"] = "Actuel :"
L["Total gear score"] = "Score total d'équipement"
L["Click to open PawnDynamic"] = "Cliquer pour ouvrir PawnDynamic"
L["[%s] New upgrade: %s (%s)"] = "[%s] Nouvelle amélioration : %s (%s)"
L["%d upgrade in your bags - /pd scan to list."] = "%d amélioration dans vos sacs - /pd scan."
L["%d upgrades in your bags - /pd scan to list."] = "%d améliorations dans vos sacs - /pd scan."
L["No upgrades found in your bags."] = "Aucune amélioration trouvée dans vos sacs."
L["Items are still loading - try again shortly."] = "Objets en cours de chargement..."
L["Saved %d item - /reload to write to disk."] = "%d objet enregistré - /reload pour sauvegarder."
L["Saved %d items - /reload to write to disk."] = "%d objets enregistrés - /reload pour sauvegarder."
L["PawnDynamic did not finish initializing."] = "PawnDynamic n'a pas fini de s'initialiser."
L["Debug mode enabled."] = "Mode débogage activé."
L["Debug mode disabled."] = "Mode débogage désactivé."
L["Caches cleared and data refreshed."] = "Caches vidés et données actualisées."
L["|cffff4040Error:|r %s (see /pd status)"] = "|cffff4040Erreur :|r %s (voir /pd status)"
L["Commands: /pd (toggle UI) | /pd status | /pd scan | /pd debug [on|off|link] | /pd dump | /pd refresh"] =
    "Commandes : /pd (fenêtre) | /pd status | /pd scan | /pd debug [on|off|lien] | /pd dump | /pd refresh"
L["Shift+Click: Toggle Tooltip"] = "Maj+Clic : Activer l'infobulle"

-- Getting started / About Tab
L["ABOUT_CREDITS"] = "Auteur : Behmen  |  Licence : MIT License (100 % Lua Clean-Room, sans XML)"
L["ABOUT_CAP_TITLE"] = "|cff00d1ff1. Moteur de caps dynamique (Delta) :|r"
L["ABOUT_CAP_INTRO"] = "Avant d'évaluer un objet, PawnDynamic soustrait les statistiques de votre objet équipé et calcule le remplacement par rapport à vos caps :"
L["ABOUT_CAP_FORMULA"] = "Valeur effective = f(StatsPerso - AncienObjet + NouvelObjet) - f(StatsPerso - AncienObjet)"
L["ABOUT_CAP_TARGET"] = "Niveau de la cible (+0 / +2 / +3 ou Auto) : Formules exactes pour Toucher (5 % / 6 % / 8 %), Toucher des sorts (4 % / 6 % / 17 %), Défense immunité critique (Niv*5 + 125/135/140), Expertise (5 % / 5,5 % / 6,5 %, Tanks jusqu'à 14 %) et Armure (75 % réd.)."
L["ABOUT_CAP_AVOIDANCE"] = "Évitement (Immunisé écrasement 100 % / 101,6 % / 102,4 %) : Lorsque Raté + Esquive + Parade + Blocage atteint le cap, seul le blocage tombe à 0 ; Esquive & Parade conservent leur valeur (classes à bouclier)."
L["ABOUT_CAP_REDUCTION"] = "Réduction automatique au-delà : Le combat à deux armes (détecté auto.) met à l'échelle le toucher blanc jusqu'à 24-27 %, et la Hâte reste active à poids réduit au-delà du cap GCD de 50 %."
L["ABOUT_CAP_DRUID"] = "Note Druide : Passez en Forme d'ours lors de la comparaison d'objets pour un calcul exact du cap d'armure à 75 %."
L["ABOUT_TALENTS_TITLE"] = "|cff00d1ff2. Talents & Buffs en direct (C_Traits + UNIT_AURA) :|r"
L["ABOUT_TALENTS_DESC"] = "Détecte les talents indépendamment de la langue via spellID / nodeID, actualise les buffs comme Bouclier sacré via les auras sans double comptage et inclut les talents de toucher par école."
L["ABOUT_PAWN_TITLE"] = "|cff00d1ff3. Compatibilité Pawn v1 :|r"
L["ABOUT_PAWN_DESC"] = "Importation et exportation complètes de chaînes Pawn v1 classiques dans l'onglet « Profil »."
L["ABOUT_COMMANDS_TITLE"] = "|cff00d1ff4. Commandes Slash :|r"
L["ABOUT_CMD_PD"] = "/pd  ou  /pawndynamic — Ouvrir/fermer la fenêtre"
L["ABOUT_CMD_STATUS"] = "/pd status — Stats en direct, caps, talents & journal d'erreurs"
L["ABOUT_CMD_SCAN"] = "/pd scan — Lister toutes les améliorations des sacs dans le chat"
L["ABOUT_CMD_DEBUG"] = "/pd debug [Lien] — Analyse détaillée de l'infobulle & des stats"
L["ABOUT_CMD_DUMP"] = "/pd dump — Enregistrer les valeurs lues dans SavedVariables"
L["ABOUT_CMD_REFRESH"] = "/pd refresh — Vider les caches et tout recalculer"

locale.scales = {
    WARRIOR = {
        ARMS = { name = "Armes", match = "armes" },
        FURY = { name = "Fureur", match = "fureur" },
        PROTECTION = { name = "Protection", match = "protection" },
    },
    PALADIN = {
        HOLY = { name = "Sacré", match = "sacr" },
        PROTECTION = { name = "Protection", match = "protection" },
        RETRIBUTION = { name = "Vindicte", match = "vindicte" },
    },
    HUNTER = {
        BEAST_MASTERY = { name = "Maîtrise des bêtes", match = "bêtes" },
        MARKSMANSHIP = { name = "Précision", match = "précision" },
        SURVIVAL = { name = "Survie (Mêlée)", match = "survie" },
    },
    ROGUE = {
        ASSASSINATION = { name = "Assassinat", match = "assassinat" },
        COMBAT = { name = "Combat", match = "combat" },
        SUBTLETY = { name = "Finesse", match = "finesse" },
    },
    PRIEST = {
        DISCIPLINE = { name = "Discipline", match = "discipline" },
        HOLY = { name = "Sacré", match = "sacr" },
        SHADOW = { name = "Ombre", match = "ombre" },
        SMITE = { name = "Châtiment" },
    },
    SHAMAN = {
        ELEMENTAL = { name = "Élémentaire", match = "élémentaire" },
        ENHANCEMENT = { name = "Amélioration", match = "amélioration" },
        RESTORATION = { name = "Restauration", match = "restauration" },
    },
    MAGE = {
        ARCANE = { name = "Arcanes", match = "arcane" },
        FIRE = { name = "Feu", match = "feu" },
        FROST = { name = "Givre", match = "givre" },
    },
    WARLOCK = {
        AFFLICTION = { name = "Affliction", match = "affliction" },
        DEMONOLOGY = { name = "Démonologie", match = "démonologie" },
        DESTRUCTION = { name = "Destruction", match = "destruction" },
    },
    DRUID = {
        BALANCE = { name = "Équilibre", match = "équilibre" },
        FERAL_CAT = { name = "Combat farouche (Chat)", match = "farouche" },
        FERAL_BEAR = { name = "Combat farouche (Ours)" },
        RESTORATION = { name = "Restauration", match = "restauration" },
    },
}

locale.talents = {
    ["arcane blast"] = { "déflagration des arcanes" },
    ["mental dexterity"] = { "dextérité mentale" },
    ["mental quickness"] = { "rapidité mentale" },
    ["careful aim"] = { "visée minutieuse" },
    ["champion of the light"] = { "champion de la lumière" },
    ["spiritual guidance"] = { "direction spirituelle" },
    ["living spirit"] = { "esprit vivant" },
    ["holy shield"] = { "bouclier sacré" },
    ["redoubt"] = { "redoute" },
    ["shield block"] = { "maîtrise du blocage" },
    ["shadow focus"] = { "focalisation de l'ombre" },
    ["focused power"] = { "pouvoir focalisé" },
    ["suppression"] = { "suppression" },
    ["arcane focus"] = { "concentration des arcanes" },
    ["elemental precision"] = { "précision élémentaire" },
    ["nature's guidance"] = { "soutien de la nature" },
    ["balance of power"] = { "équilibre de la puissance" },
}

locale.grammar = function(P)
    local NUM, UNREAD, Add = P.NUM, P.UNREAD, P.Add
    local GAP = "[^%d]-"

    local SCHOOLS = {
        arcanes = "ARCANE", arcane = "ARCANE", feu = "FIRE", givre = "FROST",
        nature = "NATURE", ombre = "SHADOW", ombres = "SHADOW", ["sacré"] = "HOLY",
    }

    local WEAPON_SKILLS = {
        ["haches"] = 0, ["haches à deux mains"] = 1, ["arcs"] = 2, ["armes à feu"] = 3,
        ["masses"] = 4, ["masses à deux mains"] = 5, ["armes d'hast"] = 6,
        ["épées"] = 7, ["épées à deux mains"] = 8, ["bâtons"] = 10,
        ["armes de pugilat"] = 13, ["dagues"] = 15, ["armes de jet"] = 16, ["arbalètes"] = 18,
    }

    local rules = {
        { "en combattant", false },
        { " contre ", false },
        { " pendant %d+ s", false },
        { "a une chance", false },
        { "chance de ", false },

        { "valeur de blocage" .. GAP .. NUM, "BLOCK_VALUE" },
        { "pénétration des sorts" .. GAP .. NUM, "SPELL_PEN" },
        { "résistances magiques de vos cibles" .. GAP .. NUM, "SPELL_PEN", true },
        { "de votre sort ", UNREAD },

        { "coup critique" .. GAP .. NUM .. "%%", "CRIT" },
        { "chances de toucher" .. GAP .. NUM .. "%%", "HIT" },
        { "toucher" .. GAP .. NUM .. "%%", "HIT" },
        { "esquivées ou parées" .. GAP .. NUM .. "%%", "EXPERTISE", true },
        { "expertise" .. GAP .. NUM, "EXPERTISE" },
        { "esquiver" .. GAP .. NUM .. "%%", "DODGE" },
        { "parer" .. GAP .. NUM .. "%%", "PARRY" },
        { "bloquer" .. GAP .. NUM .. "%%", "BLOCK" },
        { "défense augmentée %+" .. NUM, "DEFENSE" },
        { "défense" .. GAP .. NUM, "DEFENSE" },
        { "^([%aéèêàîûô'%- ]+) augmentée?s? %+" .. NUM, P.Skill(WEAPON_SKILLS) },

        { "dégâts et les soins produits par les sorts" .. GAP .. NUM, P.AddSpellPower },
        { "soins prodigués par les sorts" .. GAP .. NUM, P.AddHealing },
        { "dégâts infligés par les sorts et effets magiques" .. GAP .. NUM, "SPELL_DAMAGE" },
        { "dégâts infligés par les sorts et effets d?'? ?(%a+)" .. GAP .. NUM, function(stats, school, value)
            if SCHOOLS[school] then
                Add(stats, SCHOOLS[school] .. "_DAMAGE", value)
            else
                return false
            end
        end },
        { "puissance des sorts" .. GAP .. NUM, P.AddSpellPower },
        { NUM .. " points? de mana toutes les 5 s", "MP5" },
        { NUM .. " points? de vie toutes les 5 s", "HP5" },
        { "puissance d'attaque" .. GAP .. "félin" .. GAP .. NUM, "FERAL_AP" },
        { "puissance d'attaque à distance" .. GAP .. NUM, "RANGED_AP" },
        { "puissance d'attaque" .. GAP .. NUM, "ATTACK_POWER" },
        { "hâte" .. GAP .. NUM .. "%%", "HASTE" },
        { "vitesse d'attaque et d'incantation" .. GAP .. NUM .. "%%", "HASTE" },
        { "vitesse d'incantation" .. GAP .. NUM .. "%%", "HASTE" },
        { "vitesse d'attaque" .. GAP .. NUM .. "%%", "HASTE" },
    }

    local names = {
        ["force"] = "STRENGTH", ["agilité"] = "AGILITY", ["endurance"] = "STAMINA",
        ["intelligence"] = "INTELLECT", ["esprit"] = "SPIRIT", ["toutes les caractéristiques"] = P.AddAllStats,
        ["armure"] = "ARMOR", ["bloquer"] = "BLOCK_VALUE", ["blocage"] = "BLOCK_VALUE",
        ["% bloquer"] = "BLOCK", ["% blocage"] = "BLOCK", ["valeur de blocage"] = "BLOCK_VALUE",
        ["défense"] = "DEFENSE", ["esquive"] = "DODGE", ["% esquive"] = "DODGE",
        ["parade"] = "PARRY", ["% parade"] = "PARRY",
        ["puissance d'attaque"] = "ATTACK_POWER", ["puissance d'attaque à distance"] = "RANGED_AP",
        ["score de toucher"] = P.Rating("HIT"), ["toucher"] = "HIT", ["% toucher"] = "HIT",
        ["score de coup critique"] = P.Rating("CRIT"), ["coup critique"] = "CRIT", ["% coup critique"] = "CRIT",
        ["score de hâte"] = P.Rating("HASTE"), ["hâte"] = "HASTE", ["% hâte"] = "HASTE",
        ["expertise"] = "EXPERTISE", ["puissance des sorts"] = P.AddSpellPower,
        ["dégâts des sorts"] = "SPELL_DAMAGE", ["soins"] = P.AddHealing,
        ["pénétration des sorts"] = "SPELL_PEN", ["toutes les résistances"] = P.AddAllResistances,
        ["résistance aux arcanes"] = "ARCANE_RES", ["résistance au feu"] = "FIRE_RES",
        ["résistance au givre"] = "FROST_RES", ["résistance à la nature"] = "NATURE_RES",
        ["résistance à l'ombre"] = "SHADOW_RES",
    }

    local skip = {
        "utiliser :", "chances quand vous touchez :", "ensemble :", "requis",
        "classes :", "races :", "durabilité", "niveau d'objet", "prix de vente", "unique", "lié", "\"",
    }

    local words = {
        equip = "^équipé : (.+)$",
        classes = "^classes : (.+)$",
        set = "^%(%d+%) ensemble",
        range = { "^dégâts : " .. NUM .. " %- " .. NUM, "^" .. NUM .. " %- " .. NUM .. " dégâts" },
        flat = { "^" .. NUM .. " dégâts$" },
        dps = "%(?" .. NUM .. " dégâts par seconde",
        speed = "^vitesse " .. NUM,
        negative = { "^réduit", "^diminue" },
        also = " et ",
        plus = " et ",
        name = function(name)
            return name:gsub("^en ", ""):gsub("^de ", "")
        end,
        looseNumbers = true,
    }

    return { rules = rules, names = names, skip = skip, words = words }
end
