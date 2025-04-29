//
//  국내선물옵션_주문_계좌.swift
//  KoreaInvestSwift
//
//  Created by kin on 4/10/25.
//

import FullyRESTful

public extension KISAPI {
    enum 국내선물옵션_주문_계좌 {}
}
extension KISAPI.국내선물옵션_주문_계좌 {
    /// 선물옵션 주문[v1_국내선물-001]
    /// ​선물옵션 주문 API입니다.* 선물옵션 운영시간 외 API 호출 시 애러가 발생하오니 운영시간을 확인해주세요.※ POST API의 경우 BODY값의 key값들을 대문자로 작성하셔야 합니다.   (EX. "CANO" : "12345678", "ACNT_PRDT_CD": "01",...)※ 종목코드 마스터파일 파이썬 정제코드는 한국투자증권 Github 참고 부탁드립니다.   https://github.com/koreainvestment/open-trading-api/tree/main/stocks_info
    struct order : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 주문처리구분코드
            /// 02 : 주문전송
            let ORD_PRCS_DVSN_CD:String
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 매도매수구분코드
            /// 01 : 매도 02 : 매수
            let SLL_BUY_DVSN_CD:String
            /// 단축상품번호
            /// 종목번호 선물 6자리 (예: 101S03) 옵션 9자리 (예: 201S03370)
            let SHTN_PDNO:String
            /// 주문수량
            let ORD_QTY:String
            /// 주문가격1
            /// 시장가나 최유리 지정가인 경우 0으로 입력
            let UNIT_PRICE:String
            /// 호가유형코드
            /// ※ ORD_DVSN_CD(주문구분코드)를 입력한 경우 ""(공란)으로 입력해도 됨 01 : 지정가 02 : 시장가 03 : 조건부 04 : 최유리
            let NMPR_TYPE_CD:String?
            /// 한국거래소호가조건코드
            /// ※ ORD_DVSN_CD(주문구분코드)를 입력한 경우 ""(공란)으로 입력해도 됨 0 : 없음 3 : IOC 4 : FOK
            let KRX_NMPR_CNDT_CD:String?
            /// 연락전화번호
            /// 고객의 연락 가능한 전화번호
            let CTAC_TLNO:String?
            /// 선물옵션종목구분코드
            /// 공란(Default)
            let FUOP_ITEM_DVSN_CD:String?
            /// 주문구분코드
            /// 01 : 지정가 02 : 시장가 03 : 조건부 04 : 최유리, 10 : 지정가(IOC) 11 : 지정가(FOK) 12 : 시장가(IOC) 13 : 시장가(FOK) 14 : 최유리(IOC) 15 : 최유리(FOK)
            let ORD_DVSN_CD:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            let rt_cd: String
            /// 응답코드 - 응답코드
            let msg_cd: String
            /// 응답메세지 - 응답메세지
            let msg1: String
            /// 응답상세 : Array
            let output: [Output]
        }
        public struct Output : Codable {
            /// 계좌명
            /// 계좌의 고객명
            let ACNT_NAME:String
            /// 매매구분명
            /// 매도/매수 등 구분값
            let TRAD_DVSN_NAME:String
            /// 종목명
            /// 주문 종목 명칭
            let ITEM_NAME:String
            /// 주문시각
            /// 주문 접수 시간
            let ORD_TMD:String
            /// 주문채번지점번호
            /// 계좌 개설 시 관리점으로 선택한 영업점의 고유번호
            let ORD_GNO_BRNO:String
            /// 주문번호
            /// 접수한 주문의 일련번호
            let ODNO:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/trading/order"
        public var customHeader: [String : String]?
        enum TR_ID {
            case 주간
            case 야간
            var tr_id:String {
                switch self {
                case .주간:
                    return KISManager.getValueForCurrentTargetServer(실전서버: "TTTO1101U", 모의투자서버: "VTTO1101U")
                case .야간:
                    return KISManager.getValueForCurrentTargetServer(실전서버: "JTCE1001U", 모의투자서버: "")
                }
            }
        }
        init(tr_id: TR_ID, gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] TTTO1101U : 선물 옵션 매수 매도 주문 주간 JTCE1001U : 선물 옵션 매수 매도 주문 야간 [모의투자] VTTO1101U : 선물 옵션 매수 매도 주문 주간
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
            self.customHeader?["tr_id"] = tr_id.tr_id
        }
    }

    /// 선물옵션 정정취소주문[v1_국내선물-002]
    /// 선물옵션 주문 건에 대하여 정정 및 취소하는 API입니다. 단, 이미 체결된 건은 정정 및 취소가 불가합니다.※ POST API의 경우 BODY값의 key값들을 대문자로 작성하셔야 합니다.   (EX. "CANO" : "12345678", "ACNT_PRDT_CD": "01",...)
    struct orderrvsecncl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 주문처리구분코드
            /// 02 : 주문전송
            let ORD_PRCS_DVSN_CD:String
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 정정취소구분코드
            /// 01 : 정정 02 : 취소
            let RVSE_CNCL_DVSN_CD:String
            /// 원주문번호
            /// 정정 혹은 취소할 주문의 번호
            let ORGN_ODNO:String
            /// 주문수량
            /// [Header tr_id TTTO1103U(선물옵션 정정취소 주간)] 전량일경우 0으로 입력 [Header tr_id JTCE1002U(선물옵션 정정취소 야간)] 일부수량 정정 및 취소 불가, 주문수량 반드시 입력 (공백 불가) 일부 미체결 시 잔량 전체에 대해서 취소 가능 EX) 2개 매수주문 후 1개 체결, 1개 미체결인 상태에서 취소주문 시 ORD_QTY는 1로 입력 ※ 모의계좌의 경우, 주문수량 반드시 입력 (공백 불가)
            let ORD_QTY:String
            /// 주문가격1
            /// 시장가나 최유리의 경우 0으로 입력 (취소 시에도 0 입력)
            let UNIT_PRICE:String
            /// 호가유형코드
            /// 01 : 지정가 02 : 시장가 03 : 조건부 04 : 최유리
            let NMPR_TYPE_CD:String
            /// 한국거래소호가조건코드
            /// 취소시 0으로 입력 정정시 0 : 없음 3 : IOC 4 : FOK
            let KRX_NMPR_CNDT_CD:String
            /// 잔여수량여부
            /// Y : 전량 N : 일부
            let RMN_QTY_YN:String
            /// 선물옵션종목구분코드
            /// [Header tr_id TTTO1103U(선물옵션 정정취소 주간)] 공란(Default) [Header tr_id JTCE1002U(선물옵션 정정취소 야간)] 01 : 선물 02 : 콜옵션 03 : 풋옵션 04 : 스프레드
            let FUOP_ITEM_DVSN_CD:String?
            /// 주문구분코드
            /// [정정] 01 : 지정가 02 : 시장가 03 : 조건부 04 : 최유리, 10 : 지정가(IOC) 11 : 지정가(FOK) 12 : 시장가(IOC) 13 : 시장가(FOK) 14 : 최유리(IOC) 15 : 최유리(FOK) [취소] 01 로 입력
            let ORD_DVSN_CD:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            let rt_cd: String
            /// 응답코드 - 응답코드
            let msg_cd: String
            /// 응답메세지 - 응답메세지
            let msg1: String
            /// 응답상세 : Array
            let output: [Output]
        }
        public struct Output : Codable {
            /// 계좌명
            /// 계좌의 고객명
            let ACNT_NAME:String
            /// 매매구분명
            /// 매도/매수 등 구분값
            let TRAD_DVSN_NAME:String
            /// 종목명
            /// 주문 종목 명칭
            let ITEM_NAME:String
            /// 주문시각
            /// 주문 접수 시간
            let ORD_TMD:String
            /// 주문채번지점번호
            /// 계좌 개설 시 관리점으로 선택한 영업점의 고유번호
            let ORD_GNO_BRNO:String
            /// 원주문번호
            /// 정정 또는 취소 대상 주문의 일련번호
            let ORGN_ODNO:String
            /// 주문번호
            /// 접수한 주문(정정 또는 취소)의 일련번호
            let ODNO:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/trading/order-rvsecncl"
        public var customHeader: [String : String]?
        enum TR_ID {
            case 주간
            case 야간
            var tr_id:String {
                switch self {
                case .주간:
                    return KISManager.getValueForCurrentTargetServer(실전서버: "TTTO1103U", 모의투자서버: "VTTO1103U")
                case .야간:
                    return KISManager.getValueForCurrentTargetServer(실전서버: "JTCE1002U", 모의투자서버: "")
                }
            }
        }
        init(tr_id: TR_ID, gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] TTTO1103U : 선물 옵션 정정 취소 주문 주간 JTCE1002U : 선물 옵션 정정 취소 주문 야간 [모의투자] VTTO1103U : 선물 옵션 정정 취소 주문 주간
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
            self.customHeader?["tr_id"] = tr_id.tr_id
        }
    }

    /// 선물옵션 주문체결내역조회[v1_국내선물-003]
    /// 선물옵션 주문체결내역조회 API입니다. 한 번의 호출에 최대 100건​까지 확인 가능하며, 이후의 값은 연속조회를 통해 확인하실 수 있습니다.
    struct inquireccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 시작주문일자
            /// 주문내역 조회 시작 일자, YYYYMMDD
            let STRT_ORD_DT:String
            /// 종료주문일자
            /// 주문내역 조회 마지막 일자, YYYYMMDD
            let END_ORD_DT:String
            /// 매도매수구분코드
            /// 00 : 전체 01 : 매도 02 : 매수
            let SLL_BUY_DVSN_CD:String
            /// 체결미체결구분
            /// 00 : 전체 01 : 체결 02 : 미체결
            let CCLD_NCCS_DVSN:String
            /// 정렬순서
            /// AS : 정순 DS : 역순
            let SORT_SQN:String
            /// 시작주문번호
            /// 조회 시작 번호 입력
            let STRT_ODNO:String
            /// 상품번호
            /// 공란 시, 전체 조회 선물 6자리 (예: 101S03) 옵션 9자리 (예: 201S03370)
            let PDNO:String
            /// 시장ID코드
            /// 공란(Default)
            let MKET_ID_CD:String
            /// 연속조회검색조건200
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_FK200값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_FK200:String
            /// 연속조회키200
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_NK200값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_NK200:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            let rt_cd: String
            /// 응답코드 - 응답코드
            let msg_cd: String
            /// 응답메세지 - 응답메세지
            let msg1: String
            /// 연속조회검색조건200 -
            let ctx_area_fk200: String
            /// 연속조회키200 -
            let ctx_area_nk200: String
            /// 응답상세1 : Array
            let output1: [Output1]
            /// 응답상세2 : Object
            let output2: Output2
        }
        public struct Output1 : Codable {
            /// 주문채번지점번호
            /// 계좌 개설 시 관리점으로 선택한 영업점의 고유번호
            let ord_gno_brno:String
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            let cano:String
            /// 종합계좌명
            /// 계좌의 고객명
            let csac_name:String
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            let acnt_prdt_cd:String
            /// 주문일자
            /// 주문의 접수일자
            let ord_dt:String
            /// 주문번호
            /// 접수한 주문의 일련번호
            let odno:String
            /// 원주문번호
            /// 정정 또는 취소 대상 주문의 일련번호
            let orgn_odno:String
            /// 매도매수구분코드
            /// 00 : 전체 01 : 매도 02 : 매수
            let sll_buy_dvsn_cd:String
            /// 매매구분명
            /// 매도/매수 등 구분값
            let trad_dvsn_name:String
            /// 호가유형코드
            /// 01 : 지정가 02 : 시장가 03 : 조건부 04 : 최유리
            let nmpr_type_cd:String
            /// 호가유형명
            /// 호가 유형의 명칭
            let nmpr_type_name:String
            /// 상품번호
            /// 선물옵션종목코드
            let pdno:String
            /// 상품명
            let prdt_name:String
            /// 상품유형코드
            let prdt_type_cd:String
            /// 주문수량
            /// 주문 수량
            let ord_qty:String
            /// 주문지수
            /// 주문 가격
            let ord_idx:String
            /// 잔량
            /// 주문 체결되지 않고 남은 수량
            let qty:String
            /// 주문시각
            /// 주문 접수 시간
            let ord_tmd:String
            /// 총체결수량
            /// 주문 체결된 수량
            let tot_ccld_qty:String
            /// 평균지수
            /// 체결된 주문 수량의 평균 체결 가격
            let avg_idx:String
            /// 총체결금액
            /// 체결된 주문의 합계금액
            let tot_ccld_amt:String
            /// 거부수량
            /// 접수된 주문이 정상 처리되지 못하고 거부된 수량
            let rjct_qty:String
            /// 장내매매거부사유코드
            /// 정상 처리되지 못하고 거부된 주문의 사유코드
            let ingr_trad_rjct_rson_cd:String
            /// 장내매매거부사유명
            /// 정상 처리되지 못하고 거부된 주문의 사유
            let ingr_trad_rjct_rson_name:String
            /// 주문직원번호
            /// 주문 접수한 직원의 사번 또는 온라인 주문 시 매체 유형코드
            let ord_stfno:String
            /// 스프레드종목여부
            /// 스프레드 종목 여부 구분값
            let sprd_item_yn:String
            /// 주문IP주소
            /// 주문 시 사용한 매체의 IP 주소
            let ord_ip_addr:String
        }
        public struct Output2 : Codable {
            /// 총주문수량
            /// 전체 주문 수량
            let tot_ord_qty:String
            /// 총체결금액합계
            /// 체결된 주문 전체의 합계 금액
            let tot_ccld_amt_smtl:String
            /// 총체결수량합계
            /// 체결된 주문 전체의 합계 수량
            let tot_ccld_qty_smtl:String
            /// 수수료합계
            /// 체결된 주문에 대한 매매수수료의 합계 금액
            let fee_smtl:String
            /// 연락전화번호
            /// 고객의 연락 가능한 전화번호
            let ctac_tlno:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/trading/inquire-ccnl"
        public var customHeader: [String : String]?
        init(tr_id: String = KISManager.getValueForCurrentTargetServer(실전서버: "TTTO5201R", 모의투자서버: "VTTO5201R"), gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] TTTO5201R : 선물 옵션 주문 체결 내역 조회 [모의투자] VTTO5201R : 선물 옵션 주문 체결 내역 조회
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

    /// 선물옵션 잔고현황[v1_국내선물-004]
    /// 선물옵션 잔고현황 API입니다. 한 번의 호출에 최대 20건까지 확인 가능하며, 이후의 값은 연속조회를 통해 확인하실 수 있습니다.
    struct inquirebalance : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 증거금 구분
            /// 01 : 개시 02 : 유지
            let MGNA_DVSN:String
            /// 정산상태코드
            /// 1 : 정산 (정산가격으로 잔고 조회) 2 : 본정산 (매입가격으로 잔고 조회)
            let EXCC_STAT_CD:String
            /// 연속조회검색조건200
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_FK200값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_FK200:String
            /// 연속조회키200
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_NK200값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_NK200:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            let rt_cd: String
            /// 응답코드 - 응답코드
            let msg_cd: String
            /// 응답메세지 - 응답메세지
            let msg1: String
            /// 연속조회검색조건200 -
            let ctx_area_fk200: String
            /// 연속조회키200 -
            let ctx_area_nk200: String
            /// 응답상세1 : Array
            let output1: [Output1]
            /// 응답상세2 : Array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            let cano:String
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            let acnt_prdt_cd:String
            /// 상품번호
            /// 선물옵션종목코드
            let pdno:String
            /// 상품유형코드
            let prdt_type_cd:String
            /// 단축상품번호
            /// 단축상품번호 (예: 101P09)
            let shtn_pdno:String
            /// 상품명
            let prdt_name:String
            /// 매도매수구분명
            /// 매도/매수 구분의 명칭 - 매수잔고를 가진 경우, "매수" 혹은 "BUY"로 출력 - 매도잔고를 가진 경우, "매도" 혹은 "SLL"로 출력 - 당일 잔고를 청산하여 잔고를 가지고 있지 않은 경우 빈칸으로 출력
            let sll_buy_dvsn_name:String
            /// 잔고수량
            /// 보유한 종목의 수량
            let cblc_qty:String
            /// 정산단가
            /// 당일 종가로 정산한 가격
            let excc_unpr:String
            /// 체결평균단가1
            /// 보유한 종목의 평균 체결 가격
            let ccld_avg_unpr1:String
            /// 지수종가
            let idx_clpr:String
            /// 매입금액
            /// 보유 종목을 매수한 금액
            let pchs_amt:String
            /// 평가금액
            /// 보유 종목을 현재가로 평가하여 산출한 금액
            let evlu_amt:String
            /// 평가손익금액
            /// 매입금액과 평가금액을 비교한 손익
            let evlu_pfls_amt:String
            /// 매매손익금액
            /// 매수와 매도가 완료된 수량에 대한 실현 손익
            let trad_pfls_amt:String
            /// 청산가능수량
            /// 청산 가능한 수량
            let lqd_psbl_qty:String
        }
        public struct Output2 : Codable {
            /// 예수금현금
            /// 원화로 보유한 현금 (현금미수금액, 수수료미수금액 차감)
            let dnca_cash:String
            /// 외화예수금액
            /// 외화로 보유한 현금
            let frcr_dncl_amt:String
            /// 예수금대용
            /// 주식대용금액+채권대용금액+전일대용매도대용금액+당일대용매도대용금액
            let dnca_sbst:String
            /// 총예수금액
            /// 상기 3개 예수금 항목의 합계 금액
            let tot_dncl_amt:String
            /// 총체결금액
            /// 체결된 주문의 합계금액
            let tot_ccld_amt:String
            /// 현금증거금
            /// 원화 현금 중 주문증거금으로 사용된 금액
            let cash_mgna:String
            /// 대용증거금
            /// 대용 예수금 중 주문증거금으로 사용된 금액
            let sbst_mgna:String
            /// 증거금총액
            /// 증거금으로 사용된 항목의 합계 금액
            let mgna_tota:String
            /// 옵션차금
            /// 당일옵션매도금에서 당일옵션매수금을 차감한 금액
            let opt_dfpa:String
            /// 당일차금
            /// 당일의 각 매수거래에 대하여 1에 의하여 산출한 금액의 합계액과 당일의 각 매도거래에 대하여 2에 의하여 산출한 금액의 합계액을 합산한 금액 1. 매수거래수량*(당일의 정산가격-체결가격)*최소가격변동금액*환산승수 2. 매도거래수량*(체결가격-당일의 정산가격)*최소가격변동금액*환산승수
            let thdt_dfpa:String
            /// 갱신차금
            /// 직전 거래일의 매수미결제약정에 대하여 1에 의하여 산출한 금액과 직전거래일의 매도미결제약정에 대하여 2에 의하여 산출한 금액을 합산한 금액 1. 매수미결제약정*(당일의 정산가격-직전거래일의 정산가격)*최소가격변동 금액*환산승수 2. 매도미결제약정*(직전거래일의 정산가격-당일의 정산가격)*최소가격변동 금액*환산승수
            let rnwl_dfpa:String
            /// 수수료
            /// 체결된 주문에 의한 매매수수료
            let fee:String
            /// 익일예수금
            /// 당일 매매내역을 근거로 익일(결제일) 고객님 계좌에 있는 현금
            let nxdy_dnca:String
            /// 익일예수금액
            let nxdy_dncl_amt:String
            /// 추정예탁자산
            /// 보유한 잔고를 정산 기준으로 평가한 금액과 예수금을 합한 금액
            let prsm_dpast:String
            /// 추정예탁자산금액
            let prsm_dpast_amt:String
            /// 적정주문가능현금
            /// 미수없는 주문가능금액
            let pprt_ord_psbl_cash:String
            /// 추가증거금현금
            /// 장 종료 후 예탁평가액이 유지증거금을 하회할 경우 또는 예탁현금이 결제금액 보다 적은 경우 고객이 추가적으로 납부해야 하는 증거금
            let add_mgna_cash:String
            /// 추가증거금총액
            let add_mgna_tota:String
            /// 선물매매손익금액
            /// 선물 매수와 매도가 완료된 수량에 대한 실현 손익
            let futr_trad_pfls_amt:String
            /// 옵션매매손익금액
            /// 옵션 매수와 매도가 완료된 수량에 대한 실현 손익
            let opt_trad_pfls_amt:String
            /// 선물평가손익금액
            /// 선물 잔고의 매입가격 또는 정산가격과 평가금액을 비교한 손익
            let futr_evlu_pfls_amt:String
            /// 옵션평가손익금액
            /// 옵션 잔고의 매입가격 또는 정산가격과 평가금액을 비교한 손익
            let opt_evlu_pfls_amt:String
            /// 매매손익금액합계
            /// 선물매매손익금액과 옵션매매손익금액을 합한 금액
            let trad_pfls_amt_smtl:String
            /// 평가손익금액합계
            /// 선물평가손익금액과 옵션평가손익금액을 합한 금액
            let evlu_pfls_amt_smtl:String
            /// 인출가능총금액
            /// 출금 가능한 현금(예탁현금+예탁대용-예탁증거금총액)
            let wdrw_psbl_tot_amt:String
            /// 주문가능현금
            /// 예수금현금에서 현금증거금을 차감한 금액
            let ord_psbl_cash:String
            /// 주문가능대용
            /// 예수금대용에서 대용증거금을 차감한 금액
            let ord_psbl_sbst:String
            /// 주문가능총액
            /// 주문가능현금과 주문가능대용을 합한 금액
            let ord_psbl_tota:String
            /// 매입금액합계
            /// 종목별 매입금액의 합계 금액
            let pchs_amt_smtl:String
            /// 평가금액합계
            /// 종목별 평가금액의 합계 금액
            let evlu_amt_smtl:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/trading/inquire-balance"
        public var customHeader: [String : String]?
        init(tr_id: String = KISManager.getValueForCurrentTargetServer(실전서버: "CTFO6118R", 모의투자서버: "VTFO6118R"), gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] CTFO6118R : 선물 옵션 잔고 현황 [모의투자] VTFO6118R : 선물 옵션 잔고 현황
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

    /// 선물옵션 주문가능[v1_국내선물-005]
    /// 선물옵션 주문가능 API입니다. 주문가능 내역과 수량을 확인하실 수 있습니다.
    struct inquirepsblorder : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String? = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String? = KISManager.ACNT_PRDT_CD()
            /// 상품번호
            /// 선물옵션종목코드 선물 6자리 (예: 101S03) 옵션 9자리 (예: 201S03370)
            let PDNO:String?
            /// 매도매수구분코드
            /// 01 : 매도 02 : 매수
            let SLL_BUY_DVSN_CD:String?
            /// 주문가격1
            /// 주문가격 ※ 주문가격 '0'일 경우 - 옵션매수 : 현재가 - 그 이외 : 기준가
            let UNIT_PRICE:String?
            /// 주문구분코드
            /// 01 : 지정가 02 : 시장가 03 : 조건부 04 : 최유리, 10 : 지정가(IOC) 11 : 지정가(FOK) 12 : 시장가(IOC) 13 : 시장가(FOK) 14 : 최유리(IOC) 15 : 최유리(FOK)
            let ORD_DVSN_CD:String?
        }
        struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            let rt_cd: String
            /// 응답코드 - 응답코드
            let msg_cd: String
            /// 응답메세지 - 응답메세지
            let msg1: String
            /// 응답상세 : Array
            let output: [Output]
        }
        public struct Output : Codable {
            /// 총가능수량
            /// 총가능수량
            let tot_psbl_qty:String
            /// 청산가능수량1
            /// 청산가능수량
            let lqd_psbl_qty1:String
            /// 주문가능수량
            /// 주문가능수량
            let ord_psbl_qty:String
            /// 기준지수
            /// 기준지수
            let bass_idx:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/trading/inquire-psbl-order"
        public var customHeader: [String : String]?
        init(tr_id: String = KISManager.getValueForCurrentTargetServer(실전서버: "TTTO5105R", 모의투자서버: "VTTO5105R"), gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access Token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Credentials Grant 절차를 준용) 제휴사(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] TTTO5105R : 선물 옵션 주문 가능 [모의투자] VTTO5105R : 선물 옵션 주문 가능
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사 APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // 제휴사는 사용자(회원)의 IP Address 필수이며 일반고객은 제외
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API 문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// (야간)선물옵션 주문체결 내역조회 [국내선물-009]
    struct inquirengtccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 시작주문일자
            let STRT_ORD_DT:String
            /// 종료주문일자
            /// 조회하려는 마지막 일자 다음일자로 조회 (ex. 20221011 까지의 내역을 조회하고자 할 경우, 20221012로 종료주문일자 설정)
            let END_ORD_DT:String
            /// 매도매수구분코드
            /// 공란 : default (00: 전체 ,01 : 매도, 02 : 매수)
            let SLL_BUY_DVSN_CD:String
            /// 체결미체결구분
            /// 00 : 전체 01 : 체결 02 : 미체결
            let CCLD_NCCS_DVSN:String
            /// 정렬순서
            /// 공란 : default (DS : 정순, 그외 : 역순)
            let SORT_SQN:String
            /// 시작주문번호
            /// 공란 : default
            let STRT_ODNO:String
            /// 상품번호
            /// 공란 : default
            let PDNO:String
            /// 시장ID코드
            /// 공란 : default
            let MKET_ID_CD:String
            /// 선물옵션구분코드
            /// 공란 : 전체, 01 : 선물, 02 : 옵션
            let FUOP_DVSN_CD:String
            /// 화면구분
            /// 02(Default)
            let SCRN_DVSN:String
            /// 연속조회검색조건200
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_FK200값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_FK200:String
            /// 연속조회키200
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_NK200값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_NK200:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세1 : Array
            let output: [Output]
            /// 응답상세2 : Object Array
            /// 시간별체결 정보
            let output1: [Output1]
        }
        public struct Output : Codable {
            /// 총주문수량
            let tot_ord_qty:String
            /// 총체결수량
            let tot_ccld_qty:String
            /// 총체결금액
            let tot_ccld_amt:String
            /// 수수료
            let fee:String
        }
        public struct Output1 : Codable {
            /// 주문채번지점번호
            let ord_gno_brno:String
            /// 종합계좌번호
            let cano:String
            /// 종합계좌명
            let csac_name:String
            /// 계좌상품코드
            let acnt_prdt_cd:String
            /// 주문일자
            let ord_dt:String
            /// 주문번호
            let odno:String
            /// 원주문번호
            let orgn_odno:String
            /// 매도매수구분코드
            let sll_buy_dvsn_cd:String
            /// 매매구분명
            let trad_dvsn_name:String
            /// 호가유형명
            let nmpr_type_name:String
            /// 상품번호
            let pdno:String
            /// 상품명
            let prdt_name:String
            /// 상품유형코드
            let prdt_type_cd:String
            /// 주문수량
            let ord_qty:String
            /// 주문지수
            let ord_idx:String
            /// 잔량
            let qty:String
            /// 주문시각
            let ord_tmd:String
            /// 총체결수량
            let tot_ccld_qty:String
            /// 평균지수
            let avg_idx:String
            /// 총체결금액
            let tot_ccld_amt:String
            /// 거부수량
            let rjct_qty:String
            /// 장내매매거부사유코드
            let ingr_trad_rjct_rson_cd:String
            /// 장내매매거부사유명
            let ingr_trad_rjct_rson_name:String
            /// 주문직원번호
            let ord_stfno:String
            /// 스프레드종목여부
            let sprd_item_yn:String
            /// 주문IP주소
            let ord_ip_addr:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/trading/inquire-ngt-ccnl"
        public var customHeader: [String : String]?
        init(tr_id: String = "JTCE5005R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // JTCE5005R
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

    /// (야간)선물옵션 잔고현황 [국내선물-010]
    struct inquirengtbalance : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 계좌비밀번호
            /// 공란("")으로 조회
            let ACNT_PWD:String
            /// 증거금구분
            /// 01 : 개시, 02 : 유지
            let MGNA_DVSN:String
            /// 정산상태코드
            /// 1 : 정산 (정산가격으로 잔고 조회) 2 : 본정산 (매입가격으로 잔고 조회)
            let EXCC_STAT_CD:String
            /// 연속조회검색조건200
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_FK200값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_FK200:String
            /// 연속조회키200
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_NK200값 : 다음페이지 조회시(2번째부터)
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
            /// 시간별체결 정보
            let output1: [Output1]
        }
        public struct Output : Codable {
            /// 예수금현금
            /// 총주문수량
            let dnca_cash:String
            /// 외화예수금액
            /// 주문채번지점번호
            let frcr_dncl_amt:String
            /// 예수금대용
            let dnca_sbst:String
            /// 총예수금액
            let tot_dncl_amt:String
            /// 현금증거금
            let cash_mgna:String
            /// 대용증거금
            let sbst_mgna:String
            /// 증거금총액
            let mgna_tota:String
            /// 옵션차금
            let opt_dfpa:String
            /// 당일차금
            let thdt_dfpa:String
            /// 갱신차금
            let rnwl_dfpa:String
            /// 수수료
            let fee:String
            /// 익일예수금
            let nxdy_dnca:String
            /// 추정예탁자산
            /// 종합계좌번호
            let prsm_dpast:String
            /// 적정주문가능현금
            /// 총체결수량
            let pprt_ord_psbl_cash:String
            /// 추가증거금현금
            /// 총체결금액
            let add_mgna_cash:String
            /// 추가증거금총액
            /// 종합계좌명
            let add_mgna_tota:String
            /// 선물매매손익금액
            /// 수수료
            let futr_trad_pfls_amt:String
            /// 옵션매매손익금액
            /// 계좌상품코드
            let opt_trad_pfls_amt:String
            /// 선물평가손익금액
            /// 주문일자
            let futr_evlu_pfls_amt:String
            /// 옵션평가손익금액
            /// 주문번호
            let opt_evlu_pfls_amt:String
            /// 매매손익금액합계
            let trad_pfls_amt_smtl:String
            /// 평가손익금액합계
            let evlu_pfls_amt_smtl:String
            /// 인출가능총금액
            let wdrw_psbl_tot_amt:String
            /// 주문가능현금
            let ord_psbl_cash:String
            /// 주문가능대용
            let ord_psbl_sbst:String
            /// 주문가능총액
            let ord_psbl_tota:String
            /// 유지증거금총금액
            let mmga_tot_amt:String
            /// 유지증거금현금금액
            let mmga_cash_amt:String
            /// 유지비율
            let mtnc_rt:String
            /// 부족금액
            let isfc_amt:String
            /// 매입금액합계
            let pchs_amt_smtl:String
            /// 평가금액합계
            let evlu_amt_smtl:String
        }
        public struct Output1 : Codable {
            /// 종합계좌번호
            let cano:String
            /// 계좌상품코드
            let acnt_prdt_cd:String
            /// 상품번호
            let pdno:String
            /// 상품유형코드
            let prdt_type_cd:String
            /// 단축상품번호
            let shtn_pdno:String
            /// 상품명
            let prdt_name:String
            /// 매도매수구분코드
            let sll_buy_dvsn_cd:String
            /// 매매구분명
            let trad_dvsn_name:String
            /// 잔고수량
            let cblc_qty:String
            /// 정산단가
            let excc_unpr:String
            /// 체결평균단가1
            let ccld_avg_unpr1:String
            /// 지수종가
            let idx_clpr:String
            /// 매입금액
            let pchs_amt:String
            /// 평가금액
            let evlu_amt:String
            /// 평가손익금액
            let evlu_pfls_amt:String
            /// 매매손익금액
            let trad_pfls_amt:String
            /// 청산가능수량
            let lqd_psbl_qty:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/trading/inquire-ngt-balance"
        public var customHeader: [String : String]?
        init(tr_id: String = "JTCE6001R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // JTCE6001R
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

    /// (야간)선물옵션 주문가능 조회 [국내선물-011]
    struct inquirepsblngtorder : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            let CANO:String
            /// 계좌상품코드
            let ACNT_PRDT_CD:String
            /// 상품번호
            let PDNO:String
            /// 상품유형코드
            /// 301 : 선물옵션
            let PRDT_TYPE_CD:String
            /// 매도매수구분코드
            /// 01 : 매도 , 02 : 매수
            let SLL_BUY_DVSN_CD:String
            /// 주문가격1
            let UNIT_PRICE:String
            /// 주문구분코드
            /// '01 : 지정가 02 : 시장가 03 : 조건부 04 : 최유리, 10 : 지정가(IOC) 11 : 지정가(FOK) 12 : 시장가(IOC) 13 : 시장가(FOK) 14 : 최유리(IOC) 15 : 최유리(FOK)'
            let ORD_DVSN_CD:String
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
            /// 최대주문가능수량
            /// 최대주문가능수량
            let max_ord_psbl_qty:String
            /// 청산가능수량
            /// 청산가능수량
            let lqd_psbl_qty:String
            /// 주문가능수량
            /// 주문가능수량
            let ord_psbl_qty:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/trading/inquire-psbl-ngt-order"
        public var customHeader: [String : String]?
        init(tr_id: String = "JTCE1004R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // JTCE1004R
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

    /// 선물옵션 잔고정산손익내역[v1_국내선물-013]
    struct inquirebalancesettlementpl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 조회일자
            /// 조회일자(YYYYMMDD)
            let INQR_DT:String
            /// 연속조회검색조건200
            /// 연속조회검색조건200
            let CTX_AREA_FK200:String
            /// 연속조회키200
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
            /// 응답상세 : Object
            let output2: Output2
            /// 응답상세2 : Array
            /// array
            let output1: [Output1]
        }
        public struct Output2 : Codable {
            /// 익일예수금
            let nxdy_dnca:String
            /// 유지증거금현금
            let mmga_cash:String
            /// 위탁증거금현금
            let brkg_mgna_cash:String
            /// 옵션매수대금
            let opt_buy_chgs:String
            /// 옵션청산평가금액
            let opt_lqd_evlu_amt:String
            /// 예수금대용
            let dnca_sbst:String
            /// 유지증거금총액
            let mmga_tota:String
            /// 위탁증거금총액
            let brkg_mgna_tota:String
            /// 옵션매도대금
            let opt_sll_chgs:String
            /// 수수료
            let fee:String
            /// 당일차금
            let thdt_dfpa:String
            /// 갱신차금
            let rnwl_dfpa:String
            /// 예수금현금
            let dnca_cash:String
        }
        public struct Output1 : Codable {
            /// 상품번호
            let pdno:String
            /// 상품명
            let prdt_name:String
            /// 매매구분명
            let trad_dvsn_name:String
            /// 전일잔고수량
            let bfdy_cblc_qty:String
            /// 신규수량
            let new_qty:String
            /// 전매환매수량
            let mnpl_rpch_qty:String
            /// 잔고수량
            let cblc_qty:String
            /// 잔고금액
            let cblc_amt:String
            /// 매매손익금액
            let trad_pfls_amt:String
            /// 평가금액
            let evlu_amt:String
            /// 평가손익금액
            let evlu_pfls_amt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/trading/inquire-balance-settlement-pl"
        public var customHeader: [String : String]?
        init(tr_id: String = "CTFO6117R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // CTFO6117R
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

    /// 선물옵션 총자산현황[v1_국내선물-014]
    struct inquiredeposit : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object
            let output: Output
        }
        public struct Output : Codable {
            /// 예수금총액
            let dnca_tota:String
            /// 전일수표금액
            let bfdy_chck_amt:String
            /// 당일수표금액
            let thdt_chck_amt:String
            /// 실물인수도예치금액
            let rlth_uwdl_dpos_amt:String
            /// 위탁증거금현금
            let brkg_mgna_cash:String
            /// 인출가능총금액
            let wdrw_psbl_tot_amt:String
            /// 주문가능현금
            let ord_psbl_cash:String
            /// 주문가능총액
            let ord_psbl_tota:String
            /// 예수금대용
            let dnca_sbst:String
            /// 유가증권대용금액
            let scts_sbst_amt:String
            /// 외화평가금액
            let frcr_evlu_amt:String
            /// 위탁증거금대용
            let brkg_mgna_sbst:String
            /// 대용해제가능금액
            let sbst_rlse_psbl_amt:String
            /// 유지비율
            let mtnc_rt:String
            /// 추가증거금총액
            let add_mgna_tota:String
            /// 추가증거금현금
            let add_mgna_cash:String
            /// 미수금
            let rcva:String
            /// 선물매매손익
            let futr_trad_pfls:String
            /// 옵션매매손익금액
            let opt_trad_pfls_amt:String
            /// 매매손익합계
            let trad_pfls_smtl:String
            /// 선물평가손익금액
            let futr_evlu_pfls_amt:String
            /// 옵션평가손익금액
            let opt_evlu_pfls_amt:String
            /// 평가손익합계
            let evlu_pfls_smtl:String
            /// 정산차금
            let excc_dfpa:String
            /// 옵션차금
            let opt_dfpa:String
            /// 위탁수수료
            let brkg_fee:String
            /// 익일예수금
            let nxdy_dnca:String
            /// 추정예탁자산금액
            let prsm_dpast_amt:String
            /// 현금유지금액
            let cash_mntn_amt:String
            /// 해킹사고계좌이전금액
            let hack_acdt_acnt_move_amt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/trading/inquire-deposit"
        public var customHeader: [String : String]?
        init(tr_id: String = "CTRP6550R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // CTRP6550R
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

    /// 선물옵션 잔고평가손익내역[v1_국내선물-015]
    struct inquirebalancevaluationpl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 증거금구분
            /// 01 : 개시, 02 : 유지
            let MGNA_DVSN:String
            /// 정산상태코드
            /// 1 : 정산 (정산가격으로 잔고 조회) 2 : 본정산 (매입가격으로 잔고 조회)
            let EXCC_STAT_CD:String
            /// 연속조회검색조건200
            /// 연속조회검색조건200
            let CTX_AREA_FK200:String
            /// 연속조회키200
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
            /// 응답상세 : Object
            let output2: Output2
            /// 응답상세2 : Array
            /// array
            let output1: [Output1]
        }
        public struct Output2 : Codable {
            /// 예수금현금
            let dnca_cash:String
            /// 외화예수금액
            let frcr_dncl_amt:String
            /// 예수금대용
            let dnca_sbst:String
            /// 총예수금액
            let tot_dncl_amt:String
            /// 총체결금액
            let tot_ccld_amt:String
            /// 현금증거금
            let cash_mgna:String
            /// 대용증거금
            let sbst_mgna:String
            /// 증거금총액
            let mgna_tota:String
            /// 옵션차금
            let opt_dfpa:String
            /// 당일차금
            let thdt_dfpa:String
            /// 갱신차금
            let rnwl_dfpa:String
            /// 수수료
            let fee:String
            /// 익일예수금
            let nxdy_dnca:String
            /// 익일예수금액
            let nxdy_dncl_amt:String
            /// 추정예탁자산
            let prsm_dpast:String
            /// 추정예탁자산금액
            let prsm_dpast_amt:String
            /// 적정주문가능현금
            let pprt_ord_psbl_cash:String
            /// 추가증거금현금
            let add_mgna_cash:String
            /// 추가증거금총액
            let add_mgna_tota:String
            /// 선물매매손익금액
            let futr_trad_pfls_amt:String
            /// 옵션매매손익금액
            let opt_trad_pfls_amt:String
            /// 선물평가손익금액
            let futr_evlu_pfls_amt:String
            /// 옵션평가손익금액
            let opt_evlu_pfls_amt:String
            /// 매매손익금액합계
            let trad_pfls_amt_smtl:String
            /// 평가손익금액합계
            let evlu_pfls_amt_smtl:String
            /// 인출가능총금액
            let wdrw_psbl_tot_amt:String
            /// 주문가능현금
            let ord_psbl_cash:String
            /// 주문가능대용
            let ord_psbl_sbst:String
            /// 주문가능총액
            let ord_psbl_tota:String
        }
        public struct Output1 : Codable {
            /// 종합계좌번호
            let cano:String
            /// 계좌상품코드
            let acnt_prdt_cd:String
            /// 상품번호
            let pdno:String
            /// 상품유형코드
            let prdt_type_cd:String
            /// 단축상품번호
            let shtn_pdno:String
            /// 상품명
            let prdt_name:String
            /// 매도매수구분명
            let sll_buy_dvsn_name:String
            /// 잔고수량1
            let cblc_qty1:String
            /// 정산단가
            let excc_unpr:String
            /// 체결평균단가1
            let ccld_avg_unpr1:String
            /// 지수종가
            let idx_clpr:String
            /// 매입금액
            let pchs_amt:String
            /// 평가금액
            let evlu_amt:String
            /// 평가손익금액
            let evlu_pfls_amt:String
            /// 매매손익금액
            let trad_pfls_amt:String
            /// 청산가능수량
            let lqd_psbl_qty:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/trading/inquire-balance-valuation-pl"
        public var customHeader: [String : String]?
        init(tr_id: String = "CTFO6159R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // CTFO6159R
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

    /// 선물옵션 기준일체결내역[v1_국내선물-016]
    struct inquireccnlbstime : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 주문일자
            /// 주문일자(YYYYMMDD)
            let ORD_DT:String
            /// 선물옵션거래시작시각
            /// 선물옵션거래시작시간(HHMMSS)
            let FUOP_TR_STRT_TMD:String
            /// 선물옵션거래종료시각
            /// 선물옵션거래종료시간(HHMMSS)
            let FUOP_TR_END_TMD:String
            /// 연속조회검색조건200
            /// 연속조회검색조건200
            let CTX_AREA_FK200:String
            /// 연속조회키200
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
            /// 응답상세 : Array
            /// array
            let output1: [Output1]
            /// 응답상세2 : Object
            let output2: Output2
        }
        public struct Output1 : Codable {
            /// 상품번호
            let pdno:String
            /// 상품명
            let prdt_name:String
            /// 주문번호
            let odno:String
            /// 거래유형명
            let tr_type_name:String
            /// 최종결제일
            let last_sttldt:String
            /// 체결지수
            let ccld_idx:String
            /// 체결량
            let ccld_qty:String
            /// 매매금액
            let trad_amt:String
            /// 수수료
            let fee:String
            /// 체결시간
            let ccld_btwn:String
        }
        public struct Output2 : Codable {
            /// 총체결수량합계
            let tot_ccld_qty_smtl:String
            /// 총체결금액합계
            let tot_ccld_amt_smtl:String
            /// 수수료조정
            let fee_adjt:String
            /// 수수료합계
            let fee_smtl:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/trading/inquire-ccnl-bstime"
        public var customHeader: [String : String]?
        init(tr_id: String = "CTFO5139R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // CTFO5139R
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

    /// 선물옵션기간약정수수료일별[v1_국내선물-017]
    struct inquiredailyamountfee : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 조회시작일
            /// 조회시작일(YYYYMMDD)
            let INQR_STRT_DAY:String
            /// 조회종료일
            /// 조회종료일(YYYYMMDD)
            let INQR_END_DAY:String
            /// 연속조회검색조건200
            /// 연속조회검색조건200
            let CTX_AREA_FK200:String
            /// 연속조회키200
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
            /// 응답상세 : Array
            /// array
            let output1: [Output1]
            /// 응답상세2 : Object
            let output2: Output2
        }
        public struct Output1 : Codable {
            /// 주문일자
            let ord_dt:String
            /// 상품번호
            let pdno:String
            /// 종목명
            let item_name:String
            /// 매도약정금액
            let sll_agrm_amt:String
            /// 매도수수료
            let sll_fee:String
            /// 매수약정금액
            let buy_agrm_amt:String
            /// 매수수수료
            let buy_fee:String
            /// 총수수료합계
            let tot_fee_smtl:String
            /// 매매손익
            let trad_pfls:String
        }
        public struct Output2 : Codable {
            /// 선물약정
            let futr_agrm:String
            /// 선물약정금액
            let futr_agrm_amt:String
            /// 선물약정금액합계
            let futr_agrm_amt_smtl:String
            /// 선물매도수수료합계
            let futr_sll_fee_smtl:String
            /// 선물매수수수료합계
            let futr_buy_fee_smtl:String
            /// 선물수수료합계
            let futr_fee_smtl:String
            /// 옵션약정
            let opt_agrm:String
            /// 옵션약정금액
            let opt_agrm_amt:String
            /// 옵션약정금액합계
            let opt_agrm_amt_smtl:String
            /// 옵션매도수수료합계
            let opt_sll_fee_smtl:String
            /// 옵션매수수수료합계
            let opt_buy_fee_smtl:String
            /// 옵션수수료합계
            let opt_fee_smtl:String
            /// 상품선물약정
            let prdt_futr_agrm:String
            /// 상품선물옵션
            let prdt_fuop:String
            /// 상품선물평가금액
            let prdt_futr_evlu_amt:String
            /// 선물수수료
            let futr_fee:String
            /// 옵션수수료
            let opt_fee:String
            /// 수수료
            let fee:String
            /// 매도약정금액
            let sll_agrm_amt:String
            /// 매수약정금액
            let buy_agrm_amt:String
            /// 약정금액합계
            let agrm_amt_smtl:String
            /// 매도수수료
            let sll_fee:String
            /// 매수수수료
            let buy_fee:String
            /// 수수료합계
            let fee_smtl:String
            /// 매매손익합계
            let trad_pfls_smtl:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/trading/inquire-daily-amount-fee"
        public var customHeader: [String : String]?
        init(tr_id: String = "CTFO6119R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // CTFO6119R
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

    /// (야간)선물옵션 증거금 상세 [국내선물-024]
    /// (야간)선물옵션 증거금상세 API입니다.한국투자 HTS(eFriend Force) > [2537] 야간선물옵션 증거금상세 화면 의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct ngtmargindetail : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            let CANO:String
            /// 계좌상품코드
            let ACNT_PRDT_CD:String
            /// 통화코드
            /// 위탁(01), 유지(02)
            let CRCY_CD:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array 아래 18가지 항목이 순서대로 출력됨 (1) A. 신규증거금 - 선물 - 1.개별종목 (2) A. 신규증거금 - 선물 - 2.스프레드 (3) A. 신규증거금 - 3. ﻿﻿﻿옵션매수증거금 ﻿﻿(4) A. 신규증거금 - 4. 옵션매도증거금 ﻿﻿(5) A. 소계(1+2+3+4) (6) B. 순위험증거금 - 1. ﻿﻿가격변동증거금 (7) B. 순위험증거금 - 2. ﻿﻿﻿선물스프레드증거금 ﻿﻿(8) B. 순위험증거금 - 3. 인수수도 증거금 등 (9) B. 순위험증거금 - 4. 최소증거금 (10) B. 순위험증거금 - 5. 옵션가격증거금 (11) B. 순위험증거금 - 6. 총위험증거금 (12) B. 소계SUM상품군별MAX[{MAX(1+2+3,4)+5},6] (13) C. 결제예정금액 - 1. ﻿﻿﻿당일옵션매수금액 (14) ﻿﻿C. 결제예정금액 - 2. 당일옵션매도금액 (15) C. 결제예정금액 - 3. ﻿﻿당일선물손실 ﻿﻿﻿(16) C. 결제예정금액 - 4. 당일선물이익 (17) C.소계(1-2+3-4) (18) (A)+B+(C)
            let output1: [Output1]
            /// 응답상세 : Object Array
            /// array 아래 5가지 항목이 순서대로 출력됨 (1) 예수금 (2) 인출가능금액 (3) 주문가능금액 ﻿﻿(4) 위탁증거금액 ﻿﻿(5) 추가증거금액 ※ 인출가능금액은 정산 후 인출가능 예정 금액입니다. 현재 시점 실제 인출 가능금액은 정규장, 야간시장 인출가능금액 중 적은 금액 기준입니다.
            let output2: [Output2]
            /// 응답상세 : Object
            let output3: Output3
        }
        public struct Output1 : Codable {
            /// 현금금액
            let cash_amt:String
            /// 총금액
            let tot_amt:String
        }
        public struct Output2 : Codable {
            /// 현금금액
            let cash_amt:String
            /// 대용금액
            let sbst_amt:String
            /// 총금액
            let tot_amt:String
        }
        public struct Output3 : Codable {
            /// 기본예탁금차등등급코드
            let base_dpsa_gdat_grad_cd:String
            /// 전일대용매도체결금액
            let bfdy_sbst_sll_ccld_amt:String
            /// 전일대용매도대용금액
            let bfdy_sbst_sll_sbst_amt:String
            /// 정산차금
            let excc_dfpa:String
            /// 수수료금액
            let fee_amt:String
            /// 익일예수금액
            let nxdy_dncl_amt:String
            /// 옵션기본예탁금차등등급코드
            let opt_base_dpsa_gdat_grad_cd:String
            /// 옵션매수전용계좌여부
            let opt_buy_exus_acnt_yn:String
            /// 옵션차금
            let opt_dfpa:String
            /// 추정예탁자산금액
            let prsm_dpast_amt:String
            /// 당일대용매도체결금액
            let thdt_sbst_sll_ccld_amt:String
            /// 당일대용매도대용금액
            let thdt_sbst_sll_sbst_amt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/trading/ngt-margin-detail"
        public var customHeader: [String : String]?
        init(tr_id: String = "JTCE6003R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // JTCE6003R
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
