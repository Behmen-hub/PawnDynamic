-- PawnDynamic (MIT License)
-- Portuguese localization (ptBR).

local _, ns = ...

local locale = ns:NewLocale("ptBR")
if not locale then
    return
end

local L = locale.strings

L["Attributes"] = "Atributos"
L["Offense"] = "Ofensiva"
L["Weapon damage"] = "Dano da arma"
L["Spells"] = "Feitiços"
L["Defense"] = "Defesa"
L["Resistances"] = "Resistências"
L["Armor types"] = "Tipos de armadura"
L["Weapon types"] = "Tipos de arma"

L["Strength"] = "Força"
L["Agility"] = "Agilidade"
L["Stamina"] = "Vigor"
L["Intellect"] = "Intelecto"
L["Spirit"] = "Espírito"
L["Attack power"] = "Poder de ataque"
L["Ranged attack power"] = "Poder de ataque à distância"
L["Feral attack power"] = "Poder de ataque feral"
L["Hit %"] = "Acerto %"
L["Crit %"] = "Crítico %"
L["Expertise %"] = "Aptidão %"
L["Weapon skill"] = "Perícia com armas"
L["Haste %"] = "Aceleração %"
L["Armor penetration"] = "Penetração de armadura"
L["Main-hand DPS"] = "DPS mão principal"
L["Main-hand min damage"] = "Dano mín. mão principal"
L["Main-hand max damage"] = "Dano máx. mão principal"
L["Main-hand hit damage"] = "Acerto médio mão principal"
L["Main-hand speed"] = "Velocidade mão principal"
L["Off-hand DPS"] = "DPS mão secundária"
L["Off-hand speed"] = "Velocidade mão secundária"
L["Ranged / wand DPS"] = "DPS à distância / varinha"
L["Ranged min damage"] = "Dano mín. à distância"
L["Ranged max damage"] = "Dano máx. à distância"
L["Ranged hit damage"] = "Acerto médio à distância"
L["Ranged speed"] = "Velocidade à distância"
L["Speed baseline"] = "Base de velocidade"
L["Spell damage"] = "Dano mágico"
L["Healing"] = "Cura"
L["Arcane damage"] = "Dano Arcano"
L["Fire damage"] = "Dano de Fogo"
L["Frost damage"] = "Dano de Gelo"
L["Nature damage"] = "Dano de Natureza"
L["Shadow damage"] = "Dano de Sombra"
L["Holy damage"] = "Dano Sagrado"
L["Mana per 5 sec"] = "Mana a cada 5 s"
L["Spell penetration"] = "Penetração de feitiço"
L["Armor"] = "Armadura"
L["Defense"] = "Defesa"
L["Dodge %"] = "Esquiva %"
L["Parry %"] = "Aparo %"
L["Block %"] = "Bloqueio %"
L["Block value"] = "Valor de bloqueio"
L["Health per 5 sec"] = "Vida a cada 5 s"
L["Resilience"] = "Resiliência"
L["All resistances"] = "Todas as resistências"
L["Arcane resistance"] = "Resistência a Arcano"
L["Fire resistance"] = "Resistência a Fogo"
L["Frost resistance"] = "Resistência a Gelo"
L["Nature resistance"] = "Resistência a Natureza"
L["Shadow resistance"] = "Resistência a Sombra"
L["Include Raid Resistance Buff (+60)"] = "Incluir bônus de resistência de raide (+60)"
L["Scale % stats by level (< 60)"] = "Escalar % por nível (< 60)"
L["Scale % stats by level tooltip"] = "Escala proporcionalmente os atributos percentuais (Crítico %, Acerto %, Aceleração %, Aptidão %, Perícia com armas, Defesa, Esquiva %, Aparo %, Bloqueio %) abaixo do nível 60 (fator Nível / 60, chegando a 100 % no nível 60). Desative para usar sempre os pesos totais enquanto evolui."
L["Raid resistance buff tooltip"] = "Adiciona +60 de resistência de Auras de Paladino, Totens de Xamã, Aspecto da Natureza ou Proteção Sombria ao planejar equipamentos sem buffs. Cai automaticamente para 0 enquanto o bônus correspondente estiver ativo em você (sem contagem dupla). Frascos, jujus e poções ativos são detectados automaticamente."

L["Cloth"] = "Tecido"
L["Leather"] = "Couro"
L["Mail"] = "Malha"
L["Plate"] = "Placas"
L["Shield"] = "Escudo"
L["Scale"] = "Perfil"
L["Weights"] = "Pesos"
L["Caps & Dynamics"] = "Caps e Dinâmica"
L["Compare"] = "Comparar"
L["Options"] = "Opções"
L["Getting started / About"] = "Início / Sobre"
L["My scales"] = "Meus perfis"
L["Other scales"] = "Outros perfis"
L["Starter templates"] = "Modelos iniciais"
L["Automatic"] = "Automático"
L["Manual"] = "Manual"
L["Show this scale in tooltips"] = "Mostrar na dica"
L["Rename"] = "Renomear"
L["Delete"] = "Excluir"
L["Type \"%s\" to confirm deletion:"] = "Digite \"%s\" para confirmar:"
L["DELETE_CONFIRM_WORD"] = "EXCLUIR"
L["Type \"%s\" to permanently delete profile \"%s\":"] = "Digite \"%s\" para excluir permanentemente o perfil \"%s\":"
L["Change color"] = "Mudar cor"
L["Reset defaults"] = "Restaurar padrão"
L["Import"] = "Importar"
L["Export"] = "Exportar"
L["Export all"] = "Exportar tudo"
L["New"] = "Novo"
L["From template"] = "Modelo"
L["Copy"] = "Copiar"
L["OK"] = "OK"
L["Cancel"] = "Cancelar"
L["Create"] = "Criar"
L["Close"] = "Fechar"
L["%s upgrade"] = "%s melhoria"
L["upgrade - %s"] = "melhoria - %s"
L["%s with %s"] = "%s com %s"
L["fills an empty slot"] = "preenche espaço vazio"
L["+%s points"] = "+%s pontos"
L["replaces zero-score item"] = "substitui item sem valor"
L["Main hand"] = "Mão principal"
L["Off hand"] = "Mão secundária"
L["replaces: %s"] = "substitui: %s"
L["%s to off hand"] = "%s → Mão secundária"

L["Live Character Stats & Cap Status"] = "Atributos ao vivo e estado dos caps"
L["Profile Cap Configuration"] = "Configuração de caps do perfil"
L["Cap engine active"] = "Motor de caps ativo"
L["Talent integration active"] = "Integração de talentos ativa"
L["Tank mode"] = "Modo Tanque"
L["Target enemy level"] = "Nível do inimigo alvo"
L["Even level (+0)"] = "Mesmo nível (+0)"
L["Dungeon boss (+2)"] = "Chefe de masmorra (+2)"
L["Raid boss (+3)"] = "Chefe de raide (+3)"
L["Hit mode"] = "Modo de acerto"
L["Melee"] = "Corpo a corpo"
L["Spell"] = "Feitiços"
L["Avoidance detail format"] = "Err %.1f%% · Esq %.1f%% · Apar %.1f%% · Bloq %.1f%%"
L["Avoidance detail offset format"] = "Err %.1f%% · Esq %.1f%% · Apar %.1f%% · Bloq %.1f%% (+%.0f%%)"
L["Stat Prio Generator"] = "Gerador de Prioridades"
L["Profile name:"] = "Nome do perfil:"
L["Role:"] = "Função:"
L["Tank"] = "Tanque"
L["Melee DPS"] = "DPS Corpo a corpo"
L["Ranged DPS"] = "DPS Longo alcance"
L["Caster DPS"] = "DPS Lançador"
L["Healer"] = "Curador"
L["Load default prio"] = "Carregar padrão"
L["Available stats"] = "Atributos disponíveis"
L["Your priority (1 = highest)"] = "Sua prioridade (1 = maior)"
L["Calculated weights preview"] = "Prévia dos pesos calculados"
L["Create as new profile"] = "Criar como novo perfil"
L["Apply to current profile"] = "Aplicar ao perfil atual"
L["[Synergy]"] = "[Sinergia]"
L["[Base]"] = "[Base]"
L["Prio list is empty."] = "Adicione pelo menos um atributo."
L["Target: %s (Level %d)"] = "Alvo: %s (Nível %d)"
L["Hit cap (%)"] = "Cap de Acerto (%)"
L["Spell hit cap (%)"] = "Cap de Acerto de feitiços (%)"
L["Defense (Crit immune)"] = "Defesa (Imune a críticos)"
L["Expertise cap (%)"] = "Cap de Aptidão (%)"
L["Armor cap (75% DR)"] = "Cap de Armadura (75% Red.)"
L["Avoidance (Uncrushable)"] = "Esquiva Total (Imune a esmagamento)"
L["Haste cap (GCD)"] = "Cap de Aceleração (GCD)"
L["Dual-wield auto-detected"] = "Empunhadura dupla detectada automaticamente"
L["Optional Spirit Target (0 = no limit)"] = "Meta de Espírito opcional (0 = sem limite)"
L["Spirit target tooltip"] = "O Espírito não tem um cap fixo no jogo. Opcionalmente insira uma meta pessoal de regeneração de mana (ex.: 300 para curadores). Acima desse valor, o Espírito tem peso reduzido nos itens. Deixe 0 para manter o peso total."
L["Note: Shift into Bear Form when comparing items for an accurate 75% armor cap calculation."] = "Nota: Mude para a Forma de Urso ao comparar itens para um cálculo exato do cap de 75% de armadura."
L["Current:"] = "Atual:"
L["Active talents:"] = "Talentos ativos:"
L["Under cap"] = "Abaixo do cap"
L["Cap reached (reduced)"] = "Cap atingido (reduzido)"
L["Cap reached (weight = 0)"] = "Cap atingido (peso = 0)"
L["Not active"] = "Inativo"
L["Automatic cap mechanics note"] = "Todos os caps mecânicos (Acerto, Defesa, Aptidão, Armadura, Bloqueio, Empunhadura Dupla e Aceleração) são calculados automaticamente pelo seu nível, alvo, armas e talentos/bônus ativos."

-- Weapon types & UI strings
L["1H Axe"] = "Machado 1M"
L["2H Axe"] = "Machado 2M"
L["Bow"] = "Arco"
L["Crossbow"] = "Besta"
L["Dagger"] = "Adaga"
L["Fist weapon"] = "Arma de punho"
L["Gun"] = "Arma de fogo"
L["1H Mace"] = "Maça 1M"
L["2H Mace"] = "Maça 2M"
L["Polearm"] = "Arma de haste"
L["Relic"] = "Relíquia"
L["Staff"] = "Cajado"
L["1H Sword"] = "Espada 1M"
L["2H Sword"] = "Espada 2M"
L["Thrown weapon"] = "Arma de arremesso"
L["Wand"] = "Varinha"
L["Off-hand weapon"] = "Arma mão secundária"
L["Off-hand frill"] = "Item mão secundária"

L["Auto follows your active talent tree."] = "Automático acompanha o perfil da sua especialização de talentos ativa."
L["Manual lets you enable and customize multiple profiles."] = "Manual permite ativar e personalizar vários perfis simultaneamente."
L["Read-only template"] = "Modelo somente leitura (crie uma cópia para personalizar livremente ou edite pesos localmente)"
L["Custom scale"] = "Perfil personalizado"
L["No scale selected"] = "Nenhum perfil selecionado"
L["Enter profile name:"] = "Digite o nome do perfil:"
L["Enter new name for %s:"] = "Novo nome para %s:"
L["Enter name for copy of %s:"] = "Nome para a cópia de %s:"
L["Paste Pawn v1 string:"] = "Cole a string Pawn v1:"
L["Copy Pawn v1 string (Ctrl+C):"] = "Copie a string Pawn v1 (Ctrl+C):"
L["Choose class & template:"] = "Escolha classe e modelo:"
L["Overwrite existing scale?"] = "Sobrescrever o perfil existente?"

L["Stat weights for %s"] = "Pesos de atributos para %s"
L["Yellow values are customized."] = "Valores amarelos foram personalizados."
L["Normalize values (like Wowhead)"] = "Normalizar valores (como Wowhead)"
L["Hide 1H upgrades"] = "Ocultar melhorias 1M"
L["Hide 2H upgrades"] = "Ocultar melhorias 2M"
L["Unusable armor & weapon types"] = "Tipos de armadura e armas inutilizáveis"
L["Unusable"] = "Inutilizável"
L["Select a stat or edit values directly. Press Tab for next row."] = "Edite os pesos diretamente. Pressione Tab para o próximo campo."
L["Clear value"] = "Limpar valor"

L["Compare items for %s"] = "Comparar itens para %s"
L["Left item"] = "Item esquerdo"
L["Right item"] = "Item direito"
L["Load equipped"] = "Carregar equipado"
L["‹ Swap ›"] = "‹ Trocar ›"
L["Clear"] = "Limpar"
L["Drop an item or paste an item link / ID below, or pick from equipped / bags:"] = "Arraste um item, cole um link/ID abaixo ou escolha dos equipados / bolsas:"
L["Pick from equipped"] = "Dos equipados"
L["Pick from bags"] = "Das bolsas"
L["Stat"] = "Atributo"
L["Raw EP"] = "EP bruto"
L["Effective (Cap Delta)"] = "Efetivo (Delta Cap)"
L["Difference"] = "Diferença"
L["Total Base Score"] = "Pontuação base total"
L["Cap-Adjusted Score"] = "Pontuação com Cap"
L["Net Cap Loss"] = "Perda líquida de Cap"
L["Verdict"] = "Veredito"
L["Empty slot"] = "Espaço vazio"
L["Upgrade: %s"] = "Melhoria: %s"
L["Downgrade: %s"] = "Piora: %s"
L["Equal"] = "Igual"

L["Tooltip display"] = "Exibição da dica"
L["Only show upgrades"] = "Mostrar apenas melhorias"
L["Show values and upgrades"] = "Mostrar valores e melhorias"
L["Show only values"] = "Mostrar apenas valores"
L["Show current (enchanted) & base values"] = "Mostrar valores atuais (encantados) e base"
L["Align tooltip values right"] = "Alinhar valores à direita na dica"
L["Add blank line before values"] = "Adicionar linha em branco antes dos valores"
L["Color tooltip border on upgrades"] = "Colorir borda da dica em melhorias"
L["Healing-to-SpellDamage fallback (1/3)"] = "Conversão de Cura para Dano Mágico (1/3)"
L["Advisors & Bags"] = "Assistentes e Bolsas"
L["Bag upgrade arrows"] = "Setas de melhoria nas bolsas"
L["Quest reward arrows & gold coin"] = "Setas de recompensa de missão e moeda de ouro"
L["Loot roll advisor"] = "Consultor de rolagens de saque"
L["Announce bag upgrades in chat"] = "Anunciar melhorias das bolsas no chat"
L["Dagger build (main hand only)"] = "Build de adaga (apenas mão principal)"
L["Character panel button"] = "Botão no painel do personagem"
L["Right"] = "Direita"
L["Left"] = "Esquerda"
L["Hidden"] = "Oculto"
L["Diagnostics"] = "Diagnóstico"
L["Debug mode"] = "Modo de depuração"
L["Rescan & wipe caches"] = "Reescanear e limpar caches"

L["[Cap]"] = "[Cap]"
L["Base:"] = "Base:"
L["Total gear score"] = "Pontuação total do equipamento"
L["Click to open PawnDynamic"] = "Clique para abrir PawnDynamic"
L["[%s] New upgrade: %s (%s)"] = "[%s] Nova melhoria: %s (%s)"
L["%d upgrade in your bags - /pd scan to list."] = "%d melhoria nas bolsas - /pd scan para listar."
L["%d upgrades in your bags - /pd scan to list."] = "%d melhorias nas bolsas - /pd scan para listar."
L["No upgrades found in your bags."] = "Nenhuma melhoria encontrada nas bolsas."
L["Items are still loading - try again shortly."] = "Itens ainda carregando - tente novamente em breve."
L["Saved %d item - /reload to write to disk."] = "%d item salvo - /reload para gravar em disco."
L["Saved %d items - /reload to write to disk."] = "%d itens salvos - /reload para gravar em disco."
L["PawnDynamic did not finish initializing."] = "PawnDynamic não terminou de inicializar."
L["Debug mode enabled."] = "Modo de depuração ativado."
L["Debug mode disabled."] = "Modo de depuração desativado."
L["Caches cleared and data refreshed."] = "Caches limpos e dados atualizados."
L["|cffff4040Error:|r %s (see /pd status)"] = "|cffff4040Erro:|r %s (veja /pd status)"
L["Commands: /pd (toggle UI) | /pd status | /pd scan | /pd debug [on|off|link] | /pd dump | /pd refresh"] =
    "Comandos: /pd (janela) | /pd status | /pd scan | /pd debug [on|off|link] | /pd dump | /pd refresh"
L["Shift+Click: Toggle Tooltip"] = "Shift+Clique: Alternar dica"

-- Getting started / About Tab
L["ABOUT_CREDITS"] = "Autor: Behmen  |  Licença: MIT License (100% Lua Clean-Room, sem XML)"
L["ABOUT_CAP_TITLE"] = "|cff00d1ff1. Motor dinâmico de caps (Delta):|r"
L["ABOUT_CAP_INTRO"] = "Antes de avaliar um item, o PawnDynamic subtrai os atributos do item equipado do total do personagem e calcula o substituto contra seus caps mecânicos:"
L["ABOUT_CAP_FORMULA"] = "Valor efetivo = f(StatsPers - ItemAntigo + NovoItem) - f(StatsPers - ItemAntigo)"
L["ABOUT_CAP_TARGET"] = "Nível do inimigo (+0 / +2 / +3 ou Automático): Fórmulas exatas para Acerto (5% / 6% / 8%), Acerto de feitiços (4% / 6% / 17%), Defesa imune a críticos (Nível*5 + 125/135/140), Aptidão (5% / 5,5% / 6,5%, Tanques até 14%) e Armadura (75% RD)."
L["ABOUT_CAP_AVOIDANCE"] = "Esquiva Total (Imune a esmagamento 100% / 101,6% / 102,4%): Ao atingir Errar + Esquiva + Aparo + Bloqueio no cap, apenas o bloqueio cai para 0; Esquiva e Aparo mantêm seu peso (classes com escudo)."
L["ABOUT_CAP_REDUCTION"] = "Redução automática acima do cap: Empunhadura dupla (detectada auto.) escala acerto branco até 24-27%, e Aceleração continua com peso reduzido acima do cap de 50% GCD."
L["ABOUT_CAP_DRUID"] = "Nota para Druidas: Mude para a Forma de Urso ao comparar itens para calcular exatamente o cap de 75% de armadura."
L["ABOUT_TALENTS_TITLE"] = "|cff00d1ff2. Talentos e Bônus ao vivo (C_Traits + UNIT_AURA):|r"
L["ABOUT_TALENTS_DESC"] = "Detecta talentos independentemente do idioma por spellID / nodeID, atualiza bônus como Escudo Sagrado ao vivo sem contagem dupla e considera talentos de acerto por escola."
L["ABOUT_PAWN_TITLE"] = "|cff00d1ff3. Compatibilidade Pawn v1:|r"
L["ABOUT_PAWN_DESC"] = "Importação e exportação completas de strings clássicas Pawn v1 na aba 'Perfil'."
L["ABOUT_COMMANDS_TITLE"] = "|cff00d1ff4. Comandos Slash:|r"
L["ABOUT_CMD_PD"] = "/pd  ou  /pawndynamic — Abrir/fechar janela"
L["ABOUT_CMD_STATUS"] = "/pd status — Atributos ao vivo, caps, talentos e registro de erros"
L["ABOUT_CMD_SCAN"] = "/pd scan — Listar melhorias das bolsas no chat"
L["ABOUT_CMD_DEBUG"] = "/pd debug [Link] — Análise detalhada de dica e atributos"
L["ABOUT_CMD_DUMP"] = "/pd dump — Salvar valores lidos em SavedVariables para diagnóstico"
L["ABOUT_CMD_REFRESH"] = "/pd refresh — Limpar caches e recalcular tudo"

locale.scales = {
    WARRIOR = { ARMS = { name = "Armas", match = "armas" }, FURY = { name = "Fúria", match = "fúria" }, PROTECTION = { name = "Proteção", match = "prote" } },
    PALADIN = { HOLY = { name = "Sagrado", match = "sagrado" }, PROTECTION = { name = "Proteção", match = "prote" }, RETRIBUTION = { name = "Retribuição", match = "retribui" } },
    HUNTER = { BEAST_MASTERY = { name = "Domínio das Feras", match = "feras" }, MARKSMANSHIP = { name = "Pontaria", match = "pontaria" }, SURVIVAL = { name = "Sobrevivência", match = "sobreviv" } },
    ROGUE = { ASSASSINATION = { name = "Assassinato", match = "assassinato" }, COMBAT = { name = "Combate", match = "combate" }, SUBTLETY = { name = "Subterfúgio", match = "subterf" } },
    PRIEST = { DISCIPLINE = { name = "Disciplina", match = "disciplina" }, HOLY = { name = "Sagrado", match = "sagrado" }, SHADOW = { name = "Sombra", match = "sombra" }, SMITE = { name = "Punição" } },
    SHAMAN = { ELEMENTAL = { name = "Elemental", match = "elemental" }, ENHANCEMENT = { name = "Aperfeiçoamento", match = "aperfei" }, RESTORATION = { name = "Restauração", match = "restaura" } },
    MAGE = { ARCANE = { name = "Arcano", match = "arcano" }, FIRE = { name = "Fogo", match = "fogo" }, FROST = { name = "Gelo", match = "gelo" } },
    WARLOCK = { AFFLICTION = { name = "Suplício", match = "supl" }, DEMONOLOGY = { name = "Demonologia", match = "demonologia" }, DESTRUCTION = { name = "Destruição", match = "destrui" } },
    DRUID = { BALANCE = { name = "Equilíbrio", match = "equil" }, FERAL_CAT = { name = "Feral (Gato)", match = "feral" }, FERAL_BEAR = { name = "Feral (Urso)" }, RESTORATION = { name = "Restauração", match = "restaura" } },
}

locale.grammar = function(P)
    local NUM = P.NUM
    local GAP = "[^%d]-"
    local rules = {
        { "ao lutar", false }, { " contra ", false }, { " por %d+ s", false }, { "chance de ", false },
        { "valor de bloqueio" .. GAP .. NUM, "BLOCK_VALUE" },
        { "penetração de feitiço" .. GAP .. NUM, "SPELL_PEN" },
        { "acerto crítico" .. GAP .. NUM .. "%%", "CRIT" },
        { "chance de acerto" .. GAP .. NUM .. "%%", "HIT" },
        { "esquivados ou aparados" .. GAP .. NUM .. "%%", "EXPERTISE", true },
        { "aptidão" .. GAP .. NUM, "EXPERTISE" },
        { "esquivar" .. GAP .. NUM .. "%%", "DODGE" },
        { "aparar" .. GAP .. NUM .. "%%", "PARRY" },
        { "bloquear" .. GAP .. NUM .. "%%", "BLOCK" },
        { "defesa" .. GAP .. NUM, "DEFENSE" },
        { "dano e a cura dos feitiços" .. GAP .. NUM, P.AddSpellPower },
        { "cura dos feitiços" .. GAP .. NUM, P.AddHealing },
        { "dano dos feitiços" .. GAP .. NUM, "SPELL_DAMAGE" },
        { "poder mágico" .. GAP .. NUM, P.AddSpellPower },
        { NUM .. GAP .. "mana a cada 5 s", "MP5" },
        { NUM .. GAP .. "vida a cada 5 s", "HP5" },
        { "poder de ataque à distância" .. GAP .. NUM, "RANGED_AP" },
        { "poder de ataque" .. GAP .. NUM, "ATTACK_POWER" },
        { "aceleração" .. GAP .. NUM .. "%%", "HASTE" },
    }
    local names = {
        ["força"] = "STRENGTH", ["agilidade"] = "AGILITY", ["vigor"] = "STAMINA",
        ["intelecto"] = "INTELLECT", ["espírito"] = "SPIRIT", ["armadura"] = "ARMOR",
        ["bloqueio"] = "BLOCK_VALUE", ["% bloqueio"] = "BLOCK", ["valor de bloqueio"] = "BLOCK_VALUE",
        ["defesa"] = "DEFENSE", ["esquiva"] = "DODGE", ["aparo"] = "PARRY",
        ["poder de ataque"] = "ATTACK_POWER", ["taxa de acerto"] = P.Rating("HIT"),
        ["taxa de acerto crítico"] = P.Rating("CRIT"), ["taxa de aceleração"] = P.Rating("HASTE"),
        ["aptidão"] = "EXPERTISE", ["poder mágico"] = P.AddSpellPower,
        ["todas as resistências"] = P.AddAllResistances,
    }
    local skip = { "uso:", "chance ao acertar:", "conjunto:", "requer", "classes:", "raças:", "durabilidade", "nível do item", "preço", "único", "vincula", "\"" }
    local words = {
        equip = "^equipar: (.+)$", classes = "^classes: (.+)$", set = "^%(%d+%) conjunto",
        range = { "^" .. NUM .. " %- " .. NUM .. " de dano" }, flat = { "^" .. NUM .. " de dano$" },
        dps = "%(?" .. NUM .. " de dano por segundo", speed = "^velocidade " .. NUM,
        negative = { "^reduz", "^diminui" }, also = " e ", plus = " e ", looseNumbers = true,
    }
    return { rules = rules, names = names, skip = skip, words = words }
end
