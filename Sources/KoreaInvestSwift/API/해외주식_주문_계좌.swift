//
//  해외주식_주문_계좌.swift
//  KoreaInvestSwift
//
//  Created by kin on 4/10/25.
//
import FullyRESTful
extension KISAPI {
    enum 해외주식_주문_계좌 {}
}
extension KISAPI.해외주식_주문_계좌 {
    /// 해외주식 주문[v1_해외주식-001]
    /// 해외주식 주문 API입니다.* 모의투자의 경우, 모든 해외 종목 매매가 지원되지 않습니다. 일부 종목만 매매 가능한 점 유의 부탁드립니다.* 해외주식 서비스 신청 후 이용 가능합니다. (아래 링크 3번 해외증권 거래신청 참고)https://securities.koreainvestment.com/main/bond/research/_static/TF03ca010001.jsp* 해외 거래소 운영시간 외 API 호출 시 에러가 발생하오니 운영시간을 확인해주세요.* 해외 거래소 운영시간(한국시간 기준)1) 미국 : 23:30 ~ 06:00 (썸머타임 적용 시 22:30 ~ 05:00)    * 프리마켓(18:00 ~ 23:30, Summer Time : 17:00 ~ 22:30), 애프터마켓(06:00 ~ 07:00, Summer Time : 05:00 ~ 07:00) 시간대에도 주문 가능2) 일본 : (오전) 09:00 ~ 11:30, (오후) 12:30 ~ 15:003) 상해 : 10:30 ~ 16:004) 홍콩 : (오전) 10:30 ~ 13:00, (오후) 14:00 ~ 17:00※ POST API의 경우 BODY값의 key값들을 대문자로 작성하셔야 합니다.   (EX. "CANO" : "12345678", "ACNT_PRDT_CD": "01",...)※ 종목코드 마스터파일 파이썬 정제코드는 한국투자증권 Github 참고 부탁드립니다.   https://github.com/koreainvestment/open-trading-api/tree/main/stocks_info
    struct order : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 해외거래소코드
            /// NASD : 나스닥 NYSE : 뉴욕 AMEX : 아멕스 SEHK : 홍콩 SHAA : 중국상해 SZAA : 중국심천 TKSE : 일본 HASE : 베트남 하노이 VNSE : 베트남 호치민
            let OVRS_EXCG_CD:String
            /// 상품번호
            /// 종목코드
            let PDNO:String
            /// 주문수량
            /// 주문수량 (해외거래소 별 최소 주문수량 및 주문단위 확인 필요)
            let ORD_QTY:String
            /// 해외주문단가
            /// 1주당 가격 * 시장가의 경우 1주당 가격을 공란으로 비우지 않음 "0"으로 입력
            let OVRS_ORD_UNPR:String
            /// 연락전화번호
            let CTAC_TLNO:String?
            /// 운용사지정주문번호
            let MGCO_APTM_ODNO:String?
            /// 판매유형
            /// 제거 : 매수 00 : 매도
            let SLL_TYPE:String?
            /// 주문서버구분코드
            /// "0"(Default)
            let ORD_SVR_DVSN_CD:String
            /// 주문구분
            /// [Header tr_id TTTT1002U(미국 매수 주문)] 00 : 지정가 32 : LOO(장개시지정가) 34 : LOC(장마감지정가) * 모의투자 VTTT1002U(미국 매수 주문)로는 00:지정가만 가능 [Header tr_id TTTT1006U(미국 매도 주문)] 00 : 지정가 31 : MOO(장개시시장가) 32 : LOO(장개시지정가) 33 : MOC(장마감시장가) 34 : LOC(장마감지정가) * 모의투자 VTTT1006U(미국 매도 주문)로는 00:지정가만 가능 [Header tr_id TTTS1001U(홍콩 매도 주문)] 00 : 지정가 50 : 단주지정가 * 모의투자 VTTS1001U(홍콩 매도 주문)로는 00:지정가만 가능 [그외 tr_id] 제거
            let ORD_DVSN:String
        }
        public struct Response : Codable {
            /// 성공 실패 여부
            /// 0 : 성공 0 이외의 값 : 실패
            let rt_cd:String
            /// 응답코드
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            /// 응답메세지
            let msg1:String
            /// 응답상세 : Object
            let output:Output
        }
        public struct Output : Codable {
            /// 한국거래소전송주문조직번호
            /// 주문시 한국투자증권 시스템에서 지정된 영업점코드
            let KRX_FWDG_ORD_ORGNO:String
            /// 주문번호
            /// 주문시 한국투자증권 시스템에서 채번된 주문번호
            let ODNO:String
            /// 주문시각
            /// 주문시각(시분초HHMMSS)
            let ORD_TMD:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/trading/order"
        public var header: [String : String]
        // [실전투자] TTTT1002U : 미국 매수 주문 TTTT1006U : 미국 매도 주문 TTTS0308U : 일본 매수 주문 TTTS0307U : 일본 매도 주문 TTTS0202U : 상해 매수 주문 TTTS1005U : 상해 매도 주문 TTTS1002U : 홍콩 매수 주문 TTTS1001U : 홍콩 매도 주문 TTTS0305U : 심천 매수 주문 TTTS0304U : 심천 매도 주문 TTTS0311U : 베트남 매수 주문 TTTS0310U : 베트남 매도 주문 [모의투자] VTTT1002U : 미국 매수 주문 VTTT1001U : 미국 매도 주문 VTTS0308U : 일본 매수 주문 VTTS0307U : 일본 매도 주문 VTTS0202U : 상해 매수 주문 VTTS1005U : 상해 매도 주문 VTTS1002U : 홍콩 매수 주문 VTTS1001U : 홍콩 매도 주문 VTTS0305U : 심천 매수 주문 VTTS0304U : 심천 매도 주문 VTTS0311U : 베트남 매수 주문 VTTS0310U : 베트남 매도 주문
        enum TR_ID : String {
            case 실전투자_미국_매수 = "TTTT1002U"
            case 실전투자_미국_매도 = "TTTT1006U"
            case 실전투자_일본_매수 = "TTTS0308U"
            case 실전투자_일본_매도 = "TTTS0307U"
            case 실전투자_상해_매수 = "TTTS0202U"
            case 실전투자_상해_매도 = "TTTS1005U"
            case 실전투자_홍콩_매수 = "TTTS1002U"
            case 실전투자_홍콩_매도 = "TTTS1001U"
            case 실전투자_심천_매수 = "TTTS0305U"
            case 실전투자_심천_매도 = "TTTS0304U"
            case 실전투자_베트남_매수 = "TTTS0311U"
            case 실전투자_베트남_매도 = "TTTS0310U"
            case 모의투자_미국_매수 = "VTTT1002U"
            case 모의투자_미국_매도 = "VTTT1001U"
            case 모의투자_일본_매수 = "VTTS0308U"
            case 모의투자_일본_매도 = "VTTS0307U"
            case 모의투자_상해_매수 = "VTTS0202U"
            case 모의투자_상해_매도 = "VTTS1005U"
            case 모의투자_홍콩_매수 = "VTTS1002U"
            case 모의투자_홍콩_매도 = "VTTS1001U"
            case 모의투자_심천_매수 = "VTTS0305U"
            case 모의투자_심천_매도 = "VTTS0304U"
            case 모의투자_베트남_매수 = "VTTS0311U"
            case 모의투자_베트남_매도 = "VTTS0310U"
        }
        init(tr_id: TR_ID, gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] TTTT1002U : 미국 매수 주문 TTTT1006U : 미국 매도 주문 TTTS0308U : 일본 매수 주문 TTTS0307U : 일본 매도 주문 TTTS0202U : 상해 매수 주문 TTTS1005U : 상해 매도 주문 TTTS1002U : 홍콩 매수 주문 TTTS1001U : 홍콩 매도 주문 TTTS0305U : 심천 매수 주문 TTTS0304U : 심천 매도 주문 TTTS0311U : 베트남 매수 주문 TTTS0310U : 베트남 매도 주문 [모의투자] VTTT1002U : 미국 매수 주문 VTTT1001U : 미국 매도 주문 VTTS0308U : 일본 매수 주문 VTTS0307U : 일본 매도 주문 VTTS0202U : 상해 매수 주문 VTTS1005U : 상해 매도 주문 VTTS1002U : 홍콩 매수 주문 VTTS1001U : 홍콩 매도 주문 VTTS0305U : 심천 매수 주문 VTTS0304U : 심천 매도 주문 VTTS0311U : 베트남 매수 주문 VTTS0310U : 베트남 매도 주문
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // ※ 필수 아님 (기존 필수 사항으로 옵션으로 유지) [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.header["authorization"] = await KISManager.getAccessToken()?.token
            self.header["gt_uid"] = gt_uid
            self.header["Content-Type"] = "application/json; charset=UTF-8"
            self.header["tr_id"] = tr_id.rawValue
        }
    }

    /// 해외주식 정정취소주문[v1_해외주식-003]
    /// 접수된 해외주식 주문을 정정하거나 취소하기 위한 API입니다.(해외주식주문 시 Return 받은 ODNO를 참고하여 API를 호출하세요.)* 해외주식 서비스 신청 후 이용 가능합니다. (아래 링크 3번 해외증권 거래신청 참고)https://securities.koreainvestment.com/main/bond/research/_static/TF03ca010001.jsp* 해외 거래소 운영시간 외 API 호출 시 에러가 발생하오니 운영시간을 확인해주세요.* 해외 거래소 운영시간(한국시간 기준)1) 미국 : 23:30 ~ 06:00 (썸머타임 적용 시 22:30 ~ 05:00)    * 프리마켓(18:00 ~ 23:30, Summer Time : 17:00 ~ 22:30), 애프터마켓(06:00 ~ 07:00, Summer Time : 05:00 ~ 07:00) 시간대에도 주문 가능2) 일본 : (오전) 09:00 ~ 11:30, (오후) 12:30 ~ 15:003) 상해 : 10:30 ~ 16:004) 홍콩 : (오전) 10:30 ~ 13:00, (오후) 14:00 ~ 17:00※ POST API의 경우 BODY값의 key값들을 대문자로 작성하셔야 합니다.   (EX. "CANO" : "12345678", "ACNT_PRDT_CD": "01",...)
    struct orderrvsecncl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 해외거래소코드
            /// NASD : 나스닥 NYSE : 뉴욕 AMEX : 아멕스 SEHK : 홍콩 SHAA : 중국상해 SZAA : 중국심천 TKSE : 일본 HASE : 베트남 하노이 VNSE : 베트남 호치민
            let OVRS_EXCG_CD:String
            /// 상품번호
            let PDNO:String
            /// 원주문번호
            /// 정정 또는 취소할 원주문번호 (해외주식_주문 API ouput ODNO or 해외주식 미체결내역 API output ODNO 참고)
            let ORGN_ODNO:String
            /// 정정취소구분코드
            /// 01 : 정정 02 : 취소
            let RVSE_CNCL_DVSN_CD:String
            /// 주문수량
            let ORD_QTY:String
            /// 해외주문단가
            /// 취소주문 시, "0" 입력
            let OVRS_ORD_UNPR:String
            /// 운용사지정주문번호
            let MGCO_APTM_ODNO:String?
            /// 주문서버구분코드
            /// "0"(Default)
            let ORD_SVR_DVSN_CD:String?
        }
        public struct Response : Codable {
            /// 성공 실패 여부
            /// 0 : 성공 0 이외의 값 : 실패
            let rt_cd:String
            /// 응답코드
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            /// 응답메세지
            let msg1:String
            /// 응답상세 : Object
            let output:Output
        }
        public struct Output : Codable {
            /// 한국거래소전송주문조직번호
            /// 주문시 한국투자증권 시스템에서 지정된 영업점코드
            let KRX_FWDG_ORD_ORGNO:String
            /// 주문번호
            /// 주문시 한국투자증권 시스템에서 채번된 주문번호
            let ODNO:String
            /// 주문시각
            /// 주문시각(시분초HHMMSS)
            let ORD_TMD:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/trading/order-rvsecncl"
        public var header: [String : String]
        // [실전투자] TTTT1004U : 미국 정정 취소 주문 TTTS1003U : 홍콩 정정 취소 주문 TTTS0309U : 일본 정정 취소 주문 TTTS0302U : 상해 취소 주문 TTTS0306U : 심천 취소 주문 TTTS0312U : 베트남 취소 주문 [모의투자] VTTT1004U : 미국 정정 취소 주문 VTTS1003U : 홍콩 정정 취소 주문 VTTS0309U : 일본 정정 취소 주문 VTTS0302U : 상해 취소 주문 VTTS0306U : 심천 취소 주문 VTTS0312U : 베트남 취소 주문
        enum TR_ID : String {
            case 미국_정정_취소 = "TTTT1004U"
            case 홍콩_정정_취소 = "TTTS1003U"
            case 일본_정정_취소 = "TTTS0309U"
            case 상해_취소 = "TTTS0302U"
            case 심천_취소 = "TTTS0306U"
            case 베트남_취소 = "TTTS0312U"
        }
        init(tr_id: TR_ID, gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] TTTT1004U : 미국 정정 취소 주문 TTTS1003U : 홍콩 정정 취소 주문 TTTS0309U : 일본 정정 취소 주문 TTTS0302U : 상해 취소 주문 TTTS0306U : 심천 취소 주문 TTTS0312U : 베트남 취소 주문 [모의투자] VTTT1004U : 미국 정정 취소 주문 VTTS1003U : 홍콩 정정 취소 주문 VTTS0309U : 일본 정정 취소 주문 VTTS0302U : 상해 취소 주문 VTTS0306U : 심천 취소 주문 VTTS0312U : 베트남 취소 주문
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // ※ 필수 아님 (기존 필수 사항으로 옵션으로 유지) [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.header["authorization"] = await KISManager.getAccessToken()?.token
            self.header["gt_uid"] = gt_uid
            self.header["Content-Type"] = "application/json; charset=UTF-8"
            self.header["tr_id"] = tr_id.rawValue
        }
    }

    /// 해외주식 예약주문접수[v1_해외주식-002]
    /// 미국거래소 운영시간 외 미국주식을 예약 매매하기 위한 API입니다.* 해외주식 서비스 신청 후 이용 가능합니다. (아래 링크 3번 해외증권 거래신청 참고)https://securities.koreainvestment.com/main/bond/research/_static/TF03ca010001.jsp※ POST API의 경우 BODY값의 key값들을 대문자로 작성하셔야 합니다.   (EX. "CANO" : "12345678", "ACNT_PRDT_CD": "01",...)* 아래 각 국가의 시장별 예약주문 접수 가능 시간을 확인하시길 바랍니다.미국 예약주문 접수시간1) 10:00 ~ 23:20 / 10:00 ~ 22:20 (서머타임 시)2) 주문제한 : 16:30 ~ 16:45 경까지 (사유 : 시스템 정산작업시간)3) 23:30 정규장으로 주문 전송 (서머타임 시 22:30 정규장 주문 전송)4) 미국 거래소 운영시간(한국시간 기준) : 23:30 ~ 06:00 (썸머타임 적용 시 22:30 ~ 05:00)홍콩 예약주문 접수시간1) 09:00 ~ 10:20 접수, 10:30 주문전송2) 10:40 ~ 13:50 접수, 14:00 주문전송중국 예약주문 접수시간1) 09:00 ~ 10:20 접수, 10:30 주문전송2) 10:40 ~ 13:50 접수, 14:00 주문전송일본 예약주문 접수시간1) 09:10 ~ 12:20 까지 접수, 12:30 주문전송베트남 예약주문 접수시간1) 09:00 ~ 11:00 까지 접수, 11:15 주문전송2) 11:20 ~ 14:50 까지 접수, 15:00 주문전송* 예약주문 유의사항1) 예약주문 유효기간 : 당일 - 미국장 마감 후, 미체결주문은 자동취소 - 미국휴장 시, 익 영업일로 이전   (미국예약주문화면에서 취소 가능)2) 증거금 및 잔고보유 : 체크 안함3) 주문전송 불가사유 - 매수증거금 부족: 수수료 포함 매수금액부족, 환전, 시세이용료 출금, 인출에 의한 증거금 부족 - 기타 매수증거금 부족, 매도가능수량 부족, 주권변경 등 권리발생으로 인한 주문불가사유 발생4) 지정가주문만 가능* 단 미국 예약매도주문(TTTT3016U)의 경우, MOO(장개시시장가)로 주문 접수 가능
    struct orderresv : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 매도매수구분코드
            /// tr_id가 TTTS3013U(중국/홍콩/일본/베트남 예약 주문)인 경우만 사용 01 : 매도 02 : 매수
            let SLL_BUY_DVSN_CD:String?
            /// 정정취소구분코드
            /// tr_id가 TTTS3013U(중국/홍콩/일본/베트남 예약 주문)인 경우만 사용 00 : "매도/매수 주문"시 필수 항목 02 : 취소
            let RVSE_CNCL_DVSN_CD:String
            /// 상품번호
            let PDNO:String
            /// 상품유형코드
            /// tr_id가 TTTS3013U(중국/홍콩/일본/베트남 예약 주문)인 경우만 사용 515 : 일본 501 : 홍콩 / 543 : 홍콩CNY / 558 : 홍콩USD 507 : 베트남 하노이거래소 / 508 : 베트남 호치민거래소 551 : 중국 상해A / 552 : 중국 심천A
            let PRDT_TYPE_CD:String
            /// 해외거래소코드
            /// NASD : 나스닥 NYSE : 뉴욕 AMEX : 아멕스 SEHK : 홍콩 SHAA : 중국상해 SZAA : 중국심천 TKSE : 일본 HASE : 베트남 하노이 VNSE : 베트남 호치민
            let OVRS_EXCG_CD:String
            /// FT주문수량
            let FT_ORD_QTY:String
            /// FT주문단가3
            let FT_ORD_UNPR3:String
            /// 주문서버구분코드
            /// "0"(Default)
            let ORD_SVR_DVSN_CD:String?
            /// 예약주문접수일자
            /// tr_id가 TTTS3013U(중국/홍콩/일본/베트남 예약 주문)인 경우만 사용
            let RSVN_ORD_RCIT_DT:String?
            /// 주문구분
            /// tr_id가 TTTT3016U(미국 예약 매도 주문)인 경우만 사용 00 : 지정가 31 : MOO(장개시시장가)
            let ORD_DVSN:String?
            /// 해외예약주문번호
            /// tr_id가 TTTS3013U(중국/홍콩/일본/베트남 예약 주문)인 경우만 사용
            let OVRS_RSVN_ODNO:String?
        }
        public struct Response : Codable {
            /// 성공 실패 여부
            /// 0 : 성공 0 이외의 값 : 실패
            let rt_cd:String
            /// 응답코드
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            /// 응답메세지
            let msg1:String
            /// 응답상세 : Object
            let output:Output
        }
        public struct Output : Codable {
            /// 한국거래소전송주문조직번호
            /// tr_id가 TTTT3016U(미국 예약 매도 주문) / TTTT3014U(미국 예약 매수 주문)인 경우만 출력
            let ODNO:String
            /// 예약주문접수일자
            /// tr_id가 TTTS3013U(중국/홍콩/일본/베트남 예약 주문)인 경우만 출력
            let RSVN_ORD_RCIT_DT:String
            /// 해외예약주문번호
            /// tr_id가 TTTS3013U(중국/홍콩/일본/베트남 예약 주문)인 경우만 출력
            let OVRS_RSVN_ODNO:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/trading/order-resv"
        public var header: [String : String]
        // [실전투자] TTTT3016U : 미국 매도 예약 주문 TTTT3014U : 미국 매수 예약 주문 TTTS3013U : 중국/홍콩/일본/베트남 예약 매수/매도/취소 주문 [모의투자] VTTT3016U : 미국 매도 예약 주문 VTTT3014U : 미국 매수 예약 주문 VTTS3013U : 중국/홍콩/일본/베트남 예약 매수/매도/취소 주문
        enum TR_ID: String {
            case 실전투자_미국_매도_예약 = "TTTT3016U"
            case 실전투자_미국_매수_예약 = "TTTT3014U"
            case 실전투자_중국홍콩일본베트남_예약 = "TTTS3013U"
            case 모의투자_미국_매도_예약 = "VTTT3016U"
            case 모의투자_미국_매수_예약 = "VTTT3014U"
            case 모의투자_중국홍콩일본베트남_예약 = "VTTS3013U"
        }
        init(tr_id: TR_ID, gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] TTTT3016U : 미국 매도 예약 주문 TTTT3014U : 미국 매수 예약 주문 TTTS3013U : 중국/홍콩/일본/베트남 예약 매수/매도/취소 주문 [모의투자] VTTT3016U : 미국 매도 예약 주문 VTTT3014U : 미국 매수 예약 주문 VTTS3013U : 중국/홍콩/일본/베트남 예약 매수/매도/취소 주문
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // ※ 필수 아님 (기존 필수 사항으로 옵션으로 유지) [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.header["authorization"] = await KISManager.getAccessToken()?.token
            self.header["gt_uid"] = gt_uid
            self.header["Content-Type"] = "application/json; charset=UTF-8"
            self.header["tr_id"] = tr_id.rawValue
        }
    }

    /// 해외주식 예약주문접수취소[v1_해외주식-004]
    /// 접수된 미국주식 예약주문을 취소하기 위한 API입니다.(해외주식 예약주문접수 시 Return 받은 ODNO를 참고하여 API를 호출하세요.)* 해외주식 서비스 신청 후 이용 가능합니다. (아래 링크 3번 해외증권 거래신청 참고)https://securities.koreainvestment.com/main/bond/research/_static/TF03ca010001.jsp※ POST API의 경우 BODY값의 key값들을 대문자로 작성하셔야 합니다.   (EX. "CANO" : "12345678", "ACNT_PRDT_CD": "01",...)
    struct orderresvccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 해외주문접수일자
            let RSYN_ORD_RCIT_DT:String
            /// 해외예약주문번호
            /// 해외주식_예약주문접수 API Output ODNO(주문번호) 참고
            let OVRS_RSVN_ODNO:String
        }
        public struct Response : Codable {
            /// 성공 실패 여부
            /// 0 : 성공 0 이외의 값 : 실패
            let rt_cd:String
            /// 응답코드
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            /// 응답메세지
            let msg1:String
            /// 응답상세 : Object
            let output:Output
        }
        public struct Output : Codable {
            /// 해외예약주문번호
            let OVRS_RSVN_ODNO:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/trading/order-resv-ccnl"
        public var header: [String : String]
        init(gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] TTTT3017U : 미국예약주문접수 취소 [모의투자] VTTT3017U : 미국예약주문접수 취소 (일본, 홍콩 등 타국가 개발 진행 예정)
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // ※ 필수 아님 (기존 필수 사항으로 옵션으로 유지) [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.header["authorization"] = await KISManager.getAccessToken()?.token
            self.header["gt_uid"] = gt_uid
            self.header["Content-Type"] = "application/json; charset=UTF-8"
            self.header["tr_id"] = KISManager.getValueForCurrentTargetServer(실전서버: "TTTT3017U", 모의투자서버: "VTTT3017U")
        }
    }

    /// 해외주식 미체결내역[v1_해외주식-005]
    /// 접수된 해외주식 주문 중 체결되지 않은 미체결 내역을 조회하는 API입니다.실전계좌의 경우, 한 번의 호출에 최대 40건까지 확인 가능하며, 이후의 값은 연속조회를 통해 확인하실 수 있습니다. ※ 해외주식 미체결내역 API 모의투자에서는 사용이 불가합니다.    모의투자로 해외주식 미체결내역 확인시에는 해외주식 주문체결내역[v1_해외주식-007] API 조회하셔서 nccs_qty(미체결수량)으로 해외주식 미체결수량을 조회하실 수 있습니다.* 해외주식 서비스 신청 후 이용 가능합니다. (아래 링크 3번 해외증권 거래신청 참고)https://securities.koreainvestment.com/main/bond/research/_static/TF03ca010001.jsp* 해외 거래소 운영시간(한국시간 기준)1) 미국 : 23:30 ~ 06:00 (썸머타임 적용 시 22:30 ~ 05:00)    * 프리마켓(18:00 ~ 23:30, Summer Time : 17:00 ~ 22:30), 애프터마켓(06:00 ~ 07:00, Summer Time : 05:00 ~ 07:00)2) 일본 : (오전) 09:00 ~ 11:30, (오후) 12:30 ~ 15:003) 상해 : 10:30 ~ 16:004) 홍콩 : (오전) 10:30 ~ 13:00, (오후) 14:00 ~ 17:00
    struct inquirenccs : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 해외거래소코드
            /// NASD : 나스닥 NYSE : 뉴욕 AMEX : 아멕스 SEHK : 홍콩 SHAA : 중국상해 SZAA : 중국심천 TKSE : 일본 HASE : 베트남 하노이 VNSE : 베트남 호치민 * NASD 인 경우만 미국전체로 조회되며 나머지 거래소 코드는 해당 거래소만 조회됨 * 공백 입력 시 다음조회가 불가능하므로, 반드시 거래소코드 입력해야 함
            let OVRS_EXCG_CD:String
            /// 정렬순서
            /// DS : 정순 그외 : 역순 [header tr_id: TTTS3018R] ""(공란)
            let SORT_SQN:String
            /// 연속조회검색조건200
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_FK200값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_FK200:String
            /// 연속조회키200
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_NK200값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_NK200:String
        }
        public struct Response : Codable {
            /// 성공 실패 여부
            /// 0 : 성공 0 이외의 값 : 실패
            let rt_cd:String
            /// 응답코드
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            /// 응답메세지
            let msg1:String
            /// 응답상세 : Array
            let output:[Output]
        }
        public struct Output : Codable {
            /// 주문일자
            /// 주문접수 일자
            let ord_dt:String
            /// 주문채번지점번호
            /// 계좌 개설 시 관리점으로 선택한 영업점의 고유번호
            let ord_gno_brno:String
            /// 주문번호
            /// 접수한 주문의 일련번호
            let odno:String
            /// 원주문번호
            /// 정정 또는 취소 대상 주문의 일련번호
            let orgn_odno:String
            /// 상품번호
            /// 종목코드
            let pdno:String
            /// 상품명
            /// 종목명
            let prdt_name:String
            /// 매도매수구분코드
            /// 01 : 매도 02 : 매수
            let sll_buy_dvsn_cd:String
            /// 매도매수구분코드명
            /// 매수매도구분명
            let sll_buy_dvsn_cd_name:String
            /// 정정취소구분코드
            /// 01 : 정정 02 : 취소
            let rvse_cncl_dvsn_cd:String
            /// 정정취소구분코드명
            /// 정정취소구분명
            let rvse_cncl_dvsn_cd_name:String
            /// 거부사유
            /// 정상 처리되지 못하고 거부된 주문의 사유
            let rjct_rson:String
            /// 거부사유명
            /// 정상 처리되지 못하고 거부된 주문의 사유명
            let rjct_rson_name:String
            /// 주문시각
            /// 주문 접수 시간
            let ord_tmd:String
            /// 거래시장명
            let tr_mket_name:String
            /// 거래통화코드
            /// USD : 미국달러 HKD : 홍콩달러 CNY : 중국위안화 JPY : 일본엔화 VND : 베트남동
            let tr_crcy_cd:String
            /// 국가코드
            let natn_cd:String
            /// 국가한글명
            let natn_kor_name:String
            /// FT주문수량
            /// 주문수량
            let ft_ord_qty:String
            /// FT체결수량
            /// 체결된 수량
            let ft_ccld_qty:String
            /// 미체결수량
            /// 미체결수량
            let nccs_qty:String
            /// FT주문단가3
            /// 주문가격
            let ft_ord_unpr3:String
            /// FT체결단가3
            /// 체결된 가격
            let ft_ccld_unpr3:String
            /// FT체결금액3
            /// 체결된 금액
            let ft_ccld_amt3:String
            /// 해외거래소코드
            /// NASD : 나스닥 NYSE : 뉴욕 AMEX : 아멕스 SEHK : 홍콩 SHAA : 중국상해 SZAA : 중국심천 TKSE : 일본 HASE : 베트남 하노이 VNSE : 베트남 호치민
            let ovrs_excg_cd:String
            /// 처리상태명
            /// ""
            let prcs_stat_name:String
            /// 대출유형코드
            /// 00 해당사항없음 01 자기융자일반형 03 자기융자투자형 05 유통융자일반형 06 유통융자투자형 07 자기대주 09 유통대주 10 현금 11 주식담보대출 12 수익증권담보대출 13 ELS담보대출 14 채권담보대출 15 해외주식담보대출 16 기업신용공여 31 소액자동담보대출 41 매도담보대출 42 환매자금대출 43 매입환매자금대출 44 대여매도담보대출 81 대차거래 82 법인CMA론 91 공모주청약자금대출 92 매입자금 93 미수론서비스 94 대여
            let loan_type_cd:String
            /// 대출일자
            /// 대출 실행일자
            let loan_dt:String
            /// 미국애프터마켓연장신청여부
            /// Y/N
            let usa_amk_exts_rqst_yn:String
            /// 연속조회검색조건200
            let ctx_area_fk200:String
            /// 연속조회키200
            let ctx_area_nk200:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/trading/inquire-nccs"
        public var header: [String : String]
        init(tr_id: String = "TTTS3018R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, Oauth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] TTTS3018R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.header["authorization"] = await KISManager.getAccessToken()?.token
            self.header["gt_uid"] = gt_uid
            self.header["tr_id"] = tr_id
        }
    }

    /// 해외주식 잔고[v1_해외주식-006]
    /// 해외주식 잔고를 조회하는 API 입니다.한국투자 HTS(eFriend Plus) > [7600] 해외주식 종합주문 화면의 좌측 하단 '실시간잔고' 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다. 다만 미국주간거래 가능종목에 대해서는 frcr_evlu_pfls_amt(외화평가손익금액), evlu_pfls_rt(평가손익율), ovrs_stck_evlu_amt(해외주식평가금액), now_pric2(현재가격2) 값이 HTS와는 상이하게 표출될 수 있습니다.(주간시간 시간대에 HTS는 주간시세로 노출, API로는 야간시세로 노출)실전계좌의 경우, 한 번의 호출에 최대 100건까지 확인 가능하며, 이후의 값은 연속조회를 통해 확인하실 수 있습니다. * 해외주식 서비스 신청 후 이용 가능합니다. (아래 링크 3번 해외증권 거래신청 참고)https://securities.koreainvestment.com/main/bond/research/_static/TF03ca010001.jsp* 미니스탁 잔고는 해당 API로 확인이 불가합니다.
    struct inquirebalance : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 해외거래소코드
            /// [모의] NASD : 나스닥 NYSE : 뉴욕 AMEX : 아멕스 [실전] NASD : 미국전체 NAS : 나스닥 NYSE : 뉴욕 AMEX : 아멕스 [모의/실전 공통] SEHK : 홍콩 SHAA : 중국상해 SZAA : 중국심천 TKSE : 일본 HASE : 베트남 하노이 VNSE : 베트남 호치민
            let OVRS_EXCG_CD:String
            /// 거래통화코드
            /// USD : 미국달러 HKD : 홍콩달러 CNY : 중국위안화 JPY : 일본엔화 VND : 베트남동
            let TR_CRCY_CD:String
            /// 연속조회검색조건200
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_FK200값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_FK200:String
            /// 연속조회키200
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_NK200값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_NK200:String
        }
        public struct Response : Codable {
            /// 성공 실패 여부
            /// 0 : 성공 0 이외의 값 : 실패
            let rt_cd:String
            /// 응답코드
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            /// 응답메세지
            let msg1:String
            /// 연속조회검색조건200
            let ctx_area_fk200:String
            /// 연속조회키200
            let ctx_area_nk200:String
            /// 응답상세1 : Array
            let output1:[Output1]
            /// 응답상세2 : Object
            let output2:Output2
        }
        public struct Output1 : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            let cano:String
            /// 계좌상품코드
            /// 계좌상품코드
            let acnt_prdt_cd:String
            /// 상품유형코드
            let prdt_type_cd:String
            /// 해외상품번호
            let ovrs_pdno:String
            /// 해외종목명
            let ovrs_item_name:String
            /// 외화평가손익금액
            /// 해당 종목의 매입금액과 평가금액의 외회기준 비교 손익
            let frcr_evlu_pfls_amt:String
            /// 평가손익율
            /// 해당 종목의 평가손익을 기준으로 한 수익률
            let evlu_pfls_rt:String
            /// 매입평균가격
            /// 해당 종목의 매수 평균 단가
            let pchs_avg_pric:String
            /// 해외잔고수량
            let ovrs_cblc_qty:String
            /// 주문가능수량
            /// 매도 가능한 주문 수량
            let ord_psbl_qty:String
            /// 외화매입금액1
            /// 해당 종목의 외화 기준 매입금액
            let frcr_pchs_amt1:String
            /// 해외주식평가금액
            /// 해당 종목의 외화 기준 평가금액
            let ovrs_stck_evlu_amt:String
            /// 현재가격2
            /// 해당 종목의 현재가
            let now_pric2:String
            /// 거래통화코드
            /// USD : 미국달러 HKD : 홍콩달러 CNY : 중국위안화 JPY : 일본엔화 VND : 베트남동
            let tr_crcy_cd:String
            /// 해외거래소코드
            /// NASD : 나스닥 NYSE : 뉴욕 AMEX : 아멕스 SEHK : 홍콩 SHAA : 중국상해 SZAA : 중국심천 TKSE : 일본 HASE : 하노이거래소 VNSE : 호치민거래소
            let ovrs_excg_cd:String
            /// 대출유형코드
            /// 00 : 해당사항없음 01 : 자기융자일반형 03 : 자기융자투자형 05 : 유통융자일반형 06 : 유통융자투자형 07 : 자기대주 09 : 유통대주 10 : 현금 11 : 주식담보대출 12 : 수익증권담보대출 13 : ELS담보대출 14 : 채권담보대출 15 : 해외주식담보대출 16 : 기업신용공여 31 : 소액자동담보대출 41 : 매도담보대출 42 : 환매자금대출 43 : 매입환매자금대출 44 : 대여매도담보대출 81 : 대차거래 82 : 법인CMA론 91 : 공모주청약자금대출 92 : 매입자금 93 : 미수론서비스 94 : 대여
            let loan_type_cd:String
            /// 대출일자
            /// 대출 실행일자
            let loan_dt:String
            /// 만기일자
            /// 대출 만기일자
            let expd_dt:String
        }
        public struct Output2 : Codable {
            /// 외화매입금액1
            let frcr_pchs_amt1:String
            /// 해외실현손익금액
            let ovrs_rlzt_pfls_amt:String
            /// 해외총손익
            let ovrs_tot_pfls:String
            /// 실현수익율
            let rlzt_erng_rt:String
            /// 총평가손익금액
            let tot_evlu_pfls_amt:String
            /// 총수익률
            let tot_pftrt:String
            /// 외화매수금액합계1
            let frcr_buy_amt_smtl1:String
            /// 해외실현손익금액2
            let ovrs_rlzt_pfls_amt2:String
            /// 외화매수금액합계2
            let frcr_buy_amt_smtl2:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/trading/inquire-balance"
        public var header: [String : String]
        init(gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, Oauth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] TTTS3012R [모의투자] VTTS3012R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // ※ 필수 아님
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.header["authorization"] = await KISManager.getAccessToken()?.token
            self.header["gt_uid"] = gt_uid
            self.header["tr_id"] = KISManager.getValueForCurrentTargetServer(실전서버: "TTTS3012R", 모의투자서버: "VTTS3012R")
        }
    }

    /// 해외주식 주문체결내역[v1_해외주식-007]
    /// 일정 기간의 해외주식 주문 체결 내역을 확인하는 API입니다.실전계좌의 경우, 한 번의 호출에 최대 20건까지 확인 가능하며, 이후의 값은 연속조회를 통해 확인하실 수 있습니다. 모의계좌의 경우, 한 번의 호출에 최대 15건까지 확인 가능하며, 이후의 값은 연속조회를 통해 확인하실 수 있습니다. * 해외주식 서비스 신청 후 이용 가능합니다. (아래 링크 3번 해외증권 거래신청 참고)https://securities.koreainvestment.com/main/bond/research/_static/TF03ca010001.jsp* 해외 거래소 운영시간(한국시간 기준)1) 미국 : 23:30 ~ 06:00 (썸머타임 적용 시 22:30 ~ 05:00)    * 프리마켓(18:00 ~ 23:30, Summer Time : 17:00 ~ 22:30), 애프터마켓(06:00 ~ 07:00, Summer Time : 05:00 ~ 07:00)2) 일본 : (오전) 09:00 ~ 11:30, (오후) 12:30 ~ 15:003) 상해 : 10:30 ~ 16:004) 홍콩 : (오전) 10:30 ~ 13:00, (오후) 14:00 ~ 17:00
    struct inquireccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 상품번호
            /// 전종목일 경우 "%" 입력 ※ 모의투자계좌의 경우 ""(전체 조회)만 가능
            let PDNO:String
            /// 주문시작일자
            /// YYYYMMDD 형식 (현지시각 기준)
            let ORD_STRT_DT:String
            /// 주문종료일자
            /// YYYYMMDD 형식 (현지시각 기준)
            let ORD_END_DT:String
            /// 매도매수구분
            /// 00 : 전체 01 : 매도 02 : 매수 ※ 모의투자계좌의 경우 "00"(전체 조회)만 가능
            let SLL_BUY_DVSN:String
            /// 체결미체결구분
            /// 00 : 전체 01 : 체결 02 : 미체결 ※ 모의투자계좌의 경우 "00"(전체 조회)만 가능
            let CCLD_NCCS_DVSN:String
            /// 해외거래소코드
            /// 전종목일 경우 "%" 입력 NASD : 미국시장 전체(나스닥, 뉴욕, 아멕스) NYSE : 뉴욕 AMEX : 아멕스 SEHK : 홍콩 SHAA : 중국상해 SZAA : 중국심천 TKSE : 일본 HASE : 베트남 하노이 VNSE : 베트남 호치민 ※ 모의투자계좌의 경우 ""(전체 조회)만 가능
            let OVRS_EXCG_CD:String
            /// 정렬순서
            /// DS : 정순 AS : 역순 ※ 모의투자계좌의 경우 정렬순서 사용불가(Default : DS(정순))
            let SORT_SQN:String
            /// 주문일자
            /// "" (Null 값 설정)
            let ORD_DT:String
            /// 주문채번지점번호
            /// "" (Null 값 설정)
            let ORD_GNO_BRNO:String
            /// 주문번호
            /// "" (Null 값 설정) ※ 주문번호로 검색 불가능합니다. 반드시 ""(Null 값 설정) 바랍니다.
            let ODNO:String
            /// 연속조회키200
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_NK200값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_NK200:String
            /// 연속조회검색조건200
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_FK200값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_FK200:String
        }
        public struct Response : Codable {
            /// 성공 실패 여부
            /// 0 : 성공 0 이외의 값 : 실패
            let rt_cd:String
            /// 응답코드
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            /// 응답메세지
            let msg1:String
            /// 연속조회검색조건200
            let ctx_area_fk200:String
            /// 연속조회키200
            let ctx_area_nk200:String
            /// 응답상세 : Array
            let output:[Output]
        }
        public struct Output : Codable {
            /// 주문일자
            /// 주문접수 일자 (현지시각 기준)
            let ord_dt:String
            /// 주문채번지점번호
            /// 계좌 개설 시 관리점으로 선택한 영업점의 고유번호
            let ord_gno_brno:String
            /// 주문번호
            /// 접수한 주문의 일련번호 ※ 정정취소주문 시, 해당 값 odno(주문번호) 넣어서 사용
            let odno:String
            /// 원주문번호
            /// 정정 또는 취소 대상 주문의 일련번호
            let orgn_odno:String
            /// 매도매수구분코드
            /// 01 : 매도 02 : 매수
            let sll_buy_dvsn_cd:String
            /// 매도매수구분코드명
            let sll_buy_dvsn_cd_name:String
            /// 정정취소구분
            /// 01 : 정정 02 : 취소
            let rvse_cncl_dvsn:String
            /// 정정취소구분명
            let rvse_cncl_dvsn_name:String
            /// 상품번호
            let pdno:String
            /// 상품명
            let prdt_name:String
            /// FT주문수량
            /// 주문수량
            let ft_ord_qty:String
            /// FT주문단가3
            /// 주문가격
            let ft_ord_unpr3:String
            /// FT체결수량
            /// 체결된 수량
            let ft_ccld_qty:String
            /// FT체결단가3
            /// 체결된 가격
            let ft_ccld_unpr3:String
            /// FT체결금액3
            /// 체결된 금액
            let ft_ccld_amt3:String
            /// 미체결수량
            /// 미체결수량
            let nccs_qty:String
            /// 처리상태명
            /// 완료, 거부, 전송
            let prcs_stat_name:String
            /// 거부사유
            /// 정상 처리되지 못하고 거부된 주문의 사유
            let rjct_rson:String
            /// 주문시각
            /// 주문 접수 시간
            let ord_tmd:String
            /// 거래시장명
            let tr_mket_name:String
            /// 거래국가
            let tr_natn:String
            /// 거래국가명
            let tr_natn_name:String
            /// 해외거래소코드
            /// NASD : 나스닥 NYSE : 뉴욕 AMEX : 아멕스 SEHK : 홍콩 SHAA : 중국상해 SZAA : 중국심천 TKSE : 일본 HASE : 베트남 하노이 VNSE : 베트남 호치민
            let ovrs_excg_cd:String
            /// 거래통화코드
            let tr_crcy_cd:String
            /// 국내주문일자
            let dmst_ord_dt:String
            /// 당사주문시각
            let thco_ord_tmd:String
            /// 대출유형코드
            /// 00 : 해당사항없음 01 : 자기융자일반형 03 : 자기융자투자형 05 : 유통융자일반형 06 : 유통융자투자형 07 : 자기대주 09 : 유통대주 10 : 현금 11 : 주식담보대출 12 : 수익증권담보대출 13 : ELS담보대출 14 : 채권담보대출 15 : 해외주식담보대출 16 : 기업신용공여 31 : 소액자동담보대출 41 : 매도담보대출 42 : 환매자금대출 43 : 매입환매자금대출 44 : 대여매도담보대출 81 : 대차거래 82 : 법인CMA론 91 : 공모주청약자금대출 92 : 매입자금 93 : 미수론서비스 94 : 대여
            let loan_type_cd:String
            /// 매체구분명
            /// ex) OpenAPI, 모바일
            let mdia_dvsn_name:String
            /// 대출일자
            let loan_dt:String
            /// 거부사유명
            let rjct_rson_name:String
            /// 미국애프터마켓연장신청여부
            /// Y/N
            let usa_amk_exts_rqst_yn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/trading/inquire-ccnl"
        public var header: [String : String]
        init(gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] TTTS3035R [모의투자] VTTS3035R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.header["authorization"] = await KISManager.getAccessToken()?.token
            self.header["gt_uid"] = gt_uid
            self.header["Content-Type"] = "application/json; charset=utf-8"
            self.header["tr_id"] = KISManager.getValueForCurrentTargetServer(실전서버: "TTTS3035R", 모의투자서버: "VTTS3035R")
        }
    }

    /// 해외주식 체결기준현재잔고[v1_해외주식-008]
    /// 해외주식 잔고를 체결 기준으로 확인하는 API 입니다. HTS(eFriend Plus) [0839] 해외 체결기준잔고 화면을 API로 구현한 사항으로 화면을 함께 보시면 기능 이해가 쉽습니다.(※모의계좌의 경우 output3(외화평가총액 등 확인 가능)만 정상 출력됩니다. 잔고 확인을 원하실 경우에는 해외주식 잔고[v1_해외주식-006] API 사용을 부탁드립니다.)* 해외주식 서비스 신청 후 이용 가능합니다. (아래 링크 3번 해외증권 거래신청 참고)https://securities.koreainvestment.com/main/bond/research/_static/TF03ca010001.jsp해외주식 체결기준현재잔고 유의사항1. 해외증권 체결기준 잔고현황을 조회하는 화면입니다.2. 온라인국가는 수수료(국내/해외)가 반영된 최종 정산금액으로 잔고가 변동되며, 결제작업 지연등으로 인해 조회시간은 차이가 발생할 수 있습니다.   - 아시아 온라인국가 : 매매일 익일    08:40 ~ 08:45분 경   - 미국 온라인국가   : 당일 장 종료후 08:40 ~ 08:45분 경  ※ 단, 애프터연장 참여 신청계좌는 10:30 ~ 10:35분 경(Summer Time : 09:30 ~ 09:35분 경)에 최종 정산금액으로 변동됩니다.3. 미국 현재가 항목은 주간시세 및 애프터시세는 반영하지 않으며, 정규장 마감 후에는 종가로 조회됩니다.4. 온라인국가를 제외한 국가의 현재가는 실시간 시세가 아니므로 주문화면의 잔고 평가금액 등과 차이가 발생할 수 있습니다.5. 해외주식 담보대출 매도상환 체결내역은 해당 잔고화면에 반영되지 않습니다.   결제가 완료된 이후 외화잔고에 포함되어 반영되오니 참고하여 주시기 바랍니다.6. 외화평가금액은 당일 최초고시환율이 적용된 금액으로 실제 환전금액과는 차이가 있습니다. 7. 미국은 메인 시스템이 아닌 별도 시스템을 통해 거래되므로, 18시 10~15분 이후 발생하는 미국 매매내역은 해당 화면에 실시간으로 반영되지 않으니 하단 내용을 참고하여 안내하여 주시기 바랍니다.    [외화잔고 및 해외 유가증권 현황 조회]   - 일반/통합증거금 계좌 : 미국장 종료 + 30분 후 부터 조회 가능                            단, 통합증거금 계좌에 한해 주문금액은 외화잔고 항목에 실시간 반영되며, 해외 유가증권 현황은 반영되지                            않아 해외 유가증권 평가금액이 과다 또는 과소 평가될 수 있습니다.    - 애프터연장 신청계좌  : 실시간 반영                             단, 시스템정산작업시간(23:40~00:10) 및 거래량이 많은 경우 메인시스템에 반영되는 시간으로 인해 차이가                             발생할 수 있습니다.   ※ 배치작업시간에 따라 시간은 변동될 수 있습니다.
    struct inquirepresentbalance : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 원화외화구분코드
            /// 01 : 원화 02 : 외화
            let WCRC_FRCR_DVSN_CD:String
            /// 국가코드
            /// 000 전체 840 미국 344 홍콩 156 중국 392 일본 704 베트남
            let NATN_CD:String
            /// 거래시장코드
            /// [Request body NATN_CD 000 설정] 00 : 전체 [Request body NATN_CD 840 설정] 00 : 전체 01 : 나스닥(NASD) 02 : 뉴욕거래소(NYSE) 03 : 미국(PINK SHEETS) 04 : 미국(OTCBB) 05 : 아멕스(AMEX) [Request body NATN_CD 156 설정] 00 : 전체 01 : 상해B 02 : 심천B 03 : 상해A 04 : 심천A [Request body NATN_CD 392 설정] 01 : 일본 [Request body NATN_CD 704 설정] 01 : 하노이거래 02 : 호치민거래소 [Request body NATN_CD 344 설정] 01 : 홍콩 02 : 홍콩CNY 03 : 홍콩USD
            let TR_MKET_CD:String
            /// 조회구분코드
            /// 00 : 전체 01 : 일반해외주식 02 : 미니스탁
            let INQR_DVSN_CD:String
        }
        public struct Response : Codable {
            /// 성공 실패 여부
            /// 0 : 성공 0 이외의 값 : 실패
            let rt_cd:String
            /// 응답코드
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            /// 응답메세지
            let msg1:String
            /// 응답상세1 (체결기준 잔고) : Array
            /// 체결기준현재잔고 없으면 빈값으로 출력
            let output1:[Output1]
            /// 응답상세2 : Array
            let output2:[Output2]
            /// 응답상세3 : Object
            let output3:Output3
        }
        public struct Output1 : Codable {
            /// 상품명
            /// 종목명
            let prdt_name:String
            /// 잔고수량13
            /// 결제보유수량
            let cblc_qty13:String
            /// 당일매수체결수량1
            /// 당일 매수 체결 완료 수량
            let thdt_buy_ccld_qty1:String
            /// 당일매도체결수량1
            /// 당일 매도 체결 완료 수량
            let thdt_sll_ccld_qty1:String
            /// 체결수량합계1
            /// 체결기준 현재 보유수량
            let ccld_qty_smtl1:String
            /// 주문가능수량1
            /// 주문 가능한 주문 수량
            let ord_psbl_qty1:String
            /// 외화매입금액
            /// 해당 종목의 외화 기준 매입금액
            let frcr_pchs_amt:String
            /// 외화평가금액2
            /// 해당 종목의 외화 기준 평가금액
            let frcr_evlu_amt2:String
            /// 평가손익금액2
            /// 해당 종목의 매입금액과 평가금액의 외회기준 비교 손익
            let evlu_pfls_amt2:String
            /// 평가손익율1
            /// 해당 종목의 평가손익을 기준으로 한 수익률
            let evlu_pfls_rt1:String
            /// 상품번호
            /// 종목코드
            let pdno:String
            /// 기준환율
            /// 원화 평가 시 적용 환율
            let bass_exrt:String
            /// 매수통화코드
            /// USD : 미국달러 HKD : 홍콩달러 CNY : 중국위안화 JPY : 일본엔화 VND : 베트남동
            let buy_crcy_cd:String
            /// 해외현재가격1
            /// 해당 종목의 현재가
            let ovrs_now_pric1:String
            /// 평균단가3
            /// 해당 종목의 매수 평균 단가
            let avg_unpr3:String
            /// 거래시장명
            /// 해당 종목의 거래시장명
            let tr_mket_name:String
            /// 국가한글명
            /// 거래 국가명
            let natn_kor_name:String
            /// 매입잔액원화금액
            let pchs_rmnd_wcrc_amt:String
            /// 당일매수체결외화금액
            /// 당일 매수 외화금액 (Type: Object X String O)
            let thdt_buy_ccld_frcr_amt:String
            /// 당일매도체결외화금액
            /// 당일 매도 외화금액
            let thdt_sll_ccld_frcr_amt:String
            /// 단위금액
            let unit_amt:String
            /// 표준상품번호
            let std_pdno:String
            /// 상품유형코드
            let prdt_type_cd:String
            /// 유가증권구분명
            let scts_dvsn_name:String
            /// 대출잔액
            /// 대출 미상환 금액
            let loan_rmnd:String
            /// 대출일자
            /// 대출 실행일자
            let loan_dt:String
            /// 대출만기일자
            /// 대출 만기일자
            let loan_expd_dt:String
            /// 해외거래소코드
            /// NASD : 나스닥 NYSE : 뉴욕 AMEX : 아멕스 SEHK : 홍콩 SHAA : 중국상해 SZAA : 중국심천 TKSE : 일본 HASE : 하노이거래소 VNSE : 호치민거래소
            let ovrs_excg_cd:String
            /// 종목연동거래소코드
            /// prdt_dvsn(상품구분) : 직원용 데이터(Type: String, Length:2)
            let item_lnkg_excg_cd:String
        }
        public struct Output2 : Codable {
            /// 통화코드
            let crcy_cd:String
            /// 통화코드명
            let crcy_cd_name:String
            /// 외화매수금액합계
            /// 해당 통화로 매수한 종목 전체의 매수금액
            let frcr_buy_amt_smtl:String
            /// 외화매도금액합계
            /// 해당 통화로 매도한 종목 전체의 매수금액
            let frcr_sll_amt_smtl:String
            /// 외화예수금액2
            /// 외화로 표시된 외화사용가능금액
            let frcr_dncl_amt_2:String
            /// 최초고시환율
            let frst_bltn_exrt:String
            /// 외화매수증거금액
            /// 매수증거금으로 사용된 외화금액
            let frcr_buy_mgn_amt:String
            /// 외화기타증거금
            let frcr_etc_mgna:String
            /// 외화출금가능금액1
            /// 출금가능한 외화금액
            let frcr_drwg_psbl_amt_1:String
            /// 출금가능원화금액
            /// 출금가능한 원화금액
            let frcr_evlu_amt2:String
            /// 현지보관통화여부
            let acpl_cstd_crcy_yn:String
            /// 익일외화출금가능금액
            let nxdy_frcr_drwg_psbl_amt:String
        }
        public struct Output3 : Codable {
            /// 매입금액합계
            /// 해외유가증권 매수금액의 원화 환산 금액
            let pchs_amt_smtl:String
            /// 평가금액합계
            /// 해외유가증권 평가금액의 원화 환산 금액
            let evlu_amt_smtl:String
            /// 평가손익금액합계
            /// 해외유가증권 평가손익의 원화 환산 금액
            let evlu_pfls_amt_smtl:String
            /// 예수금액
            let dncl_amt:String
            /// CMA평가금액
            let cma_evlu_amt:String
            /// 총예수금액
            let tot_dncl_amt:String
            /// 기타증거금
            let etc_mgna:String
            /// 인출가능총금액
            let wdrw_psbl_tot_amt:String
            /// 외화평가총액
            let frcr_evlu_tota:String
            /// 평가수익율1
            let evlu_erng_rt1:String
            /// 매입금액합계금액
            let pchs_amt_smtl_amt:String
            /// 평가금액합계금액
            let evlu_amt_smtl_amt:String
            /// 총평가손익금액
            let tot_evlu_pfls_amt:String
            /// 총자산금액
            let tot_asst_amt:String
            /// 매수증거금액
            let buy_mgn_amt:String
            /// 증거금총액
            let mgna_tota:String
            /// 외화사용가능금액
            let frcr_use_psbl_amt:String
            /// 미결제매도금액합계
            let ustl_sll_amt_smtl:String
            /// 미결제매수금액합계
            let ustl_buy_amt_smtl:String
            /// 총외화잔고합계
            let tot_frcr_cblc_smtl:String
            /// 총대출금액
            let tot_loan_amt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/trading/inquire-present-balance"
        public var header: [String : String]
        init(gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, Oauth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] CTRP6504R [모의투자] VTRP6504R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.header["authorization"] = await KISManager.getAccessToken()?.token
            self.header["gt_uid"] = gt_uid
            self.header["tr_id"] = KISManager.getValueForCurrentTargetServer(실전서버: "CTRP6504R", 모의투자서버: "VTRP6504R")
        }
    }

    /// 해외주식 예약주문조회[v1_해외주식-013]
    /// 해외주식 예약주문 조회 API입니다.※ 모의투자는 사용 불가합니다.* 해외주식 서비스 신청 후 이용 가능합니다. (아래 링크 3번 해외증권 거래신청 참고)https://securities.koreainvestment.com/main/bond/research/_static/TF03ca010001.jsp
    struct orderresvlist : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 조회시작일자
            /// 조회시작일자(YYYYMMDD)
            let INQR_STRT_DT:String
            /// 조회종료일자
            /// 조회종료일자(YYYYMMDD)
            let INQR_END_DT:String
            /// 조회구분코드
            /// 00 : 전체 01 : 일반해외주식 02 : 미니스탁
            let INQR_DVSN_CD:String
            /// 상품유형코드
            /// [tr_id=TTTT3039R인 경우] 공백 입력 시 미국주식 전체조회 [tr_id=TTTS3014R인 경우] 공백 입력 시 아시아주식 전체조회 512 : 미국 나스닥 / 513 : 미국 뉴욕거래소 / 529 : 미국 아멕스 515 : 일본 501 : 홍콩 / 543 : 홍콩CNY / 558 : 홍콩USD 507 : 베트남 하노이거래소 / 508 : 베트남 호치민거래소 551 : 중국 상해A / 552 : 중국 심천A
            let PRDT_TYPE_CD:String
            /// 해외거래소코드
            /// [tr_id=TTTT3039R인 경우] 공백 입력 시 미국주식 전체조회 [tr_id=TTTS3014R인 경우] 공백 입력 시 아시아주식 전체조회 NASD : 나스닥 / NYSE : 뉴욕 / AMEX : 아멕스 SEHK : 홍콩 / SHAA : 중국상해 / SZAA : 중국심천 TKSE : 일본 / HASE : 하노이거래소 / VNSE : 호치민거래소
            let OVRS_EXCG_CD:String
            /// 연속조회검색조건200
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_FK200값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_FK200:String
            /// 연속조회키200
            /// 공란 : 최초 조회시 이전 조회 Output CTX_AREA_NK200값 : 다음페이지 조회시(2번째부터)
            let CTX_AREA_NK200:String
        }
        public struct Response : Codable {
            /// 성공 실패 여부
            let rt_cd:String
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            let msg1:String
            /// 연속조회검색조건200
            let ctx_area_fk200:String
            /// 연속조회키200
            let ctx_area_nk200:String
            /// 응답상세1 : Object
            let output:Output
        }
        public struct Output : Codable {
            /// 취소여부
            let cncl_yn:String?
            /// 예약주문접수일자
            let rsvn_ord_rcit_dt:String?
            /// 해외예약주문번호
            let ovrs_rsvn_odno:String?
            /// 주문일자
            let ord_dt:String?
            /// 주문채번지점번호
            let ord_gno_brno:String?
            /// 주문번호
            let odno:String?
            /// 매도매수구분코드
            let sll_buy_dvsn_cd:String?
            /// 매도매수구분명
            let sll_buy_dvsn_name:String?
            /// 해외예약주문상태코드
            let ovrs_rsvn_ord_stat_cd:String?
            /// 해외예약주문상태코드명
            let ovrs_rsvn_ord_stat_cd_name:String?
            /// 상품번호
            let pdno:String?
            /// 상품유형코드
            let prdt_type_cd:String?
            /// 상품명
            let prdt_name:String?
            /// 주문접수시각
            let ord_rcit_tmd:String?
            /// 주문전송시각
            let ord_fwdg_tmd:String?
            /// 거래구분명
            let tr_dvsn_name:String?
            /// 해외거래소코드
            let ovrs_excg_cd:String?
            /// 거래시장명
            let tr_mket_name:String?
            /// 주문직원번호
            let ord_stfno:String?
            /// FT주문수량
            let ft_ord_qty:String?
            /// FT주문단가3
            let ft_ord_unpr3:String?
            /// FT체결수량
            let ft_ccld_qty:String?
            /// FT체결단가3
            let ft_ccld_unpr3:String?
            /// 미처리사유내용
            let nprc_rson_text:String?
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/trading/order-resv-list"
        public var header: [String : String]
        // [실전투자] 미국 : TTTT3039R 일본, 중국, 홍콩, 베트남 : TTTS3014R
        enum TR_ID : String {
            case 미국 = "TTTT3039R"
            case 일본_중국_홍콩_베트남 = "TTTS3014R"
        }
        init(tr_id: TR_ID, gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] 미국 : TTTT3039R 일본, 중국, 홍콩, 베트남 : TTTS3014R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 / P : 개인
                "seq_no", // 법인 : "001" / 개인: ""(Default)
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.header["authorization"] = await KISManager.getAccessToken()?.token
            self.header["gt_uid"] = gt_uid
            self.header["Content-Type"] = "application/json; charset=utf-8"
            self.header["tr_id"] = tr_id.rawValue
        }
    }

    /// 해외주식 매수가능금액조회[v1_해외주식-014]
    /// 해외주식 매수가능금액조회 API입니다.* 해외주식 서비스 신청 후 이용 가능합니다. (아래 링크 3번 해외증권 거래신청 참고)https://securities.koreainvestment.com/main/bond/research/_static/TF03ca010001.jsp
    struct inquirepsamount : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 해외거래소코드
            /// NASD : 나스닥 / NYSE : 뉴욕 / AMEX : 아멕스 SEHK : 홍콩 / SHAA : 중국상해 / SZAA : 중국심천 TKSE : 일본 / HASE : 하노이거래소 / VNSE : 호치민거래소
            let OVRS_EXCG_CD:String
            /// 해외주문단가
            /// 해외주문단가 (23.8) 정수부분 23자리, 소수부분 8자리
            let OVRS_ORD_UNPR:String
            /// 종목코드
            /// 종목코드
            let ITEM_CD:String
        }
        public struct Response : Codable {
            /// 성공 실패 여부
            let rt_cd:String
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            let msg1:String
            /// 응답상세1 : Object
            let output:Output
        }
        public struct Output : Codable {
            /// 거래통화코드
            /// 18.2
            let tr_crcy_cd:String?
            /// 주문가능외화금액
            /// 18.2
            let ord_psbl_frcr_amt:String?
            /// 매도재사용가능금액
            /// 가능금액 산정 시 사용
            let sll_ruse_psbl_amt:String?
            /// 해외주문가능금액
            /// - 한국투자 앱 해외주식 주문화면내 "외화" 인경우 주문가능금액
            let ovrs_ord_psbl_amt:String?
            /// 최대주문가능수량
            /// - 한국투자 앱 해외주식 주문화면내 "외화" 인경우 주문가능수량 - 매수 시 수량단위 절사해서 사용 예 : (100주단위) 545 주 -> 500 주 / (10주단위) 545 주 -> 540 주
            let max_ord_psbl_qty:String?
            /// 환전이후주문가능금액
            /// 사용되지 않는 사항(0으로 출력)
            let echm_af_ord_psbl_amt:String?
            /// 환전이후주문가능수량
            /// 사용되지 않는 사항(0으로 출력)
            let echm_af_ord_psbl_qty:String?
            /// 주문가능수량
            /// 22(20.1)
            let ord_psbl_qty:String?
            /// 환율
            /// 25(18.6)
            let exrt:String?
            /// 외화주문가능금액1
            /// - 한국투자 앱 해외주식 주문화면내 "통합" 인경우 주문가능금액
            let frcr_ord_psbl_amt1:String?
            /// 해외최대주문가능수량
            /// - 한국투자 앱 해외주식 주문화면내 "통합" 인경우 주문가능수량 - 매수 시 수량단위 절사해서 사용 예 : (100주단위) 545 주 -> 500 주 / (10주단위) 545 주 -> 540 주
            let ovrs_max_ord_psbl_qty:String?
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/trading/inquire-psamount"
        public var header: [String : String]
        init(gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] TTTS3007R [모의투자] VTTS3007R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 / P : 개인
                "seq_no", // 법인 : "001" / 개인: ""(Default)
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.header["authorization"] = await KISManager.getAccessToken()?.token
            self.header["gt_uid"] = gt_uid
            self.header["Content-Type"] = "application/json; charset=utf-8"
            self.header["tr_id"] = KISManager.getValueForCurrentTargetServer(실전서버: "TTTS3007R", 모의투자서버: "VTTS3007R")
        }
    }

    /// 해외주식 미국주간주문[v1_해외주식-026]
    /// 해외주식 미국주간주문 API입니다.* 미국주식 주간거래 시 아래 참고 부탁드립니다.. 포럼 > FAQ > 미국주식 주간거래 시 어떤 API를 사용해야 하나요?* 미국주간거래의 경우, 모든 미국 종목 매매가 지원되지 않습니다. 일부 종목만 매매 가능한 점 유의 부탁드립니다.* 해외주식 서비스 신청 후 이용 가능합니다. (아래 링크 3번 해외증권 거래신청 참고)https://securities.koreainvestment.com/main/bond/research/_static/TF03ca010001.jsp* 미국주간거래시간 외 API 호출 시 에러가 발생하오니 운영시간을 확인해주세요.. 주간거래(장전거래)(한국시간 기준) : 10:00 ~ 18:00 (Summer Time 동일)* 한국투자증권 해외주식 시장별 매매안내(매매수수료, 거래시간 안내, 결제일 정보, 환전안내)   https://securities.koreainvestment.com/main/bond/research/_static/TF03ca050000.jsp※ POST API의 경우 BODY값의 key값들을 대문자로 작성하셔야 합니다.   (EX. "CANO" : "12345678", "ACNT_PRDT_CD": "01",...)※ 종목코드 마스터파일 파이썬 정제코드는 한국투자증권 Github 참고 부탁드립니다.   https://github.com/koreainvestment/open-trading-api/tree/main/stocks_info
    struct daytimeorder : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 해외거래소코드
            /// NASD:나스닥 / NYSE:뉴욕 / AMEX:아멕스
            let OVRS_EXCG_CD:String
            /// 상품번호
            /// 종목코드
            let PDNO:String
            /// 주문수량
            /// 해외거래소 별 최소 주문수량 및 주문단위 확인 필요
            let ORD_QTY:String
            /// 해외주문단가
            /// 소수점 포함, 1주당 가격 * 시장가의 경우 1주당 가격을 공란으로 비우지 않음 "0"으로 입력
            let OVRS_ORD_UNPR:String
            /// 연락전화번호
            /// " "
            let CTAC_TLNO:String?
            /// 운용사지정주문번호
            /// " "
            let MGCO_APTM_ODNO:String?
            /// 주문서버구분코드
            /// "0"
            let ORD_SVR_DVSN_CD:String
            /// 주문구분
            /// [미국 매수/매도 주문] 00 : 지정가 * 주간거래는 지정가만 가능
            let ORD_DVSN:String
        }
        public struct Response : Codable {
            /// 성공 실패 여부
            let rt_cd:String
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            let msg1:String
            let output1:Output1?
        }
        public struct Output1 : Codable {
            /// 한국거래소전송주문조직번호
            /// 주문시 한국투자증권 시스템에서 지정된 영업점코드
            let KRX_FWDG_ORD_ORGNO:String
            /// 주문번호
            /// 주문시 한국투자증권 시스템에서 채번된 주문번호
            let ODNO:String
            /// 주문시각
            /// 주문시각(시분초HHMMSS)
            let ORD_TMD:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/trading/daytime-order"
        public var header: [String : String]
        init(gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] 미국주간매수 : TTTS6036U 미국주간매도 : TTTS6037U
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.header["authorization"] = await KISManager.getAccessToken()?.token
            self.header["gt_uid"] = gt_uid
            self.header["Content-Type"] = "application/json; charset=utf-8"
            self.header["tr_id"] = KISManager.getValueForCurrentTargetServer(실전서버: "TTTS6036U", 모의투자서버: "TTTS6037U")
        }
    }

    /// 해외주식 미국주간정정취소[v1_해외주식-027]
    /// 해외주식 미국주간정정취소 API입니다.* 미국주식 주간거래 시 아래 참고 부탁드립니다.. 포럼 > FAQ > 미국주식 주간거래 시 어떤 API를 사용해야 하나요?* 미국주간거래의 경우, 모든 미국 종목 매매가 지원되지 않습니다. 일부 종목만 매매 가능한 점 유의 부탁드립니다.* 해외주식 서비스 신청 후 이용 가능합니다. (아래 링크 3번 해외증권 거래신청 참고)https://securities.koreainvestment.com/main/bond/research/_static/TF03ca010001.jsp* 미국주간거래시간 외 API 호출 시 에러가 발생하오니 운영시간을 확인해주세요.. 주간거래(장전거래)(한국시간 기준) : 10:00 ~ 18:00 (Summer Time 동일)* 한국투자증권 해외주식 시장별 매매안내(매매수수료, 거래시간 안내, 결제일 정보, 환전안내)   https://securities.koreainvestment.com/main/bond/research/_static/TF03ca050000.jsp※ POST API의 경우 BODY값의 key값들을 대문자로 작성하셔야 합니다.   (EX. "CANO" : "12345678", "ACNT_PRDT_CD": "01",...)※ 종목코드 마스터파일 파이썬 정제코드는 한국투자증권 Github 참고 부탁드립니다.   https://github.com/koreainvestment/open-trading-api/tree/main/stocks_info
    struct daytimeorderrvsecncl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 해외거래소코드
            /// NASD:나스닥 / NYSE:뉴욕 / AMEX:아멕스
            let OVRS_EXCG_CD:String
            /// 상품번호
            /// 종목코드
            let PDNO:String
            /// 원주문번호
            /// '정정 또는 취소할 원주문번호(매매 TR의 주문번호) - 해외주식 주문체결내역api (/uapi/overseas-stock/v1/trading/inquire-nccs)에서 odno(주문번호) 참조'
            let ORGN_ODNO:String
            /// 정정취소구분코드
            /// '01 : 정정 02 : 취소'
            let RVSE_CNCL_DVSN_CD:String
            /// 주문수량
            let ORD_QTY:String
            /// 해외주문단가
            /// 소수점 포함, 1주당 가격
            let OVRS_ORD_UNPR:String
            /// 연락전화번호
            /// " "
            let CTAC_TLNO:String
            /// 운용사지정주문번호
            /// " "
            let MGCO_APTM_ODNO:String
            /// 주문서버구분코드
            /// "0"
            let ORD_SVR_DVSN_CD:String
        }
        public struct Response : Codable {
            /// 성공 실패 여부
            let rt_cd:String
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            let msg1:String
            let output1:Output1
        }
        public struct Output1 : Codable {
            /// 한국거래소전송주문조직번호
            /// 주문시 한국투자증권 시스템에서 지정된 영업점코드
            let KRX_FWDG_ORD_ORGNO:String
            /// 주문번호
            /// 주문시 한국투자증권 시스템에서 채번된 주문번호
            let ODNO:String
            /// 주문시각
            /// 주문시각(시분초HHMMSS)
            let ORD_TMD:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/trading/daytime-order-rvsecncl"
        public var header: [String : String]
        init(tr_id: String = "TTTS6038U", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] 미국주간 정정취소 : TTTS6038U
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.header["authorization"] = await KISManager.getAccessToken()?.token
            self.header["gt_uid"] = gt_uid
            self.header["Content-Type"] = "application/json; charset=utf-8"
            self.header["tr_id"] = tr_id
        }
    }

    /// 해외주식 기간손익[v1_해외주식-032]
    /// 해외주식 기간손익 API입니다.한국투자 HTS(eFriend Plus) > [7717] 해외 기간손익 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.* 해외주식 서비스 신청 후 이용 가능합니다. (아래 링크 3번 해외증권 거래신청 참고)https://securities.koreainvestment.com/main/bond/research/_static/TF03ca010001.jsp[해외 기간손익 유의 사항]■ 단순 매체결내역을 기초로 만든 화면으로 매도체결시점의 체결기준 매입단가와 비교하여 손익이 계산됩니다.  결제일의 환율과 금액을 기준으로 산출하는 해외주식 양도소득세 계산방식과는 상이하오니, 참고용으로만 활용하여 주시기 바랍니다.■ 기간손익은 매매일 익일부터 조회가능합니다.﻿﻿■ 매입금액/매도금액 원화 환산 시 매도일의 환율이 적용되어있습니다.﻿﻿■ 손익금액의 비용은 "매도비용" 만 포함되어있습니다. 단, 동일 종목의 매수/매도가 동시에 있는 경우에는 해당일 발생한 매수비용도 함께 계산됩니다.﻿﻿■ 담보상환내역은 기간손익화면에 표시되지 많으니 참고하여 주시기 바랍니다.
    struct inquireperiodprofit : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            /// 계좌번호 체계(8-2)의 앞 8자리
            var CANO:String = KISManager.getCANO()
            /// 계좌상품코드
            /// 계좌번호 체계(8-2)의 뒤 2자리
            var ACNT_PRDT_CD:String = KISManager.ACNT_PRDT_CD()
            /// 해외거래소코드
            /// 공란 : 전체, NASD : 미국, SEHK : 홍콩, SHAA : 중국, TKSE : 일본, HASE : 베트남
            let OVRS_EXCG_CD:String
            /// 국가코드
            /// 공란(Default)
            let NATN_CD:String
            /// 통화코드
            /// 공란 : 전체 USD : 미국달러, HKD : 홍콩달러, CNY : 중국위안화, JPY : 일본엔화, VND : 베트남동
            let CRCY_CD:String
            /// 상품번호
            /// 공란 : 전체
            let PDNO:String
            /// 조회시작일자
            /// YYYYMMDD
            let INQR_STRT_DT:String
            /// 조회종료일자
            /// YYYYMMDD
            let INQR_END_DT:String
            /// 원화외화구분코드
            /// 01 : 외화, 02 : 원화
            let WCRC_FRCR_DVSN_CD:String
            /// 연속조회검색조건200
            let CTX_AREA_FK200:String
            /// 연속조회키200
            let CTX_AREA_NK200:String
        }
        public struct Response : Codable {
            /// 성공 실패 여부
            let rt_cd:String
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            let msg1:String
            /// 응답상세 : Object Array
            /// array
            let Output1: [Output1]
            /// 응답상세2 : Object
            let Output2: Output2
        }
        public struct Output1 : Codable {
            /// 매매일
            let trad_day:String
            /// 해외상품번호
            let ovrs_pdno:String
            /// 해외종목명
            let ovrs_item_name:String
            /// 매도청산수량
            let slcl_qty:String
            /// 매입평균가격
            let pchs_avg_pric:String
            /// 외화매입금액1
            let frcr_pchs_amt1:String
            /// 평균매도단가
            let avg_sll_unpr:String
            /// 외화매도금액합계1
            let frcr_sll_amt_smtl1:String
            /// 주식매도제비용
            let stck_sll_tlex:String
            /// 해외실현손익금액
            let ovrs_rlzt_pfls_amt:String
            /// 수익률
            let pftrt:String
            /// 환율
            let exrt:String
            /// 해외거래소코드
            let ovrs_excg_cd:String
            /// 최초고시환율
            let frst_bltn_exrt:String
        }
        public struct Output2 : Codable {
            /// 주식매도금액합계
            /// WCRC_FRCR_DVSN_CD(원화외화구분코드)가 01(외화)이고 OVRS_EXCG_CD(해외거래소코드)가 공란(전체)인 경우 출력값 무시
            let stck_sll_amt_smtl:String
            /// 주식매수금액합계
            /// WCRC_FRCR_DVSN_CD(원화외화구분코드)가 01(외화)이고 OVRS_EXCG_CD(해외거래소코드)가 공란(전체)인 경우 출력값 무시
            let stck_buy_amt_smtl:String
            /// 합계수수료1
            /// WCRC_FRCR_DVSN_CD(원화외화구분코드)가 01(외화)이고 OVRS_EXCG_CD(해외거래소코드)가 공란(전체)인 경우 출력값 무시
            let smtl_fee1:String
            /// 정산지급금액
            /// WCRC_FRCR_DVSN_CD(원화외화구분코드)가 01(외화)이고 OVRS_EXCG_CD(해외거래소코드)가 공란(전체)인 경우 출력값 무시
            let excc_dfrm_amt:String
            /// 해외실현손익총금액
            /// WCRC_FRCR_DVSN_CD(원화외화구분코드)가 01(외화)이고 OVRS_EXCG_CD(해외거래소코드)가 공란(전체)인 경우 출력값 무시
            let ovrs_rlzt_pfls_tot_amt:String
            /// 총수익률
            let tot_pftrt:String
            /// 기준일자
            let bass_dt:String
            /// 환율
            let exrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/trading/inquire-period-profit"
        public var header: [String : String]
        init(tr_id: String = "TTTS3039R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자] TTTS3039R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.header["authorization"] = await KISManager.getAccessToken()?.token
            self.header["gt_uid"] = gt_uid
            self.header["Content-Type"] = "application/json; charset=utf-8"
            self.header["tr_id"] = tr_id
        }
    }

    /// 해외증거금 통화별조회 [해외주식-035]
    /// 해외증거금 통화별조회 API입니다.한국투자 HTS(eFriend Plus) > [7718] 해외주식 증거금상세 화면 의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct foreignmargin : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            let CANO:String
            /// 계좌상품코드
            let ACNT_PRDT_CD:String
        }
        public struct Response : Codable {
            /// 성공 실패 여부
            let rt_cd:String
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            let msg1:String
            /// 응답상세 : Object Array
            /// array
            let output: [Output]
        }
        public struct Output : Codable {
            /// 국가명
            let natn_name:String
            /// 통화코드
            let crcy_cd:String
            /// 외화예수금액
            let frcr_dncl_amt1:String
            /// 미결제매수금액
            let ustl_buy_amt:String
            /// 미결제매도금액
            let ustl_sll_amt:String
            /// 외화미수금액
            let frcr_rcvb_amt:String
            /// 외화증거금액
            let frcr_mgn_amt:String
            /// 외화일반주문가능금액
            let frcr_gnrl_ord_psbl_amt:String
            /// 외화주문가능금액
            /// 원화주문가능환산금액
            let frcr_ord_psbl_amt1:String
            /// 통합주문가능금액
            let itgr_ord_psbl_amt:String
            /// 기준환율
            let bass_exrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/trading/foreign-margin"
        public var header: [String : String]
        init(tr_id: String = "TTTC2101R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // TTTC2101R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.header["authorization"] = await KISManager.getAccessToken()?.token
            self.header["gt_uid"] = gt_uid
            self.header["tr_id"] = tr_id
        }
    }

    /// 해외주식 일별거래내역 [해외주식-063]
    /// 해외주식 일별거래내역 API입니다.한국투자 HTS(eFriend Plus) > [0828] 해외증권 일별거래내역 화면 의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 체결가격, 매매금액, 정산금액, 수수료 원화금액은 국내 결제일까지는 예상환율로 적용되고, 국내 결제일 익일부터 확정환율로 적용됨으로 금액이 변경될 수 있습니다.※ 해외증권 투자 및 업무문의 안내: 한국투자증권 해외투자지원부 02)3276-5300
    struct inquireperiodtrans : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            let CANO:String
            /// 계좌상품코드
            let ACNT_PRDT_CD:String
            /// 등록시작일자
            /// 입력날짜 ~ (ex) 20240420)
            let ERLM_STRT_DT:String
            /// 등록종료일자
            /// ~입력날짜 (ex) 20240520)
            let ERLM_END_DT:String
            /// 해외거래소코드
            /// 공백
            let OVRS_EXCG_CD:String
            /// 상품번호
            /// 공백 (전체조회), 개별종목 조회는 상품번호입력
            let PDNO:String
            /// 매도매수구분코드
            /// 00(전체), 01(매도), 02(매수)
            let SLL_BUY_DVSN_CD:String
            /// 대출구분코드
            /// 공백
            let LOAN_DVSN_CD:String
            /// 연속조회검색조건100
            /// 공백
            let CTX_AREA_FK100:String
            /// 연속조회키100
            /// 공백
            let CTX_AREA_NK100:String
        }
        public struct Response : Codable {
            /// 성공 실패 여부
            let rt_cd:String
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            let msg1:String
            /// 연속조회검색조건100
            let ctx_area_fk100:String
            /// 연속조회키100
            let ctx_area_nk100:String
            /// 응답상세 : Object Array
            /// array
            let output1:[Output1]
            /// 응답상세 : Object
            let output2:Output2
        }
        public struct Output1 : Codable {
            /// 매매일자
            let trad_dt:String
            /// 결제일자
            let sttl_dt:String
            /// 매도매수구분코드
            let sll_buy_dvsn_cd:String
            /// 매도매수구분명
            let sll_buy_dvsn_name:String
            /// 상품번호
            let pdno:String
            /// 해외종목명
            let ovrs_item_name:String
            /// 체결수량
            let ccld_qty:String
            /// 금액단위체결수량
            let amt_unit_ccld_qty:String
            /// FT체결단가2
            let ft_ccld_unpr2:String
            /// 해외주식체결단가
            let ovrs_stck_ccld_unpr:String
            /// 거래외화금액2
            let tr_frcr_amt2:String
            /// 거래금액
            let tr_amt:String
            /// 외화정산금액1
            let frcr_excc_amt_1:String
            /// 원화정산금액
            let wcrc_excc_amt:String
            /// 국내외화수수료1
            let dmst_frcr_fee1:String
            /// 외화수수료1
            let frcr_fee1:String
            /// 국내원화수수료
            let dmst_wcrc_fee:String
            /// 해외원화수수료
            let ovrs_wcrc_fee:String
            /// 통화코드
            let crcy_cd:String
            /// 표준상품번호
            let std_pdno:String
            /// 등록환율
            let erlm_exrt:String
            /// 대출구분코드
            let loan_dvsn_cd:String
            /// 대출구분명
            let loan_dvsn_name:String
        }
        public struct Output2 : Codable {
            /// 외화매수금액합계
            let frcr_buy_amt_smtl:String
            /// 외화매도금액합계
            let frcr_sll_amt_smtl:String
            /// 국내수수료합계
            let dmst_fee_smtl:String
            /// 해외수수료합계
            let ovrs_fee_smtl:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/trading/inquire-period-trans"
        public var header: [String : String]
        init(tr_id: String = "CTOS4001R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // CTOS4001R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.header["authorization"] = await KISManager.getAccessToken()?.token
            self.header["gt_uid"] = gt_uid
            self.header["tr_id"] = tr_id
        }
    }

    /// 해외주식 결제기준잔고 [해외주식-064]
    /// 해외주식 결제기준잔고 API입니다.한국투자 HTS(eFriend Plus) > [0829] 해외 결제기준잔고 화면 의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 적용환율은 당일 매매기준이며, 현재가의 경우 지연된 시세로 평가되므로 실제매도금액과 상이할 수 있습니다.※ 주문가능수량 : 보유수량 - 미결제 매도수량※ 매입금액 계산 시 결제일의 최초고시환율을 적용하므로, 금일 최초고시환율을 적용하는 체결기준 잔고와는 상이합니다.※ 해외증권 투자 및 업무문의 안내: 한국투자증권 해외투자지원부 02)3276-5300
    struct inquirepaymtstdrbalance : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종합계좌번호
            let CANO:String
            /// 계좌상품코드
            let ACNT_PRDT_CD:String
            /// 기준일자
            let BASS_DT:String
            /// 원화외화구분코드
            /// 01(원화기준),02(외화기준)
            let WCRC_FRCR_DVSN_CD:String
            /// 조회구분코드
            /// 00(전체), 01(일반), 02(미니스탁)
            let INQR_DVSN_CD:String
        }
        public struct Response : Codable {
            /// 성공 실패 여부
            let rt_cd:String
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            let msg1:String
            /// 응답상세 : Object Array
            /// array
            let output1:[Output1]
            /// 응답상세 : Object Array
            /// array
            let output2:[Output2]
            /// 응답상세 : Object
            let output3:Output3
        }
        public struct Output1 : Codable {
            /// 상품번호
            let pdno:String
            /// 상품명
            let prdt_name:String
            /// 잔고수량13
            let cblc_qty13:String
            /// 주문가능수량1
            let ord_psbl_qty1:String
            /// 평균단가3
            let avg_unpr3:String
            /// 해외현재가격1
            let ovrs_now_pric1:String
            /// 외화매입금액
            let frcr_pchs_amt:String
            /// 외화평가금액2
            let frcr_evlu_amt2:String
            /// 평가손익금액2
            let evlu_pfls_amt2:String
            /// 기준환율
            let bass_exrt:String
            /// 조작상세일시
            let oprt_dtl_dtime:String
            /// 매수통화코드
            let buy_crcy_cd:String
            /// 당일매도체결수량1
            let thdt_sll_ccld_qty1:String
            /// 당일매수체결수량1
            let thdt_buy_ccld_qty1:String
            /// 평가손익율1
            let evlu_pfls_rt1:String
            /// 거래시장명
            let tr_mket_name:String
            /// 국가한글명
            let natn_kor_name:String
            /// 표준상품번호
            let std_pdno:String
            /// 담보수량
            let mgge_qty:String
            /// 대출잔액
            let loan_rmnd:String
            /// 상품유형코드
            let prdt_type_cd:String
            /// 해외거래소코드
            let ovrs_excg_cd:String
            /// 유가증권구분명
            let scts_dvsn_name:String
            /// 대여잔고수량
            let ldng_cblc_qty:String
        }
        public struct Output2 : Codable {
            /// 통화코드
            let crcy_cd:String
            /// 통화코드명
            let crcy_cd_name:String
            /// 외화예수금액2
            let frcr_dncl_amt_2:String
            /// 최초고시환율
            let frst_bltn_exrt:String
            /// 외화평가금액2
            let frcr_evlu_amt2:String
        }
        public struct Output3 : Codable {
            /// 매입금액합계금액
            let pchs_amt_smtl_amt:String
            /// 총평가손익금액
            let tot_evlu_pfls_amt:String
            /// 평가수익율1
            let evlu_erng_rt1:String
            /// 총예수금액
            let tot_dncl_amt:String
            /// 원화평가금액합계
            let wcrc_evlu_amt_smtl:String
            /// 총자산금액2
            let tot_asst_amt2:String
            /// 외화잔고원화평가금액합계
            let frcr_cblc_wcrc_evlu_amt_smtl:String
            /// 총대출금액
            let tot_loan_amt:String
            /// 총대여평가금액
            let tot_ldng_evlu_amt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/trading/inquire-paymt-stdr-balance"
        public var header: [String : String]
        init(tr_id: String = "CTRP6010R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // CTRP6010R
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 P : 개인
                "seq_no", // [법인 필수] 001
                "mac_address", // 법인고객 혹은 개인고객의 Mac address 값
                "phone_number", // [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
                "ip_addr", // [법인 필수] 사용자(회원)의 IP Address
                "hashkey", // [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
                "gt_uid", // [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            ])
            self.header["authorization"] = await KISManager.getAccessToken()?.token
            self.header["gt_uid"] = gt_uid
            self.header["tr_id"] = tr_id
        }
    }
}
