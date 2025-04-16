//
//  해외선물옵션_주문_계좌.swift
//  KoreaInvestSwift
//
//  Created by kin on 4/12/25.
//

import FullyRESTful
extension KISAPI {
    enum 해외선물옵션_주문_계좌 {}
}
extension KISAPI.해외선물옵션_주문_계좌 {
    /// 해외선물옵션 주문 [v1_해외선물-001]
    /// 해외선물옵션 주문 API 입니다.※ POST API의 경우 BODY값의 key값들을 대문자로 작성하셔야 합니다.   (EX. "CANO" : "12345678", "ACNT_PRDT_CD": "01",...)※ 종목코드 마스터파일 파이썬 정제코드는 한국투자증권 Github 참고 부탁드립니다.   https://github.com/koreainvestment/open-trading-api/tree/main/stocks_info
    struct order : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 해외선물FX상품번호
            let OVRS_FUTR_FX_PDNO:String
            /// 매도매수구분코드
            /// 01 : 매도 02 : 매수
            let SLL_BUY_DVSN_CD:String
            /// FM청산미결제체결일자
            /// 빈칸 (hedge청산만 이용)
            let FM_LQD_USTL_CCLD_DT:String?
            /// FM청산미결제체결번호
            /// 빈칸 (hedge청산만 이용)
            let FM_LQD_USTL_CCNO:String?
            /// 가격구분코드
            /// 1.지정, 2. 시장, 3. STOP, 4 S/L
            let PRIC_DVSN_CD:String
            /// FMLIMIT주문가격
            /// 지정가인 경우 가격 입력 * 시장가, STOP주문인 경우, 빈칸("") 입력
            let FM_LIMIT_ORD_PRIC:String
            /// FMSTOP주문가격
            /// STOP 주문 가격 입력 * 시장가, 지정가인 경우, 빈칸("") 입력
            let FM_STOP_ORD_PRIC:String
            /// FM주문수량
            let FM_ORD_QTY:String
            /// FM청산LIMIT주문가격
            /// 빈칸 (hedge청산만 이용)
            let FM_LQD_LMT_ORD_PRIC:String?
            /// FM청산STOP주문가격
            /// 빈칸 (hedge청산만 이용)
            let FM_LQD_STOP_ORD_PRIC:String?
            /// 체결조건코드
            /// 일반적으로 6 (EOD, 지정가) GTD인 경우 5, 시장가인 경우만 2
            let CCLD_CNDT_CD:String
            /// 복합주문구분코드
            /// 0 (hedge청산만 이용)
            let CPLX_ORD_DVSN_CD:String
            /// 행사예약주문여부
            /// N
            let ECIS_RSVN_ORD_YN:String
            /// FM_HEDGE주문화면여부
            /// N
            let FM_HDGE_ORD_SCRN_YN:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            ///  : Object
            let output: Output?
        }
        public struct Output : Codable {
            /// 주문일자
            let ORD_DT:String?
            /// 주문번호
            /// 접수한 주문의 일련번호(ex. 00360686) * 정정/취소시 문자열처럼 "0"을 포함해서 전송 (ex. ORGN_ODNO : 00360686)
            let ODNO:String?
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/trading/order"
        public var customHeader: [String : String]?
        init(tr_id: String = "OTFM3001U", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] OTFM3001U : ASFM선물옵션주문신규
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
            self.customHeader?["Content-Type"] = "application/json; charset=UTF-8"
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 해외선물옵션 정정취소주문 [v1_해외선물-002, 003]
    /// 해외선물옵션 정정취소주문 API 입니다.※ POST API의 경우 BODY값의 key값들을 대문자로 작성하셔야 합니다.   (EX. "CANO" : "12345678", "ACNT_PRDT_CD": "01",...)
    struct orderrvsecncl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 원주문일자
            /// 원 주문 시 출력되는 ORD_DT 값을 입력 (현지거래일)
            let ORGN_ORD_DT:String
            /// 원주문번호
            /// 정정/취소시 주문번호(ODNO) 8자리를 문자열처럼 "0"을 포함해서 전송 (원 주문 시 출력된 ODNO 값 활용) (ex. ORGN_ODNO : 00360686)
            let ORGN_ODNO:String
            /// FMLIMIT주문가격
            /// OTFM3002U(해외선물옵션주문정정)만 사용
            let FM_LIMIT_ORD_PRIC:String?
            /// FMSTOP주문가격
            /// OTFM3002U(해외선물옵션주문정정)만 사용
            let FM_STOP_ORD_PRIC:String?
            /// FM청산LIMIT주문가격
            /// OTFM3002U(해외선물옵션주문정정)만 사용
            let FM_LQD_LMT_ORD_PRIC:String?
            /// FM청산STOP주문가격
            /// OTFM3002U(해외선물옵션주문정정)만 사용
            let FM_LQD_STOP_ORD_PRIC:String?
            /// FM_HEDGE주문화면여부
            /// N
            let FM_HDGE_ORD_SCRN_YN:String
            /// FM시장가전환여부
            /// OTFM3003U(해외선물옵션주문취소)만 사용 ※ FM_MKPR_CVSN_YN 항목에 'Y'로 설정하여 취소주문을 접수할 경우, 주문 취소확인이 들어오면 원장에서 시장가주문을 하나 또 내줌
            let FM_MKPR_CVSN_YN:String?
        }
        struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            ///  : Object
            let output: Output?
        }
        public struct Output : Codable {
            /// 주문일자
            /// YYYYMMDD(ex. 20230811)
            let ORD_DT:String?
            /// 주문번호
            /// 접수한 주문의 일련번호(ex. 00360686) * 정정/취소시 문자열처럼 "0"을 포함해서 전송 (ex. ORGN_ODNO : 00360686)
            let ODNO:String?
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/trading/order-rvsecncl"
        public var customHeader: [String : String]?
        enum TR_ID : String {
            case 주문정정 = "OTFM3002U"
            case 주문취소 = "OTFM3003U"
        }
        init(tr_id: TR_ID, gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] OTFM3002U : 해외선물옵션주문정정 OTFM3003U : 해외선물옵션주문취소
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
            self.customHeader?["Content-Type"] = "application/json; charset=UTF-8"
            self.customHeader?["tr_id"] = tr_id.rawValue
        }
    }

    /// 해외선물옵션 당일주문내역조회 [v1_해외선물-004]
    struct inquireccld : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 체결미체결구분
            /// 01:전체 / 02:체결 / 03:미체결
            let CCLD_NCCS_DVSN:String
            /// 매도매수구분코드
            /// %%:전체 / 01:매도 / 02:매수
            let SLL_BUY_DVSN_CD:String
            /// 선물옵션구분
            /// 00:전체 / 01:선물 / 02:옵션
            let FUOP_DVSN:String
            /// 연속조회검색조건200
            let CTX_AREA_FK200:String
            /// 연속조회키200
            let CTX_AREA_NK200:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세1 : Object Array
            /// Array
            let output: [Output]?
        }
        public struct Output : Codable {
            /// 종합계좌번호
            let cano:String?
            /// 계좌상품코드
            let acnt_prdt_cd:String?
            /// 주문일자
            let ord_dt:String?
            /// 주문번호
            /// 접수한 주문의 일련번호(ex. 00360686) * 정정/취소시 문자열처럼 "0"을 포함해서 전송 (ex. ORGN_ODNO : 00360686)
            let odno:String?
            /// 원주문일자
            let orgn_ord_dt:String?
            /// 원주문번호
            /// 원주문번호(ex. 00360685)
            let orgn_odno:String?
            /// 해외선물FX상품번호
            let ovrs_futr_fx_pdno:String?
            /// 접수구분코드
            /// 05 온라인
            let rcit_dvsn_cd:String?
            /// 매도매수구분코드
            /// 01:매도, 02:매수
            let sll_buy_dvsn_cd:String?
            /// 매매전략구분코드
            let trad_stgy_dvsn_cd:String?
            /// 기준가격유형코드
            /// 01 시가평가 02 액면가 03 기준가격 04 대용가
            let bass_pric_type_cd:String?
            /// 주문상태코드
            let ord_stat_cd:String?
            /// FM주문수량
            let fm_ord_qty:String?
            /// FM주문가격
            let fm_ord_pric:String?
            /// FMSTOP주문가격
            let fm_stop_ord_pric:String?
            /// 예약구분
            let rsvn_dvsn:String?
            /// FM체결수량
            let fm_ccld_qty:String?
            /// FM체결가격
            let fm_ccld_pric:String?
            /// FM주문잔여수량
            let fm_ord_rmn_qty:String?
            /// 주문그룹명
            let ord_grp_name:String?
            /// 등록상세일시
            let erlm_dtl_dtime:String?
            /// 체결상세일시
            let ccld_dtl_dtime:String?
            /// 주문직원번호
            let ord_stfno:String?
            /// 비고1
            let rmks1:String?
            /// 신규청산구분코드
            /// 01 신규 02 청산
            let new_lqd_dvsn_cd:String?
            /// FM청산LIMIT주문가격
            let fm_lqd_lmt_ord_pric:String?
            /// FM청산STOP가격
            let fm_lqd_stop_pric:String?
            /// 체결조건코드
            let ccld_cndt_cd:String?
            /// 게시유효일자
            let noti_vald_dt:String?
            /// 계좌유형코드
            let acnt_type_cd:String?
            /// 선물옵션구분
            /// 01:선물, 02: 옵션
            let fuop_dvsn:String?
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/trading/inquire-ccld"
        public var customHeader: [String : String]?
        init(tr_id: String = "OTFM3116R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // OTFM3116R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 / P : 개인
                "seq_no", // 법인 : "001" / default 개인: ""
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

    /// 해외선물옵션 미결제내역조회(잔고) [v1_해외선물-005]
    struct inquireunpd : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 선물옵션구분
            /// 00: 전체 / 01:선물 / 02: 옵션
            let FUOP_DVSN:String
            /// 연속조회검색조건100
            let CTX_AREA_FK100:String
            /// 연속조회키100
            let CTX_AREA_NK100:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세1 : Object Array
            /// Array
            let output: [Output]?
        }
        public struct Output : Codable {
            /// 종합계좌번호
            let cano:String?
            /// 계좌상품코드
            let acnt_prdt_cd:String?
            /// 해외선물FX상품번호
            let ovrs_futr_fx_pdno:String?
            /// 상품유형코드
            let prdt_type_cd:String?
            /// 통화코드
            let crcy_cd:String?
            /// 매도매수구분코드
            let sll_buy_dvsn_cd:String?
            /// FM미결제수량
            let fm_ustl_qty:String?
            /// FM체결평균가격
            let fm_ccld_avg_pric:String?
            /// FM현재가격
            let fm_now_pric:String?
            /// FM평가손익금액
            let fm_evlu_pfls_amt:String?
            /// FM옵션평가금액
            let fm_opt_evlu_amt:String?
            /// FM옵션평가손익금액
            let fm_otp_evlu_pfls_amt:String?
            /// 선물옵션구분
            let fuop_dvsn:String?
            /// 행사예약주문여부
            let ecis_rsvn_ord_yn:String?
            /// FM청산가능수량
            let fm_lqd_psbl_qty:String?
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/trading/inquire-unpd"
        public var customHeader: [String : String]?
        init(tr_id: String = "OTFM1412R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // OTFM1412R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 / P : 개인
                "seq_no", // 법인 : "001" / default 개인: ""
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

    /// 해외선물옵션 주문가능조회 [v1_해외선물-006]
    struct inquirepsamount : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 해외선물FX상품번호
            let OVRS_FUTR_FX_PDNO:String
            /// 매도매수구분코드
            /// 01 : 매도 / 02 : 매수
            let SLL_BUY_DVSN_CD:String
            /// FM주문가격
            /// N
            let FM_ORD_PRIC:String
            /// 행사예약주문여부
            /// N
            let ECIS_RSVN_ORD_YN:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세1 : Object
            let output: Output?
        }
        public struct Output : Codable {
            /// 종합계좌번호
            let cano:String?
            /// 계좌상품코드
            let acnt_prdt_cd:String?
            /// 해외선물FX상품번호
            let ovrs_futr_fx_pdno:String?
            /// 통화코드
            let crcy_cd:String?
            /// 매도매수구분코드
            let sll_buy_dvsn_cd:String?
            /// FM미결제수량
            let fm_ustl_qty:String?
            /// FM청산가능수량
            let fm_lqd_psbl_qty:String?
            /// FM신규주문가능수량
            let fm_new_ord_psbl_qty:String?
            /// FM총주문가능수량
            let fm_tot_ord_psbl_qty:String?
            /// FM시장가총주문가능수량
            let fm_mkpr_tot_ord_psbl_qty:String?
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/trading/inquire-psamount"
        public var customHeader: [String : String]?
        init(tr_id: String = "OTFM3304R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // OTFM3304R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 / P : 개인
                "seq_no", // 법인 : "001" / default 개인: ""
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

    /// 해외선물옵션 기간계좌손익 일별[해외선물-010]
    struct inquireperiodccld : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조회기간FROM일자
            let INQR_TERM_FROM_DT:String
            /// 조회기간TO일자
            let INQR_TERM_TO_DT:String
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 통화코드
            /// '%%% : 전체 TUS: TOT_USD / TKR: TOT_KRW KRW: 한국 / USD: 미국 EUR: EUR / HKD: 홍콩 CNY: 중국 / JPY: 일본'
            let CRCY_CD:String
            /// 전체환산여부
            /// N
            let WHOL_TRSL_YN:String
            /// 선물옵션구분
            /// 00:전체 / 01:선물 / 02:옵션
            let FUOP_DVSN:String
            /// 연속조회검색조건200
            let CTX_AREA_FK200:String
            /// 연속조회키200
            let CTX_AREA_NK200:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세1 : Object Array
            /// Array
            let output1: [Output1]
            /// 응답상세2 : Object Array
            /// Array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 종합계좌번호
            let cano:String
            /// 계좌상품코드
            let acnt_prdt_cd:String?
            /// 통화코드
            let crcy_cd:String
            /// FM매수수량
            let fm_buy_qty:String
            /// FM매도수량
            let fm_sll_qty:String
            /// FM청산손익금액
            let fm_lqd_pfls_amt:String
            /// FM수수료
            let fm_fee:String
            /// FM순손익금액
            let fm_net_pfls_amt:String
            /// FM미결제매수수량
            let fm_ustl_buy_qty:String
            /// FM미결제매도수량
            let fm_ustl_sll_qty:String
            /// FM미결제평가손익금액
            let fm_ustl_evlu_pfls_amt:String
            /// FM미결제평가손익금액2
            let fm_ustl_evlu_pfls_amt2:String
            /// FM미결제평가손익증감금액
            let fm_ustl_evlu_pfls_icdc_amt:String
            /// FM미결제약정금액
            let fm_ustl_agrm_amt:String
            /// FM옵션청산금액
            let fm_opt_lqd_amt:String
        }
        public struct Output2 : Codable {
            /// 종합계좌번호
            let cano:String
            /// 계좌상품코드
            let acnt_prdt_cd:String
            /// 해외선물FX상품번호
            let ovrs_futr_fx_pdno:String
            /// 통화코드
            let crcy_cd:String
            /// FM매수수량
            let fm_buy_qty:String
            /// FM매도수량
            let fm_sll_qty:String
            /// FM청산손익금액
            let fm_lqd_pfls_amt:String
            /// FM수수료
            let fm_fee:String
            /// FM순손익금액
            let fm_net_pfls_amt:String
            /// FM미결제매수수량
            let fm_ustl_buy_qty:String
            /// FM미결제매도수량
            let fm_ustl_sll_qty:String
            /// FM미결제평가손익금액
            let fm_ustl_evlu_pfls_amt:String
            /// FM미결제평가손익금액2
            let fm_ustl_evlu_pfls_amt2:String
            /// FM미결제평가손익증감금액
            let fm_ustl_evlu_pfls_icdc_amt:String
            /// FM체결평균가격
            let fm_ccld_avg_pric:String
            /// FM미결제약정금액
            let fm_ustl_agrm_amt:String
            /// FM옵션청산금액
            let fm_opt_lqd_amt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/trading/inquire-period-ccld"
        public var customHeader: [String : String]?
        init(tr_id: String = "OTFM3118R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // OTFM3118R
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
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 해외선물옵션 일별 체결내역[해외선물-011]
    struct inquiredailyccld : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 시작일자
            /// 시작일자(YYYYMMDD)
            let STRT_DT:String
            /// 종료일자
            /// 종료일자(YYYYMMDD)
            let END_DT:String
            /// 선물옵션구분코드
            /// 00:전체 / 01:선물 / 02:옵션
            let FUOP_DVSN_CD:String
            /// FM상품군코드
            /// 공란(Default)
            let FM_PDGR_CD:String
            /// 통화코드
            /// %%% : 전체 TUS: TOT_USD / TKR: TOT_KRW KRW: 한국 / USD: 미국 EUR: EUR / HKD: 홍콩 CNY: 중국 / JPY: 일본 VND: 베트남
            let CRCY_CD:String
            /// FM종목합산여부
            /// "N"(Default)
            let FM_ITEM_FTNG_YN:String
            /// 매도매수구분코드
            /// %%: 전체 / 01 : 매도 / 02 : 매수
            let SLL_BUY_DVSN_CD:String
            /// 연속조회검색조건200
            let CTX_AREA_FK200:String
            /// 연속조회키200
            let CTX_AREA_NK200:String
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
            /// 응답상세2 : Object Array
            /// Array
            let output1: [Output1]
        }
        public struct Output : Codable {
            /// FM총체결수량
            let fm_tot_ccld_qty:String
            /// FM총선물약정금액
            let fm_tot_futr_agrm_amt:String
            /// FM총옵션약정금액
            let fm_tot_opt_agrm_amt:String
            /// FM수수료합계
            let fm_fee_smtl:String
        }
        public struct Output1 : Codable {
            /// 일자
            let dt:String
            /// 체결번호
            let ccno:String
            /// 해외선물FX상품번호
            let ovrs_futr_fx_pdno:String
            /// 매도매수구분코드
            let sll_buy_dvsn_cd:String
            /// FM체결수량
            let fm_ccld_qty:String
            /// FM체결금액
            let fm_ccld_amt:String
            /// FM선물체결금액
            let fm_futr_ccld_amt:String
            /// FM옵션체결금액
            let fm_opt_ccld_amt:String
            /// 통화코드
            let crcy_cd:String
            /// FM수수료
            let fm_fee:String
            /// FM선물순약정금액
            let fm_futr_pure_agrm_amt:String
            /// FM옵션순약정금액
            let fm_opt_pure_agrm_amt:String
            /// 체결상세일시
            let ccld_dtl_dtime:String
            /// 주문일자
            let ord_dt:String
            /// 주문번호
            /// 접수한 주문의 일련번호(ex. 00360686)
            let odno:String
            /// 주문매체구분명
            let ord_mdia_dvsn_name:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/trading/inquire-daily-ccld"
        public var customHeader: [String : String]?
        init(tr_id: String = "OTFM3122R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // OTFM3122R
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
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 해외선물옵션 예수금현황[해외선물-012]
    struct inquiredeposit : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 통화코드
            /// TUS: TOT_USD / TKR: TOT_KRW KRW: 한국 / USD: 미국 EUR: EUR / HKD: 홍콩 CNY: 중국 / JPY: 일본 VND: 베트남
            let CRCY_CD:String
            /// 조회일자
            let INQR_DT:String
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
            /// FM익일예수금액
            let fm_nxdy_dncl_amt:String
            /// FM총자산평가금액
            let fm_tot_asst_evlu_amt:String
            /// 종합계좌번호
            let cano:String
            /// 계좌상품코드
            let acnt_prdt_cd:String
            /// 통화코드
            let crcy_cd:String
            /// 응답일자
            let resp_dt:String
            /// FM예수금잔액
            let fm_dnca_rmnd:String
            /// FM청산손익금액
            let fm_lqd_pfls_amt:String
            /// FM수수료
            let fm_fee:String
            /// FM선물옵션평가손익금액
            let fm_fuop_evlu_pfls_amt:String
            /// FM미수금액
            let fm_rcvb_amt:String
            /// FM위탁증거금액
            let fm_brkg_mgn_amt:String
            /// FM유지증거금액
            let fm_mntn_mgn_amt:String
            /// FM추가증거금액
            let fm_add_mgn_amt:String
            /// FM위험율
            let fm_risk_rt:String
            /// FM주문가능금액
            let fm_ord_psbl_amt:String
            /// FM출금가능금액
            let fm_drwg_psbl_amt:String
            /// FM환전요청금액
            let fm_echm_rqrm_amt:String
            /// FM출금예정금액
            let fm_drwg_prar_amt:String
            /// FM옵션거래대금
            let fm_opt_tr_chgs:String
            /// FM옵션포함자산평가금액
            let fm_opt_icld_asst_evlu_amt:String
            /// FM옵션평가금액
            let fm_opt_evlu_amt:String
            /// FM통화대용금액
            let fm_crcy_sbst_amt:String
            /// FM통화대용사용금액
            let fm_crcy_sbst_use_amt:String
            /// FM통화대용설정금액
            let fm_crcy_sbst_stup_amt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/trading/inquire-deposit"
        public var customHeader: [String : String]?
        init(tr_id: String = "OTFM1411R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // OTFM1411R
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
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 해외선물옵션 일별 주문내역[해외선물-013]
    struct inquiredailyorder : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 시작일자
            let STRT_DT:String
            /// 종료일자
            let END_DT:String
            /// FM상품군코드
            let FM_PDGR_CD:String
            /// 체결미체결구분
            /// 01:전체 / 02:체결 / 03:미체결
            let CCLD_NCCS_DVSN:String
            /// 매도매수구분코드
            /// %%전체 / 01 : 매도 / 02 : 매수
            let SLL_BUY_DVSN_CD:String
            /// 선물옵션구분
            /// 00:전체 / 01:선물 / 02:옵션
            let FUOP_DVSN:String
            /// 연속조회검색조건200
            let CTX_AREA_FK200:String
            /// 연속조회키200
            let CTX_AREA_NK200:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세1 : Object Array
            /// Array
            let output: [Output]
        }
        public struct Output : Codable {
            /// 종합계좌번호
            let cano:String
            /// 계좌상품코드
            let acnt_prdt_cd:String
            /// 일자
            let dt:String
            /// 주문일자
            let ord_dt:String
            /// 주문번호
            /// 접수한 주문의 일련번호(ex. 00360686) * 정정/취소시 문자열처럼 "0"을 포함해서 전송 (ex. ORGN_ODNO : 00360686) * 정정/취소시 문자열처럼 "0"을 포함해서 전송 (ex. ORGN_ODNO : 00360686)
            let odno:String
            /// 원주문일자
            let orgn_ord_dt:String
            /// 원주문번호
            /// 원주문번호(ex. 00360685)
            let orgn_odno:String
            /// 해외선물FX상품번호
            let ovrs_futr_fx_pdno:String
            /// 정정취소구분코드
            /// 청산체결이 없는 신규 00 청산체결이 없는 정정 01 청산체결이 없는 취소 02 청산체결이 있는 취소 02 청산체결이 있는 신규 03 청산체결이 있는 정정 04 행사 05 배정 06 소멸 07 만기 08
            let rvse_cncl_dvsn_cd:String
            /// 매도매수구분코드
            let sll_buy_dvsn_cd:String
            /// 복합주문구분코드
            let cplx_ord_dvsn_cd:String
            /// 가격구분코드
            let pric_dvsn_cd:String
            /// 접수구분코드
            let rcit_dvsn_cd:String
            /// FM주문수량
            let fm_ord_qty:String
            /// FM주문가격
            let fm_ord_pric:String
            /// FMSTOP주문가격
            let fm_stop_ord_pric:String
            /// 행사예약주문여부
            let ecis_rsvn_ord_yn:String
            /// FM체결수량
            let fm_ccld_qty:String
            /// FM체결가격
            let fm_ccld_pric:String
            /// FM주문잔여수량
            let fm_ord_rmn_qty:String
            /// 주문그룹명
            let ord_grp_name:String
            /// 접수상세일시
            let rcit_dtl_dtime:String
            /// 체결상세일시
            let ccld_dtl_dtime:String
            /// 주문자사원번호
            let ordr_emp_no:String
            /// 거부사유명
            let rjct_rson_name:String
            /// 체결조건코드
            let ccld_cndt_cd:String
            /// 매매종료일자
            let trad_end_dt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/trading/inquire-daily-order"
        public var customHeader: [String : String]?
        init(tr_id: String = "OTFM3120R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // OTFM3120R
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
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 해외선물옵션 기간계좌거래내역[해외선물-014]
    struct inquireperiodtrans : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조회기간FROM일자
            let INQR_TERM_FROM_DT:String
            /// 조회기간TO일자
            let INQR_TERM_TO_DT:String
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 계좌거래유형코드
            /// 1: 전체, 2:입출금 , 3: 결제
            let ACNT_TR_TYPE_CD:String
            /// 통화코드
            /// '%%% : 전체 TUS: TOT_USD / TKR: TOT_KRW KRW: 한국 / USD: 미국 EUR: EUR / HKD: 홍콩 CNY: 중국 / JPY: 일본 VND: 베트남 '
            let CRCY_CD:String
            /// 연속조회검색조건100
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_FK100값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_FK100:String
            /// 연속조회키100
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_NK100값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_NK100:String
            /// 비밀번호체크여부
            /// 공란(Default)
            let PWD_CHK_YN:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세1 : Object Array
            /// Array
            let output: [Output]
        }
        public struct Output : Codable {
            /// 기준일자
            let bass_dt:String
            /// 종합계좌번호
            let cano:String
            /// 계좌상품코드
            let acnt_prdt_cd:String
            /// FM원장출납순번
            let fm_ldgr_inog_seq:String
            /// 계좌거래유형명
            let acnt_tr_type_name:String
            /// 통화코드
            let crcy_cd:String
            /// 거래항목명
            let tr_itm_name:String
            /// FM입출금액
            let fm_iofw_amt:String
            /// FM수수료
            let fm_fee:String
            /// FM세금금액
            let fm_tax_amt:String
            /// FM결제금액
            let fm_sttl_amt:String
            /// FM이전예수금액
            let fm_bf_dncl_amt:String
            /// FM예수금액
            let fm_dncl_amt:String
            /// FM미수발생금액
            let fm_rcvb_occr_amt:String
            /// FM미수변제금액
            let fm_rcvb_pybk_amt:String
            /// 연체이자변제금액
            let ovdu_int_pybk_amt:String
            /// 비고내용
            let rmks_text:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/trading/inquire-period-trans"
        public var customHeader: [String : String]?
        init(tr_id: String = "OTFM3114R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // OTFM3114R
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
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 해외선물옵션 증거금상세 [해외선물-032]
    /// 해외선물옵션 증거금상세 API입니다.한국투자 HTS(eFriend Force) > [0867] 해외선물옵션 증거금상세 화면 의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.[증거금 상세설명]- SPAN, EUREX 증거금1. 가격변동증거금 : 보유하고 있는 미결제를 Product Class 별로 구간[SPAN-16구간, EUREX-29구간)손익 합계액 산출하며 최대손실구간의 금액을 해당 Class의 증거금으로 산정2. 스프레드증거금 : 보유하고 있는 미결제를 Product Class 별로 스프레드 산정하며 스프레드 증거금 적용** 스프레드 산정방법 : SPAN은 선물+옵션의 Delta Spread로 계산, EUREX는 선물의 Spread만 산정 보유중인 옵선가치를 평가하며 청산가치가 양수(고객미 수취할 금액이 있는 경우)에 해당하는 금액을 증거금에서 할인3. 옵션가격증거금 : 보유중인 옵션가치를 평가하여 청산가치가 양수(고객이 수취할 금액이 있는 경우)에 해당하는 금액을 증거금에서 할인**계산식 : MAXID, 온선평가대금 Class별 합계액) ** 산출된 값을 음수처리함 옵션 미결제약정에 대해 최소로 징구하는 증거금4. 옵선최소증거금 증거금 : 옵션 미결제약정에 대해 최소로 징구하는 증거금﻿** SPAN : 매도옵선회소증거금(행사가별로 상미)과 매수옵선최소증거금(계약당 1Tick에 해당하는 금액)** EUREX : 매수옵선최소증거금(계약당 1Tick에 해당하는 금액)(EUREX는 매도옵션최소증거금이 가격변동증거금에 포함되어 있음)5. 일방해소증거금 : (기본개념)보유중인 포트폴리오 중에서 머느 일방향을 전량 청산했을 경우 잔존하는 미결제 약정의 최대손실가능액을 사전에 징구함가격상승포지션과 가격하락포지션에 대해 최불리증거금을 각각 산정하며 큰 금액을 증거금으로 장구﻿* 가격장승포지션 : 선물매수포지션, 풋옵션매도포지션﻿* 가격하락포지션 : 선물매도포지션, 콜옵션매도포지선- 일반 증거금1. 선물미결제증거금 : 선물미결제약정에 대해 계약당증거금율 적용2. 매도옵션미결제증거금 : 매도옵션미결제약정에 대해 옵선계약당 증거금을 적용** 옵션계약당증거금 : 각 종목별 최불리증거금액으로 해외 거래소에서 계산하며 제공되는 데이터임3. 매수옵션미결제증거금 : 매수옵션최소증거금으로 1Tick에 해당하는 금액을 적용- 주문 증거금1. 선물 주문증거금 : 선물 미체결주문에 대해 계약당 증거금을 적용(신규주문에 한해 징수)2. 매도옵션 주문증거금 : 옵션매도 미체결주문에 대해 계약당증거금을 적용(신규주문에 한해 징수)3. 매수옵션 주문증거금 : 옵션매수 미체결주문에 대해 최소증거금(Tick Value와 10 중에서 큰 금액)과 만기행사예약한 미체결주문에 대한 행사예약증거금을 징수4. 매수옵션 주문대금 : 옵션매수 미체결주문의 매수대금(주문가격을 기준으로 대금 산정, 시장가주문시 현재가 +50틱으로 매수대금 산정)5. 매수옵선행사예약증거금 : 옵선매수 미결제약정 중에서 행사예약한 수량에 대해 기초자산선물의 계약당 증거금을 징수
    struct margindetail : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            let CANO:String
            /// 계좌상품코드
            let ACNT_PRDT_CD:String
            /// 통화코드
            /// 'TKR(TOT_KRW), TUS(TOT_USD), USD(미국달러), HKD(홍콩달러), CNY(중국위안화), JPY )일본엔화), VND(베트남동)'
            let CRCY_CD:String
            /// 조회일자
            let INQR_DT:String
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
        }
        public struct Output1 : Codable {
            /// 종합계좌번호
            let cano:String
            /// 계좌상품코드
            let acnt_prdt_cd:String
            /// 통화코드
            let crcy_cd:String
            /// 응답일자
            let resp_dt:String
            /// 계좌순위험증거금적용여부
            let acnt_net_risk_mgna_aply_yn:String
            /// FM주문가능금액
            let fm_ord_psbl_amt:String
            /// FM추가증거금액
            let fm_add_mgn_amt:String
            /// FM위탁증거금액
            let fm_brkg_mgn_amt:String
            /// FM정산위탁증거금액
            let fm_excc_brkg_mgn_amt:String
            /// FM미결제증거금액
            let fm_ustl_mgn_amt:String
            /// FM유지증거금액
            let fm_mntn_mgn_amt:String
            /// FM주문증거금액
            let fm_ord_mgn_amt:String
            /// FM선물주문증거금액
            let fm_futr_ord_mgn_amt:String
            /// FM옵션매수주문금액
            let fm_opt_buy_ord_amt:String
            /// FM옵션매도주문증거금액
            let fm_opt_sll_ord_mgn_amt:String
            /// FM옵션매수주문증거금액
            let fm_opt_buy_ord_mgn_amt:String
            /// FM행사예약증거금액
            let fm_ecis_rsvn_mgn_amt:String
            /// FMSPAN위탁증거금액
            let fm_span_brkg_mgn_amt:String
            /// FMSPAN가격변동증거금액
            let fm_span_pric_altr_mgn_amt:String
            /// FMSPAN기간스프레드증거금액
            let fm_span_term_sprd_mgn_amt:String
            /// FMSPAN옵션가격증거금액
            let fm_span_buy_opt_min_mgn_amt:String
            /// FMSPAN옵션최소증거금액
            let fm_span_opt_min_mgn_amt:String
            /// FMSPAN총위험증거금액
            let fm_span_tot_risk_mgn_amt:String
            /// FMSPAN유지증거금액
            let fm_span_mntn_mgn_amt:String
            /// FMSPAN유지가격변동증거금액
            let fm_span_mntn_pric_altr_mgn_amt:String
            /// FMSPAN유지기간스프레드증거금액
            let fm_span_mntn_term_sprd_mgn_amt:String
            /// FMSPAN유지옵션가격증거금액
            let fm_span_mntn_opt_pric_mgn_amt:String
            /// FMSPAN유지옵션최소증거금액
            let fm_span_mntn_opt_min_mgn_amt:String
            /// FMSPAN유지총위험증거금액
            let fm_span_mntn_tot_risk_mgn_amt:String
            /// FMEUREX위탁증거금액
            let fm_eurx_brkg_mgn_amt:String
            /// FMEUREX가격변동증거금액
            let fm_eurx_pric_altr_mgn_amt:String
            /// FMEUREX기간스프레드증거금액
            let fm_eurx_term_sprd_mgn_amt:String
            /// FMEUREX옵션가격증거금액
            let fm_eurx_opt_pric_mgn_amt:String
            /// FMEUREX매수옵션최소증거금액
            let fm_eurx_buy_opt_min_mgn_amt:String
            /// FMEUREX총위험증거금액
            let fm_eurx_tot_risk_mgn_amt:String
            /// FMEUREX유지증거금액
            let fm_eurx_mntn_mgn_amt:String
            /// FMEUREX유지가격변동증거금액
            let fm_eurx_mntn_pric_altr_mgn_amt:String
            /// FMEUREX기간스프레드증거금액
            let fm_eurx_mntn_term_sprd_mgn_amt:String
            /// FMEUREX유지옵션가격증거금액
            let fm_eurx_mntn_opt_pric_mgn_amt:String
            /// FMEUREX유지총위험증거금액
            let fm_eurx_mntn_tot_risk_mgn_amt:String
            /// FM일반위탁증거금액
            let fm_gnrl_brkg_mgn_amt:String
            /// FM선물미결제증거금액
            let fm_futr_ustl_mgn_amt:String
            /// FM매도옵션미결제증거금액
            let fm_sll_opt_ustl_mgn_amt:String
            /// FM매수옵션미결제증거금액
            let fm_buy_opt_ustl_mgn_amt:String
            /// FM스프레드미결제증거금액
            let fm_sprd_ustl_mgn_amt:String
            /// FMAVG할인증거금액
            let fm_avg_dsct_mgn_amt:String
            /// FM일반유지증거금액
            let fm_gnrl_mntn_mgn_amt:String
            /// FM선물유지증거금액
            let fm_futr_mntn_mgn_amt:String
            /// FM옵션유지증거금액
            let fm_opt_mntn_mgn_amt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/trading/margin-detail"
        public var customHeader: [String : String]?
        init(tr_id: String = "OTFM3115R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // OTFM3115R
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
