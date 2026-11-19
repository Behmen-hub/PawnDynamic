-- PawnDynamic (MIT License)
-- Korean localization (koKR).

local _, ns = ...

local locale = ns:NewLocale("koKR")
if not locale then
    return
end

local L = locale.strings

L["Attributes"] = "기본 능력치"
L["Offense"] = "공격"
L["Weapon damage"] = "무기 피해"
L["Spells"] = "주문"
L["Defense"] = "방어"
L["Resistances"] = "저항"
L["Armor types"] = "방어구 종류"
L["Weapon types"] = "무기 종류"

L["Strength"] = "힘"
L["Agility"] = "민첩성"
L["Stamina"] = "체력"
L["Intellect"] = "지능"
L["Spirit"] = "정신력"
L["Attack power"] = "전투력"
L["Ranged attack power"] = "원거리 전투력"
L["Feral attack power"] = "야성 전투력"
L["Hit %"] = "적중 %"
L["Crit %"] = "치명타 %"
L["Expertise %"] = "숙련 %"
L["Weapon skill"] = "무기 숙련도"
L["Haste %"] = "가속 %"
L["Armor penetration"] = "방어구 관통력"
L["Main-hand DPS"] = "주장비 DPS"
L["Off-hand DPS"] = "보조장비 DPS"
L["Ranged / wand DPS"] = "원거리 / 마법봉 DPS"
L["Spell damage"] = "주문 공격력"
L["Healing"] = "치유량"
L["Mana per 5 sec"] = "5초당 마나 회복"
L["Spell penetration"] = "주문 관통력"
L["Armor"] = "방어도"
L["Defense"] = "방어 숙련"
L["Dodge %"] = "회피 %"
L["Parry %"] = "무기 막기 %"
L["Block %"] = "방패 막기 %"
L["Block value"] = "피해 방어량"
L["Health per 5 sec"] = "5초당 생명력 회복"
L["All resistances"] = "모든 저항력"
L["Arcane resistance"] = "비전 저항력"
L["Fire resistance"] = "화염 저항력"
L["Frost resistance"] = "냉기 저항력"
L["Nature resistance"] = "자연 저항력"
L["Shadow resistance"] = "암흑 저항력"
L["Include Raid Resistance Buff (+60)"] = "공격대 저항 강화 효과 (+60) 포함"
L["Raid resistance buff tooltip"] = "강화 효과가 없는 장비를 구성할 때 성기사 오라, 주술사 토템, 야생의 상 또는 어둠의 보호로 얻는 저항력 +60을 미리 반영합니다. 해당 공격대 강화 효과가 이미 활성화되어 있으면 자동으로 0으로 전환됩니다(중복 계산 방지). 활성화된 영약, 주주, 물약은 자동으로 반영됩니다."

L["Scale"] = "프로필"
L["Weights"] = "가중치"
L["Caps & Dynamics"] = "상한선 & 동적 계산"
L["Compare"] = "비교"
L["Options"] = "설정"
L["Getting started / About"] = "시작하기 / 정보"

L["My scales"] = "내 프로필"
L["Other scales"] = "기타 프로필"
L["Starter templates"] = "기본 템플릿"
L["Automatic"] = "자동"
L["Manual"] = "수동"
L["Show this scale in tooltips"] = "툴팁에 표시"
L["Rename"] = "이름 변경"
L["Delete"] = "삭제"
L["Type \"%s\" to confirm deletion:"] = "\"%s\"을(를) 입력하여 확인하세요:"
L["DELETE_CONFIRM_WORD"] = "삭제"
L["Type \"%s\" to permanently delete profile \"%s\":"] = "\"%s\"을(를) 입력하여 \"%s\" 프로필을 영구히 삭제합니다:"
L["Change color"] = "색상 변경"
L["Reset defaults"] = "초기화"
L["Import"] = "가져오기"
L["Export"] = "내보내기"
L["Export all"] = "전체 내보내기"
L["New"] = "새로 만들기"
L["From template"] = "템플릿에서"
L["Copy"] = "복사"
L["OK"] = "확인"
L["Cancel"] = "취소"
L["Create"] = "생성"
L["Close"] = "닫기"
L["%s upgrade"] = "%s 업그레이드"
L["upgrade - %s"] = "업그레이드 - %s"
L["%s with %s"] = "%s (%s 포함)"
L["fills an empty slot"] = "빈 슬롯 채움"
L["+%s points"] = "+%s 점수"
L["replaces zero-score item"] = "점수 없는 아이템 교체"

L["Live Character Stats & Cap Status"] = "실시간 능력치 및 한계치(Cap) 현황"
L["Profile Cap Configuration"] = "프로필 한계치 설정"
L["Cap engine active"] = "한계치 엔진 활성화"
L["Talent integration active"] = "특성 연동 활성화"
L["Tank mode"] = "탱커 모드"
L["Target enemy level"] = "대상 적 레벨"
L["Even level (+0)"] = "동일 레벨 (+0)"
L["Dungeon boss (+2)"] = "던전 우두머리 (+2)"
L["Raid boss (+3)"] = "공격대 우두머리 (+3)"
L["Hit mode"] = "적중 모드"
L["Melee"] = "근접"
L["Spell"] = "주문"
L["Avoidance detail format"] = "빗맞 %.1f%% · 회피 %.1f%% · 막기 %.1f%% · 방패 %.1f%%"
L["Avoidance detail offset format"] = "빗맞 %.1f%% · 회피 %.1f%% · 막기 %.1f%% · 방패 %.1f%% (+%.0f%%)"
L["Stat Prio Generator"] = "능력치 우선순위 생성기"
L["Profile name:"] = "프로필 이름:"
L["Role:"] = "역할:"
L["Tank"] = "방어 전담"
L["Melee DPS"] = "근접 공격"
L["Ranged DPS"] = "원거리 공격"
L["Caster DPS"] = "주문 공격"
L["Healer"] = "치유 전담"
L["Load default prio"] = "기본값 불러오기"
L["Available stats"] = "사용 가능한 능력치"
L["Your priority (1 = highest)"] = "우선순위 (1 = 최우선)"
L["Calculated weights preview"] = "계산된 가중치 미리보기"
L["Create as new profile"] = "새 프로필로 만들기"
L["Apply to current profile"] = "현재 프로필에 적용"
L["[Synergy]"] = "[시너지]"
L["[Base]"] = "[기본]"
L["Prio list is empty."] = "최소 하나 이상의 능력치를 추가하세요."
L["Target: %s (Level %d)"] = "대상: %s (레벨 %d)"
L["Hit cap (%)"] = "적중 한계치 (%)"
L["Spell hit cap (%)"] = "주문 적중 한계치 (%)"
L["Defense (Crit immune)"] = "방어 숙련도 (치명타 면역)"
L["Expertise cap (%)"] = "숙련 한계치 (%)"
L["Armor cap (75% DR)"] = "방어도 한계치 (75% 감소)"
L["Avoidance (Uncrushable)"] = "회피 합계 (강타 면역)"
L["Haste cap (GCD)"] = "가속 한계치 (GCD)"
L["Dual-wield auto-detected"] = "쌍수 무기 자동 감지됨"
L["Optional Spirit Target (0 = no limit)"] = "정신력 선택 목표치 (0 = 제한 없음)"
L["Spirit target tooltip"] = "정신력에는 고정된 게임 내 한계치가 없습니다. 힐러의 마나 재생 등을 위해 개인 목표치(예: 300)를 선택적으로 입력하세요. 목표치를 초과하는 정신력은 가중치가 낮아집니다. 0으로 두면 항상 전체 가중치를 유지합니다."
L["Note: Shift into Bear Form when comparing items for an accurate 75% armor cap calculation."] = "참고: 정확한 75% 방어도 한계치 계산을 위해 아이템 비교 시 곰 변신 상태로 전환하세요."
L["Current:"] = "현재:"
L["Active talents:"] = "활성 특성:"
L["Under cap"] = "한계치 미만"
L["Cap reached (reduced)"] = "한계치 도달 (가중치 감소)"
L["Cap reached (weight = 0)"] = "한계치 도달 (가중치 = 0)"
L["Not active"] = "비활성"
L["Automatic cap mechanics note"] = "모든 기계적 한계치(적중, 주문 적중, 방어, 숙련, 방어도, 방패 막기, 쌍수 및 가속)는 캐릭터 레벨, 대상 레벨, 장착 무기 및 활성 특성/버프에 따라 자동으로 계산됩니다."

-- Additional Stat, Armor, Weapon & UI strings
L["Main-hand min damage"] = "주장비 최소 피해"
L["Main-hand max damage"] = "주장비 최대 피해"
L["Main-hand hit damage"] = "주장비 평균 피해"
L["Main-hand speed"] = "주장비 속도"
L["Off-hand speed"] = "보조장비 속도"
L["Ranged min damage"] = "원거리 최소 피해"
L["Ranged max damage"] = "원거리 최대 피해"
L["Ranged hit damage"] = "원거리 평균 피해"
L["Ranged speed"] = "원거리 속도"
L["Speed baseline"] = "기준 속도"
L["Arcane damage"] = "비전 피해"
L["Fire damage"] = "화염 피해"
L["Frost damage"] = "냉기 피해"
L["Nature damage"] = "자연 피해"
L["Shadow damage"] = "암흑 피해"
L["Holy damage"] = "신성 피해"
L["Resilience"] = "탄력도"
L["Cloth"] = "천"
L["Leather"] = "가죽"
L["Mail"] = "사슬"
L["Plate"] = "판금"
L["Shield"] = "방패"
L["1H Axe"] = "한손 도끼"
L["2H Axe"] = "양손 도끼"
L["Bow"] = "활"
L["Crossbow"] = "석궁"
L["Dagger"] = "단검"
L["Fist weapon"] = "장착 무기"
L["Gun"] = "총"
L["1H Mace"] = "한손 둔기"
L["2H Mace"] = "양손 둔기"
L["Polearm"] = "장창"
L["Relic"] = "성물"
L["Staff"] = "지팡이"
L["1H Sword"] = "한손 도검"
L["2H Sword"] = "양손 도검"
L["Thrown weapon"] = "투척 무기"
L["Wand"] = "마법봉"
L["Off-hand weapon"] = "보조 무기"
L["Off-hand frill"] = "보조장비"

L["Auto follows your active talent tree."] = "자동 모드는 현재 활성화된 특성 트리의 기본 프로필을 따릅니다."
L["Manual lets you enable and customize multiple profiles."] = "수동 모드에서는 여러 프로필을 동시에 활성화하고 편집할 수 있습니다."
L["Read-only template"] = "기본 템플릿 (자유롭게 수정하려면 복사본을 만드세요)"
L["Custom scale"] = "사용자 지정 프로필"
L["No scale selected"] = "선택된 프로필 없음"
L["Enter profile name:"] = "프로필 이름 입력:"
L["Enter new name for %s:"] = "%s의 새 이름 입력:"
L["Enter name for copy of %s:"] = "%s 복사본 이름 입력:"
L["Paste Pawn v1 string:"] = "Pawn v1 문자열 붙여넣기:"
L["Copy Pawn v1 string (Ctrl+C):"] = "Pawn v1 문자열 복사 (Ctrl+C):"
L["Choose class & template:"] = "직업 및 템플릿 선택:"
L["Overwrite existing scale?"] = "기존 프로필을 덮어쓰시겠습니까?"

L["Stat weights for %s"] = "%s 능력치 가중치"
L["Yellow values are customized."] = "노란색 값은 사용자가 수정한 값입니다."
L["Normalize values (like Wowhead)"] = "가중치 정규화 (Wowhead 방식)"
L["Hide 1H upgrades"] = "한손 무기 업그레이드 숨김"
L["Hide 2H upgrades"] = "양손 무기 업그레이드 숨김"
L["Unusable armor & weapon types"] = "사용 불가 방어구 및 무기 종류"
L["Unusable"] = "사용 불가"
L["Select a stat or edit values directly. Press Tab for next row."] = "가중치를 직접 편집하세요. Tab 키로 다음 칸으로 이동합니다."
L["Clear value"] = "값 지우기"

L["Compare items for %s"] = "%s 아이템 비교"
L["Left item"] = "왼쪽 아이템"
L["Right item"] = "오른쪽 아이템"
L["Load equipped"] = "장착 아이템 불러오기"
L["‹ Swap ›"] = "‹ 교체 ›"
L["Clear"] = "지우기"
L["Drop an item or paste an item link / ID below, or pick from equipped / bags:"] = "아래에 아이템을 올리거나 링크/ID를 붙여넣고, 장착/가방에서 선택하세요:"
L["Pick from equipped"] = "장착 장비에서 선택"
L["Pick from bags"] = "가방에서 선택"
L["Stat"] = "능력치"
L["Raw EP"] = "기본 EP"
L["Effective (Cap Delta)"] = "실효 점수 (한계치 델타)"
L["Difference"] = "차이"
L["Total Base Score"] = "총 기본 점수"
L["Cap-Adjusted Score"] = "한계치 반영 점수"
L["Net Cap Loss"] = "순 한계치 손실"
L["Verdict"] = "판정"
L["Empty slot"] = "빈 슬롯"
L["Upgrade: %s"] = "업그레이드: %s"
L["Downgrade: %s"] = "다운그레이드: %s"
L["Equal"] = "동일"

L["Tooltip display"] = "툴팁 표시"
L["Only show upgrades"] = "업그레이드만 표시"
L["Show values and upgrades"] = "점수 및 업그레이드 표시"
L["Show only values"] = "점수만 표시"
L["Show current (enchanted) & base values"] = "현재(마부 포함) 및 기본 점수 표시"
L["Align tooltip values right"] = "툴팁 점수 오른쪽 정렬"
L["Add blank line before values"] = "점수 앞에 빈 줄 추가"
L["Color tooltip border on upgrades"] = "업그레이드 시 툴팁 테두리 강조"
L["Healing-to-SpellDamage fallback (1/3)"] = "치유량 → 주문 공격력 보조 환산 (1/3)"
L["Advisors & Bags"] = "조언자 및 가방"
L["Bag upgrade arrows"] = "가방 업그레이드 화살표"
L["Quest reward arrows & gold coin"] = "퀘스트 보상 화살표 및 최고 상점가"
L["Loot roll advisor"] = "전리품 주사위 조언자"
L["Announce bag upgrades in chat"] = "가방 업그레이드 대화창 알림"
L["Dagger build (main hand only)"] = "단검 빌드 (주장비만 사용)"
L["Character panel button"] = "캐릭터 창 버튼"
L["Right"] = "오른쪽"
L["Left"] = "왼쪽"
L["Hidden"] = "숨김"
L["Diagnostics"] = "진단"
L["Debug mode"] = "디버그 모드"
L["Rescan & wipe caches"] = "재검색 및 캐시 초기화"

L["[Cap]"] = "[한계치]"
L["Base:"] = "기본:"
L["Total gear score"] = "총 장비 점수"
L["Click to open PawnDynamic"] = "클릭하여 PawnDynamic 열기"
L["[%s] New upgrade: %s (%s)"] = "[%s] 새 업그레이드: %s (%s)"
L["%d upgrade in your bags - /pd scan to list."] = "가방에 업그레이드 %d개 — /pd scan 으로 확인"
L["%d upgrades in your bags - /pd scan to list."] = "가방에 업그레이드 %d개 — /pd scan 으로 확인"
L["No upgrades found in your bags."] = "가방에서 업그레이드 아이템을 찾지 못했습니다."
L["Items are still loading - try again shortly."] = "아이템 정보를 불러오는 중입니다. 잠시 후 다시 시도하세요."
L["Saved %d item - /reload to write to disk."] = "%d개 아이템 저장됨 — /reload 로 디스크에 기록"
L["Saved %d items - /reload to write to disk."] = "%d개 아이템 저장됨 — /reload 로 디스크에 기록"
L["PawnDynamic did not finish initializing."] = "PawnDynamic 초기화가 완료되지 않았습니다."
L["Debug mode enabled."] = "디버그 모드가 활성화되었습니다."
L["Debug mode disabled."] = "디버그 모드가 비활성화되었습니다."
L["Caches cleared and data refreshed."] = "캐시가 초기화되고 데이터가 새로고침되었습니다."
L["|cffff4040Error:|r %s (see /pd status)"] = "|cffff4040오류:|r %s (/pd status 확인)"
L["Commands: /pd (toggle UI) | /pd status | /pd scan | /pd debug [on|off|link] | /pd dump | /pd refresh"] =
    "명령어: /pd (창 토글) | /pd status | /pd scan | /pd debug [on|off|링크] | /pd dump | /pd refresh"
L["Shift+Click: Toggle Tooltip"] = "Shift+클릭: 툴팁 토글"

-- Getting started / About Tab
L["ABOUT_CREDITS"] = "제작자: Behmen  |  라이선스: MIT License (100% Clean-Room Lua, XML 없음)"
L["ABOUT_CAP_TITLE"] = "|cff00d1ff1. 동적 델타 한계치(Cap) 엔진:|r"
L["ABOUT_CAP_INTRO"] = "아이템 점수를 계산하기 전에 현재 장착 중인 아이템의 능력치를 캐릭터 합계에서 뺀 뒤 한계치 기준으로 새 아이템을 평가합니다:"
L["ABOUT_CAP_FORMULA"] = "실효 가치 = f(캐릭터 - 기존아이템 + 새아이템) - f(캐릭터 - 기존아이템)"
L["ABOUT_CAP_TARGET"] = "대상 적 레벨 (+0 / +2 / +3 또는 자동): 적중 (5% / 6% / 8%), 주문 적중 (4% / 6% / 17%), 방어 치명타 면역 (레벨*5 + 125/135/140), 숙련 (5% / 5.5% / 6.5%, 탱커 최대 14%) 및 방어도 (75% 감소) 공식 적용."
L["ABOUT_CAP_AVOIDANCE"] = "회피 합계 (강타 면역 100% / 101.6% / 102.4%): 빗맞힘 + 회피 + 무기 막기 + 방패 막기 합계가 한계치에 도달하면 방패 막기만 0이 되며 회피/무기 막기 가중치는 유지됩니다 (방패 직업 전용)."
L["ABOUT_CAP_REDUCTION"] = "초과 시 자동 감쇄: 쌍수 무기(자동 감지)는 일반 공격 적중 24-27%까지 반영하며, 가속은 50% GCD 한계치 초과 시 가중치가 완화됩니다."
L["ABOUT_CAP_DRUID"] = "드루이드 참고: 정확한 75% 방어도 한계치 계산을 위해 아이템 비교 시 곰 변신 상태로 전환하세요."
L["ABOUT_TALENTS_TITLE"] = "|cff00d1ff2. 특성 및 실시간 버프 (C_Traits + UNIT_AURA):|r"
L["ABOUT_TALENTS_DESC"] = "언어와 무관하게 spellID / nodeID로 특성을 감지하고, 신성한 방패 같은 버프를 오라를 통해 중복 계산 없이 실시간 반영하며 계열별 주문 적중 특성을 포함합니다."
L["ABOUT_PAWN_TITLE"] = "|cff00d1ff3. Pawn v1 호환성:|r"
L["ABOUT_PAWN_DESC"] = "'프로필' 탭에서 클래식 Pawn v1 문자열 전체 가져오기 및 내보내기를 지원합니다."
L["ABOUT_COMMANDS_TITLE"] = "|cff00d1ff4. 슬래시 명령어:|r"
L["ABOUT_CMD_PD"] = "/pd  또는  /pawndynamic — 창 열기/닫기"
L["ABOUT_CMD_STATUS"] = "/pd status — 실시간 능력치, 한계치, 특성 및 오류 기록"
L["ABOUT_CMD_SCAN"] = "/pd scan — 가방 내 모든 업그레이드 대화창에 출력"
L["ABOUT_CMD_DEBUG"] = "/pd debug [링크] — 상세 툴팁 및 능력치 분석"
L["ABOUT_CMD_DUMP"] = "/pd dump — 오류 분석용 인식 데이터를 SavedVariables에 저장"
L["ABOUT_CMD_REFRESH"] = "/pd refresh — 캐시 초기화 및 전체 재계산"

locale.scales = {
    WARRIOR = { ARMS = { name = "무기", match = "무기" }, FURY = { name = "분노", match = "분노" }, PROTECTION = { name = "방어", match = "방어" } },
    PALADIN = { HOLY = { name = "신성", match = "신성" }, PROTECTION = { name = "보호", match = "보호" }, RETRIBUTION = { name = "징벌", match = "징벌" } },
    HUNTER = { BEAST_MASTERY = { name = "야수", match = "야수" }, MARKSMANSHIP = { name = "사격", match = "사격" }, SURVIVAL = { name = "생존", match = "생존" } },
    ROGUE = { ASSASSINATION = { name = "암살", match = "암살" }, COMBAT = { name = "전투", match = "전투" }, SUBTLETY = { name = "잠행", match = "잠행" } },
    PRIEST = { DISCIPLINE = { name = "수양", match = "수양" }, HOLY = { name = "신성", match = "신성" }, SHADOW = { name = "암흑", match = "암흑" }, SMITE = { name = "성스러운 일격" } },
    SHAMAN = { ELEMENTAL = { name = "정기", match = "정기" }, ENHANCEMENT = { name = "고양", match = "고양" }, RESTORATION = { name = "복원", match = "복원" } },
    MAGE = { ARCANE = { name = "비전", match = "비전" }, FIRE = { name = "화염", match = "화염" }, FROST = { name = "냉기", match = "냉기" } },
    WARLOCK = { AFFLICTION = { name = "고통", match = "고통" }, DEMONOLOGY = { name = "악마", match = "악마" }, DESTRUCTION = { name = "파괴", match = "파괴" } },
    DRUID = { BALANCE = { name = "조화", match = "조화" }, FERAL_CAT = { name = "야성 (표범)", match = "야성" }, FERAL_BEAR = { name = "야성 (곰)" }, RESTORATION = { name = "회복", match = "회복" } },
}

locale.grammar = function(P)
    local NUM = P.NUM
    local GAP = "[^%d]-"
    local rules = {
        { "전투 시", false }, { "상대로", false }, { "%d+초 동안", false }, { "일정 확률로", false },
        { "피해 방어량이? " .. GAP .. NUM, "BLOCK_VALUE" },
        { "주문 관통력이? " .. GAP .. NUM, "SPELL_PEN" },
        { "치명타 적중률이? " .. GAP .. NUM .. "%%", "CRIT" },
        { "적중률이? " .. GAP .. NUM .. "%%", "HIT" },
        { "회피 또는 무기 막기 확률이? " .. GAP .. NUM .. "%%", "EXPERTISE", true },
        { "숙련도?가? " .. GAP .. NUM, "EXPERTISE" },
        { "회피 확률이? " .. GAP .. NUM .. "%%", "DODGE" },
        { "무기 막기 확률이? " .. GAP .. NUM .. "%%", "PARRY" },
        { "방패 막기 확률이? " .. GAP .. NUM .. "%%", "BLOCK" },
        { "방어 숙련도?가? " .. GAP .. NUM, "DEFENSE" },
        { "주문 공격력과 치유량이? " .. GAP .. NUM, P.AddSpellPower },
        { "치유량이? " .. GAP .. NUM, P.AddHealing },
        { "주문 공격력이? " .. GAP .. NUM, "SPELL_DAMAGE" },
        { "5초당 " .. NUM .. "의 마나", "MP5" },
        { "5초당 " .. NUM .. "의 생명력", "HP5" },
        { "원거리 전투력이? " .. GAP .. NUM, "RANGED_AP" },
        { "전투력이? " .. GAP .. NUM, "ATTACK_POWER" },
        { "가속" .. GAP .. NUM .. "%%", "HASTE" },
    }
    local names = {
        ["힘"] = "STRENGTH", ["민첩성"] = "AGILITY", ["체력"] = "STAMINA",
        ["지능"] = "INTELLECT", ["정신력"] = "SPIRIT", ["방어도"] = "ARMOR",
        ["방어 숙련"] = "DEFENSE", ["피해 방어량"] = "BLOCK_VALUE",
        ["적중 숙련도"] = P.Rating("HIT"), ["치명타 적중도"] = P.Rating("CRIT"),
        ["가속도"] = P.Rating("HASTE"), ["숙련"] = "EXPERTISE",
        ["주문력"] = P.AddSpellPower, ["모든 저항력"] = P.AddAllResistances,
    }
    local skip = { "사용 효과:", "발동 효과:", "세트:", "최소 요구", "직업:", "종족:", "내구도", "아이템 레벨", "판매 가격", "고유 아이템", "귀속", "\"" }
    local words = {
        equip = "^착용 효과: (.+)$", classes = "^직업: (.+)$", set = "^%(%d+%) 세트",
        range = { "^공격력 " .. NUM .. " %- " .. NUM }, flat = { "^공격력 " .. NUM .. "$" },
        dps = "%(초당 공격력 " .. NUM .. "%)", speed = "^공격 속도 " .. NUM,
        negative = { "^감소" }, also = ", ", plus = ", ", looseNumbers = false,
    }
    return { rules = rules, names = names, skip = skip, words = words }
end
