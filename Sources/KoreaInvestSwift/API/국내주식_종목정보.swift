//
//  국내주식_종목정보.swift
//  KoreaInvestSwift
//
//  Created by kin on 4/6/25.
//

import FullyRESTful

extension KISAPI {
    enum 국내주식_종목정보 {}
}

extension KISAPI.국내주식_종목정보 {
    /// 상품기본조회[v1_국내주식-029]
    struct searchinfo : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 상품번호
            /// '주식(하이닉스) : 000660 (코드 : 300) 선물(101S12) : KR4101SC0009 (코드 : 301) 미국(AAPL) : AAPL (코드 : 512)'
            let PDNO:String
            /// 상품유형코드
            /// '300 주식 301 선물옵션 302 채권 512 미국 나스닥 / 513 미국 뉴욕 / 529 미국 아멕스 515 일본 501 홍콩 / 543 홍콩CNY / 558 홍콩USD 507 베트남 하노이 / 508 베트남 호치민 551 중국 상해A / 552 중국 심천A'
            let PRDT_TYPE_CD:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세1 : Object
            let output: Output
        }
        public struct Output : Codable {
            /// 상품번호
            let pdno:String
            /// 상품유형코드
            let prdt_type_cd:String
            /// 상품명
            let prdt_name:String
            /// 상품명120
            let prdt_name120:String
            /// 상품약어명
            let prdt_abrv_name:String
            /// 상품영문명
            let prdt_eng_name:String
            /// 상품영문명120
            let prdt_eng_name120:String
            /// 상품영문약어명
            let prdt_eng_abrv_name:String
            /// 표준상품번호
            let std_pdno:String
            /// 단축상품번호
            let shtn_pdno:String
            /// 상품판매상태코드
            let prdt_sale_stat_cd:String
            /// 상품위험등급코드
            let prdt_risk_grad_cd:String
            /// 상품분류코드
            let prdt_clsf_cd:String
            /// 상품분류명
            let prdt_clsf_name:String
            /// 판매시작일자
            let sale_strt_dt:String
            /// 판매종료일자
            let sale_end_dt:String
            /// 랩어카운트자산유형코드
            let wrap_asst_type_cd:String
            /// 투자상품유형코드
            let ivst_prdt_type_cd:String
            /// 투자상품유형코드명
            let ivst_prdt_type_cd_name:String
            /// 최초등록일자
            let frst_erlm_dt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/search-info"
        public var customHeader: [String : String]?
        init(tr_id: String = "CTPF1604R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // CTPF1604R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 주식기본조회[v1_국내주식-067]
    /// 주식기본조회 API입니다.국내주식 종목의 종목상세정보를 확인할 수 있습니다.
    struct searchstockinfo : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 상품유형코드
            /// 300: 주식, ETF, ETN, ELW 301 : 선물옵션 302 : 채권 306 : ELS'
            let PRDT_TYPE_CD:String
            /// 상품번호
            /// 종목번호 (6자리) ETN의 경우, Q로 시작 (EX. Q500001)
            let PDNO:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세1 : Object
            let output: Output
        }
        public struct Output : Codable {
            /// 상품번호
            let pdno:String
            /// 상품유형코드
            let prdt_type_cd:String
            /// 시장ID코드
            /// AGR.농축산물파생 BON.채권파생 CMD.일반상품시장 CUR.통화파생 ENG.에너지파생 EQU.주식파생 ETF.ETF파생 IRT.금리파생 KNX.코넥스 KSQ.코스닥 MTL.금속파생 SPI.주가지수파생 STK.유가증권
            let mket_id_cd:String
            /// 증권그룹ID코드
            /// BC.수익증권 DR.주식예탁증서 EF.ETF EN.ETN EW.ELW FE.해외ETF FO.선물옵션 FS.외국주권 FU.선물 FX.플렉스 선물 GD.금현물 IC.투자계약증권 IF.사회간접자본투융자회사 KN.코넥스주권 MF.투자회사 OP.옵션 RT.부동산투자회사 SC.선박투자회사 SR.신주인수권증서 ST.주권 SW.신주인수권증권 TC.신탁수익증권
            let scty_grp_id_cd:String
            /// 거래소구분코드
            /// 01.한국증권 02.증권거래소 03.코스닥 04.K-OTC 05.선물거래소 06.CME 07.EUREX 21.금현물 50.미국주간 51.홍콩 52.상해B 53.심천 54.홍콩거래소 55.미국 56.일본 57.상해A 58.심천A 59.베트남 61.장전시간외시장 64.경쟁대량매매 65.경매매시장 81.시간외단일가시장
            let excg_dvsn_cd:String
            /// 결산월일
            let setl_mmdd:String
            /// 상장주수
            let lstg_stqt:String
            /// 상장자본금액
            let lstg_cptl_amt:String
            /// 자본금
            let cpta:String
            /// 액면가
            let papr:String
            /// 발행가격
            let issu_pric:String
            /// 코스피200종목여부
            let kospi200_item_yn:String
            /// 유가증권시장상장일자
            let scts_mket_lstg_dt:String
            /// 유가증권시장상장폐지일자
            let scts_mket_lstg_abol_dt:String
            /// 코스닥시장상장일자
            let kosdaq_mket_lstg_dt:String
            /// 코스닥시장상장폐지일자
            let kosdaq_mket_lstg_abol_dt:String
            /// 프리보드시장상장일자
            let frbd_mket_lstg_dt:String
            /// 프리보드시장상장폐지일자
            let frbd_mket_lstg_abol_dt:String
            /// 리츠종류코드
            let reits_kind_cd:String
            /// ETF구분코드
            let etf_dvsn_cd:String
            /// 유전펀드여부
            let oilf_fund_yn:String
            /// 지수업종대분류코드
            let idx_bztp_lcls_cd:String
            /// 지수업종중분류코드
            let idx_bztp_mcls_cd:String
            /// 지수업종소분류코드
            let idx_bztp_scls_cd:String
            /// 주식종류코드
            /// 000.해당사항없음 101.보통주 201.우선주 202.2우선주 203.3우선주 204.4우선주 205.5우선주 206.6우선주 207.7우선주 208.8우선주 209.9우선주 210.10우선주 211.11우선주 212.12우선주 213.13우선주 214.14우선주 215.15우선주 216.16우선주 217.17우선주 218.18우선주 219.19우선주 220.20우선주 301.후배주 401.혼합주
            let stck_kind_cd:String
            /// 뮤추얼펀드개시일자
            let mfnd_opng_dt:String
            /// 뮤추얼펀드종료일자
            let mfnd_end_dt:String
            /// 예탁등록취소일자
            let dpsi_erlm_cncl_dt:String
            /// ETFCU수량
            let etf_cu_qty:String
            /// 상품명
            let prdt_name:String
            /// 상품명120
            let prdt_name120:String
            /// 상품약어명
            let prdt_abrv_name:String
            /// 표준상품번호
            let std_pdno:String
            /// 상품영문명
            let prdt_eng_name:String
            /// 상품영문명120
            let prdt_eng_name120:String
            /// 상품영문약어명
            let prdt_eng_abrv_name:String
            /// 예탁지정등록여부
            let dpsi_aptm_erlm_yn:String
            /// ETF과세유형코드
            let etf_txtn_type_cd:String
            /// ETF유형코드
            let etf_type_cd:String
            /// 상장폐지일자
            let lstg_abol_dt:String
            /// 신주구주구분코드
            let nwst_odst_dvsn_cd:String
            /// 대용가격
            let sbst_pric:String
            /// 당사대용가격
            let thco_sbst_pric:String
            /// 당사대용가격변경일자
            let thco_sbst_pric_chng_dt:String
            /// 거래정지여부
            let tr_stop_yn:String
            /// 관리종목여부
            let admn_item_yn:String
            /// 당일종가
            let thdt_clpr:String
            /// 전일종가
            let bfdy_clpr:String
            /// 종가변경일자
            let clpr_chng_dt:String
            /// 표준산업분류코드
            let std_idst_clsf_cd:String
            /// 표준산업분류코드명
            /// 표준산업소분류코드 000000 해당사항없음 010101 작물 재배업 010102 축산업 010103 작물재배 및 축산 복합농업 010104 작물재배 및 축산 관련 서비스업 010105 수렵 및 관련 서비스업 010201 임업 010301 어로 어업 010302 양식어업 및 어업관련 서비스업 020501 석탄 광업 020502 원유 및 천연가스 채굴업 020601 철 광업 020602 비철금속 광업 020701 토사석 광업 020702 기타 비금속광물 광업 020801 광업 지원 서비스업 031001 도축, 육류 가공 및 저장 처리업 031002 수산물 가공 및 저장 처리업 031003 과실, 채소 가공 및 저장 처리업 031004 동물성 및 식물성 유지 제조업 031005 낙농제품 및 식용빙과류 제조업 031006 곡물가공품, 전분 및 전분제품 제조업 031007 기타 식품 제조업 031008 동물용 사료 및 조제식품 제조업 031101 알콜음료 제조업 031102 비알콜음료 및 얼음 제조업 031201 담배 제조업 031301 방적 및 가공사 제조업 031302 직물직조 및 직물제품 제조업 031303 편조원단 및 편조제품 제조업 031304 섬유제품 염색, 정리 및 마무리 가공업 031309 기타 섬유제품 제조업 031401 봉제의복 제조업 031402 모피가공 및 모피제품 제조업 031403 편조의복 제조업 031404 의복 액세서리 제조업 031501 가죽, 가방 및 유사제품 제조업 031502 신발 및 신발부분품 제조업 031601 제재 및 목재 가공업 031602 나무제품 제조업 031603 코르크 및 조물 제품 제조업 031701 펄프, 종이 및 판지 제조업 031702 골판지, 종이 상자 및 종이용기 제조업 031709 기타 종이 및 판지 제품 제조업 031801 인쇄 및 인쇄관련 산업 031802 기록매체 복제업 031901 코크스 및 연탄 제조업 031902 석유 정제품 제조업 032001 기초화학물질 제조업 032002 비료 및 질소화합물 제조업 032003 합성고무 및 플라스틱 물질 제조업 032004 기타 화학제품 제조업 032005 화학섬유 제조업 032101 기초 의약물질 및 생물학적 제제 제조업 032102 의약품 제조업 032103 의료용품 및 기타 의약관련제품 제조업 032201 고무제품 제조업 032202 플라스틱제품 제조업 032301 유리 및 유리제품 제조업 032302 도자기 및 기타 요업제품 제조업 032303 시멘트, 석회, 플라스터 및 그 제품 제조업 032309 기타 비금속 광물제품 제조업 032401 1차 철강 제조업 032402 1차 비철금속 제조업 032403 금속 주조업 032501 구조용 금속제품, 탱크 및 증기발생기 제조업 032502 무기 및 총포탄 제조업 032509 기타 금속가공제품 제조업 032601 반도체 제조업 032602 전자부품 제조업 032603 컴퓨터 및 주변장치 제조업 032604 통신 및 방송 장비 제조업 032605 영상 및 음향기기 제조업 032606 마그네틱 및 광학 매체 제조업 032701 의료용 기기 제조업 032702 측정, 시험, 항해, 제어 및 기타 정밀기기 제조업; ? 032703 안경, 사진장비 및 기타 광학기기 제조업 032704 시계 및 시계부품 제조업 032801 전동기, 발전기 및 전기 변환 · 공급 · 제어 장치 032802 일차전지 및 축전지 제조업 032803 절연선 및 케이블 제조업 032804 전구 및 조명장치 제조업 032805 가정용 기기 제조업 032809 기타 전기장비 제조업 032901 일반 목적용 기계 제조업 032902 특수 목적용 기계 제조업 033001 자동차용 엔진 및 자동차 제조업 033002 자동차 차체 및 트레일러 제조업 033003 자동차 부품 제조업 033101 선박 및 보트 건조업 033102 철도장비 제조업 033103 항공기,우주선 및 부품 제조업 033109 그외 기타 운송장비 제조업 033201 가구 제조업 033301 귀금속 및 장신용품 제조업 033302 악기 제조업 033303 운동 및 경기용구 제조업 033304 인형,장난감 및 오락용품 제조업 033309 그외 기타 제품 제조업 043501 전기업 043502 가스 제조 및 배관공급업 043503 증기, 냉온수 및 공기조절 공급업 043601 수도사업 053701 하수, 폐수 및 분뇨 처리업 053801 폐기물 수집운반업 053802 폐기물 처리업 053803 금속 및 비금속 원료 재생업 053901 환경 정화 및 복원업 064101 건물 건설업 064102 토목 건설업 064201 기반조성 및 시설물 축조관련 전문공사업 064202 건물설비 설치 공사업 064203 전기 및 통신 공사업 064204 실내건축 및 건축 마무리 공사업 064205 건설장비 운영업 074501 자동차 판매업 074502 자동차 부품 및 내장품 판매업 074503 모터사이클 및 부품 판매업 074601 상품 중개업 074602 산업용 농축산물 및 산동물 도매업 074603 음·식료품 및 담배 도매업 074604 가정용품 도매업 074605 기계장비 및 관련 물품 도매업 074606 건축자재, 철물 및 난방장치 도매업 074607 기타 전문 도매업 074608 상품 종합 도매업 074701 종합 소매업 074702 음·식료품 및 담배 소매업 074703 정보통신장비 소매업 074704 섬유, 의복, 신발 및 가죽제품 소매업 074705 기타 가정용품 소매업 074706 문화, 오락 및 여가 용품 소매업 074707 연료 소매업 074708 기타 상품 전문 소매업 074709 무점포 소매업 084901 철도운송업 084902 육상 여객 운송업 084903 도로 화물 운송업 084904 소화물 전문 운송업 084905 파이프라인 운송업 085001 해상 운송업 085002 내륙 수상 및 항만내 운송업 085101 정기 항공 운송업 085102 부정기 항공 운송업 085201 보관 및 창고업 085209 기타 운송관련 서비스업 095501 숙박시설 운영업 095509 기타 숙박업 095601 음식점업 095602 주점 및 비알콜음료점업 105801 서적, 잡지 및 기타 인쇄물 출판업 105802 소프트웨어 개발 및 공급업 105901 영화, 비디오물, 방송프로그램 제작 및 배급업 105902 오디오물 출판 및 원판 녹음업 106001 라디오 방송업 106002 텔레비전 방송업 106101 우편업 106102 전기통신업 106201 컴퓨터 프로그래밍, 시스템 통합 및 관리업 106301 자료처리, 호스팅, 포털 및 기타 인터넷 정보매개서? 106309 기타 정보 서비스업 116401 은행 및 저축기관 116402 투자기관 116409 기타 금융업 116501 보험업 116502 재 보험업 116503 연금 및 공제업 116601 금융지원 서비스업 116602 보험 및 연금관련 서비스업 126801 부동산 임대 및 공급업 126802 부동산 관련 서비스업 126901 운송장비 임대업 126902 개인 및 가정용품 임대업 126903 산업용 기계 및 장비 임대업 126904 무형재산권 임대업 137001 자연과학 및 공학 연구개발업 137002 인문 및 사회과학 연구개발업 137101 법무관련 서비스업 137102 회계 및 세무관련 서비스업 137103 광고업 137104 시장조사 및 여론조사업 137105 회사본부, 지주회사 및 경영컨설팅 서비스업 137201 건축기술, 엔지니어링 및 관련기술 서비스업 137209 기타 과학기술 서비스업 137301 수의업 137302 전문디자인업 137303 사진 촬영 및 처리업 137309 그외 기타 전문, 과학 및 기술 서비스업 147401 사업시설 유지관리 서비스업 147402 건물·산업설비 청소 및 방제 서비스업 147403 조경 관리 및 유지 서비스업 147501 인력공급 및 고용알선업 147502 여행사 및 기타 여행보조 서비스업 147503 경비, 경호 및 탐정업 147509 기타 사업지원 서비스업 158401 입법 및 일반 정부 행정 158402 사회 및 산업정책 행정 158403 외무 및 국방 행정 158404 사법 및 공공질서 행정 158405 사회보장 행정 168501 초등 교육기관 168502 중등 교육기관 168503 고등 교육기관 168504 특수학교, 외국인학교 및 대안학교 168505 일반 교습 학원 168506 기타 교육기관 168507 교육지원 서비스업 178601 병원 178602 의원 178603 공중 보건 의료업 178609 기타 보건업 178701 거주 복지시설 운영업 178702 비거주 복지시설 운영업 189001 창작 및 예술관련 서비스업 189002 도서관, 사적지 및 유사 여가관련 서비스업 189101 스포츠 서비스업 189102 유원지 및 기타 오락관련 서비스업 199401 산업 및 전문가 단체 199402 노동조합 199409 기타 협회 및 단체 199501 기계 및 장비 수리업 199502 자동차 및 모터사이클 수리업 199503 개인 및 가정용품 수리업 199601 미용, 욕탕 및 유사 서비스업 199609 그외 기타 개인 서비스업 209701 가구내 고용활동 209801 자가 소비를 위한 가사 생산 활동 209802 자가 소비를 위한 가사 서비스 활동 219901 국제 및 외국기관
            let std_idst_clsf_cd_name:String
            /// 지수업종대분류코드명
            /// 표준산업대분류코드 00 해당사항없음 01 농업, 임업 및 어업 02 광업 03 제조업 04 전기, 가스, 증기 및 수도사업 05 하수-폐기물 처리, 원료재생 및환경복원업 06 건설업 07 도매 및 소매업 08 운수업 09 숙박 및 음식점업 10 출판, 영상, 방송통신 및 정보서비스업 11 금융 및 보험업 12 부동산업 및 임대업 13 전문, 과학 및 기술 서비스업 14 사업시설관리 및 사업지원서비스업 15 공공행정, 국방 및 사회보장 행정 16 교육 서비스업 17 보건업 및 사회복지 서비스업 18 예술, 스포츠 및 여가관련 서비스업 19 협회 및 단체, 수리 및 기타 개인 서비스업 20 가구내 고용활동 및 달리 분류되지 않은 자가소비생산활동 21 국제 및 외국기관
            let idx_bztp_lcls_cd_name:String
            /// 지수업종중분류코드명
            /// 표준산업중분류코드 0000 해당사항없음 0101 농업 0102 임업 0103 어업 0205 석탄, 원유 및 천연가스 광업 0206 금속 광업 0207 비금속광물 광업; 연료용 제외 0208 광업 지원 서비스업 0310 식료품 제조업 0311 음료 제조업 0312 담배 제조업 0313 섬유제품 제조업; 의복제외 0314 의복, 의복액세서리 및 모피제품제조업 0315 가죽, 가방 및 신발 제조업 0316 목재 및 나무제품 제조업;가구제외 0317 펄프, 종이 및 종이제품 제조업 0318 인쇄 및 기록매체 복제업 0319 코크스, 연탄 및 석유정제품 제조업 0320 화학물질 및 화학제품 제조업;의약품 제외 0321 의료용 물질 및 의약품 제조업 0322 고무제품 및 플라스틱제품 제조업 0323 비금속 광물제품 제조업 0324 1차 금속 제조업 0325 금속가공제품 제조업;기계 및가구 제외 0326 전자부품, 컴퓨터, 영상, 음향 및 통신장비 제조업 0327 의료, 정밀, 광학기기 및 시계 제조업 0328 전기장비 제조업 0329 기타 기계 및 장비 제조업 0330 자동차 및 트레일러 제조업 0331 기타 운송장비 제조업 0332 가구 제조업 0333 기타 제품 제조업 0435 전기, 가스, 증기 및 공기조절 공급업 0436 수도사업 0537 하수, 폐수 및 분뇨 처리업 0538 폐기물 수집운반, 처리 및 원료재생업 0539 환경 정화 및 복원업 0641 종합 건설업 0642 전문직별 공사업 0745 자동차 및 부품 판매업 0746 도매 및 상품중개업 0747 소매업; 자동차 제외 0849 육상운송 및 파이프라인 운송업 0850 수상 운송업 0851 항공 운송업 0852 창고 및 운송관련 서비스업 0955 숙박업 0956 음식점 및 주점업 1058 출판업 1059 영상·오디오 기록물 제작 및 배급업 1060 방송업 1061 통신업 1062 컴퓨터 프로그래밍, 시스템 통합및 관리업 1063 정보서비스업 1164 금융업 1165 보험 및 연금업 1166 금융 및 보험 관련 서비스업 1268 부동산업 1269 임대업;부동산 제외 1370 연구개발업 1371 전문서비스업 1372 건축기술, 엔지니어링 및 기타과학기술 서비스업 1373 기타 전문, 과학 및 기술 서비스업 1474 사업시설 관리 및 조경 서비스업 1475 사업지원 서비스업 1584 공공행정, 국방 및 사회보장 행정 1685 교육 서비스업 1786 보건업 1787 사회복지 서비스업 1890 창작, 예술 및 여가관련 서비스업 1891 스포츠 및 오락관련 서비스업 1994 협회 및 단체 1995 수리업 1996 기타 개인 서비스업 2097 가구내 고용활동 2098 달리 분류되지 않은 자가소비를 위한가구의 재화 및 서비스 생산활동 2199 국제 및 외국기관
            let idx_bztp_mcls_cd_name:String
            /// 지수업종소분류코드명
            /// 표준산업소분류코드 참조
            let idx_bztp_scls_cd_name:String
            /// OCR번호
            let ocr_no:String
            /// 크라우드펀딩종목여부
            let crfd_item_yn:String
            /// 전자증권여부
            let elec_scty_yn:String
            /// 발행기관코드
            let issu_istt_cd:String
            /// ETF추적수익율배수
            let etf_chas_erng_rt_dbnb:String
            /// ETFETN투자유의종목여부
            let etf_etn_ivst_heed_item_yn:String
            /// 대주이자율구분코드
            let stln_int_rt_dvsn_cd:String
            /// 외국인개인한도비율
            let frnr_psnl_lmt_rt:String
            /// 상장신청인발행기관코드
            let lstg_rqsr_issu_istt_cd:String
            /// 상장신청인종목코드
            let lstg_rqsr_item_cd:String
            /// 신탁기관발행기관코드
            let trst_istt_issu_istt_cd:String
            /// NXT 거래종목여부
            /// NXT 거래가능한 종목은 Y, 그 외 종목은 N
            let cptt_trad_tr_psbl_yn:String
            /// NXT 거래정지여부
            /// NXT 거래종목 중 거래정지가 된 종목은 Y, 그 외 모든 종목은 N
            let nxt_tr_stop_yn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/search-stock-info"
        public var customHeader: [String : String]?
        init(tr_id: String = "CTPF1002R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // CTPF1002R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 국내주식 대차대조표[v1_국내주식-078]
    /// 국내주식 대차대조표 API입니다.한국투자 HTS(eFriend Plus) > [0635] 재무분석종합 화면의 하단 '1. 대차대조표' 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct balancesheet : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 분류 구분 코드
            /// 0: 년, 1: 분기
            let FID_DIV_CLS_CODE:String
            /// 조건 시장 분류 코드
            /// J
            let fid_cond_mrkt_div_code:String
            /// 입력 종목코드
            /// 000660 : 종목코드
            let fid_input_iscd:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output: [Output]
        }
        public struct Output : Codable {
            /// 결산 년월
            let stac_yymm:String
            /// 유동자산
            let cras:String
            /// 고정자산
            let fxas:String
            /// 자산총계
            let total_aset:String
            /// 유동부채
            let flow_lblt:String
            /// 고정부채
            let fix_lblt:String
            /// 부채총계
            let total_lblt:String
            /// 자본금
            let cpfn:String
            /// 자본 잉여금
            /// 출력되지 않는 데이터(99.99 로 표시)
            let cfp_surp:String
            /// 이익 잉여금
            /// 출력되지 않는 데이터(99.99 로 표시)
            let prfi_surp:String
            /// 자본총계
            let total_cptl:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/finance/balance-sheet"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKST66430100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST66430100
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 국내주식 손익계산서[v1_국내주식-079]
    /// 국내주식 손익계산서 API입니다.한국투자 HTS(eFriend Plus) > [0635] 재무분석종합 화면의 하단 '2. 손익계산서' 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct incomestatement : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 분류 구분 코드
            /// 0: 년, 1: 분기 ※ 분기데이터는 연단위 누적합산
            let FID_DIV_CLS_CODE:String
            /// 조건 시장 분류 코드
            /// J
            let fid_cond_mrkt_div_code:String
            /// 입력 종목코드
            /// 000660 : 종목코드
            let fid_input_iscd:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output: [Output]
        }
        public struct Output : Codable {
            /// 결산 년월
            let stac_yymm:String
            /// 매출액
            let sale_account:String
            /// 매출 원가
            let sale_cost:String
            /// 매출 총 이익
            let sale_totl_prfi:String
            /// 감가상각비
            /// 출력되지 않는 데이터(99.99 로 표시)
            let depr_cost:String
            /// 판매 및 관리비
            /// 출력되지 않는 데이터(99.99 로 표시)
            let sell_mang:String
            /// 영업 이익
            let bsop_prti:String
            /// 영업 외 수익
            /// 출력되지 않는 데이터(99.99 로 표시)
            let bsop_non_ernn:String
            /// 영업 외 비용
            /// 출력되지 않는 데이터(99.99 로 표시)
            let bsop_non_expn:String
            /// 경상 이익
            let op_prfi:String
            /// 특별 이익
            let spec_prfi:String
            /// 특별 손실
            let spec_loss:String
            /// 당기순이익
            let thtr_ntin:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/finance/income-statement"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKST66430200", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST66430200
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 국내주식 재무비율[v1_국내주식-080]
    /// 국내주식 재무비율 API입니다.한국투자 HTS(eFriend Plus) > [0635] 재무분석종합 화면의 우측의 '재무 비율' 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct financialratio : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 분류 구분 코드
            /// 0: 년, 1: 분기
            let FID_DIV_CLS_CODE:String
            /// 조건 시장 분류 코드
            /// J
            let fid_cond_mrkt_div_code:String
            /// 입력 종목코드
            /// 000660 : 종목코드
            let fid_input_iscd:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output: [Output]
        }
        public struct Output : Codable {
            /// 결산 년월
            let stac_yymm:String
            /// 매출액 증가율
            let grs:String
            /// 영업 이익 증가율
            /// 적자지속, 흑자전환, 적자전환인 경우 0으로 표시
            let bsop_prfi_inrt:String
            /// 순이익 증가율
            let ntin_inrt:String
            /// ROE 값
            let roe_val:String
            /// EPS
            let eps:String
            /// 주당매출액
            let sps:String
            /// BPS
            let bps:String
            /// 유보 비율
            let rsrv_rate:String
            /// 부채 비율
            let lblt_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/finance/financial-ratio"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKST66430300", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST66430300
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 국내주식 수익성비율[v1_국내주식-081]
    /// 국내주식 수익성비율 API입니다.한국투자 HTS(eFriend Plus) > [0635] 재무분석종합 화면의 하단 '4. 수익성비율' 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct profitratio : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 입력 종목코드
            /// 000660 : 종목코드
            let fid_input_iscd:String
            /// 분류 구분 코드
            /// 0: 년, 1: 분기
            let FID_DIV_CLS_CODE:String
            /// 조건 시장 분류 코드
            /// J
            let fid_cond_mrkt_div_code:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output: [Output]
        }
        public struct Output : Codable {
            /// 결산 년월
            let stac_yymm:String
            /// 총자본 순이익율
            let cptl_ntin_rate:String
            /// 자기자본 순이익율
            let self_cptl_ntin_inrt:String
            /// 매출액 순이익율
            let sale_ntin_rate:String
            /// 매출액 총이익율
            let sale_totl_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/finance/profit-ratio"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKST66430400", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST66430400
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 국내주식 기타주요비율[v1_국내주식-082]
    /// 국내주식 기타주요비율 API입니다.한국투자 HTS(eFriend Plus) > [0635] 재무분석종합 화면의 하단 '9. 기타주요비율' 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct othermajorratios : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 입력 종목코드
            /// 000660 : 종목코드
            let fid_input_iscd:String
            /// 분류 구분 코드
            /// 0: 년, 1: 분기
            let fid_div_cls_code:String
            /// 조건 시장 분류 코드
            /// J
            let fid_cond_mrkt_div_code:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output: [Output]
        }
        public struct Output : Codable {
            /// 결산 년월
            let stac_yymm:String
            /// 배당 성향
            /// 비정상 출력되는 데이터로 무시
            let payout_rate:String
            /// EVA
            let eva:String
            /// EBITDA
            let ebitda:String
            /// EV_EBITDA
            let ev_ebitda:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/finance/other-major-ratios"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKST66430500", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST66430500
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 국내주식 안정성비율[v1_국내주식-083]
    /// 국내주식 안정성비율 API입니다.한국투자 HTS(eFriend Plus) > [0635] 재무분석종합 화면의 하단 '5. 안정성비율' 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct stabilityratio : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 입력 종목코드
            /// 000660 : 종목코드
            let fid_input_iscd:String
            /// 분류 구분 코드
            /// 0: 년, 1: 분기
            let fid_div_cls_code:String
            /// 조건 시장 분류 코드
            /// J
            let fid_cond_mrkt_div_code:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output: [Output]
        }
        public struct Output : Codable {
            /// 결산 년월
            let stac_yymm:String
            /// 부채 비율
            let lblt_rate:String
            /// 차입금 의존도
            let bram_depn:String
            /// 유동 비율
            let crnt_rate:String
            /// 당좌 비율
            let quck_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/finance/stability-ratio"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKST66430600", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST66430600
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 국내주식 성장성비율[v1_국내주식-085]
    /// 국내주식 성장성비율 API입니다.한국투자 HTS(eFriend Plus) > [0635] 재무분석종합 화면의 하단 '7.성장성비율' 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct growthratio : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 입력 종목코드
            /// ex : 000660
            let fid_input_iscd:String
            /// 분류 구분 코드
            /// 0: 년, 1: 분기
            let fid_div_cls_code:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let fid_cond_mrkt_div_code:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output: [Output]
        }
        public struct Output : Codable {
            /// 결산 년월
            let stac_yymm:String
            /// 매출액 증가율
            let grs:String
            /// 영업 이익 증가율
            let bsop_prfi_inrt:String
            /// 자기자본 증가율
            let equt_inrt:String
            /// 총자산 증가율
            let totl_aset_inrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/finance/growth-ratio"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKST66430800", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST66430800
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 국내주식 당사 신용가능종목[국내주식-111]
    /// 국내주식 당사 신용가능종목 API입니다.한국투자 HTS(eFriend Plus) > [0477] 당사 신용가능 종목 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 100건 확인 가능하며, 다음 조회가 불가합니다.
    struct creditbycompany : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 순위 정렬 구분 코드
            /// 0:코드순, 1:이름순
            let fid_rank_sort_cls_code:String
            /// 선택 여부
            /// 0:신용주문가능, 1: 신용주문불가
            let fid_slct_yn:String
            /// 입력 종목코드
            /// 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200, 4001: KRX100
            let fid_input_iscd:String
            /// 조건 화면 분류 코드
            /// Unique key(20477)
            let fid_cond_scr_div_code:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let fid_cond_mrkt_div_code:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output: [Output]
        }
        public struct Output : Codable {
            /// 주식 단축 종목코드
            let stck_shrn_iscd:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 신용 비율
            let crdt_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/credit-by-company"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPST04770000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST04770000
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 예탁원정보(배당일정)[국내주식-145]
    /// 예탁원정보(배당일정) API입니다. 한국투자 HTS(eFriend Plus) > [0658] 배당 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 예탁원에서 제공한 자료이므로 정보용으로만 사용하시기 바랍니다.'주식배당지급일'은 배당주식의 주식교부일자를 말합니다. 배당주식의 계좌입고는 배당주식 상장일인데 일반적으로 주권교부일의 익영업일입니다.
    struct dividend : APIITEM, NeedHash {
        public struct Request : Codable {
            /// CTS
            /// 공백
            let CTS:String
            /// 조회구분
            /// 0:배당전체, 1:결산배당, 2:중간배당
            let GB1:String
            /// 조회일자From
            /// 일자 ~
            let F_DT:String
            /// 조회일자To
            /// ~ 일자
            let T_DT:String
            /// 종목코드
            /// 공백: 전체, 특정종목 조회시 : 종목코드
            let SHT_CD:String
            /// 고배당여부
            /// 공백
            let HIGH_GB:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
        }
        public struct Output1 : Codable {
            /// 기준일
            let record_date:String
            /// 종목코드
            let sht_cd:String
            /// 종목명
            let isin_name:String
            /// 배당종류
            let divi_kind:String
            /// 액면가
            let face_val:String
            /// 현금배당금
            let per_sto_divi_amt:String
            /// 현금배당률(%)
            let divi_rate:String
            /// 주식배당률(%)
            let stk_divi_rate:String
            /// 배당금지급일
            let divi_pay_dt:String
            /// 주식배당지급일
            let stk_div_pay_dt:String
            /// 단주대금지급일
            let odd_pay_dt:String
            /// 주식종류
            let stk_kind:String
            /// 고배당종목여부
            let high_divi_gb:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ksdinfo/dividend"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHKDB669102C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHKDB669102C0
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 예탁원정보(주식매수청구일정)[국내주식-146]
    /// 예탁원정보(주식매수청구일정) API입니다. 한국투자 HTS(eFriend Plus) > [0663] 주식매수청구 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 예탁원에서 제공한 자료이므로 정보용으로만 사용하시기 바랍니다.
    struct purreq : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// 공백: 전체, 특정종목 조회시 : 종목코드
            let SHT_CD:String
            /// 조회일자To
            /// ~ 일자
            let T_DT:String
            /// 조회일자From
            /// 일자 ~
            let F_DT:String
            /// CTS
            /// 공백
            let CTS:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
        }
        public struct Output1 : Codable {
            /// 기준일
            let record_date:String
            /// 종목코드
            let sht_cd:String
            /// 종목명
            let isin_name:String
            /// 주식종류
            let stk_kind:String
            /// 반대의사접수시한
            let opp_opi_rcpt_term:String
            /// 매수청구접수시한
            let buy_req_rcpt_term:String
            /// 매수청구가격
            let buy_req_price:String
            /// 매수대금지급일
            let buy_amt_pay_dt:String
            /// 주총일
            let get_meet_dt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ksdinfo/purreq"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHKDB669103C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHKDB669103C0
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 예탁원정보(합병/분할일정)[국내주식-147]
    /// 예탁원정보(합병/분할일정) API입니다. 한국투자 HTS(eFriend Plus) > [0664] 합병/분할 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 예탁원에서 제공한 자료이므로 정보용으로만 사용하시기 바랍니다.
    struct mergersplit : APIITEM, NeedHash {
        public struct Request : Codable {
            /// CTS
            /// 공백
            let CTS:String
            /// 조회일자From
            /// 일자 ~
            let F_DT:String
            /// 조회일자To
            /// ~ 일자
            let T_DT:String
            /// 종목코드
            /// 공백: 전체, 특정종목 조회시 : 종목코드
            let SHT_CD:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
        }
        public struct Output1 : Codable {
            /// 기준일
            let record_date:String
            /// 종목코드
            let sht_cd:String
            /// 피합병(피분할)회사코드
            let opp_cust_cd:String
            /// 피합병(피분할)회사명
            let opp_cust_nm:String
            /// 합병(분할)회사코드
            let cust_cd:String
            /// 합병(분할)회사명
            let cust_nm:String
            /// 합병사유
            let merge_type:String
            /// 비율
            let merge_rate:String
            /// 매매거래정지기간
            let td_stop_dt:String
            /// 상장/등록일
            let list_dt:String
            /// 단주대금지급일
            let odd_amt_pay_dt:String
            /// 발행주식
            let tot_issue_stk_qty:String
            /// 발행할주식
            let issue_stk_qty:String
            /// 연번
            let seq:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ksdinfo/merger-split"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHKDB669104C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHKDB669104C0
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 예탁원정보(액면교체일정)[국내주식-148]
    /// 예탁원정보(액면교체일정) API입니다. 한국투자 HTS(eFriend Plus) > [0657] 액면교체 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 예탁원에서 제공한 자료이므로 정보용으로만 사용하시기 바랍니다.
    struct revsplit : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// 공백: 전체, 특정종목 조회시 : 종목코드
            let SHT_CD:String
            /// CTS
            /// 공백
            let CTS:String
            /// 조회일자From
            /// 일자 ~
            let F_DT:String
            /// 조회일자To
            /// ~ 일자
            let T_DT:String
            /// 시장구분
            /// 0:전체, 1:코스피, 2:코스닥
            let MARKET_GB:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
        }
        public struct Output1 : Codable {
            /// 기준일
            let record_date:String
            /// 종목코드
            let sht_cd:String
            /// 종목명
            let isin_name:String
            /// 변경전액면가
            let inter_bf_face_amt:String
            /// 변경후액면가
            let inter_af_face_amt:String
            /// 매매거래정지기간
            let td_stop_dt:String
            /// 상장/등록일
            let list_dt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ksdinfo/rev-split"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHKDB669105C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHKDB669105C0
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 예탁원정보(자본감소일정)[국내주식-149]
    /// 예탁원정보(자본감소일정) API입니다. 한국투자 HTS(eFriend Plus) > [0665] 자본감소 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 예탁원에서 제공한 자료이므로 정보용으로만 사용하시기 바랍니다.
    struct capdcrs : APIITEM, NeedHash {
        public struct Request : Codable {
            /// CTS
            /// 공백
            let CTS:String
            /// 조회일자From
            /// 일자 ~
            let F_DT:String
            /// 조회일자To
            /// ~ 일자
            let T_DT:String
            /// 종목코드
            /// 공백: 전체, 특정종목 조회시 : 종목코드
            let SHT_CD:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
        }
        public struct Output1 : Codable {
            /// 기준일
            let record_date:String
            /// 종목코드
            let sht_cd:String
            /// 종목명
            let isin_name:String
            /// 주식종류
            let stk_kind:String
            /// 감자구분
            let reduce_cap_type:String
            /// 감자배정율
            let reduce_cap_rate:String
            /// 계산방법
            let comp_way:String
            /// 매매거래정지기간
            let td_stop_dt:String
            /// 상장/등록일
            let list_dt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ksdinfo/cap-dcrs"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHKDB669106C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHKDB669106C0
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 예탁원정보(상장정보일정)[국내주식-150]
    /// 예탁원정보(상장정보일정) API입니다. 한국투자 HTS(eFriend Plus) > [0666] 상장정보 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 예탁원에서 제공한 자료이므로 정보용으로만 사용하시기 바랍니다.
    struct listinfo : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// 공백: 전체, 특정종목 조회시 : 종목코드
            let SHT_CD:String
            /// 조회일자To
            /// ~ 일자
            let T_DT:String
            /// 조회일자From
            /// 일자 ~
            let F_DT:String
            /// CTS
            /// 공백
            let CTS:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
        }
        public struct Output1 : Codable {
            /// 상장/등록일
            let list_dt:String
            /// 종목코드
            let sht_cd:String
            /// 종목명
            let isin_name:String
            /// 주식종류
            let stk_kind:String
            /// 사유
            let issue_type:String
            /// 상장주식수
            let issue_stk_qty:String
            /// 총발행주식수
            let tot_issue_stk_qty:String
            /// 발행가
            let issue_price:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ksdinfo/list-info"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHKDB669107C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHKDB669107C0
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 예탁원정보(공모주청약일정)[국내주식-151]
    /// 예탁원정보(공모주청약일정) API입니다. 한국투자 HTS(eFriend Plus) > [0667] 공모주청약 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 예탁원에서 제공한 자료이므로 정보용으로만 사용하시기 바랍니다.
    struct puboffer : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// 공백: 전체, 특정종목 조회시 : 종목코드
            let SHT_CD:String
            /// CTS
            /// 공백
            let CTS:String
            /// 조회일자From
            /// 일자 ~
            let F_DT:String
            /// 조회일자To
            /// ~ 일자
            let T_DT:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
        }
        public struct Output1 : Codable {
            /// 기준일
            let record_date:String
            /// 종목코드
            let sht_cd:String
            /// 종목명
            let isin_name:String
            /// 공모가
            let fix_subscr_pri:String
            /// 액면가
            let face_value:String
            /// 청약기간
            let subscr_dt:String
            /// 납입일
            let pay_dt:String
            /// 환불일
            let refund_dt:String
            /// 상장/등록일
            let list_dt:String
            /// 주간사
            let lead_mgr:String
            /// 공모전자본금
            let pub_bf_cap:String
            /// 공모후자본금
            let pub_af_cap:String
            /// 당사배정물량
            let assign_stk_qty:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ksdinfo/pub-offer"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHKDB669108C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHKDB669108C0
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 예탁원정보(실권주일정)[국내주식-152]
    /// 예탁원정보(실권주일정) API입니다. 한국투자 HTS(eFriend Plus) > [0668] 실권주 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 예탁원에서 제공한 자료이므로 정보용으로만 사용하시기 바랍니다.
    struct forfeit : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// 공백: 전체, 특정종목 조회시 : 종목코드
            let SHT_CD:String
            /// 조회일자To
            /// ~ 일자
            let T_DT:String
            /// 조회일자From
            /// 일자 ~
            let F_DT:String
            /// CTS
            /// 공백
            let CTS:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
        }
        public struct Output1 : Codable {
            /// 기준일
            let record_date:String
            /// 종목코드
            let sht_cd:String
            /// 종목명
            let isin_name:String
            /// 청약일
            let subscr_dt:String
            /// 공모가
            let subscr_price:String
            /// 공모주식수
            let subscr_stk_qty:String
            /// 환불일
            let refund_dt:String
            /// 상장/등록일
            let list_dt:String
            /// 주간사
            let lead_mgr:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ksdinfo/forfeit"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHKDB669109C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHKDB669109C0
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 예탁원정보(의무예치일정)[국내주식-153]
    /// 예탁원정보(의무예치일정) API입니다. 한국투자 HTS(eFriend Plus) > [0758] 의무예치 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 예탁원에서 제공한 자료이므로 정보용으로만 사용하시기 바랍니다.
    struct manddeposit : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조회일자To
            /// ~ 일자
            let T_DT:String
            /// 종목코드
            /// 공백: 전체, 특정종목 조회시 : 종목코드
            let SHT_CD:String
            /// 조회일자From
            /// 일자 ~
            let F_DT:String
            /// CTS
            /// 공백
            let CTS:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
        }
        public struct Output1 : Codable {
            /// 종목코드
            let sht_cd:String
            /// 종목명
            let isin_name:String
            /// 주식수
            let stk_qty:String
            /// 예치일
            let depo_date:String
            /// 사유
            let depo_reason:String
            /// 총발행주식수대비비율(%)
            let tot_issue_qty_per_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ksdinfo/mand-deposit"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHKDB669110C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHKDB669110C0
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 예탁원정보(유상증자일정) [국내주식-143]
    /// 예탁원정보(유상증자일정) API입니다. 한국투자 HTS(eFriend Plus) > [0655] 유상증자 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 예탁원에서 제공한 자료이므로 정보용으로만 사용하시기 바랍니다.
    struct paidincapin : APIITEM, NeedHash {
        public struct Request : Codable {
            /// CTS
            /// 공백
            let CTS:String
            /// 조회구분
            /// 1(청약일별), 2(기준일별)
            let GB1:String
            /// 조회일자From
            /// 일자 ~
            let F_DT:String
            /// 조회일자To
            /// ~ 일자
            let T_DT:String
            /// 종목코드
            /// 공백(전체), 특정종목 조회시(종목코드)
            let SHT_CD:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output: [Output]
        }
        public struct Output : Codable {
            /// 기준일
            let record_date:String
            /// 종목코드
            let sht_cd:String
            /// 종목명
            let isin_name:String
            /// 발행주식
            let tot_issue_stk_qty:String
            /// 발행할주식
            let issue_stk_qty:String
            /// 확정배정율
            let fix_rate:String
            /// 할인율
            let disc_rate:String
            /// 발행예정가
            let fix_price:String
            /// 권리락일
            let right_dt:String
            /// 청약기간
            let sub_term_ft:String
            /// 청약기간
            let sub_term:String
            /// 상장/등록일
            let list_date:String
            /// 주식종류
            let stk_kind:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ksdinfo/paidin-capin"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHKDB669100C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHKDB669100C0
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 예탁원정보(무상증자일정) [국내주식-144]
    /// 예탁원정보(무상증자일정) API입니다. 한국투자 HTS(eFriend Plus) > [0656] 무상증자 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 예탁원에서 제공한 자료이므로 정보용으로만 사용하시기 바랍니다.
    struct bonusissue : APIITEM, NeedHash {
        public struct Request : Codable {
            /// CTS
            /// 공백
            let CTS:String
            /// 조회일자From
            /// 일자 ~
            let F_DT:String
            /// 조회일자To
            /// ~ 일자
            let T_DT:String
            /// 종목코드
            /// 공백: 전체, 특정종목 조회시 : 종목코드
            let SHT_CD:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
        }
        public struct Output1 : Codable {
            /// 기준일
            let record_date:String
            /// 종목코드
            let sht_cd:String
            /// 종목명
            let isin_name:String
            /// 확정배정율
            let fix_rate:String
            /// 단주기준가
            let odd_rec_price:String
            /// 권리락일
            let right_dt:String
            /// 단주대금지급일
            let odd_pay_dt:String
            /// 상장/등록일
            let list_date:String
            /// 발행주식
            let tot_issue_stk_qty:String
            /// 발행할주식
            let issue_stk_qty:String
            /// 주식종류
            let stk_kind:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ksdinfo/bonus-issue"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHKDB669101C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHKDB669101C0
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 예탁원정보(주주총회일정) [국내주식-154]
    /// 예탁원정보(주주총회일정) API입니다. 한국투자 HTS(eFriend Plus) > [0759] 주주총회 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 예탁원에서 제공한 자료이므로 정보용으로만 사용하시기 바랍니다.
    struct sharehldmeet : APIITEM, NeedHash {
        public struct Request : Codable {
            /// CTS
            /// 공백
            let CTS:String
            /// 조회일자From
            /// 일자 ~
            let F_DT:String
            /// 조회일자To
            /// ~ 일자
            let T_DT:String
            /// 종목코드
            /// 공백: 전체, 특정종목 조회시 : 종목코드
            let SHT_CD:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
        }
        public struct Output1 : Codable {
            /// 기준일
            let record_date:String
            /// 종목코드
            let sht_cd:String
            /// 종목명
            let isin_name:String
            /// 주총일자
            let gen_meet_dt:String
            /// 주총사유
            let gen_meet_type:String
            /// 주총의안
            let agenda:String
            /// 의결권주식총수
            let vote_tot_qty:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ksdinfo/sharehld-meet"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHKDB669111C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHKDB669111C0
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 국내주식 종목추정실적 [국내주식-187]
    /// 국내주식 종목추정실적 API입니다.한국투자 HTS(eFriend Plus) > [0613] 종목추정실적 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.  ※ 본 화면의 추정실적 및 투자의견은 당월 초의 애널리스트의 의견사항이므로 월중 변동 사항이 있을 수 있음을 유의하시기 바랍니다.※ 종목별 수익추정은 리서치본부에서 매월 발표되는 거래소, 코스닥 160여개 기업에 한정합니다. 구체적인 종목 리스트는 추정종목리스트를 참고하기 바랍니다.
    struct estimateperform : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// ex) 265520
            let SHT_CD:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object
            let output1: Output1
            /// 응답상세 : Object Array
            /// '(추정손익계산서-6개 array) 매출액, 매출액증감율, 영업이익, 영업이익증감율, 순이익, 순이익증감율,'
            let output2: [Output2]
            /// 응답상세 : Object Array
            /// '(투자지표-8개 array) EBITDA(십억원), EPS(원), EPS 증감율(0.1%), PER(배, 0.1%), EV/EBITDA(배, 0.1), ROE(0.1%), 부채비율(0.1%), 이자보상배율(0.1%)'
            let output3: [Output3]
            /// 응답상세 : Object Array
            /// array
            let output4: [Output4]
        }
        public struct Output1 : Codable {
            /// ELW단축종목코드
            let sht_cd:String
            /// HTS한글종목명
            let item_kor_nm:String
            /// ELW현재가
            let name1:String
            /// 전일대비
            let name2:String
            /// 전일대비부호
            let estdate:String
            /// 전일대비율
            let rcmd_name:String
            /// 누적거래량
            let capital:String
            /// 행사가
            let forn_item_lmtrt:String
        }
        public struct Output2 : Codable {
            /// DATA1
            /// 결산연월(outblock4) 참조
            let data1:String
            /// DATA2
            /// 결산연월(outblock4) 참조
            let data2:String
            /// DATA3
            /// 결산연월(outblock4) 참조
            let data3:String
            /// DATA4
            /// 결산연월(outblock4) 참조
            let data4:String
            /// DATA5
            /// 결산연월(outblock4) 참조
            let data5:String
        }
        public struct Output3 : Codable {
            /// DATA1
            /// 결산연월(outblock4) 참조
            let data1:String
            /// DATA2
            /// 결산연월(outblock4) 참조
            let data2:String
            /// DATA3
            /// 결산연월(outblock4) 참조
            let data3:String
            /// DATA4
            /// 결산연월(outblock4) 참조
            let data4:String
            /// DATA5
            /// 결산연월(outblock4) 참조
            let data5:String
        }
        public struct Output4 : Codable {
            /// 결산년월
            /// DATA1 ~5 결산월 정보
            let dt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/estimate-perform"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHKST668300C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHKST668300C0
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 당사 대주가능 종목 [국내주식-195]
    /// 당사 대주가능 종목 API입니다. 한국투자 HTS(eFriend Plus) > [0490] 당사 대주가능 종목 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 본 API는 다음조회가 불가합니다.
    struct lendablebycompany : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 거래소구분코드
            /// 00(전체), 02(거래소), 03(코스닥)
            let EXCG_DVSN_CD:String
            /// 상품번호
            /// 공백 : 전체조회, 종목코드 입력 시 해당종목만 조회
            let PDNO:String
            /// 당사대주가능여부
            /// Y
            let THCO_STLN_PSBL_YN:String
            /// 조회구분1
            /// 0 : 전체조회, 1: 종목코드순 정렬
            let INQR_DVSN_1:String
            /// 연속조회검색조건200
            /// 미입력 (다음조회 불가)
            let CTX_AREA_FK200:String
            /// 연속조회키100
            /// 미입력 (다음조회 불가)
            let CTX_AREA_NK100:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
            /// 응답상세 : Object
            let output2: Output2
        }
        public struct Output1 : Codable {
            /// 상품번호
            let pdno:String
            /// 상품명
            let prdt_name:String
            /// 액면가
            let papr:String
            /// 전일종가
            let bfdy_clpr:String
            /// 대용가
            let sbst_prvs:String
            /// 거래정지구분명
            let tr_stop_dvsn_name:String
            /// 가능여부명
            let psbl_yn_name:String
            /// 한도수량1
            let lmt_qty1:String
            /// 사용수량1
            let use_qty1:String
            /// 매매가능수량2
            let trad_psbl_qty2:String
            /// 권리유형코드
            let rght_type_cd:String
            /// 기준일자
            let bass_dt:String
            /// 가능여부
            let psbl_yn:String
        }
        public struct Output2 : Codable {
            /// 총설정한도수량
            let tot_stup_lmt_qty:String
            /// 지점한도수량
            let brch_lmt_qty:String
            /// 신청가능수량
            let rqst_psbl_qty:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/lendable-by-company"
        public var customHeader: [String : String]?
        init(tr_id: String = "CTSC2702R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // CTSC2702R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 국내주식 종목투자의견 [국내주식-188]
    /// 국내주식 종목투자의견 API입니다.한국투자 HTS(eFriend Plus) > [0605] 종목투자의견 화면 의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.한 번의 호출에 100건까지 조회가 가능하기에, 일자 파라미터(FID_INPUT_DATE_1, FID_INPUT_DATE_2)를 조절하여 다음 데이터 조회하시기 바랍니다.
    struct investopinion : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// J(시장 구분 코드)
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건화면분류코드
            /// 16633(Primary key)
            let FID_COND_SCR_DIV_CODE:String
            /// 입력종목코드
            /// 종목코드(ex) 005930(삼성전자))
            let FID_INPUT_ISCD:String
            /// 입력날짜1
            /// 이후 ~(ex) 0020231113)
            let FID_INPUT_DATE_1:String
            /// 입력날짜2
            /// ~ 이전(ex) 0020240513)
            let FID_INPUT_DATE_2:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
        }
        public struct Output1 : Codable {
            /// 주식영업일자
            let stck_bsop_date:String
            /// 투자의견
            let invt_opnn:String
            /// 투자의견구분코드
            let invt_opnn_cls_code:String
            /// 직전투자의견
            let rgbf_invt_opnn:String
            /// 직전투자의견구분코드
            let rgbf_invt_opnn_cls_code:String
            /// 회원사명
            let mbcr_name:String
            /// HTS목표가격
            let hts_goal_prc:String
            /// 주식전일종가
            let stck_prdy_clpr:String
            /// 주식N일괴리도
            let stck_nday_esdg:String
            /// N일괴리율
            let nday_dprt:String
            /// 주식선물괴리도
            let stft_esdg:String
            /// 괴리율
            let dprt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/invest-opinion"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKST663300C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST663300C0
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 국내주식 증권사별 투자의견 [국내주식-189]
    /// 국내주식 증권사별 투자의견 API입니다.한국투자 HTS(eFriend Plus) > [0608] 증권사별 투자의견 화면 의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.한 번의 호출에 20건까지 조회가 가능하기에, 일자 파라미터(FID_INPUT_DATE_1, FID_INPUT_DATE_2)를 조절하여 다음 데이터 조회하시기 바랍니다.
    struct investopbysec : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// J(시장 구분 코드)
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건화면분류코드
            /// 16634(Primary key)
            let FID_COND_SCR_DIV_CODE:String
            /// 입력종목코드
            /// 회원사코드 (kis developers 포탈 사이트 포럼-> FAQ -> 종목정보 다운로드(국내) 참조)
            let FID_INPUT_ISCD:String
            /// 분류구분코드
            /// 전체(0) 매수(1) 중립(2) 매도(3)
            let FID_DIV_CLS_CODE:String
            /// 입력날짜1
            /// 이후 ~
            let FID_INPUT_DATE_1:String
            /// 입력날짜2
            /// ~ 이전
            let FID_INPUT_DATE_2:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
        }
        public struct Output1 : Codable {
            /// 주식영업일자
            let stck_bsop_date:String
            /// 주식단축종목코드
            let stck_shrn_iscd:String
            /// HTS한글종목명
            let hts_kor_isnm:String
            /// 투자의견
            let invt_opnn:String
            /// 투자의견구분코드
            let invt_opnn_cls_code:String
            /// 직전투자의견
            let rgbf_invt_opnn:String
            /// 직전투자의견구분코드
            let rgbf_invt_opnn_cls_code:String
            /// 회원사명
            let mbcr_name:String
            /// 주식현재가
            let stck_prpr:String
            /// 전일대비
            let prdy_vrss:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 전일대비율
            let prdy_ctrt:String
            /// HTS목표가격
            let hts_goal_prc:String
            /// 주식전일종가
            let stck_prdy_clpr:String
            /// 주식선물괴리도
            let stft_esdg:String
            /// 괴리율
            let dprt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/invest-opbysec"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKST663400C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST663400C0
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }
}
