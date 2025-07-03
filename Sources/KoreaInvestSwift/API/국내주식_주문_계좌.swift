//
//  국내주식_주문_계좌.swift
//  KoreaInvestSwift
//
//  Created by kin on 3/25/25.
//
import FullyRESTful
import Foundation
import KinKit
public extension KISAPI {
    public enum 국내주식_주문_계좌 {}
    public enum 국내주식_주문_계좌_퇴직연금 {}
}
public extension KISAPI.국내주식_주문_계좌 {
    /// 주식주문(현금)[v1_국내주식-001]
    /// 국내주식주문(현금) API 입니다. ※ TTC0802U(현금매수) 사용하셔서 미수매수 가능합니다. 단, 거래하시는 계좌가 증거금40%계좌로 신청이 되어있어야 가능합니다. ※ 신용매수는 별도의 API가 준비되어 있습니다.※ ORD_QTY(주문수량), ORD_UNPR(주문단가) 등을 String으로 전달해야 함에 유의 부탁드립니다.※ ORD_UNPR(주문단가)가 없는 주문은 상한가로 주문금액을 선정하고 이후 체결이되면 체결금액로 정산됩니다.※ POST API의 경우 BODY값의 key값들을 대문자로 작성하셔야 합니다.   (EX. "CANO" : "12345678", "ACNT_PRDT_CD": "01",...)※ 종목코드 마스터파일 파이썬 정제코드는 한국투자증권 Github 참고 부탁드립니다.   https://github.com/koreainvestment/open-trading-api/tree/main/stocks_info
    public struct ordercash : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 종합계좌번호
            let CANO:String
            /// 계좌상품코드
            /// 상품유형코드
            let ACNT_PRDT_CD:String
            /// 상품번호
            /// 종목코드(6자리)
            let PDNO:String
            /// 매도유형 (매도주문 시)
            /// 01@일반매도 02@임의매매 05@대차매도 → 미입력시 01 일반매도로 진행
            let SLL_TYPE:SLL_TYPE_enum
            /// 주문구분
            /// 00@지정가 01@시장가 02@조건부지정가 03@최유리지정가 04@최우선지정가 05@장전 시간외 06@장후 시간외 07@시간외 단일가 65@경매매 08@자기주식 09@자기주식S-Option 10@자기주식금전신탁 11@IOC지정가 (즉시체결,잔량취소) 12@FOK지정가 (즉시체결,전량취소) 13@IOC시장가 (즉시체결,잔량취소) 14@FOK시장가 (즉시체결,전량취소) 15@IOC최유리 (즉시체결,잔량취소) 16@FOK최유리 (즉시체결,전량취소) 51@장중대량 52@장중바스켓 62@장개시전 시간외대량 63@장개시전 시간외바스켓 67@장개시전 금전신탁자사주 69@장개시전 자기주식 72@시간외대량 77@시간외자사주신탁 79@시간외대량자기주식 80@바스켓 21@중간가 22@스톱지정가 23@중간가IOC 24@중간가FOK
            let ORD_DVSN:ORD_DVSN_enum
            /// 주문수량
            /// 주문수량
            let ORD_QTY:String
            /// 주문단가
            /// 주문단가
            let ORD_UNPR:String
            /// 조건가격
            /// 스탑지정가호가 주문 (ORD_DVSN이 22) 사용 시에만 필수
            let CNDT_PRIC:String?
            /// 거래소ID구분코드
            /// 한국거래소 : KRX 대체거래소 (넥스트레이드) : NXT → 미입력시 KRX로 진행
            let EXCG_ID_DVSN_CD:String?
            public init(CANO: String? = nil, ACNT_PRDT_CD: String? = nil, PDNO: String, SLL_TYPE: SLL_TYPE_enum, ORD_DVSN: ORD_DVSN_enum, ORD_QTY: String, ORD_UNPR: String, CNDT_PRIC: String?, EXCG_ID_DVSN_CD: String?) {
                self.CANO = CANO ?? KISManager.currentManager!.getCANO()
                self.ACNT_PRDT_CD = ACNT_PRDT_CD ?? KISManager.currentManager!.ACNT_PRDT_CD()
                self.PDNO = PDNO
                self.SLL_TYPE = SLL_TYPE
                self.ORD_DVSN = ORD_DVSN
                self.ORD_QTY = ORD_QTY
                self.ORD_UNPR = ORD_UNPR
                self.CNDT_PRIC = CNDT_PRIC
                self.EXCG_ID_DVSN_CD = EXCG_ID_DVSN_CD
            }
        }
        public struct Response: Codable {
            /// 성공 실패 여부 -
            public let rt_cd: String
            /// 응답코드 -
            public let msg_cd: String
            /// 응답메세지 -
            public let msg1: String
            /// 응답상세 : Object Array
            /// single
            public let output: Output
        }
        public struct Output : Codable {
            /// 거래소코드
            public let krx_fwdg_ord_orgno:String
            /// 주문번호
            public let odno:String
            /// 주문시간
            public let ord_tmd:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/order-cash"
        public var customHeader: [String : String]?
        public enum TR_ID {
            case 매도
            case 매수
            var tr_id : String {
                switch self {
                case .매도: return KISManager.currentManager!.getValueForCurrentTargetServer(실전서버: "TTTC0011U", 모의투자서버: "VTTC0011U")
                case .매수: return KISManager.currentManager!.getValueForCurrentTargetServer(실전서버: "TTTC0012U", 모의투자서버: "VTTC0012U")
                }
            }
        }
        public init(tr_id: TR_ID, gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // '※ 구TR은 사전고지 없이 막힐 수 있으므로 반드시 신TR로 변경이용 부탁드립니다. [실전투자] 국내주식주문 매도 : (구)TTTC0801U → (신)TTTC0011U 국내주식주문 매도(모의투자) : (구)VTTC0801U → (신)VTTC0011U 국내주식주문 매수 : (구)TTTC0802U → (신)TTTC0012U 국내주식주문 매수(모의투자) : (구)VTTC0802U → (신)VTTC0012U'
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["Content-Type"] = "application/json; charset=UTF-8"
            self.customHeader?["tr_id"] = tr_id.tr_id
        }
        public enum SLL_TYPE_enum : String, Codable {
            case 일반매도 = "01"
            case 임의매매 = "02"
            case 대차매도미입력시 = "05"
        }
        public enum ORD_DVSN_enum : String, Codable {
            case 지정가 = "00"
            case 시장가 = "01"
            case 조건부지정가 = "02"
            case 최유리지정가 = "03"
            case 최우선지정가 = "04"
            case 장전시간외 = "05"
            case 장후시간외 = "06"
            case 시간외단일가 = "07"
            case 경매매 = "65"
            case 자기주식 = "08"
            case 자기주식SOption = "09"
            case 자기주식금전신탁 = "10"
            case IOC지정가즉시체결잔량취소 = "11"
            case FOK지정가즉시체결전량취소 = "12"
            case IOC시장가즉시체결잔량취소 = "13"
            case FOK시장가즉시체결전량취소 = "14"
            case IOC최유리즉시체결잔량취소 = "15"
            case FOK최유리즉시체결전량취소 = "16"
            case 장중대량 = "51"
            case 장중바스켓 = "52"
            case 장개시전시간외대량 = "62"
            case 장개시전시간외바스켓 = "63"
            case 장개시전금전신탁자사주 = "67"
            case 장개시전자기주식 = "69"
            case 시간외대량 = "72"
            case 시간외자사주신탁 = "77"
            case 시간외대량자기주식 = "79"
            case 바스켓 = "80"
            case 중간가 = "21"
            case 스톱지정가 = "22"
            case 중간가IOC = "23"
            case 중간가FOK = "24"
        }
    }

    /// 주식주문(신용)[v1_국내주식-002]
    /// 국내주식주문(신용) API입니다. ※ 모의투자는 사용 불가합니다.※ POST API의 경우 BODY값의 key값들을 대문자로 작성하셔야 합니다.   (EX. "CANO" : "12345678", "ACNT_PRDT_CD": "01",...)
    struct ordercredit : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.currentManager!.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.currentManager!.ACNT_PRDT_CD()
            /// 상품번호
            /// 종목코드(6자리)
            let PDNO:String
            /// 매도유형
            /// 공란 입력
            let SLL_TYPE:String?
            /// 신용유형
            /// [매도] 22 : 유통대주신규, 24 : 자기대주신규, 25 : 자기융자상환, 27 : 유통융자상환 [매수] 21 : 자기융자신규, 23 : 유통융자신규 , 26 : 유통대주상환, 28 : 자기대주상환
            let CRDT_TYPE:String
            /// 대출일자
            /// [신용매수] 신규 대출로, 오늘날짜(yyyyMMdd)) 입력 [신용매도] 매도할 종목의 대출일자(yyyyMMdd)) 입력
            let LOAN_DT:String
            /// 주문구분
            /// 00@지정가 01@시장가 02@조건부지정가 03@최유리지정가 04@최우선지정가 05@장전 시간외 06@장후 시간외 07@시간외 단일가 65@경매매 08@자기주식 09@자기주식S-Option 10@자기주식금전신탁 11@IOC지정가 (즉시체결,잔량취소) 12@FOK지정가 (즉시체결,전량취소) 13@IOC시장가 (즉시체결,잔량취소) 14@FOK시장가 (즉시체결,전량취소) 15@IOC최유리 (즉시체결,잔량취소) 16@FOK최유리 (즉시체결,전량취소) 51@장중대량 52@장중바스켓 62@장개시전 시간외대량 63@장개시전 시간외바스켓 67@장개시전 금전신탁자사주 69@장개시전 자기주식 72@시간외대량 77@시간외자사주신탁 79@시간외대량자기주식 80@바스켓 21@중간가 22@스톱지정가 23@중간가IOC 24@중간가FOK
            let ORD_DVSN:ORD_DVSN_enum
            /// 주문수량
            let ORD_QTY:String
            /// 주문단가
            /// 1주당 가격 * 장전 시간외, 장후 시간외, 시장가의 경우 1주당 가격을 공란으로 비우지 않음 "0"으로 입력 권고
            let ORD_UNPR:String
            /// 예약주문여부
            /// 정규 증권시장이 열리지 않는 시간 (15:10분 ~ 익일 7:30분) 에 주문을 미리 설정 하여 다음 영업일 또는 설정한 기간 동안 아침 동시 호가에 주문하는 것 Y : 예약주문 N : 신용주문
            let RSVN_ORD_YN:String
            /// 비상주문여부
            let EMGC_ORD_YN:String
            /// 프로그램매매구분
            let PGTR_DVSN:String
            /// 운용사지정주문번호
            let MGCO_APTM_ODNO:String
            /// 대량거래협상상세번호
            let LQTY_TR_NGTN_DTL_NO:String
            /// 대량거래협정번호
            let LQTY_TR_AGMT_NO:String
            /// 대량거래협상자Id
            let LQTY_TR_NGTN_ID:String
            /// LP주문여부
            let LP_ORD_YN:String
            /// 매체주문번호
            let MDIA_ODNO:String
            /// 주문서버구분코드
            let ORD_SVR_DVSN_CD:String
            /// 프로그램호가신고구분코드
            let PGM_NMPR_STMT_DVSN_CD:String
            /// 반대매매선정사유코드
            let CVRG_SLCT_RSON_CD:String
            /// 반대매매순번
            let CVRG_SEQ:String
            /// 거래소ID구분코드
            /// 한국거래소 : KRX 대체거래소 (넥스트레이드) : NXT
            let EXCG_ID_DVSN_CD:String
            /// 조건가격
            /// 스탑지정가호가에서 사용
            let CNDT_PRIC:String
        }
        public struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// single
            let output: Output
        }
        public struct Output : Codable {
            /// 한국거래소전송주문조직번호
            let krx_fwdg_ord_orgno:String
            /// 주문번호
            let odno:String
            /// 주문시간
            let ord_tmd:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/order-credit"
        public var customHeader: [String : String]?
        enum TR_ID : String {
            case 매도 = "TTTC0051U"
            case 매수 = "TTTC0052U"
        }
        init(tr_id:TR_ID, gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // '※ 구TR은 사전고지 없이 막힐 수 있으므로 반드시 신TR로 변경이용 부탁드립니다. [실전투자] 매도 : (구)TTTC0851U → (신)TTTC0051U 매수 : (구)TTTC0852U → (신)TTTC0052U '
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["Content-Type"] = "application/json; charset=UTF-8"
            self.customHeader?["tr_id"] = tr_id.rawValue
        }
        enum ORD_DVSN_enum : String, Codable {
            case 지정가 = "00"
            case 시장가 = "01"
            case 조건부지정가 = "02"
            case 최유리지정가 = "03"
            case 최우선지정가 = "04"
            case 장전시간외 = "05"
            case 장후시간외 = "06"
            case 시간외단일가 = "07"
            case 경매매 = "65"
            case 자기주식 = "08"
            case 자기주식SOption = "09"
            case 자기주식금전신탁 = "10"
            case IOC지정가즉시체결잔량취소 = "11"
            case FOK지정가즉시체결전량취소 = "12"
            case IOC시장가즉시체결잔량취소 = "13"
            case FOK시장가즉시체결전량취소 = "14"
            case IOC최유리즉시체결잔량취소 = "15"
            case FOK최유리즉시체결전량취소 = "16"
            case 장중대량 = "51"
            case 장중바스켓 = "52"
            case 장개시전시간외대량 = "62"
            case 장개시전시간외바스켓 = "63"
            case 장개시전금전신탁자사주 = "67"
            case 장개시전자기주식 = "69"
            case 시간외대량 = "72"
            case 시간외자사주신탁 = "77"
            case 시간외대량자기주식 = "79"
            case 바스켓 = "80"
            case 중간가 = "21"
            case 스톱지정가 = "22"
            case 중간가IOC = "23"
            case 중간가FOK = "24"
        }
    }

    /// 주식주문(정정취소)[v1_국내주식-003]
    /// 주문 건에 대하여 정정 및 취소하는 API입니다. 단, 이미 체결된 건은 정정 및 취소가 불가합니다.※ 정정은 원주문에 대한 주문단가 혹은 주문구분을 변경하는 사항으로, 정정이 가능한 수량은 원주문수량을 초과 할 수 없습니다.※ 주식주문(정정취소) 호출 전에 반드시 주식정정취소가능주문조회 호출을 통해 정정취소가능수량(output > psbl_qty)을 확인하신 후 정정취소주문 내시기 바랍니다.※ POST API의 경우 BODY값의 key값들을 대문자로 작성하셔야 합니다.   (EX. "CANO" : "12345678", "ACNT_PRDT_CD": "01",...)
    public struct orderrvsecncl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 종합계좌번호
            public let CANO:String
            /// 계좌상품코드
            /// 상품유형코드
            public let ACNT_PRDT_CD:String
            /// 한국거래소전송주문조직번호
            public let KRX_FWDG_ORD_ORGNO:String
            /// 원주문번호
            /// 원주문번호
            public let ORGN_ODNO:String
            /// 주문구분
            /// 00@지정가 01@시장가 02@조건부지정가 03@최유리지정가 04@최우선지정가 05@장전 시간외 06@장후 시간외 07@시간외 단일가 65@경매매 08@자기주식 09@자기주식S-Option 10@자기주식금전신탁 11@IOC지정가 (즉시체결,잔량취소) 12@FOK지정가 (즉시체결,전량취소) 13@IOC시장가 (즉시체결,잔량취소) 14@FOK시장가 (즉시체결,전량취소) 15@IOC최유리 (즉시체결,잔량취소) 16@FOK최유리 (즉시체결,전량취소) 51@장중대량 52@장중바스켓 62@장개시전 시간외대량 63@장개시전 시간외바스켓 67@장개시전 금전신탁자사주 69@장개시전 자기주식 72@시간외대량 77@시간외자사주신탁 79@시간외대량자기주식 80@바스켓 21@중간가 22@스톱지정가 23@중간가IOC 24@중간가FOK
            public let ORD_DVSN:ORD_DVSN_enum
            /// 정정취소구분코드
            /// 01@정정 02@취소
            public let RVSE_CNCL_DVSN_CD:RVSE_CNCL_DVSN_CD_enum
            /// 주문수량
            /// 주문수량
            public let ORD_QTY:String
            /// 주문단가
            /// 주문단가
            public let ORD_UNPR:String
            /// 잔량전부주문여부
            /// 'Y@전량 N@일부'
            public let QTY_ALL_ORD_YN:String
            /// 조건가격
            /// 스탑지정가호가에서 사용
            public let CNDT_PRIC:String
            /// 거래소ID구분코드
            /// 한국거래소 : KRX 대체거래소 (넥스트레이드) : NXT
            public let EXCG_ID_DVSN_CD:String
            public init(CANO: String? = nil, ACNT_PRDT_CD: String? = nil, KRX_FWDG_ORD_ORGNO: String, ORGN_ODNO: String, ORD_DVSN: ORD_DVSN_enum, RVSE_CNCL_DVSN_CD: RVSE_CNCL_DVSN_CD_enum, ORD_QTY: String, ORD_UNPR: String, QTY_ALL_ORD_YN: String, CNDT_PRIC: String, EXCG_ID_DVSN_CD: String) {
                self.CANO = CANO ?? KISManager.currentManager!.getCANO()
                self.ACNT_PRDT_CD = ACNT_PRDT_CD ?? KISManager.currentManager!.ACNT_PRDT_CD()
                self.KRX_FWDG_ORD_ORGNO = KRX_FWDG_ORD_ORGNO
                self.ORGN_ODNO = ORGN_ODNO
                self.ORD_DVSN = ORD_DVSN
                self.RVSE_CNCL_DVSN_CD = RVSE_CNCL_DVSN_CD
                self.ORD_QTY = ORD_QTY
                self.ORD_UNPR = ORD_UNPR
                self.QTY_ALL_ORD_YN = QTY_ALL_ORD_YN
                self.CNDT_PRIC = CNDT_PRIC
                self.EXCG_ID_DVSN_CD = EXCG_ID_DVSN_CD
            }
        }
        public struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// single
            let output: Output
        }
        public struct Output : Codable {
            /// 한국거래소전송주문조직번호
            let krx_fwdg_ord_orgno:String
            /// 주문번호
            let odno:String
            /// 주문시각
            let ord_tmd:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/order-rvsecncl"
        public var customHeader: [String : String]?
        public init(tr_id: String = "TTTC0013U", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // ※ 구TR은 사전고지 없이 막힐 수 있으므로 반드시 신TR로 변경이용 부탁드립니다. [실전투자] 정정/취소 (구)TTTC0803U → (신)TTTC0013U
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
            self.customHeader?["tr_id"] = tr_id
        }
        public enum ORD_DVSN_enum : String, Codable {
            case 지정가 = "00"
            case 시장가 = "01"
            case 조건부지정가 = "02"
            case 최유리지정가 = "03"
            case 최우선지정가 = "04"
            case 장전시간외 = "05"
            case 장후시간외 = "06"
            case 시간외단일가 = "07"
            case 경매매 = "65"
            case 자기주식 = "08"
            case 자기주식SOption = "09"
            case 자기주식금전신탁 = "10"
            case IOC지정가즉시체결잔량취소 = "11"
            case FOK지정가즉시체결전량취소 = "12"
            case IOC시장가즉시체결잔량취소 = "13"
            case FOK시장가즉시체결전량취소 = "14"
            case IOC최유리즉시체결잔량취소 = "15"
            case FOK최유리즉시체결전량취소 = "16"
            case 장중대량 = "51"
            case 장중바스켓 = "52"
            case 장개시전시간외대량 = "62"
            case 장개시전시간외바스켓 = "63"
            case 장개시전금전신탁자사주 = "67"
            case 장개시전자기주식 = "69"
            case 시간외대량 = "72"
            case 시간외자사주신탁 = "77"
            case 시간외대량자기주식 = "79"
            case 바스켓 = "80"
            case 중간가 = "21"
            case 스톱지정가 = "22"
            case 중간가IOC = "23"
            case 중간가FOK = "24"
        }
        public enum RVSE_CNCL_DVSN_CD_enum : String, Codable {
            case 정정 = "01"
            case 취소 = "02"
        }
    }

    /// 주식정정취소가능주문조회[v1_국내주식-004]
    /// 주식정정취소가능주문조회 API입니다. 한 번의 호출에 최대 50건까지 확인 가능하며, 이후의 값은 연속조회를 통해 확인하실 수 있습니다.※ 주식주문(정정취소) 호출 전에 반드시 주식정정취소가능주문조회 호출을 통해 정정취소가능수량(output > psbl_qty)을 확인하신 후 정정취소주문 내시기 바랍니다.
    struct inquirepsblrvsecncl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.currentManager!.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.currentManager!.ACNT_PRDT_CD()
            /// 연속조회검색조건100
            /// '공란 : 최초 조회시는 이전 조회 Output CTX_AREA_FK100 값 : 다음페이지 조회시(2번째부터)'
            let CTX_AREA_FK100:String
            /// 연속조회키100
            /// '공란 : 최초 조회시 이전 조회 Output CTX_AREA_NK100 값 : 다음페이지 조회시(2번째부터)'
            let CTX_AREA_NK100:String
            /// 조회구분1
            /// '0 주문 1 종목'
            let INQR_DVSN_1:String
            /// 조회구분2
            /// '0 전체 1 매도 2 매수'
            let INQR_DVSN_2:String
            public init(CANO: String? = nil, ACNT_PRDT_CD: String? = nil, CTX_AREA_FK100: String, CTX_AREA_NK100: String, INQR_DVSN_1: String, INQR_DVSN_2: String) {
                self.CANO = CANO ?? KISManager.currentManager!.getCANO()
                self.ACNT_PRDT_CD = ACNT_PRDT_CD ?? KISManager.currentManager!.ACNT_PRDT_CD()
                self.CTX_AREA_FK100 = CTX_AREA_FK100
                self.CTX_AREA_NK100 = CTX_AREA_NK100
                self.INQR_DVSN_1 = INQR_DVSN_1
                self.INQR_DVSN_2 = INQR_DVSN_2
            }
        }
        public struct Response: Codable {
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
            /// 주문채번지점번호
            /// 주문시 한국투자증권 시스템에서 지정된 영업점코드
            let ord_gno_brno:String
            /// 주문번호
            /// 주문시 한국투자증권 시스템에서 채번된 주문번호
            let odno:String
            /// 원주문번호
            /// 정정/취소주문 인경우 원주문번호
            let orgn_odno:String
            /// 주문구분명
            let ord_dvsn_name:String
            /// 상품번호
            /// 종목번호(뒤 6자리만 해당)
            let pdno:String
            /// 상품명
            /// 종목명
            let prdt_name:String
            /// 정정취소구분명
            /// 정정 또는 취소 여부 표시
            let rvse_cncl_dvsn_name:String
            /// 주문수량
            let ord_qty:String
            /// 주문단가
            /// 1주당 주문가격
            let ord_unpr:String
            /// 주문시각
            /// 주문시각(시분초HHMMSS)
            let ord_tmd:String
            /// 총체결수량
            /// 주문 수량 중 체결된 수량
            let tot_ccld_qty:String
            /// 총체결금액
            /// 주문금액 중 체결금액
            let tot_ccld_amt:String
            /// 가능수량
            /// 정정/취소 주문 가능 수량
            let psbl_qty:String
            /// 매도매수구분코드
            /// 01 : 매도 / 02 : 매수
            let sll_buy_dvsn_cd:String
            /// 주문구분코드
            /// 00 : 지정가 01 : 시장가 02 : 조건부지정가 03 : 최유리지정가 04 : 최우선지정가 05 : 장전 시간외 06 : 장후 시간외 07 : 시간외 단일가 08 : 자기주식 09 : 자기주식S-Option 10 : 자기주식금전신탁 11 : IOC지정가 (즉시체결,잔량취소) 12 : FOK지정가 (즉시체결,전량취소) 13 : IOC시장가 (즉시체결,잔량취소) 14 : FOK시장가 (즉시체결,전량취소) 15 : IOC최유리 (즉시체결,잔량취소) 16 : FOK최유리 (즉시체결,전량취소) 51 : 장중대량
            let ord_dvsn_cd:String
            /// 운용사지정주문번호
            let mgco_aptm_odno:String
            /// 거래소구분코드
            let excg_dvsn_cd:String
            /// 거래소ID구분코드
            let excg_id_dvsn_cd:String
            /// 거래소ID구분명
            let excg_id_dvsn_name:String
            /// 스톱지정가조건가격
            let stpm_cndt_pric:String
            /// 스톱지정가효력발생여부
            let stpm_efct_occr_yn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/inquire-psbl-rvsecncl"
        public var customHeader: [String : String]?
        public init(tr_id: String = "TTTC0084R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // ※ 구TR은 사전고지 없이 막힐 수 있으므로 반드시 신TR로 변경이용 부탁드립니다. [실전투자] (구)TTTC8036R → (신)TTTC0084R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 주식일별주문체결조회[v1_국내주식-005]
    /// 주식일별주문체결조회 API입니다. 실전계좌의 경우, 한 번의 호출에 최대 100건까지 확인 가능하며, 이후의 값은 연속조회를 통해 확인하실 수 있습니다. 모의계좌의 경우, 한 번의 호출에 최대 15건까지 확인 가능하며, 이후의 값은 연속조회를 통해 확인하실 수 있습니다. * 다만, 3개월 이전 체결내역 조회(CTSC9115R) 의 경우, 장중에는 많은 거래량으로 인해 순간적으로 DB가 밀렸거나 응답을 늦게 받거나 하는 등의 이슈가 있을 수 있어① 가급적 장 종료 이후(15:30 이후) 조회하시고 ② 조회기간(INQR_STRT_DT와 INQR_END_DT 사이의 간격)을 보다 짧게 해서 조회하는 것을권유드립니다.
    struct inquiredailyccld : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.currentManager!.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.currentManager!.ACNT_PRDT_CD()
            /// 조회시작일자
            /// YYYYMMDD
            let INQR_STRT_DT:String
            /// 조회종료일자
            /// YYYYMMDD
            let INQR_END_DT:String
            /// 매도매수구분코드
            /// 00 : 전체 / 01 : 매도 / 02 : 매수
            let SLL_BUY_DVSN_CD:String
            /// 상품번호
            /// 종목번호(6자리)
            let PDNO:String
            /// 주문채번지점번호
            /// 주문시 한국투자증권 시스템에서 지정된 영업점코드
            let ORD_GNO_BRNO:String
            /// 주문번호
            /// 주문시 한국투자증권 시스템에서 채번된 주문번호
            let ODNO:String
            /// 체결구분
            /// '00 전체 01 체결 02 미체결'
            let CCLD_DVSN:String
            /// 조회구분
            /// '00 역순 01 정순'
            let INQR_DVSN:String
            /// 조회구분1
            /// '없음: 전체 1: ELW 2: 프리보드'
            let INQR_DVSN_1:String
            /// 조회구분3
            /// '00 전체 01 현금 02 신용 03 담보 04 대주 05 대여 06 자기융자신규/상환 07 유통융자신규/상환'
            let INQR_DVSN_3:String
            /// 거래소ID구분코드
            /// KRX : KRX NXT : NXT
            let EXCG_ID_DVSN_CD:String
            /// 연속조회검색조건100
            /// '공란 : 최초 조회시는 이전 조회 Output CTX_AREA_FK100 값 : 다음페이지 조회시(2번째부터)'
            let CTX_AREA_FK100:String
            /// 연속조회키100
            /// '공란 : 최초 조회시 이전 조회 Output CTX_AREA_NK100 값 : 다음페이지 조회시(2번째부터)'
            let CTX_AREA_NK100:String
        }
        public struct Response: Codable {
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
            /// single
            let output2: Output2
        }
        public struct Output1 : Codable {
            /// 주문일자
            let ord_dt:String
            /// 주문채번지점번호
            let ord_gno_brno:String
            /// 주문번호
            let odno:String
            /// 원주문번호
            let orgn_odno:String
            /// 주문구분명
            let ord_dvsn_name:String
            /// 매도매수구분코드
            let sll_buy_dvsn_cd:String
            /// 매도매수구분코드명
            let sll_buy_dvsn_cd_name:String
            /// 상품번호
            let pdno:String
            /// 상품명
            let prdt_name:String
            /// 주문수량
            let ord_qty:String
            /// 주문단가
            let ord_unpr:String
            /// 주문시각
            let ord_tmd:String
            /// 총체결수량
            let tot_ccld_qty:String
            /// 평균가
            let avg_prvs:String
            /// 취소여부
            let cncl_yn:String
            /// 총체결금액
            let tot_ccld_amt:String
            /// 대출일자
            let loan_dt:String
            /// 주문자사번
            let ordr_empno:String
            /// 주문구분코드
            let ord_dvsn_cd:String
            /// 취소확인수량
            let cnc_cfrm_qty:String
            /// 잔여수량
            let rmn_qty:String
            /// 거부수량
            let rjct_qty:String
            /// 체결조건명
            let ccld_cndt_name:String
            /// 조회IP주소
            let inqr_ip_addr:String
            /// 전산주문표주문접수구분코드
            let cpbc_ordp_ord_rcit_dvsn_cd:String
            /// 전산주문표통보방법구분코드
            let cpbc_ordp_infm_mthd_dvsn_cd:String
            /// 통보시각
            let infm_tmd:String
            /// 연락전화번호
            let ctac_tlno:String
            /// 상품유형코드
            let prdt_type_cd:String
            /// 거래소구분코드
            let excg_dvsn_cd:String
            /// 전산주문표자료구분코드
            let cpbc_ordp_mtrl_dvsn_cd:String
            /// 주문조직번호
            let ord_orgno:String
            /// 예약주문종료일자
            let rsvn_ord_end_dt:String
            /// 거래소ID구분코드
            let excg_id_dvsn_Cd:String
            /// 스톱지정가조건가격
            let stpm_cndt_pric:String
            /// 스톱지정가효력발생상세시각
            let stpm_efct_occr_dtmd:String
            /// 성공 실패 여부
            let rt_cd:String
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            let msg1:String
        }
        public struct Output2 : Codable {
            /// 총주문수량
            let tot_ord_qty:String
            /// 총체결수량
            let tot_ccld_qty:String
            /// 매입평균가격
            let tot_ccld_amt:String
            /// 총체결금액
            let prsm_tlex_smtl:String
            /// 추정제비용합계
            let pchs_avg_pric:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/inquire-daily-ccld"
        public var customHeader: [String : String]?
        enum TR_ID : String {
            case _3개월이내 = "TTTC0081R"
            case _3개월이전 = "CTSC9215R"
        }
        init(tr_id: TR_ID, gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // ※ 구TR은 사전고지 없이 막힐 수 있으므로 반드시 신TR로 변경이용 부탁드립니다. [실전투자] 3개월이내 (구)TTTC8001R → (신)TTTC0081R 3개월이전 (구)CTSC9115R → (신)CTSC9215R'
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
            self.customHeader?["tr_id"] = tr_id.rawValue
        }
    }

    /// 주식잔고조회[v1_국내주식-006]
    /// 주식 잔고조회 API입니다. 실전계좌의 경우, 한 번의 호출에 최대 50건까지 확인 가능하며, 이후의 값은 연속조회를 통해 확인하실 수 있습니다. 모의계좌의 경우, 한 번의 호출에 최대 20건까지 확인 가능하며, 이후의 값은 연속조회를 통해 확인하실 수 있습니다. * 당일 전량매도한 잔고도 보유수량 0으로 보여질 수 있으나, 해당 보유수량 0인 잔고는 최종 D-2일 이후에는 잔고에서 사라집니다.
    public struct inquirebalance : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            public var CANO:String
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            public var ACNT_PRDT_CD:String
            /// 시간외단일가, 거래소여부
            /// N : 기본값, Y : 시간외단일가, X : NXT 정규장 (프리마켓, 메인, 애프터마켓) ※ NXT 선택 시 : NXT 거래종목만 시세 등 정보가 NXT 기준으로 변동됩니다. KRX 종목들은 그대로 유지
            public let AFHR_FLPR_YN:String
            /// 오프라인여부
            /// 공란(Default)
            public let OFL_YN:String
            /// 조회구분
            /// 01 : 대출일별 02 : 종목별
            public let INQR_DVSN:String
            /// 단가구분
            /// 01 : 기본값
            public let UNPR_DVSN:String
            /// 펀드결제분포함여부
            /// N : 포함하지 않음 Y : 포함
            public let FUND_STTL_ICLD_YN:String
            /// 융자금액자동상환여부
            /// N : 기본값
            public let FNCG_AMT_AUTO_RDPT_YN:String
            /// 처리구분
            /// 00 : 전일매매포함 01 : 전일매매미포함
            public let PRCS_DVSN:String
            /// 연속조회검색조건100
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_FK100 값 : 다음페이지 조회시(2번째부터)
            public let CTX_AREA_FK100:String
            /// 연속조회키100
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_NK100 값 : 다음페이지 조회시(2번째부터)
            public let CTX_AREA_NK100:String
            public init(CANO: String? = nil, ACNT_PRDT_CD: String? = nil, AFHR_FLPR_YN: String, OFL_YN: String, INQR_DVSN: String, UNPR_DVSN: String, FUND_STTL_ICLD_YN: String, FNCG_AMT_AUTO_RDPT_YN: String, PRCS_DVSN: String, CTX_AREA_FK100: String, CTX_AREA_NK100: String) {
                self.CANO = CANO ?? KISManager.currentManager!.getCANO()
                self.ACNT_PRDT_CD = ACNT_PRDT_CD ?? KISManager.currentManager!.ACNT_PRDT_CD()
                self.AFHR_FLPR_YN = AFHR_FLPR_YN
                self.OFL_YN = OFL_YN
                self.INQR_DVSN = INQR_DVSN
                self.UNPR_DVSN = UNPR_DVSN
                self.FUND_STTL_ICLD_YN = FUND_STTL_ICLD_YN
                self.FNCG_AMT_AUTO_RDPT_YN = FNCG_AMT_AUTO_RDPT_YN
                self.PRCS_DVSN = PRCS_DVSN
                self.CTX_AREA_FK100 = CTX_AREA_FK100
                self.CTX_AREA_NK100 = CTX_AREA_NK100
            }
        }
        public struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            let rt_cd: String
            /// 응답코드 - 응답코드
            let msg_cd: String
            /// 응답메세지 - 응답메세지
            let msg1: String
            /// 연속조회검색조건100 -
            let ctx_area_fk100: String
            /// 연속조회키100 -
            let ctx_area_nk100: String
            /// 응답상세1 : Object Array
            /// Array
            let output1: [Output1]
            /// 응답상세2 : Object Array
            /// Array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 상품번호
            /// 종목번호(뒷 6자리)
            let pdno:String
            /// 상품명
            /// 종목명
            let prdt_name:String
            /// 매매구분명
            /// 매수매도구분
            let trad_dvsn_name:String
            /// 전일매수수량
            let bfdy_buy_qty:String
            /// 전일매도수량
            let bfdy_sll_qty:String
            /// 금일매수수량
            let thdt_buyqty:String
            /// 금일매도수량
            let thdt_sll_qty:String
            /// 보유수량
            let hldg_qty:String
            /// 주문가능수량
            let ord_psbl_qty:String
            /// 매입평균가격
            /// 매입금액 / 보유수량
            let pchs_avg_pric:String
            /// 매입금액
            let pchs_amt:String
            /// 현재가
            let prpr:String
            /// 평가금액
            let evlu_amt:String
            /// 평가손익금액
            /// 평가금액 - 매입금액
            let evlu_pfls_amt:String
            /// 평가손익율
            let evlu_pfls_rt:String
            /// 평가수익율
            /// 미사용항목(0으로 출력)
            let evlu_erng_rt:String
            /// 대출일자
            /// INQR_DVSN(조회구분)을 01(대출일별)로 설정해야 값이 나옴
            let loan_dt:String
            /// 대출금액
            let loan_amt:String
            /// 대주매각대금
            let stln_slng_chgs:String
            /// 만기일자
            let expd_dt:String
            /// 등락율
            let fltt_rt:String
            /// 전일대비증감
            let bfdy_cprs_icdc:String
            /// 종목증거금율명
            let item_mgna_rt_name:String
            /// 보증금율명
            let grta_rt_name:String
            /// 대용가격
            /// 증권매매의 위탁보증금으로서 현금 대신에 사용되는 유가증권 가격
            let sbst_pric:String
            /// 주식대출단가
            let stck_loan_unpr:String
        }
        public struct Output2 : Codable {
            /// 예수금총금액
            /// 예수금
            let dnca_tot_amt:String
            /// 익일정산금액
            /// D+1 예수금
            let nxdy_excc_amt:String
            /// 가수도정산금액
            /// D+2 예수금
            let prvs_rcdl_excc_amt:String
            /// CMA평가금액
            let cma_evlu_amt:String
            /// 전일매수금액
            let bfdy_buy_amt:String
            /// 금일매수금액
            let thdt_buy_amt:String
            /// 익일자동상환금액
            let nxdy_auto_rdpt_amt:String
            /// 전일매도금액
            let bfdy_sll_amt:String
            /// 금일매도금액
            let thdt_sll_amt:String
            /// D+2자동상환금액
            let d2_auto_rdpt_amt:String
            /// 전일제비용금액
            let bfdy_tlex_amt:String
            /// 금일제비용금액
            let thdt_tlex_amt:String
            /// 총대출금액
            let tot_loan_amt:String
            /// 유가평가금액
            let scts_evlu_amt:String
            /// 총평가금액
            /// 유가증권 평가금액 합계금액 + D+2 예수금
            let tot_evlu_amt:String
            /// 순자산금액
            let nass_amt:String
            /// 융자금자동상환여부
            /// 보유현금에 대한 융자금만 차감여부 신용융자 매수체결 시점에서는 융자비율을 매매대금 100%로 계산 하였다가 수도결제일에 보증금에 해당하는 금액을 고객의 현금으로 충당하여 융자금을 감소시키는 업무
            let fncg_gld_auto_rdpt_yn:String
            /// 매입금액합계금액
            let pchs_amt_smtl_amt:String
            /// 평가금액합계금액
            /// 유가증권 평가금액 합계금액
            let evlu_amt_smtl_amt:String
            /// 평가손익합계금액
            let evlu_pfls_smtl_amt:String
            /// 총대주매각대금
            let tot_stln_slng_chgs:String
            /// 전일총자산평가금액
            let bfdy_tot_asst_evlu_amt:String
            /// 자산증감액
            let asst_icdc_amt:String
            /// 자산증감수익율
            /// 데이터 미제공
            let asst_icdc_erng_rt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/inquire-balance"
        public var customHeader: [String : String]?
        public init(tr_id: String? = nil, gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] TTTC8434R : 주식 잔고 조회 [모의투자] VTTC8434R : 주식 잔고 조회
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
            self.customHeader?["tr_id"] = tr_id ?? KISManager.currentManager!.getValueForCurrentTargetServer(실전서버: "TTTC8434R", 모의투자서버: "VTTC8434R")
        }
    }

    /// 매수가능조회[v1_국내주식-007]
    /// 매수가능 조회 API입니다. 실전계좌/모의계좌의 경우, 한 번의 호출에 최대 1건까지 확인 가능합니다.1) 매수가능금액 확인 . 미수 사용 X: nrcvb_buy_amt(미수없는매수금액) 확인 . 미수 사용 O: max_buy_amt(최대매수금액) 확인2) 매수가능수량 확인 . 특정 종목 전량매수 시 가능수량을 확인하실 경우 ORD_DVSN:00(지정가)는 종목증거금율이 반영되지 않습니다.    따라서 "반드시" ORD_DVSN:01(시장가)로 지정하여 종목증거금율이 반영된 가능수량을 확인하시기 바랍니다.    (다만, 조건부지정가 등 특정 주문구분(ex.IOC)으로 주문 시 가능수량을 확인할 경우 주문 시와 동일한 주문구분(ex.IOC) 입력하여 가능수량 확인) . 미수 사용 X: ORD_DVSN:01(시장가) or 특정 주문구분(ex.IOC)로 지정하여 nrcvb_buy_qty(미수없는매수수량) 확인 . 미수 사용 O: ORD_DVSN:01(시장가) or 특정 주문구분(ex.IOC)로 지정하여 max_buy_qty(최대매수수량) 확인
    struct inquirepsblorder : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.currentManager!.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.currentManager!.ACNT_PRDT_CD()
            /// 상품번호
            /// 종목번호(6자리) * PDNO, ORD_UNPR 공란 입력 시, 매수수량 없이 매수금액만 조회됨
            let PDNO:String
            /// 주문단가
            /// 1주당 가격 * 시장가(ORD_DVSN:01)로 조회 시, 공란으로 입력 * PDNO, ORD_UNPR 공란 입력 시, 매수수량 없이 매수금액만 조회됨
            let ORD_UNPR:String
            /// 주문구분
            /// * 특정 종목 전량매수 시 가능수량을 확인할 경우 00:지정가는 증거금율이 반영되지 않으므로 증거금율이 반영되는 01: 시장가로 조회 * 다만, 조건부지정가 등 특정 주문구분(ex.IOC)으로 주문 시 가능수량을 확인할 경우 주문 시와 동일한 주문구분(ex.IOC) 입력하여 가능수량 확인 * 종목별 매수가능수량 조회 없이 매수금액만 조회하고자 할 경우 임의값(00) 입력 00 : 지정가 01 : 시장가 02 : 조건부지정가 03 : 최유리지정가 04 : 최우선지정가 05 : 장전 시간외 06 : 장후 시간외 07 : 시간외 단일가 08 : 자기주식 09 : 자기주식S-Option 10 : 자기주식금전신탁 11 : IOC지정가 (즉시체결,잔량취소) 12 : FOK지정가 (즉시체결,전량취소) 13 : IOC시장가 (즉시체결,잔량취소) 14 : FOK시장가 (즉시체결,전량취소) 15 : IOC최유리 (즉시체결,잔량취소) 16 : FOK최유리 (즉시체결,전량취소) 51 : 장중대량 52 : 장중바스켓 62 : 장개시전 시간외대량 63 : 장개시전 시간외바스켓 67 : 장개시전 금전신탁자사주 69 : 장개시전 자기주식 72 : 시간외대량 77 : 시간외자사주신탁 79 : 시간외대량자기주식 80 : 바스켓
            let ORD_DVSN:String
            /// CMA평가금액포함여부
            /// Y : 포함 N : 포함하지 않음
            let CMA_EVLU_AMT_ICLD_YN:String
            /// 해외포함여부
            /// Y : 포함 N : 포함하지 않음
            let OVRS_ICLD_YN:String
        }
        public struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            let rt_cd: String
            /// 응답코드 - 응답코드
            let msg_cd: String
            /// 응답메세지 - 응답메세지
            let msg1: String
            /// 응답상세 : Object
            /// Single
            let output: Output
        }
        public struct Output : Codable {
            /// 주문가능현금
            /// 예수금으로 계산된 주문가능금액
            let ord_psbl_cash:String
            /// 주문가능대용
            let ord_psbl_sbst:String
            /// 재사용가능금액
            /// 전일/금일 매도대금으로 계산된 주문가능금액
            let ruse_psbl_amt:String
            /// 펀드환매대금
            let fund_rpch_chgs:String
            /// 가능수량계산단가
            let psbl_qty_calc_unpr:String
            /// 미수없는매수금액
            /// 미수를 사용하지 않으실 경우 nrcvb_buy_amt(미수없는매수금액)을 확인
            let nrcvb_buy_amt:String
            /// 미수없는매수수량
            /// 미수를 사용하지 않으실 경우 nrcvb_buy_qty(미수없는매수수량)을 확인 * 특정 종목 전량매수 시 가능수량을 확인하실 경우 조회 시 ORD_DVSN:01(시장가)로 지정 필수 * 다만, 조건부지정가 등 특정 주문구분(ex.IOC)으로 주문 시 가능수량을 확인할 경우 주문 시와 동일한 주문구분(ex.IOC) 입력
            let nrcvb_buy_qty:String
            /// 최대매수금액
            /// 미수를 사용하시는 경우 max_buy_amt(최대매수금액)를 확인
            let max_buy_amt:String
            /// 최대매수수량
            /// 미수를 사용하시는 경우 max_buy_qty(최대매수수량)를 확인 * 특정 종목 전량매수 시 가능수량을 확인하실 경우 조회 시 ORD_DVSN:01(시장가)로 지정 필수 * 다만, 조건부지정가 등 특정 주문구분(ex.IOC)으로 주문 시 가능수량을 확인할 경우 주문 시와 동일한 주문구분(ex.IOC) 입력
            let max_buy_qty:String
            /// CMA평가금액
            let cma_evlu_amt:String
            /// 해외재사용금액원화
            let ovrs_re_use_amt_wcrc:String
            /// 주문가능외화금액원화
            let ord_psbl_frcr_amt_wcrc:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/inquire-psbl-order"
        public var customHeader: [String : String]?
        public init(tr_id: String? = nil, gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] TTTC8908R : 매수 가능 조회 [모의투자] VTTC8908R : 매수 가능 조회
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
            self.customHeader?["tr_id"] = tr_id ?? KISManager.currentManager!.getValueForCurrentTargetServer(실전서버: "TTTC8908R", 모의투자서버: "VTTC8908R")
        }
    }

    /// 주식예약주문[v1_국내주식-017]
    /// 국내주식 예약주문 매수/매도 API 입니다.※ POST API의 경우 BODY값의 key값들을 대문자로 작성하셔야 합니다.   (EX. "CANO" : "12345678", "ACNT_PRDT_CD": "01",...)※ 유의사항 1. 예약주문 가능시간 : 15시 40분 ~ 다음 영업일 7시 30분     (단, 서버 초기화 작업 시 예약주문 불가 : 23시 40분 ~ 00시 10분)    ※ 예약주문 처리내역은 통보되지 않으므로 주문처리일 장 시작전에 반드시 주문처리 결과를 확인하시기 바랍니다. 2. 예약주문 안내   - 예약종료일 미입력 시 일반예약주문으로 최초 도래하는 영업일에 주문 전송됩니다.   - 예약종료일 입력 시 기간예약주문으로 최초 예약주문수량 중 미체결 된 수량에 대해 예약종료일까지 매 영업일 주문이      실행됩니다. (예약종료일은 익영업일부터 달력일 기준으로 공휴일 포함하여 최대 30일이 되는 일자까지 입력가능)   - 예약주문 접수 처리순서는 일반/기간예약주문 중 신청일자가 빠른 주문이 우선합니다.      단, 기간예약주문 자동배치시간(약 15시35분 ~ 15시55분)사이 접수되는 주문의 경우 당일에 한해 순서와 상관없이      처리될 수 있습니다.   - 기간예약주문 자동배치시간(약 15시35분 ~ 15시55분)에는 예약주문 조회가 제한 될 수 있습니다.   - 기간예약주문은 계좌 당 주문건수 최대 1,000건으로 제한됩니다.3. 예약주문 접수내역 중 아래의 사유 등으로 인해 주문이 거부될 수 있사오니, 주문처리일 장 시작전에 반드시    주문처리 결과를 확인하시기 바랍니다.    * 주문처리일 기준 : 매수가능금액 부족, 매도가능수량 부족, 주문수량/호가단위 오류, 대주 호가제한,                               신용/대주가능종목 변경, 상/하한폭 변경, 시가형성 종목(신규상장 등)의 시장가, 거래서비스 미신청 등 4. 익일 예상 상/하한가는 조회시점의 현재가로 계산되며 익일의 유/무상증자, 배당, 감자, 합병, 액면변경 등에 의해    변동될 수 있으며 이로 인해 상/하한가를 벗어나 주문이 거부되는 경우가 발생할 수 있사오니, 주문처리일 장 시작전에    반드시 주문처리결과를 확인하시기 바랍니다. 5. 정리매매종목, ELW, 신주인수권증권, 신주인수권증서 등은 가격제한폭(상/하한가) 적용 제외됩니다. 6. 영업일 장 시작 후 [기간예약주문] 내역 취소는 해당시점 이후의 예약주문이 취소되는 것으로,     일반주문으로 이미 전환된 주문에는 영향을 미치지 않습니다. 반드시 장 시작전 주문처리결과를 확인하시기 바랍니다.
    public struct orderresv : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            public var CANO:String
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            public var ACNT_PRDT_CD:String
            /// 종목코드(6자리)
            public let PDNO:String
            /// 주문수량
            /// 주문주식수
            public let ORD_QTY:String
            /// 주문단가
            /// 1주당 가격 * 장전 시간외, 시장가의 경우 1주당 가격을 공란으로 비우지 않음 "0"으로 입력 권고
            public let ORD_UNPR:String
            /// 매도매수구분코드
            /// 01 : 매도 02 : 매수
            public let SLL_BUY_DVSN_CD:String
            /// 주문구분코드
            /// 00 : 지정가 01 : 시장가 02 : 조건부지정가 05 : 장전 시간외
            public let ORD_DVSN_CD:String
            /// 주문대상잔고구분코드
            /// [매도매수구분코드 01:매도/02:매수시 사용] 10 : 현금 [매도매수구분코드 01:매도시 사용] 12 : 주식담보대출 14 : 대여상환 21 : 자기융자신규 22 : 유통대주신규 23 : 유통융자신규 24 : 자기대주신규 25 : 자기융자상환 26 : 유통대주상환 27 : 유통융자상환 28 : 자기대주상환
            public let ORD_OBJT_CBLC_DVSN_CD:String
            /// 대출일자
            public let LOAN_DT:String?
            /// 예약주문종료일자
            /// (YYYYMMDD) 현재 일자보다 이후로 설정해야 함 * RSVN_ORD_END_DT(예약주문종료일자)를 안 넣으면 다음날 주문처리되고 예약주문은 종료됨 * RSVN_ORD_END_DT(예약주문종료일자)는 익영업일부터 달력일 기준으로 공휴일 포함하여 최대 30일이 되는 일자까지 입력 가능
            public let RSVN_ORD_END_DT:String?
            /// 대여일자
            public let LDNG_DT:String?
            public init(CANO: String? = nil, ACNT_PRDT_CD: String? = nil, PDNO: String, ORD_QTY: String, ORD_UNPR: String, SLL_BUY_DVSN_CD: String, ORD_DVSN_CD: String, ORD_OBJT_CBLC_DVSN_CD: String, LOAN_DT: String?, RSVN_ORD_END_DT: String?, LDNG_DT: String?) {
                self.CANO = CANO ?? KISManager.currentManager!.getCANO()
                self.ACNT_PRDT_CD = ACNT_PRDT_CD ?? KISManager.currentManager!.ACNT_PRDT_CD()
                self.PDNO = PDNO
                self.ORD_QTY = ORD_QTY
                self.ORD_UNPR = ORD_UNPR
                self.SLL_BUY_DVSN_CD = SLL_BUY_DVSN_CD
                self.ORD_DVSN_CD = ORD_DVSN_CD
                self.ORD_OBJT_CBLC_DVSN_CD = ORD_OBJT_CBLC_DVSN_CD
                self.LOAN_DT = LOAN_DT
                self.RSVN_ORD_END_DT = RSVN_ORD_END_DT
                self.LDNG_DT = LDNG_DT
            }
        }
        public struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            public let rt_cd: String
            /// 응답코드 -
            public let msg_cd: String
            /// 응답메세지 -
            public let msg1: String
            /// 응답상세 : Object Array
            /// Array
            public let output: Output?
        }
        public struct Output : Codable {
            /// 예약주문 순번
            public let RSVN_ORD_SEQ:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/order-resv"
        public var customHeader: [String : String]?
        public init(tr_id: String = "CTSC0008U", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] CTSC0008U : 국내예약매수입력/주문예약매도입력
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // ※ 필수 아님 (선택사항) [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 주식예약주문정정취소[v1_국내주식-018,019]
    /// 국내주식 예약주문 정정/취소 API 입니다.*  정정주문은 취소주문에 비해 필수 입력값이 추가 됩니다.    하단의 입력값을 참조하시기 바랍니다.※ POST API의 경우 BODY값의 key값들을 대문자로 작성하셔야 합니다.   (EX. "CANO" : "12345678", "ACNT_PRDT_CD": "01",...)
    struct orderresvrvsecncl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// [정정/취소] 계좌번호 체계(8-2)의 앞 8자리
            let CANO:String
            /// 계좌상품코드
            /// [정정/취소] 계좌번호 체계(8-2)의 뒤 2자리
            let ACNT_PRDT_CD:String
            /// 종목코드(6자리)
            /// [정정]
            let PDNO:String
            /// 주문수량
            /// [정정] 주문주식수
            let ORD_QTY:String
            /// 주문단가
            /// [정정] 1주당 가격 * 장전 시간외, 시장가의 경우 1주당 가격을 공란으로 비우지 않음 "0"으로 입력 권고
            let ORD_UNPR:String
            /// 매도매수구분코드
            /// [정정] 01 : 매도 02 : 매수
            let SLL_BUY_DVSN_CD:String
            /// 주문구분코드
            /// [정정] 00 : 지정가 01 : 시장가 02 : 조건부지정가 05 : 장전 시간외
            let ORD_DVSN_CD:String
            /// 주문대상잔고구분코드
            /// [정정] 10 : 현금 12 : 주식담보대출 14 : 대여상환 21 : 자기융자신규 22 : 유통대주신규 23 : 유통융자신규 24 : 자기대주신규 25 : 자기융자상환 26 : 유통대주상환 27 : 유통융자상환 28 : 자기대주상환
            let ORD_OBJT_CBLC_DVSN_CD:String
            /// 대출일자
            /// [정정]
            let LOAN_DT:String?
            /// 예약주문종료일자
            /// [정정]
            let RSVN_ORD_END_DT:String?
            /// 연락전화번호
            /// [정정]
            let CTAL_TLNO:String?
            /// 예약주문순번
            /// [정정/취소]
            let RSVN_ORD_SEQ:String
            /// 예약주문조직번호
            /// [정정/취소]
            let RSVN_ORD_ORGNO:String?
            /// 예약주문주문일자
            /// [정정/취소]
            let RSVN_ORD_ORD_DT:String?
        }
        public struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg: String
            /// 응답상세 : Array
            let output: [Output]
        }
        public struct Output : Codable {
            /// 정상처리여부
            let nrml_prcs_yn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/order-resv-rvsecncl"
        public var customHeader: [String : String]?
        init(tr_id: String = KISManager.currentManager!.getValueForCurrentTargetServer(실전서버: "CTSC0009U", 모의투자서버: "CTSC0013U"), gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] CTSC0009U : 국내주식예약취소주문 CTSC0013U : 국내주식예약정정주문 * 모의투자 사용 불가
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 주식예약주문조회[v1_국내주식-020]
    /// 국내예약주문 처리내역 조회 API 입니다.실전계좌/모의계좌의 경우, 한 번의 호출에 최대 20건까지 확인 가능하며, 이후의 값은 연속조회를 통해 확인하실 수 있습니다.
    public struct orderresvccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 예약주문시작일자
            let RSVN_ORD_ORD_DT:String
            /// 예약주문종료일자
            let RSVN_ORD_END_DT:String
            /// 예약주문순번
            let RSVN_ORD_SEQ:String
            /// 단말매체종류코드
            /// "00" 입력
            let TMNL_MDIA_KIND_CD:String
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String? = nil
            /// 처리구분코드
            /// 0: 전체 1: 처리내역 2: 미처리내역
            let PRCS_DVSN_CD:String
            /// 취소여부
            /// "Y" 유효한 주문만 조회
            let CNCL_YN:String
            /// 상품번호
            /// 종목코드(6자리) (공백 입력 시 전체 조회)
            let PDNO:String
            /// 매도매수구분코드
            let SLL_BUY_DVSN_CD:String
            /// 연속조회검색조건200
            /// 다음 페이지 조회시 사용
            let CTX_AREA_FK200:String
            /// 연속조회키200
            /// 다음 페이지 조회시 사용
            let CTX_AREA_NK200:String
            public init(RSVN_ORD_ORD_DT: String? = nil, RSVN_ORD_END_DT: String? = nil, RSVN_ORD_SEQ: String, TMNL_MDIA_KIND_CD: String, CANO: String? = nil, ACNT_PRDT_CD: String? = nil, PRCS_DVSN_CD: String, CNCL_YN: String, PDNO: String, SLL_BUY_DVSN_CD: String, CTX_AREA_FK200: String, CTX_AREA_NK200: String) {
                self.RSVN_ORD_ORD_DT = RSVN_ORD_ORD_DT ?? Date().add(.day(-30)).toString(format:"yyyyMMdd")
                self.RSVN_ORD_END_DT = RSVN_ORD_END_DT ?? Date().toString(format:"yyyyMMdd")
                self.RSVN_ORD_SEQ = RSVN_ORD_SEQ
                self.TMNL_MDIA_KIND_CD = TMNL_MDIA_KIND_CD
                self.CANO = CANO ?? KISManager.currentManager!.getCANO()
                self.ACNT_PRDT_CD = ACNT_PRDT_CD ?? KISManager.currentManager!.ACNT_PRDT_CD()
                self.PRCS_DVSN_CD = PRCS_DVSN_CD
                self.CNCL_YN = CNCL_YN
                self.PDNO = PDNO
                self.SLL_BUY_DVSN_CD = SLL_BUY_DVSN_CD
                self.CTX_AREA_FK200 = CTX_AREA_FK200
                self.CTX_AREA_NK200 = CTX_AREA_NK200
            }
        }
        public struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            public let rt_cd: String
            /// 응답코드 -
            public let msg_cd: String
            /// 응답메세지 -
            public let msg1: String
            /// 응답상세 : Array
            public let output: [Output]
        }
        public struct Output : Codable {
            /// 예약주문 순번
            public let RSVN_ORD_SEQ:String?
            /// 예약주문주문일자
            public let rsvn_ord_ord_dt:String?
            /// 예약주문접수일자
            public let rsvn_ord_rcit_dt:String?
            /// 상품번호
            public let pdno:String?
            /// 주문구분코드
            public let ord_dvsn_cd:String?
            /// 주문예약수량
            public let ord_rsvn_qty:String?
            /// 총체결수량
            public let tot_ccld_qty:String?
            /// 취소주문일자
            public let cncl_ord_dt:String?
            /// 주문시각
            public let ord_tmd:String?
            /// 연락전화번호
            public let ctac_tlno:String?
            /// 거부사유2
            public let rjct_rson2:String?
            /// 주문번호
            public let odno:String?
            /// 예약주문접수시각
            public let rsvn_ord_rcit_tmd:String?
            /// 한글종목단축명
            public let kor_item_shtn_name:String?
            /// 매도매수구분코드
            public let SLL_BUY_DSVN_CD:String?
            /// 주문예약단가
            public let ord_rsvn_unpr:String?
            /// 총체결금액
            public let tot_ccld_amt:String?
            /// 대출일자
            public let loan_dt:String?
            /// 취소접수시각
            public let cncl_rcit_tmd:String?
            /// 처리결과
            public let prcs_rslt:String?
            /// 주문구분명
            public let ord_dvsn_name:String?
            /// 단말매체종류코드
            public let tmnl_mdia_kind_cd:String?
            /// 예약종료일자
            public let rsvn_end_dt:String?
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/order-resv-ccnl"
        public var customHeader: [String : String]?
        public init(tr_id: String = "CTSC0004R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] CTSC0004R : 국내주식예약주문조회 * 모의투자 사용 불가
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 퇴직연금 체결기준잔고[v1_국내주식-032]
    /// ​※ 55번 계좌(DC가입자계좌)의 경우 해당 API 이용이 불가합니다.KIS Developers API의 경우 HTS ID에 반드시 연결되어있어야만 API 신청 및 앱정보 발급이 가능한 서비스로 개발되어서 실물계좌가 아닌 55번 계좌는 API 이용이 불가능한 점 양해 부탁드립니다.
    struct inquirepresentbalance : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            let CANO:String
            /// 계좌상품코드
            /// 29
            let ACNT_PRDT_CD:String
            /// 사용자구분코드
            /// 00
            let USER_DVSN_CD:String
            /// 연속조회검색조건100
            let CTX_AREA_FK100:String
            /// 연속조회키100
            let CTX_AREA_NK100:String
        }
        public struct Response: Codable {
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
            /// 잔고구분
            let cblc_dvsn:String
            /// 잔고구분명
            let cblc_dvsn_name:String
            /// 상품번호
            let pdno:String
            /// 상품명
            let prdt_name:String
            /// 보유수량
            let hldg_qty:String
            /// 매도가능수량
            let slpsb_qty:String
            /// 매입평균가격
            let pchs_avg_pric:String
            /// 평가손익금액
            let evlu_pfls_amt:String
            /// 평가손익율
            let evlu_pfls_rt:String
            /// 현재가
            let prpr:String
            /// 평가금액
            let evlu_amt:String
            /// 매입금액
            let pchs_amt:String
            /// 잔고비중
            let cblc_weit:String
        }
        public struct Output2 : Codable {
            /// 매입금액합계금액
            let pchs_amt_smtl_amt:String
            /// 평가금액합계금액
            let evlu_amt_smtl_amt:String
            /// 평가손익합계금액
            let evlu_pfls_smtl_amt:String
            /// 매매손익합계
            let trad_pfls_smtl:String
            /// 당일총손익금액
            let thdt_tot_pfls_amt:String
            /// 수익률
            let pftrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/pension/inquire-present-balance"
        public var customHeader: [String : String]?
        init(tr_id: String = "TTTC2202R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // TTTC2202R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }
    /// 주식잔고조회_실현손익[v1_국내주식-041]
    /// 주식잔고조회_실현손익 API입니다.한국투자 HTS(eFriend Plus) [0800] 국내 체결기준잔고 화면을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.(참고: 포럼 - 공지사항 - 신규 API 추가 안내(주식잔고조회_실현손익 외 1건))
    struct inquirebalancerlzpl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.currentManager!.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.currentManager!.ACNT_PRDT_CD()
            /// 시간외단일가여부
            /// 'N : 기본값 Y : 시간외단일가'
            let AFHR_FLPR_YN:String
            /// 오프라인여부
            /// 공란
            let OFL_YN:String
            /// 조회구분
            /// 00 : 전체
            let INQR_DVSN:String
            /// 단가구분
            /// 01 : 기본값
            let UNPR_DVSN:String
            /// 펀드결제포함여부
            /// N : 포함하지 않음 Y : 포함
            let FUND_STTL_ICLD_YN:String
            /// 융자금액자동상환여부
            /// N : 기본값
            let FNCG_AMT_AUTO_RDPT_YN:String
            /// PRCS_DVSN
            /// 00 : 전일매매포함 01 : 전일매매미포함
            let PRCS_DVSN:String
            /// 비용포함여부
            let COST_ICLD_YN:String
            /// 연속조회검색조건100
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_FK100 값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_FK100:String
            /// 연속조회키100
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_NK100 값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_NK100:String
        }
        public struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// Array
            let Output1: [Output1]
            /// 응답상세2 : Object Array
            /// Array
            let Output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 상품번호
            /// 종목번호(뒷 6자리)
            let pdno:String
            /// 상품명
            /// 종목명
            let prdt_name:String
            /// 매매구분명
            /// 매수매도구분
            let trad_dvsn_name:String
            /// 전일매수수량
            let bfdy_buy_qty:String
            /// 전일매도수량
            let bfdy_sll_qty:String
            /// 금일매수수량
            let thdt_buyqty:String
            /// 금일매도수량
            let thdt_sll_qty:String
            /// 보유수량
            let hldg_qty:String
            /// 주문가능수량
            let ord_psbl_qty:String
            /// 매입평균가격
            /// 매입금액 / 보유수량
            let pchs_avg_pric:String
            /// 매입금액
            let pchs_amt:String
            /// 현재가
            let prpr:String
            /// 평가금액
            let evlu_amt:String
            /// 평가손익금액
            /// 평가금액 - 매입금액
            let evlu_pfls_amt:String
            /// 평가손익율
            let evlu_pfls_rt:String
            /// 평가수익율
            let evlu_erng_rt:String
            /// 대출일자
            let loan_dt:String
            /// 대출금액
            let loan_amt:String
            /// 대주매각대금
            /// 신용 거래에서, 고객이 증권 회사로부터 대부받은 주식의 매각 대금
            let stln_slng_chgs:String
            /// 만기일자
            let expd_dt:String
            /// 주식대출단가
            let stck_loan_unpr:String
            /// 전일대비증감
            let bfdy_cprs_icdc:String
            /// 등락율
            let fltt_rt:String
        }
        public struct Output2 : Codable {
            /// 예수금총금액
            let dnca_tot_amt:String
            /// 익일정산금액
            let nxdy_excc_amt:String
            /// 가수도정산금액
            let prvs_rcdl_excc_amt:String
            /// CMA평가금액
            let cma_evlu_amt:String
            /// 전일매수금액
            let bfdy_buy_amt:String
            /// 금일매수금액
            let thdt_buy_amt:String
            /// 익일자동상환금액
            let nxdy_auto_rdpt_amt:String
            /// 전일매도금액
            let bfdy_sll_amt:String
            /// 금일매도금액
            let thdt_sll_amt:String
            /// D+2자동상환금액
            let d2_auto_rdpt_amt:String
            /// 전일제비용금액
            let bfdy_tlex_amt:String
            /// 금일제비용금액
            let thdt_tlex_amt:String
            /// 총대출금액
            let tot_loan_amt:String
            /// 유가평가금액
            let scts_evlu_amt:String
            /// 총평가금액
            let tot_evlu_amt:String
            /// 순자산금액
            let nass_amt:String
            /// 융자금자동상환여부
            let fncg_gld_auto_rdpt_yn:String
            /// 매입금액합계금액
            let pchs_amt_smtl_amt:String
            /// 평가금액합계금액
            let evlu_amt_smtl_amt:String
            /// 평가손익합계금액
            let evlu_pfls_smtl_amt:String
            /// 총대주매각대금
            let tot_stln_slng_chgs:String
            /// 전일총자산평가금액
            let bfdy_tot_asst_evlu_amt:String
            /// 자산증감액
            let asst_icdc_amt:String
            /// 자산증감수익율
            let asst_icdc_erng_rt:String
            /// 실현손익
            let rlzt_pfls:String
            /// 실현수익율
            let rlzt_erng_rt:String
            /// 실평가손익
            let real_evlu_pfls:String
            /// 실평가손익수익율
            let real_evlu_pfls_erng_rt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/inquire-balance-rlz-pl"
        public var customHeader: [String : String]?
        init(tr_id: String = "TTTC8494R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // TTTC8494R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 신용매수가능조회[v1_국내주식-042]
    struct inquirecreditpsamount : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.currentManager!.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.currentManager!.ACNT_PRDT_CD()
            /// 상품번호
            /// 종목코드(6자리)
            let PDNO:String
            /// 주문단가
            /// 1주당 가격 * 장전 시간외, 장후 시간외, 시장가의 경우 1주당 가격을 공란으로 비우지 않음 "0"으로 입력 권고
            let ORD_UNPR:String
            /// 주문구분
            /// 00 : 지정가 01 : 시장가 02 : 조건부지정가 03 : 최유리지정가 04 : 최우선지정가 05 : 장전 시간외 06 : 장후 시간외 07 : 시간외 단일가 등
            let ORD_DVSN:String
            /// 신용유형
            /// 21 : 자기융자신규 23 : 유통융자신규 26 : 유통대주상환 28 : 자기대주상환 25 : 자기융자상환 27 : 유통융자상환 22 : 유통대주신규 24 : 자기대주신규
            let CRDT_TYPE:String
            /// CMA평가금액포함여부
            /// Y/N
            let CMA_EVLU_AMT_ICLD_YN:String
            /// 해외포함여부
            /// Y/N
            let OVRS_ICLD_YN:String
        }
        public struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            let rt_cd: String
            /// 응답코드 - 응답코드
            let msg_cd: String
            /// 응답메세지 - 응답메시지
            let msg1: String
            /// 응답상세 : Object
            let Output1: Output1
        }
        public struct Output1 : Codable {
            /// 주문가능현금
            let ord_psbl_cash:String
            /// 주문가능대용
            let ord_psbl_sbst:String
            /// 재사용가능금액
            let ruse_psbl_amt:String
            /// 펀드환매대금
            let fund_rpch_chgs:String
            /// 가능수량계산단가
            let psbl_qty_calc_unpr:String
            /// 미수없는매수금액
            let nrcvb_buy_amt:String
            /// 미수없는매수수량
            let nrcvb_buy_qty:String
            /// 최대매수금액
            let max_buy_amt:String
            /// 최대매수수량
            let max_buy_qty:String
            /// CMA평가금액
            let cma_evlu_amt:String
            /// 해외재사용금액원화
            let ovrs_re_use_amt_wcrc:String
            /// 주문가능외화금액원화
            let ord_psbl_frcr_amt_wcrc:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/inquire-credit-psamount"
        public var customHeader: [String : String]?
        init(tr_id: String = "TTTC8909R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // TTTC8909R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // ※ 입력 불필요
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 투자계좌자산현황조회[v1_국내주식-048]
    /// 투자계좌자산현황조회 API입니다.output1은 한국투자 HTS(eFriend Plus) > [0891] 계좌 자산비중(결제기준) 화면 아래 테이블의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct inquireaccountbalance : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.currentManager!.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.currentManager!.ACNT_PRDT_CD()
            /// 조회구분1
            /// 공백입력
            let INQR_DVSN_1:String
            /// 기준가이전일자적용여부
            /// 공백입력
            let BSPR_BF_DT_APLY_YN:String
        }
        public struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// Array [아래 순서대로 출력 : 19항목] 1: 주식 2: 펀드/MMW 3: 채권 4: ELS/DLS 5: WRAP 6: 신탁/퇴직연금/외화신탁 7: RP/발행어음 8: 해외주식 9: 해외채권 10: 금현물 11: CD/CP 12: 단기사채 13: 타사상품 14: 외화단기사채 15: 외화 ELS/DLS 16: 외화 17: 예수금+CMA 18: 청약자예수금 19: <합계> [21번 계좌일 경우 : 16항목] 1: 수익증권 2: 채권 3: ELS/DLS 4: wrap 5: 신탁 6: rp 7: 외화rp 8: 해외채권 9: CD/CP 10: 전자단기사채 11: 외화전자단기사채 12: 외화ELS/DLS 13: 외화평가금액 14: 예수금+cma 15: 청약자예수금 16: 합계
            let Output1: [Output1]
            /// 응답상세2 : Object
            let Output2: Output2
        }
        public struct Output1 : Codable {
            /// 매입금액
            let pchs_amt:String
            /// 평가금액
            let evlu_amt:String
            /// 평가손익금액
            let evlu_pfls_amt:String
            /// 신용대출금액
            let crdt_lnd_amt:String
            /// 실제순자산금액
            let real_nass_amt:String
            /// 전체비중율
            let whol_weit_rt:String
        }
        public struct Output2 : Codable {
            /// 매입금액합계
            /// 유가매입금액
            let pchs_amt_smtl:String
            /// 순자산총금액
            let nass_tot_amt:String
            /// 대출금액합계
            let loan_amt_smtl:String
            /// 평가손익금액합계
            /// 평가손익금액
            let evlu_pfls_amt_smtl:String
            /// 평가금액합계
            /// 유가평가금액
            let evlu_amt_smtl:String
            /// 총자산금액
            /// 총 자산금액
            let tot_asst_amt:String
            /// 총대출금액총융자대출금액
            let tot_lnda_tot_ulst_lnda:String
            /// CMA자동대출금액
            let cma_auto_loan_amt:String
            /// 총담보대출금액
            let tot_mgln_amt:String
            /// 대주평가금액
            let stln_evlu_amt:String
            /// 신용융자금액
            let crdt_fncg_amt:String
            /// OCL_APL대출금액
            let ocl_apl_loan_amt:String
            /// 질권설정금액
            let pldg_stup_amt:String
            /// 외화평가총액
            let frcr_evlu_tota:String
            /// 총예수금액
            let tot_dncl_amt:String
            /// CMA평가금액
            let cma_evlu_amt:String
            /// 예수금액
            let dncl_amt:String
            /// 총대용금액
            let tot_sbst_amt:String
            /// 당일미수금액
            let thdt_rcvb_amt:String
            /// 해외주식평가금액1
            let ovrs_stck_evlu_amt1:String
            /// 해외채권평가금액
            let ovrs_bond_evlu_amt:String
            /// MMFCMA담보대출금액
            let mmf_cma_mgge_loan_amt:String
            /// 청약예수금액
            let sbsc_dncl_amt:String
            /// 공모주청약자금대출사용금액
            let pbst_sbsc_fnds_loan_use_amt:String
            /// 기업신용공여대출금액
            let etpr_crdt_grnt_loan_amt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/inquire-account-balance"
        public var customHeader: [String : String]?
        init(tr_id: String = "CTRP6548R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // CTRP6548R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // ※ 입력 불필요
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 기간별매매손익현황조회[v1_국내주식-060]
    /// 기간별매매손익현황조회 API입니다.한국투자 HTS(eFriend Plus) > [0856] 기간별 매매손익 화면 에서 "종목별" 클릭 시의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct inquireperiodtradeprofit : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            let CANO:String
            /// 정렬구분
            /// 00: 최근 순, 01: 과거 순, 02: 최근 순
            let SORT_DVSN:String
            /// 계좌상품코드
            let ACNT_PRDT_CD:String
            /// 상품번호
            /// ""공란입력 시, 전체
            let PDNO:String
            /// 조회시작일자
            let INQR_STRT_DT:String
            /// 조회종료일자
            let INQR_END_DT:String
            /// 연속조회키100
            let CTX_AREA_NK100:String
            /// 잔고구분
            /// 00: 전체
            let CBLC_DVSN:String
            /// 연속조회검색조건100
            let CTX_AREA_FK100:String
        }
        public struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 연속조회키100 -
            let ctx_area_nk100: String
            /// 연속조회검색조건100 -
            let ctx_area_fk100: String
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
            /// 응답상세2 : Object
            let output2: Output2
        }
        public struct Output1 : Codable {
            /// 매매일자
            let trad_dt:String
            /// 상품번호
            /// 종목번호(뒤 6자리만 해당)
            let pdno:String
            /// 상품명
            let prdt_name:String
            /// 매매구분명
            let trad_dvsn_name:String
            /// 대출일자
            let loan_dt:String
            /// 보유수량
            let hldg_qty:String
            /// 매입단가
            let pchs_unpr:String
            /// 매수수량
            let buy_qty:String
            /// 매수금액
            let buy_amt:String
            /// 매도가격
            let sll_pric:String
            /// 매도수량
            let sll_qty:String
            /// 매도금액
            let sll_amt:String
            /// 실현손익
            let rlzt_pfls:String
            /// 손익률
            let pfls_rt:String
            /// 수수료
            let fee:String
            /// 제세금
            let tl_tax:String
            /// 대출이자
            let loan_int:String
        }
        public struct Output2 : Codable {
            /// 매도수량합계
            let sll_qty_smtl:String
            /// 매도거래금액합계
            let sll_tr_amt_smtl:String
            /// 매도수수료합계
            let sll_fee_smtl:String
            /// 매도제세금합계
            let sll_tltx_smtl:String
            /// 매도정산금액합계
            let sll_excc_amt_smtl:String
            /// 매수수량합계
            let buyqty_smtl:String
            /// 매수거래금액합계
            let buy_tr_amt_smtl:String
            /// 매수수수료합계
            let buy_fee_smtl:String
            /// 매수제세금합계
            let buy_tax_smtl:String
            /// 매수정산금액합계
            let buy_excc_amt_smtl:String
            /// 총수량
            let tot_qty:String
            /// 총거래금액
            let tot_tr_amt:String
            /// 총수수료
            let tot_fee:String
            /// 총제세금
            let tot_tltx:String
            /// 총정산금액
            let tot_excc_amt:String
            /// 총실현손익
            let tot_rlzt_pfls:String
            /// 대출이자
            let loan_int:String
            /// 총수익률
            let tot_pftrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/inquire-period-trade-profit"
        public var customHeader: [String : String]?
        init(tr_id: String = "TTTC8715R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // TTTC8715R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 기간별손익일별합산조회[v1_국내주식-052]
    /// 기간별손익일별합산조회 API입니다.한국투자 HTS(eFriend Plus) > [0856] 기간별 매매손익 화면 에서 "일별" 클릭 시의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct inquireperiodprofit : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 계좌상품코드
            let ACNT_PRDT_CD:String
            /// 종합계좌번호
            let CANO:String
            /// 조회시작일자
            let INQR_STRT_DT:String
            /// 상품번호
            /// ""공란입력 시, 전체
            let PDNO:String
            /// 연속조회키100
            let CTX_AREA_NK100:String
            /// 조회종료일자
            let INQR_END_DT:String
            /// 정렬구분
            /// 00: 최근 순, 01: 과거 순, 02: 최근 순
            let SORT_DVSN:String
            /// 조회구분
            /// 00 입력
            let INQR_DVSN:String
            /// 잔고구분
            /// 00: 전체
            let CBLC_DVSN:String
            /// 연속조회검색조건100
            let CTX_AREA_FK100:String
        }
        public struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
            /// 응답상세2 : Object
            let output2: Output2
        }
        public struct Output1 : Codable {
            /// 매매일자
            let trad_dt:String
            /// 매수금액
            let buy_amt:String
            /// 매도금액
            let sll_amt:String
            /// 실현손익
            let rlzt_pfls:String
            /// 수수료
            let fee:String
            /// 대출이자
            let loan_int:String
            /// 제세금
            let tl_tax:String
            /// 손익률
            let pfls_rt:String
            /// 매도수량1
            let sll_qty1:String
            /// 매수수량1
            let buy_qty1:String
        }
        public struct Output2 : Codable {
            /// 매도수량합계
            let sll_qty_smtl:String
            /// 매도거래금액합계
            let sll_tr_amt_smtl:String
            /// 매도수수료합계
            let sll_fee_smtl:String
            /// 매도제세금합계
            let sll_tltx_smtl:String
            /// 매도정산금액합계
            let sll_excc_amt_smtl:String
            /// 매수수량합계
            let buy_qty_smtl:String
            /// 매수거래금액합계
            let buy_tr_amt_smtl:String
            /// 매수수수료합계
            let buy_fee_smtl:String
            /// 매수제세금합계
            let buy_tax_smtl:String
            /// 매수정산금액합계
            let buy_excc_amt_smtl:String
            /// 총수량
            let tot_qty:String
            /// 총거래금액
            let tot_tr_amt:String
            /// 총수수료
            let tot_fee:String
            /// 총제세금
            let tot_tltx:String
            /// 총정산금액
            let tot_excc_amt:String
            /// 총실현손익
            /// ※ HTS[0856] 기간별 매매손익 '일별' 화면의 우측 하단 '총손익률' 항목은 기간별매매손익현황조회(TTTC8715R) > output2 > tot_pftrt(총수익률) 으로 확인 가능
            let tot_rlzt_pfls:String
            /// 대출이자
            let loan_int:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/inquire-period-profit"
        public var customHeader: [String : String]?
        init(tr_id: String = "TTTC8708R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // TTTC8708R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 매도가능수량조회 [국내주식-165]
    /// 매도가능수량조회 API입니다. 한국투자 HTS(eFriend Plus) > [0971] 주식 매도 화면에서 종목코드 입력 후 "가능" 클릭 시 매도가능수량이 확인되는 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.특정종목 매도가능수량 확인 시, 매도주문 내시려는 주문종목(PDNO)으로 API 호출 후 output > ord_psbl_qty(주문가능수량) 확인하실 수 있습니다.
    struct inquirepsblsell : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 종합계좌번호
            let CANO:String
            /// 계좌상품코드
            /// 계좌상품코드
            let ACNT_PRDT_CD:String
            /// 종목번호
            /// 보유종목 코드 ex)000660
            let PDNO:String
        }
        public struct Response: Codable {
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
            /// 상품번호
            let pdno:String
            /// 상품명
            let prdt_name:String
            /// 매수수량
            let buy_qty:String
            /// 매도수량
            let sll_qty:String
            /// 잔고수량
            let cblc_qty:String
            /// 비저축수량
            let nsvg_qty:String
            /// 주문가능수량
            let ord_psbl_qty:String
            /// 매입평균가격
            let pchs_avg_pric:String
            /// 매입금액
            let pchs_amt:String
            /// 현재가
            let now_pric:String
            /// 평가금액
            let evlu_amt:String
            /// 평가손익금액
            let evlu_pfls_amt:String
            /// 평가손익율
            let evlu_pfls_rt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/inquire-psbl-sell"
        public var customHeader: [String : String]?
        init(tr_id: String = "TTTC8408R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // TTTC8408R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 주식통합증거금 현황 [국내주식-191]
    /// 주식통합증거금 현황 API입니다.한국투자 HTS(eFriend Plus) > [0867] 통합증거금조회 화면 의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 해당 화면은 일반계좌와 통합증거금 신청계좌에 대해서 국내 및 해외 주문가능금액을 간단하게 조회하는 화면입니다.※ 해외 국가별 상세한 증거금현황을 원하시면 [해외주식] 주문/계좌 > 해외증거금 통화별조회 API를 이용하여 주시기 바랍니다.
    struct intgrmargin : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.currentManager!.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.currentManager!.ACNT_PRDT_CD()
            /// CMA평가금액포함여부
            /// N 입력
            let CMA_EVLU_AMT_ICLD_YN:String
            /// 원화외화구분코드
            /// 01(외화기준),02(원화기준)
            let WCRC_FRCR_DVSN_CD:String
            /// 선도환계약외화구분코드
            /// 01(외화기준),02(원화기준)
            let FWEX_CTRT_FRCR_DVSN_CD:String
        }
        public struct Response: Codable {
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
            /// 계좌증거금율
            let acmga_rt:String
            /// 계좌증거금100퍼센트지정사유
            let acmga_pct100_aptm_rson:String
            /// 주식현금대상금액
            let stck_cash_objt_amt:String
            /// 주식대용대상금액
            let stck_sbst_objt_amt:String
            /// 주식평가대상금액
            let stck_evlu_objt_amt:String
            /// 주식재사용가능대상금액
            let stck_ruse_psbl_objt_amt:String
            /// 주식펀드환매대금대상금액
            let stck_fund_rpch_chgs_objt_amt:String
            /// 주식융자상환금대상금액
            let stck_fncg_rdpt_objt_atm:String
            /// 채권재사용가능대상금액
            let bond_ruse_psbl_objt_amt:String
            /// 주식현금사용금액
            let stck_cash_use_amt:String
            /// 주식대용사용금액
            let stck_sbst_use_amt:String
            /// 주식평가사용금액
            let stck_evlu_use_amt:String
            /// 주식재사용가능금사용금액
            let stck_ruse_psbl_amt_use_amt:String
            /// 주식펀드환매대금사용금액
            let stck_fund_rpch_chgs_use_amt:String
            /// 주식융자상환금사용금액
            let stck_fncg_rdpt_amt_use_amt:String
            /// 채권재사용가능금사용금액
            let bond_ruse_psbl_amt_use_amt:String
            /// 주식현금주문가능금액
            let stck_cash_ord_psbl_amt:String
            /// 주식대용주문가능금액
            let stck_sbst_ord_psbl_amt:String
            /// 주식평가주문가능금액
            let stck_evlu_ord_psbl_amt:String
            /// 주식재사용가능주문가능금액
            let stck_ruse_psbl_ord_psbl_amt:String
            /// 주식펀드환매주문가능금액
            let stck_fund_rpch_ord_psbl_amt:String
            /// 채권재사용가능주문가능금액
            let bond_ruse_psbl_ord_psbl_amt:String
            /// 미수금액
            let rcvb_amt:String
            /// 주식대출보증금재사용가능금액
            let stck_loan_grta_ruse_psbl_amt:String
            /// 주식현금20최대주문가능금액
            let stck_cash20_max_ord_psbl_amt:String
            /// 주식현금30최대주문가능금액
            let stck_cash30_max_ord_psbl_amt:String
            /// 주식현금40최대주문가능금액
            let stck_cash40_max_ord_psbl_amt:String
            /// 주식현금50최대주문가능금액
            let stck_cash50_max_ord_psbl_amt:String
            /// 주식현금60최대주문가능금액
            let stck_cash60_max_ord_psbl_amt:String
            /// 주식현금100최대주문가능금액
            let stck_cash100_max_ord_psbl_amt:String
            /// 주식재사용불가100최대주문가능
            let stck_rsip100_max_ord_psbl_amt:String
            /// 채권최대주문가능금액
            let bond_max_ord_psbl_amt:String
            /// 주식융자45최대주문가능금액
            let stck_fncg45_max_ord_psbl_amt:String
            /// 주식융자50최대주문가능금액
            let stck_fncg50_max_ord_psbl_amt:String
            /// 주식융자60최대주문가능금액
            let stck_fncg60_max_ord_psbl_amt:String
            /// 주식융자70최대주문가능금액
            let stck_fncg70_max_ord_psbl_amt:String
            /// 주식대주최대주문가능금액
            let stck_stln_max_ord_psbl_amt:String
            /// 한도금액
            let lmt_amt:String
            /// 해외주식통합증거금구분명
            let ovrs_stck_itgr_mgna_dvsn_name:String
            /// 미화대상금액
            let usd_objt_amt:String
            /// 미화사용금액
            let usd_use_amt:String
            /// 미화주문가능금액
            let usd_ord_psbl_amt:String
            /// 홍콩달러대상금액
            let hkd_objt_amt:String
            /// 홍콩달러사용금액
            let hkd_use_amt:String
            /// 홍콩달러주문가능금액
            let hkd_ord_psbl_amt:String
            /// 엔화대상금액
            let jpy_objt_amt:String
            /// 엔화사용금액
            let jpy_use_amt:String
            /// 엔화주문가능금액
            let jpy_ord_psbl_amt:String
            /// 위안화대상금액
            let cny_objt_amt:String
            /// 위안화사용금액
            let cny_use_amt:String
            /// 위안화주문가능금액
            let cny_ord_psbl_amt:String
            /// 미화재사용대상금액
            let usd_ruse_objt_amt:String
            /// 미화재사용금액
            let usd_ruse_amt:String
            /// 미화재사용주문가능금액
            let usd_ruse_ord_psbl_amt:String
            /// 홍콩달러재사용대상금액
            let hkd_ruse_objt_amt:String
            /// 홍콩달러재사용금액
            let hkd_ruse_amt:String
            /// 홍콩달러재사용주문가능금액
            let hkd_ruse_ord_psbl_amt:String
            /// 엔화재사용대상금액
            let jpy_ruse_objt_amt:String
            /// 엔화재사용금액
            let jpy_ruse_amt:String
            /// 엔화재사용주문가능금액
            let jpy_ruse_ord_psbl_amt:String
            /// 위안화재사용대상금액
            let cny_ruse_objt_amt:String
            /// 위안화재사용금액
            let cny_ruse_amt:String
            /// 위안화재사용주문가능금액
            let cny_ruse_ord_psbl_amt:String
            /// 미화일반주문가능금액
            let usd_gnrl_ord_psbl_amt:String
            /// 미화통합주문가능금액
            let usd_itgr_ord_psbl_amt:String
            /// 홍콩달러일반주문가능금액
            let hkd_gnrl_ord_psbl_amt:String
            /// 홍콩달러통합주문가능금액
            let hkd_itgr_ord_psbl_amt:String
            /// 엔화일반주문가능금액
            let jpy_gnrl_ord_psbl_amt:String
            /// 엔화통합주문가능금액
            let jpy_itgr_ord_psbl_amt:String
            /// 위안화일반주문가능금액
            let cny_gnrl_ord_psbl_amt:String
            /// 위안화통합주문가능금액
            let cny_itgr_ord_psbl_amt:String
            /// 주식통합현금20주문가능금액
            let stck_itgr_cash20_ord_psbl_amt:String
            /// 주식통합현금30주문가능금액
            let stck_itgr_cash30_ord_psbl_amt:String
            /// 주식통합현금40주문가능금액
            let stck_itgr_cash40_ord_psbl_amt:String
            /// 주식통합현금50주문가능금액
            let stck_itgr_cash50_ord_psbl_amt:String
            /// 주식통합현금60주문가능금액
            let stck_itgr_cash60_ord_psbl_amt:String
            /// 주식통합현금100주문가능금액
            let stck_itgr_cash100_ord_psbl_amt:String
            /// 주식통합100주문가능금액
            let stck_itgr_100_ord_psbl_amt:String
            /// 주식통합융자45주문가능금액
            let stck_itgr_fncg45_ord_psbl_amt:String
            /// 주식통합융자50주문가능금액
            let stck_itgr_fncg50_ord_psbl_amt:String
            /// 주식통합융자60주문가능금액
            let stck_itgr_fncg60_ord_psbl_amt:String
            /// 주식통합융자70주문가능금액
            let stck_itgr_fncg70_ord_psbl_amt:String
            /// 주식통합대주주문가능금액
            let stck_itgr_stln_ord_psbl_amt:String
            /// 채권통합주문가능금액
            let bond_itgr_ord_psbl_amt:String
            /// 주식현금해외사용금액
            let stck_cash_ovrs_use_amt:String
            /// 주식대용해외사용금액
            let stck_sbst_ovrs_use_amt:String
            /// 주식평가해외사용금액
            let stck_evlu_ovrs_use_amt:String
            /// 주식재사용금액해외사용금액
            let stck_re_use_amt_ovrs_use_amt:String
            /// 주식펀드환매해외사용금액
            let stck_fund_rpch_ovrs_use_amt:String
            /// 주식융자상환해외사용금액
            let stck_fncg_rdpt_ovrs_use_amt:String
            /// 채권재사용해외사용금액
            let bond_re_use_ovrs_use_amt:String
            /// 미화타시장사용금액
            let usd_oth_mket_use_amt:String
            /// 엔화타시장사용금액
            let jpy_oth_mket_use_amt:String
            /// 위안화타시장사용금액
            let cny_oth_mket_use_amt:String
            /// 홍콩달러타시장사용금액
            let hkd_oth_mket_use_amt:String
            /// 미화재사용타시장사용금액
            let usd_re_use_oth_mket_use_amt:String
            /// 엔화재사용타시장사용금액
            let jpy_re_use_oth_mket_use_amt:String
            /// 위안화재사용타시장사용금액
            let cny_re_use_oth_mket_use_amt:String
            /// 홍콩달러재사용타시장사용금액
            let hkd_re_use_oth_mket_use_amt:String
            /// 홍콩위안화재사용금액
            let hgkg_cny_re_use_amt:String
            /// 미국달러최초고시환율
            let usd_frst_bltn_exrt:String
            /// 홍콩달러최초고시환율
            let hkd_frst_bltn_exrt:String
            /// 일본엔화최초고시환율
            /// 일본 엔화는 1엔으로 환산되어 제공
            let jpy_frst_bltn_exrt:String
            /// 중국위안화최초고시환율
            let cny_frst_bltn_exrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/intgr-margin"
        public var customHeader: [String : String]?
        init(tr_id: String = "TTTC0869R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // TTTC0869R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 기간별계좌권리현황조회 [국내주식-211]
    /// 기간별계좌권리현황조회 API입니다.한국투자 HTS(eFriend Plus) > [7344] 권리유형별 현황조회 화면을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct periodrights : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조회구분
            /// 03 입력
            let INQR_DVSN:String
            /// 고객실명확인번호25
            /// 공란
            let CUST_RNCNO25:String
            /// 홈넷ID
            /// 공란
            let HMID:String
            /// 종합계좌번호
            /// 계좌번호 8자리 입력 (ex.12345678)
            let CANO:String
            /// 계좌상품코드
            /// 상품계좌번호 2자리 입력(ex. 01 or 22)
            let ACNT_PRDT_CD:String
            /// 조회시작일자
            /// 조회시작일자(YYYYMMDD)
            let INQR_STRT_DT:String
            /// 조회종료일자
            /// 조회종료일자(YYYYMMDD)
            let INQR_END_DT:String
            /// 권리유형코드
            /// 공란
            let RGHT_TYPE_CD:String
            /// 상품번호
            /// 공란
            let PDNO:String
            /// 상품유형코드
            /// 공란
            let PRDT_TYPE_CD:String
            /// 연속조회키100
            /// 다음조회시 입력
            let CTX_AREA_NK100:String
            /// 연속조회검색조건100
            /// 다음조회시 입력
            let CTX_AREA_FK100:String
        }
        public struct Response: Codable {
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
            /// 계좌번호10
            let acno10:String
            /// 권리유형코드
            /// 1 유상 2 무상 3 배당 4 매수청구 5 공개매수 6 주주총회 7 신주인수권증서 8 반대의사 9 신주인수권증권 11 합병 12 회사분할 13 주식교환 14 액면분할 15 액면병합 16 종목변경 17 감자 18 신구주합병 21 후합병 22 후회사분할 23 후주식교환 24 후액면분할 25 후액면병합 26 후종목변경 27 후감자 28 후신구주합병 31 뮤츄얼펀드 32 ETF 33 선박투자회사 34 투융자회사 35 해외자원 36 부동산신탁(Ritz) 37 상장수익증권 41 ELW만기 42 ELS분배 43 DLS분배 44 하일드펀드 45 ETN 51 전환청구 52 교환청구 53 BW청구 54 WRT청구 55 채권풋옵션청구 56 전환우선주청구 57 전환조건부청구 58 전자증권일괄입고 59 클라우드펀딩일괄입고 61 원리금상환 62 스트립채권 71 WRT소멸 72 WRT증권 73 DR전환 74 배당옵션 75 특별배당 76 ISINCODE변경 77 실권주청약 81 해외분배금(청산) 82 해외분배금(조기상환) 83 해외분배금(상장폐지) 84 DR FEE 85 SECTION 871M 86 종목전환 87 재매수 88 종목교환 89 기타이벤트 91 공모주 92 청약 93 환매 99 기타권리사유
            let rght_type_cd:String
            /// 기준일자
            let bass_dt:String
            /// 권리잔고유형코드
            /// 1 입고 2 출고 3 출고입고 4 출고입금 5 출고출금 10 현금입금 11 단수주대금입금 12 교부금입금 13 유상감자대금입금 14 지연이자입금 15 이자지급 16 대주권리금출금 17 분할상환 18 만기상환 19 조기상환 20 출금 21 입고&입금 22 입고&입금&단수주대금입금 25 유상환불금입금 26 중도상환 27 분할합병세금출금
            let rght_cblc_type_cd:String
            /// 대표상품번호
            let rptt_pdno:String
            /// 상품번호
            let pdno:String
            /// 상품유형코드
            let prdt_type_cd:String
            /// 단축상품번호
            let shtn_pdno:String
            /// 상품명
            let prdt_name:String
            /// 잔고수량
            let cblc_qty:String
            /// 최종배정수량
            let last_alct_qty:String
            /// 초과배정수량
            let excs_alct_qty:String
            /// 총배정수량
            let tot_alct_qty:String
            /// 최종단수주수량
            let last_ftsk_qty:String
            /// 최종배정금액
            let last_alct_amt:String
            /// 최종단수주대금
            let last_ftsk_chgs:String
            /// 상환원금
            let rdpt_prca:String
            /// 지연이자금액
            let dlay_int_amt:String
            /// 상장일자
            let lstg_dt:String
            /// 청약종료일자
            let sbsc_end_dt:String
            /// 현금지급일자
            let cash_dfrm_dt:String
            /// 신청수량
            let rqst_qty:String
            /// 신청금액
            let rqst_amt:String
            /// 신청일자
            let rqst_dt:String
            /// 환불일자
            let rfnd_dt:String
            /// 환불금액
            let rfnd_amt:String
            /// 상장주수
            let lstg_stqt:String
            /// 세금금액
            let tax_amt:String
            /// 청약단가
            let sbsc_unpr:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/period-rights"
        public var customHeader: [String : String]?
        init(tr_id: String = "CTRGA011R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // CTRGA011R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }
}
// MARK: 퇴직연금
public extension KISAPI.국내주식_주문_계좌_퇴직연금 {
    /// 퇴직연금 미체결내역[v1_국내주식-033]
    /// ​※ 55번 계좌(DC가입자계좌)의 경우 해당 API 이용이 불가합니다.KIS Developers API의 경우 HTS ID에 반드시 연결되어있어야만 API 신청 및 앱정보 발급이 가능한 서비스로 개발되어서 실물계좌가 아닌 55번 계좌는 API 이용이 불가능한 점 양해 부탁드립니다.
    struct inquiredailyccld : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            let CANO:String
            /// 계좌상품코드
            /// 29
            let ACNT_PRDT_CD:String
            /// 사용자구분코드
            /// %%
            let USER_DVSN_CD:String
            /// 매도매수구분코드
            /// 00 : 전체 / 01 : 매도 / 02 : 매수
            let SLL_BUY_DVSN_CD:String
            /// 체결미체결구분
            /// %% : 전체 / 01 : 체결 / 02 : 미체결
            let CCLD_NCCS_DVSN:String
            /// 조회구분3
            /// 00 : 전체
            let INQR_DVSN_3:String
            /// 연속조회검색조건100
            let CTX_AREA_FK100:String
            /// 연속조회키100
            let CTX_AREA_NK100:String
        }
        public struct Response: Codable {
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
            /// 주문채번지점번호
            let ord_gno_brno:String
            /// 매도매수구분코드
            let sll_buy_dvsn_cd:String
            /// 매매구분명
            let trad_dvsn_name:String
            /// 주문번호
            let odno:String
            /// 상품번호
            let pdno:String
            /// 상품명
            let prdt_name:String
            /// 주문단가
            let ord_unpr:String
            /// 주문수량
            let ord_qty:String
            /// 총체결수량
            let tot_ccld_qty:String
            /// 미체결수량
            let nccs_qty:String
            /// 주문구분코드
            let ord_dvsn_cd:String
            /// 주문구분명
            let ord_dvsn_name:String
            /// 원주문번호
            let orgn_odno:String
            /// 주문시각
            let ord_tmd:String
            /// 대상고객구분명
            let objt_cust_dvsn_name:String
            /// 매입평균가격
            let pchs_avg_pric:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/pension/inquire-daily-ccld"
        public var customHeader: [String : String]?
        init(tr_id: String = "TTTC2201R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // TTTC2201R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }
    /// 퇴직연금 매수가능조회[v1_국내주식-034]
    /// ​※ 55번 계좌(DC가입자계좌)의 경우 해당 API 이용이 불가합니다.KIS Developers API의 경우 HTS ID에 반드시 연결되어있어야만 API 신청 및 앱정보 발급이 가능한 서비스로 개발되어서 실물계좌가 아닌 55번 계좌는 API 이용이 불가능한 점 양해 부탁드립니다.
    struct inquirepsblorder : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            let CANO:String
            /// 계좌상품코드
            /// 29
            let ACNT_PRDT_CD:String
            /// 상품번호
            let PDNO:String
            /// 적립금구분코드
            /// 00
            let ACCA_DVSN_CD:String
            /// CMA평가금액포함여부
            let CMA_EVLU_AMT_ICLD_YN:String
            /// 주문구분
            /// 00 : 지정가 / 01 : 시장가
            let ORD_DVSN:String
            /// 주문단가
            let ORD_UNPR:String
        }
        public struct Response: Codable {
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
            /// 주문가능현금
            let ord_psbl_cash:String
            /// 재사용가능금액
            let ruse_psbl_amt:String
            /// 가능수량계산단가
            let psbl_qty_calc_unpr:String
            /// 최대매수금액
            let max_buy_amt:String
            /// 최대매수수량
            let max_buy_qty:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/pension/inquire-psbl-order"
        public var customHeader: [String : String]?
        init(tr_id: String = "TTTC0503R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // TTTC0503R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 퇴직연금 예수금조회[v1_국내주식-035]
    /// ​※ 55번 계좌(DC가입자계좌)의 경우 해당 API 이용이 불가합니다.KIS Developers API의 경우 HTS ID에 반드시 연결되어있어야만 API 신청 및 앱정보 발급이 가능한 서비스로 개발되어서 실물계좌가 아닌 55번 계좌는 API 이용이 불가능한 점 양해 부탁드립니다.
    struct inquiredeposit : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            let CANO:String
            /// 계좌상품코드
            /// 29
            let ACNT_PRDT_CD:String
            /// 적립금구분코드
            /// 00
            let ACCA_DVSN_CD:String
        }
        public struct Response: Codable {
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
            /// 예수금총액
            let dnca_tota:String
            /// 익일정산액
            let nxdy_excc_amt:String
            /// 익일결제금액
            let nxdy_sttl_amt:String
            /// 2익일결제금액
            let nx2_day_sttl_amt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/pension/inquire-deposit"
        public var customHeader: [String : String]?
        init(tr_id: String = "TTTC0506R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // TTTC0506R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 퇴직연금 잔고조회[v1_국내주식-036]
    /// 주식, ETF, ETN만 조회 가능하며 펀드는 조회 불가합니다.​※ 55번 계좌(DC가입자계좌)의 경우 해당 API 이용이 불가합니다.KIS Developers API의 경우 HTS ID에 반드시 연결되어있어야만 API 신청 및 앱정보 발급이 가능한 서비스로 개발되어서 실물계좌가 아닌 55번 계좌는 API 이용이 불가능한 점 양해 부탁드립니다.
    struct inquirebalance : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            let CANO:String
            /// 계좌상품코드
            /// 29
            let ACNT_PRDT_CD:String
            /// 적립금구분코드
            /// 00
            let ACCA_DVSN_CD:String
            /// 조회구분
            /// 00 : 전체
            let INQR_DVSN:String
            /// 연속조회검색조건100
            let CTX_AREA_FK100:String
            /// 연속조회키100
            let CTX_AREA_NK100:String
        }
        public struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// Array
            let output1: [Output1]
            /// 응답상세2 : Object
            let output2: Output2
        }
        public struct Output1 : Codable {
            /// 잔고구분명
            let cblc_dvsn_name:String
            /// 상품명
            let prdt_name:String
            /// 상품번호
            let pdno:String
            /// 종목구분명
            let item_dvsn_name:String
            /// 금일매수수량
            let thdt_buyqty:String
            /// 금일매도수량
            let thdt_sll_qty:String
            /// 보유수량
            let hldg_qty:String
            /// 주문가능수량
            let ord_psbl_qty:String
            /// 매입평균가격
            let pchs_avg_pric:String
            /// 매입금액
            let pchs_amt:String
            /// 현재가
            let prpr:String
            /// 평가금액
            let evlu_amt:String
            /// 평가손익금액
            let evlu_pfls_amt:String
            /// 평가수익율
            let evlu_erng_rt:String
        }
        public struct Output2 : Codable {
            /// 예수금총금액
            let dnca_tot_amt:String
            /// 익일정산금액
            let nxdy_excc_amt:String
            /// 가수도정산금액
            let prvs_rcdl_excc_amt:String
            /// 금일매수금액
            let thdt_buy_amt:String
            /// 금일매도금액
            let thdt_sll_amt:String
            /// 금일제비용금액
            let thdt_tlex_amt:String
            /// 유가평가금액
            let scts_evlu_amt:String
            /// 총평가금액
            let tot_evlu_amt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/trading/pension/inquire-balance"
        public var customHeader: [String : String]?
        init(tr_id: String = "TTTC2208R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // TTTC2208R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.customHeader?["authorization"] = await KISManager.currentManager?.getAccessToken()?.token
            self.customHeader?["gt_uid"] = gt_uid
            self.customHeader?["tr_id"] = tr_id
        }
    }
}
