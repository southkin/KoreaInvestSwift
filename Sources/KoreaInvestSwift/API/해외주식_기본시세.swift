//
//  해외주식_기본시세.swift
//  KoreaInvestSwift
//
//  Created by kin on 4/10/25.
//

import FullyRESTful
extension KISAPI {
    enum 해외주식_기본시세 {}
}
extension KISAPI.해외주식_기본시세 {
    /// 해외주식 현재체결가[v1_해외주식-009]
    /// 해외주식종목의 현재체결가를 확인하는 API 입니다.해외주식 시세는 무료시세(지연체결가)만이 제공되며, API로는 유료시세(실시간체결가)를 받아보실 수 없습니다.※ 지연시세 지연시간 : 미국 - 실시간무료(0분지연) / 홍콩, 베트남, 중국, 일본 - 15분지연   미국의 경우 0분지연시세로 제공되나, 장중 당일 시가는 상이할 수 있으며, 익일 정정 표시됩니다.※ 2024년 12월 13일(금) 오후 5시부터 HTS(efriend Plus) [7781] 시세신청(실시간) 화면에서 유료 서비스 신청 후 접근토큰 발급하면 최대 2시간 이후 실시간 유료 시세 수신 가능※ 미국주식 시세의 경우 주간거래시간을 제외한 정규장, 애프터마켓, 프리마켓 시간대에 동일한 API(TR)로 시세 조회가 되는 점 유의 부탁드립니다.해당 API로 미국주간거래(10:00~16:00) 시세 조회도 가능합니다. ※ 미국주간거래 시세 조회 시, EXCD(거래소코드)를 다음과 같이 입력 → 나스닥: BAQ, 뉴욕: BAY, 아멕스: BAA※ 종목코드 마스터파일 파이썬 정제코드는 한국투자증권 Github 참고 부탁드립니다.   https://github.com/koreainvestment/open-trading-api/tree/main/stocks_info[미국주식시세 이용시 유의사항]■ 무료 실시간 시세 서비스가 기본 제공되며, 유료 실시간 시세 서비스는 HTS ‘[7781] 시세신청 (실시간)’과 MTS(모바일) ‘고객서비스 > 거래 서비스신청 > 해외주식 > 해외 실시간시세 신청’ 에서 신청 가능합니다. ※ 무료(매수/매도 각 10호가) : 나스닥 마켓센터에서 거래되는 호가 및 호가 잔량 정보※ 유료(매수/매도 각 1호가) : 미국 전체 거래소들의 통합 주문체결 및 최우선 호가■ 무료 실시간 시세 서비스는 유료 실시간 시세 서비스 대비 평균 50% 수준에 해당하는 정보이므로 현재가/호가/순간체결량/차트 등에서 일시적·부분적 차이가 있을 수 있습니다. ■ 무료∙유료 모두 미국에 상장된 종목(뉴욕, 나스닥, 아멕스 등)의 시세를 제공하며, 동일한 시스템을 사용하여 주문∙체결됩니다. 단, 무료∙유료의 기반 데이터 차이로 호가 및 체결 데이터는 차이가 발생할 수 있고, 이로 인해 발생하는 손실에 대해서 당사가 책임지지 않습니다.■ 무료 실시간 시세 서비스의 시가, 저가, 고가, 종가는 유료 실시간 시세 서비스와 다를 수 있으며, 종목별 과거 데이터(거래량, 시가, 종가, 고가, 차트 데이터 등)는 장 종료 후(오후 12시경) 유료 실시간 시세 서비스 데이터와 동일하게 업데이트됩니다.■ 유료 실시간 시세 서비스는 신청 시 1~12개월까지 기간 선택 후 해당 요금을 일괄 납부하며, 해지 시 해지한 달의 말일까지 시세 제공 후 남은 기간 해당 금액이 환급되니 유의하시기 바랍니다.(출처: 한국투자증권 외화증권 거래설명서 - https://www.truefriend.com/main/customer/guide/Guide.jsp?&cmd=TF04ag010002¤tPage=1&num=64)
    struct price : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// "" (Null 값 설정)
            let AUTH:String
            /// 거래소코드
            /// HKS : 홍콩 NYS : 뉴욕 NAS : 나스닥 AMS : 아멕스 TSE : 도쿄 SHS : 상해 SZS : 심천 SHI : 상해지수 SZI : 심천지수 HSX : 호치민 HNX : 하노이 BAY : 뉴욕(주간) BAQ : 나스닥(주간) BAA : 아멕스(주간)
            let EXCD:String
            /// 종목코드
            let SYMB:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            let rt_cd: String
            /// 응답코드 - 응답코드
            let msg_cd: String
            /// 응답메세지 - 응답메세지
            let msg1: String
            /// 응답상세 : Object
            let output: Output
        }
        public struct Output : Codable {
            /// 실시간조회종목코드
            /// D+시장구분(3자리)+종목코드 예) DNASAAPL : D+NAS(나스닥)+AAPL(애플) [시장구분] NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 , TSE : 도쿄, HKS : 홍콩, SHS : 상해, SZS : 심천 HSX : 호치민, HNX : 하노이
            let rsym:String
            /// 소수점자리수
            let zdiv:String
            /// 전일종가
            /// 전일의 종가
            let base:String
            /// 전일거래량
            /// 전일의 거래량
            let pvol:String
            /// 현재가
            /// 당일 조회시점의 현재 가격
            let last:String
            /// 대비기호
            /// 1 : 상한 2 : 상승 3 : 보합 4 : 하한 5 : 하락
            let sign:String
            /// 대비
            /// 전일 종가와 당일 현재가의 차이 (당일 현재가-전일 종가)
            let diff:String
            /// 등락율
            /// 전일 대비 / 당일 현재가 * 100
            let rate:String
            /// 거래량
            /// 당일 조회시점까지 전체 거래량
            let tvol:String
            /// 거래대금
            /// 당일 조회시점까지 전체 거래금액
            let tamt:String
            /// 매수가능여부
            /// 매수주문 가능 종목 여부
            let ordy:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-price/v1/quotations/price"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS00000300", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자/모의투자] HHDFS00000300
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

    /// 해외주식 기간별시세[v1_해외주식-010]
    /// 해외주식의 기간별시세를 확인하는 API 입니다.실전계좌/모의계좌의 경우, 한 번의 호출에 최대 100건까지 확인 가능합니다.해외주식 시세는 무료시세(지연체결가)만이 제공되며, API로는 유료시세(실시간체결가)를 받아보실 수 없습니다.※ 지연시세 지연시간 : 미국 - 실시간무료(0분지연) / 홍콩, 베트남, 중국, 일본 - 15분지연   미국의 경우 0분지연시세로 제공되나, 장중 당일 시가는 상이할 수 있으며, 익일 정정 표시됩니다.※ 2024년 12월 13일(금) 오후 5시부터 HTS(efriend Plus) [7781] 시세신청(실시간) 화면에서 유료 서비스 신청 후 접근토큰 발급하면 최대 2시간 이후 실시간 유료 시세 수신 가능※ 당사 미국주식 주간거래는 별도 일봉을 제공하지 않고 당일 시세만 제공하고 있습니다.[미국주식시세 이용시 유의사항]■ 무료 실시간 시세 서비스가 기본 제공되며, 유료 실시간 시세 서비스는 HTS ‘[7781] 시세신청 (실시간)’과 MTS(모바일) ‘고객서비스 > 거래 서비스신청 > 해외주식 > 해외 실시간시세 신청’ 에서 신청 가능합니다. ※ 무료(매수/매도 각 10호가) : 나스닥 마켓센터에서 거래되는 호가 및 호가 잔량 정보※ 유료(매수/매도 각 1호가) : 미국 전체 거래소들의 통합 주문체결 및 최우선 호가■ 무료 실시간 시세 서비스는 유료 실시간 시세 서비스 대비 평균 50% 수준에 해당하는 정보이므로 현재가/호가/순간체결량/차트 등에서 일시적·부분적 차이가 있을 수 있습니다. ■ 무료∙유료 모두 미국에 상장된 종목(뉴욕, 나스닥, 아멕스 등)의 시세를 제공하며, 동일한 시스템을 사용하여 주문∙체결됩니다. 단, 무료∙유료의 기반 데이터 차이로 호가 및 체결 데이터는 차이가 발생할 수 있고, 이로 인해 발생하는 손실에 대해서 당사가 책임지지 않습니다.■ 무료 실시간 시세 서비스의 시가, 저가, 고가, 종가는 유료 실시간 시세 서비스와 다를 수 있으며, 종목별 과거 데이터(거래량, 시가, 종가, 고가, 차트 데이터 등)는 장 종료 후(오후 12시경) 유료 실시간 시세 서비스 데이터와 동일하게 업데이트됩니다.■ 유료 실시간 시세 서비스는 신청 시 1~12개월까지 기간 선택 후 해당 요금을 일괄 납부하며, 해지 시 해지한 달의 말일까지 시세 제공 후 남은 기간 해당 금액이 환급되니 유의하시기 바랍니다.(출처: 한국투자증권 외화증권 거래설명서 - https://www.truefriend.com/main/customer/guide/Guide.jsp?&cmd=TF04ag010002¤tPage=1&num=64)
    struct dailyprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// "" (Null 값 설정)
            let AUTH:String
            /// 거래소코드
            /// HKS : 홍콩 NYS : 뉴욕 NAS : 나스닥 AMS : 아멕스 TSE : 도쿄 SHS : 상해 SZS : 심천 SHI : 상해지수 SZI : 심천지수 HSX : 호치민 HNX : 하노이
            let EXCD:String
            /// 종목코드
            /// 종목코드 (ex. TSLA)
            let SYMB:String
            /// 일/주/월구분
            /// 0 : 일 1 : 주 2 : 월
            let GUBN:String
            /// 조회기준일자
            /// 조회기준일자(YYYYMMDD) ※ 공란 설정 시, 기준일 오늘 날짜로 설정
            let BYMD:String
            /// 수정주가반영여부
            /// 0 : 미반영 1 : 반영
            let MODP:String
            /// NEXT KEY BUFF
            /// 응답시 다음값이 있으면 값이 셋팅되어 있으므로 다음 조회시 응답값 그대로 셋팅
            let KEYB:String?
        }
        struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            let rt_cd: String
            /// 응답코드 - 응답코드
            let msg_cd: String
            /// 응답메세지 - 응답메세지
            let msg1: String
            /// 응답상세1 : Object
            let output1: Output1
            /// 응답상세2 : Object Array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 실시간조회종목코드
            /// D+시장구분(3자리)+종목코드 예) DNASAAPL : D+NAS(나스닥)+AAPL(애플) [시장구분] NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 , TSE : 도쿄, HKS : 홍콩, SHS : 상해, SZS : 심천 HSX : 호치민, HNX : 하노이
            let rsym:String
            /// 소수점자리수
            let zdiv:String
            /// 전일종가
            let nrec:String
        }
        public struct Output2 : Codable {
            /// 일자(YYYYMMDD)
            let xymd:String
            /// 종가
            /// 해당 일자의 종가
            let clos:String
            /// 대비기호
            /// 1 : 상한 2 : 상승 3 : 보합 4 : 하한 5 : 하락
            let sign:String
            /// 대비
            /// 해당 일자의 종가와 해당 전일 종가의 차이 (해당일 종가-해당 전일 종가)
            let diff:String
            /// 등락율
            /// 해당 전일 대비 / 해당일 종가 * 100
            let rate:String
            /// 시가
            /// 해당일 최초 거래가격
            let open:String
            /// 고가
            /// 해당일 가장 높은 거래가격
            let high:String
            /// 저가
            /// 해당일 가장 낮은 거래가격
            let low:String
            /// 거래량
            /// 해당일 거래량
            let tvol:String
            /// 거래대금
            /// 해당일 거래대금
            let tamt:String
            /// 매수호가
            /// 마지막 체결이 발생한 시점의 매수호가 * 해당 일자 거래량 0인 경우 값이 수신되지 않음
            let pbid:String
            /// 매수호가잔량
            /// * 해당 일자 거래량 0인 경우 값이 수신되지 않음
            let vbid:String
            /// 매도호가
            /// 마지막 체결이 발생한 시점의 매도호가 * 해당 일자 거래량 0인 경우 값이 수신되지 않음
            let pask:String
            /// 매도호가잔량
            /// * 해당 일자 거래량 0인 경우 값이 수신되지 않음
            let vask:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-price/v1/quotations/dailyprice"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76240000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자/모의투자] HHDFS76240000
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

    /// 해외주식 종목/지수/환율기간별시세(일/주/월/년)[v1_해외주식-012]
    /// 해외주식 종목/지수/환율기간별시세(일/주/월/년) API입니다.해외지수 당일 시세의 경우 지연시세 or 종가시세가 제공됩니다.※ 해당 API로 미국주식 조회 시, 다우30, 나스닥100, S&P500 종목만 조회 가능합니다.   더 많은 미국주식 종목 시세를 이용할 시에는, 해외주식기간별시세 API 사용 부탁드립니다.
    struct inquiredailychartprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FID 조건 시장 분류 코드
            /// N: 해외지수, X 환율, I: 국채, S:금선물
            let FID_COND_MRKT_DIV_CODE:String
            /// FID 입력 종목코드
            /// 종목코드 ※ 해외주식 마스터 코드 참조 (포럼 > FAQ > 종목정보 다운로드(해외) > 해외지수) ※ 해당 API로 미국주식 조회 시, 다우30, 나스닥100, S&P500 종목만 조회 가능합니다. 더 많은 미국주식 종목 시세를 이용할 시에는, 해외주식기간별시세 API 사용 부탁드립니다.
            let FID_INPUT_ISCD:String
            /// FID 입력 날짜1
            /// 시작일자(YYYYMMDD)
            let FID_INPUT_DATE_1:String
            /// FID 입력 날짜2
            /// 종료일자(YYYYMMDD)
            let FID_INPUT_DATE_2:String
            /// FID 기간 분류 코드
            /// D:일, W:주, M:월, Y:년
            let FID_PERIOD_DIV_CODE:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세1 : Object
            /// 기본정보
            let output1: Output1?
            /// 응답상세2 : Object Array
            /// 일자별 정보
            let output2: [Output2]?
        }
        public struct Output1 : Codable {
            /// 전일 대비
            /// 16(11.4) 정수부분 11자리, 소수부분 4자리
            let ovrs_nmix_prdy_vrss:String?
            /// 전일 대비 부호
            let prdy_vrss_sign:String?
            /// 전일 대비율
            /// 11(8.2) 정수부분 8자리, 소수부분 2자리
            let prdy_ctrt:String?
            /// 전일 종가
            /// 16(11.4) 정수부분 11자리, 소수부분 4자리
            let ovrs_nmix_prdy_clpr:String?
            /// 누적 거래량
            let acml_vol:String?
            /// HTS 한글 종목명
            let hts_kor_isnm:String?
            /// 현재가
            /// 16(11.4) 정수부분 11자리, 소수부분 4자리
            let ovrs_nmix_prpr:String?
            /// 단축 종목코드
            let stck_shrn_iscd:String?
            /// 전일 거래량
            let prdy_vol:String?
            /// 시가
            /// 16(11.4) 정수부분 11자리, 소수부분 4자리
            let ovrs_prod_oprc:String?
            /// 최고가
            /// 16(11.4) 정수부분 11자리, 소수부분 4자리
            let ovrs_prod_hgpr:String?
            /// 최저가
            /// 16(11.4) 정수부분 11자리, 소수부분 4자리
            let ovrs_prod_lwpr:String?
        }
        public struct Output2 : Codable {
            /// 영업 일자
            let stck_bsop_date:String?
            /// 현재가
            /// 16(11.4) 정수부분 11자리, 소수부분 4자리
            let ovrs_nmix_prpr:String?
            /// 시가
            /// 16(11.4) 정수부분 11자리, 소수부분 4자리
            let ovrs_nmix_oprc:String?
            /// 최고가
            /// 16(11.4) 정수부분 11자리, 소수부분 4자리
            let ovrs_nmix_hgpr:String?
            /// 최저가
            /// 16(11.4) 정수부분 11자리, 소수부분 4자리
            let ovrs_nmix_lwpr:String?
            /// 누적 거래량
            let acml_vol:String?
            /// 변경 여부
            let mod_yn:String?
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-price/v1/quotations/inquire-daily-chartprice"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKST03030100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자/모의투자] FHKST03030100
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

    /// 해외주식조건검색[v1_해외주식-015]
    /// 해외주식 조건검색 API입니다.한국투자 HTS(eFriend Plus) > [7641] 해외주식 조건검색 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다. 현재 조건검색 결과값은 최대 100개까지 조회 가능합니다. 다음 조회(100개 이후의 값) 기능에 대해서는 개선검토 중에 있습니다.※ 지연시세 지연시간 : 미국 - 실시간무료(0분지연) / 홍콩, 베트남, 중국, 일본 - 15분지연   미국의 경우 0분지연시세로 제공되나, 장중 당일 시가는 상이할 수 있으며, 익일 정정 표시됩니다.※ 2024년 12월 13일(금) 오후 5시부터 HTS(efriend Plus) [7781] 시세신청(실시간) 화면에서 유료 서비스 신청 후 접근토큰 발급하면 최대 2시간 이후 실시간 유료 시세 수신 가능※ 그날 거래량이나 시세 형성이 안된 종목은 해외주식 기간별시세(HHDFS76240000)에서는 조회되지만    해외주식 조건검색(HHDFS76410000)에서 조회되지 않습니다. (EX. NAS AATC)[미국주식시세 이용시 유의사항]■ 무료 실시간 시세 서비스가 기본 제공되며, 유료 실시간 시세 서비스는 HTS ‘[7781] 시세신청 (실시간)’과 MTS(모바일) ‘고객서비스 > 거래 서비스신청 > 해외주식 > 해외 실시간시세 신청’ 에서 신청 가능합니다. ※ 무료(매수/매도 각 10호가) : 나스닥 마켓센터에서 거래되는 호가 및 호가 잔량 정보※ 유료(매수/매도 각 1호가) : 미국 전체 거래소들의 통합 주문체결 및 최우선 호가■ 무료 실시간 시세 서비스는 유료 실시간 시세 서비스 대비 평균 50% 수준에 해당하는 정보이므로 현재가/호가/순간체결량/차트 등에서 일시적·부분적 차이가 있을 수 있습니다. ■ 무료∙유료 모두 미국에 상장된 종목(뉴욕, 나스닥, 아멕스 등)의 시세를 제공하며, 동일한 시스템을 사용하여 주문∙체결됩니다. 단, 무료∙유료의 기반 데이터 차이로 호가 및 체결 데이터는 차이가 발생할 수 있고, 이로 인해 발생하는 손실에 대해서 당사가 책임지지 않습니다.■ 무료 실시간 시세 서비스의 시가, 저가, 고가, 종가는 유료 실시간 시세 서비스와 다를 수 있으며, 종목별 과거 데이터(거래량, 시가, 종가, 고가, 차트 데이터 등)는 장 종료 후(오후 12시경) 유료 실시간 시세 서비스 데이터와 동일하게 업데이트됩니다.■ 유료 실시간 시세 서비스는 신청 시 1~12개월까지 기간 선택 후 해당 요금을 일괄 납부하며, 해지 시 해지한 달의 말일까지 시세 제공 후 남은 기간 해당 금액이 환급되니 유의하시기 바랍니다.(출처: 한국투자증권 외화증권 거래설명서 - https://www.truefriend.com/main/customer/guide/Guide.jsp?&cmd=TF04ag010002¤tPage=1&num=64)
    struct inquiresearch : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// "" (Null 값 설정)
            let AUTH:String
            /// 거래소코드
            /// NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 HKS : 홍콩, SHS : 상해 , SZS : 심천 HSX : 호치민, HNX : 하노이 TSE : 도쿄
            let EXCD:String
            /// 현재가선택조건
            /// 해당조건 사용시(1), 미사용시 필수항목아님
            let CO_YN_PRICECUR:String?
            /// 현재가시작범위가
            /// 단위: 각국통화(JPY, USD, HKD, CNY, VND)
            let CO_ST_PRICECUR:String?
            /// 현재가끝범위가
            /// 단위: 각국통화(JPY, USD, HKD, CNY, VND)
            let CO_EN_PRICECUR:String?
            /// 등락율선택조건
            /// 해당조건 사용시(1), 미사용시 필수항목아님
            let CO_YN_RATE:String?
            /// 등락율시작율
            /// %
            let CO_ST_RATE:String?
            /// 등락율끝율
            /// %
            let CO_EN_RATE:String?
            /// 시가총액선택조건
            /// 해당조건 사용시(1), 미사용시 필수항목아님
            let CO_YN_VALX:String?
            /// 시가총액시작액
            /// 단위: 천
            let CO_ST_VALX:String?
            /// 시가총액끝액
            /// 단위: 천
            let CO_EN_VALX:String?
            /// 발행주식수선택조건
            /// 해당조건 사용시(1), 미사용시 필수항목아님
            let CO_YN_SHAR:String?
            /// 발행주식시작수
            /// 단위: 천
            let CO_ST_SHAR:String?
            /// 발행주식끝수
            /// 단위: 천
            let CO_EN_SHAR:String?
            /// 거래량선택조건
            /// 해당조건 사용시(1), 미사용시 필수항목아님
            let CO_YN_VOLUME:String?
            /// 거래량시작량
            /// 단위: 주
            let CO_ST_VOLUME:String?
            /// 거래량끝량
            /// 단위: 주
            let CO_EN_VOLUME:String?
            /// 거래대금선택조건
            /// 해당조건 사용시(1), 미사용시 필수항목아님
            let CO_YN_AMT:String?
            /// 거래대금시작금
            /// 단위: 천
            let CO_ST_AMT:String?
            /// 거래대금끝금
            /// 단위: 천
            let CO_EN_AMT:String?
            /// EPS선택조건
            /// 해당조건 사용시(1), 미사용시 필수항목아님
            let CO_YN_EPS:String?
            /// EPS시작
            let CO_ST_EPS:String?
            /// EPS끝
            let CO_EN_EPS:String?
            /// PER선택조건
            /// 해당조건 사용시(1), 미사용시 필수항목아님
            let CO_YN_PER:String?
            /// PER시작
            let CO_ST_PER:String?
            /// PER끝
            let CO_EN_PER:String?
            /// NEXT KEY BUFF
            /// "" 공백 입력
            let KEYB:String?
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
            /// 조회결과 상세
            let output1: [Output1]
        }
        public struct Output : Codable {
            /// 소수점자리수
            /// 소수점자리수
            let zdiv:String
            /// 거래상태정보
            /// 거래상태정보
            let stat:String
            /// 현재조회종목수
            /// 현재조회종목수
            let crec:String
            /// 전체조회종목수
            /// 전체조회종목수
            let trec:String
            /// Record Count
            /// Record Count
            let nrec:String
        }
        public struct Output1 : Codable {
            /// 실시간조회심볼
            /// 실시간조회심볼 D+시장구분(3자리)+종목코드 예) DNASAAPL : D+NAS(나스닥)+AAPL(애플) [시장구분] NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 , TSE : 도쿄, HKS : 홍콩, SHS : 상해, SZS : 심천 HSX : 호치민, HNX : 하노이
            let rsym:String?
            /// 거래소코드
            /// 거래소코드
            let excd:String?
            /// 종목명
            /// 종목명
            let name:String?
            /// 종목코드
            /// 종목코드
            let symb:String?
            /// 현재가
            /// 현재가
            let last:String?
            /// 발행주식
            /// 발행주식수(단위: 천)
            let shar:String?
            /// 시가총액
            /// 시가총액(단위: 천)
            let valx:String?
            /// 저가
            /// 저가
            let plow:String?
            /// 고가
            /// 고가
            let phigh:String?
            /// 시가
            /// 시가
            let popen:String?
            /// 거래량
            /// 거래량(단위: 주)
            let tvol:String?
            /// 등락율
            /// 등락율(%)
            let rate:String?
            /// 대비
            /// 대비
            let diff:String?
            /// 기호
            /// 기호
            let sign:String?
            /// 거래대금
            /// 거래대금(단위: 천)
            let avol:String?
            /// EPS
            /// EPS
            let eps:String?
            /// PER
            /// PER
            let per:String?
            /// 순위
            /// 순위
            let rank:String?
            /// 영문종목명
            /// 영문종목명
            let ename:String?
            /// 매매가능
            /// 가능 : O
            let e_ordyn:String?
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-price/v1/quotations/inquire-search"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76410000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS76410000
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
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 해외결제일자조회[해외주식-017]
    /// 해외결제일자조회 API입니다.
    struct countriesholiday : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 기준일자
            /// 기준일자(YYYYMMDD)
            let TRAD_DT:String
            /// 연속조회키
            /// 공백으로 입력
            let CTX_AREA_NK:String
            /// 연속조회검색조건
            /// 공백으로 입력
            let CTX_AREA_FK:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세1 : Object
            let Output: Output
        }
        public struct Output : Codable {
            /// 상품유형코드
            /// 512 미국 나스닥 / 513 미국 뉴욕거래소 / 529 미국 아멕스 515 일본 501 홍콩 / 543 홍콩CNY / 558 홍콩USD 507 베트남 하노이거래소 / 508 베트남 호치민거래소 551 중국 상해A / 552 중국 심천A
            let prdt_type_cd:String
            /// 거래국가코드
            /// 840 미국 / 392 일본 / 344 홍콩 704 베트남 / 156 중국
            let tr_natn_cd:String
            /// 거래국가명
            let tr_natn_name:String
            /// 국가영문약어코드
            /// US 미국 / JP 일본 / HK 홍콩 VN 베트남 / CN 중국
            let natn_eng_abrv_cd:String
            /// 거래시장코드
            let tr_mket_cd:String
            /// 거래시장명
            let tr_mket_name:String
            /// 현지결제일자
            /// 현지결제일자(YYYYMMDD)
            let acpl_sttl_dt:String
            /// 국내결제일자
            /// 국내결제일자(YYYYMMDD)
            let dmst_sttl_dt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/quotations/countries-holiday"
        public var customHeader: [String : String]?
        init(tr_id: String = "CTOS5011R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // CTOS5011R
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

    /// 해외주식 현재가상세[v1_해외주식-029]
    /// 해외주식 현재가상세 API입니다.해당 API를 활용하여 해외주식 종목의 매매단위(vnit), 호가단위(e_hogau), PER, PBR, EPS, BPS 등의 데이터를 확인하실 수 있습니다.해외주식 시세는 무료시세(지연시세)만이 제공되며, API로는 유료시세(실시간시세)를 받아보실 수 없습니다.※ 지연시세 지연시간 : 미국 - 실시간무료(0분지연) / 홍콩, 베트남, 중국, 일본 - 15분지연   미국의 경우 0분지연시세로 제공되나, 장중 당일 시가는 상이할 수 있으며, 익일 정정 표시됩니다.※ 2024년 12월 13일(금) 오후 5시부터 HTS(efriend Plus) [7781] 시세신청(실시간) 화면에서 유료 서비스 신청 후 접근토큰 발급하면 최대 2시간 이후 실시간 유료 시세 수신 가능※ 미국주식 시세의 경우 주간거래시간을 제외한 정규장, 애프터마켓, 프리마켓 시간대에 동일한 API(TR)로 시세 조회가 되는 점 유의 부탁드립니다.[미국주식시세 이용시 유의사항]■ 무료 실시간 시세 서비스가 기본 제공되며, 유료 실시간 시세 서비스는 HTS ‘[7781] 시세신청 (실시간)’과 MTS(모바일) ‘고객서비스 > 거래 서비스신청 > 해외주식 > 해외 실시간시세 신청’ 에서 신청 가능합니다. ※ 무료(매수/매도 각 10호가) : 나스닥 마켓센터에서 거래되는 호가 및 호가 잔량 정보※ 유료(매수/매도 각 1호가) : 미국 전체 거래소들의 통합 주문체결 및 최우선 호가■ 무료 실시간 시세 서비스는 유료 실시간 시세 서비스 대비 평균 50% 수준에 해당하는 정보이므로 현재가/호가/순간체결량/차트 등에서 일시적·부분적 차이가 있을 수 있습니다. ■ 무료∙유료 모두 미국에 상장된 종목(뉴욕, 나스닥, 아멕스 등)의 시세를 제공하며, 동일한 시스템을 사용하여 주문∙체결됩니다. 단, 무료∙유료의 기반 데이터 차이로 호가 및 체결 데이터는 차이가 발생할 수 있고, 이로 인해 발생하는 손실에 대해서 당사가 책임지지 않습니다.■ 무료 실시간 시세 서비스의 시가, 저가, 고가, 종가는 유료 실시간 시세 서비스와 다를 수 있으며, 종목별 과거 데이터(거래량, 시가, 종가, 고가, 차트 데이터 등)는 장 종료 후(오후 12시경) 유료 실시간 시세 서비스 데이터와 동일하게 업데이트됩니다.■ 유료 실시간 시세 서비스는 신청 시 1~12개월까지 기간 선택 후 해당 요금을 일괄 납부하며, 해지 시 해지한 달의 말일까지 시세 제공 후 남은 기간 해당 금액이 환급되니 유의하시기 바랍니다.(출처: 한국투자증권 외화증권 거래설명서 - https://www.truefriend.com/main/customer/guide/Guide.jsp?&cmd=TF04ag010002¤tPage=1&num=64)
    struct pricedetail : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            let AUTH:String
            /// 거래소명
            /// HKS : 홍콩 NYS : 뉴욕 NAS : 나스닥 AMS : 아멕스 TSE : 도쿄 SHS : 상해 SZS : 심천 SHI : 상해지수 SZI : 심천지수 HSX : 호치민 HNX : 하노이 BAY : 뉴욕(주간) BAQ : 나스닥(주간) BAA : 아멕스(주간)
            let EXCD:String
            /// 종목코드
            let SYMB:String
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
            /// 실시간조회종목코드
            let rsym:String
            /// 전일거래량
            let pvol:String
            /// 시가
            let open:String
            /// 고가
            let high:String
            /// 저가
            let low:String
            /// 현재가
            let last:String
            /// 전일종가
            let base:String
            /// 시가총액
            let tomv:String
            /// 전일거래대금
            let pamt:String
            /// 상한가
            let uplp:String
            /// 하한가
            let dnlp:String
            /// 52주최고가
            let h52p:String
            /// 52주최고일자
            let h52d:String
            /// 52주최저가
            let l52p:String
            /// 52주최저일자
            let l52d:String
            /// PER
            let perx:String
            /// PBR
            let pbrx:String
            /// EPS
            let epsx:String
            /// BPS
            let bpsx:String
            /// 상장주수
            let shar:String
            /// 자본금
            let mcap:String
            /// 통화
            let curr:String
            /// 소수점자리수
            let zdiv:String
            /// 매매단위
            let vnit:String
            /// 원환산당일가격
            let t_xprc:String
            /// 원환산당일대비
            let t_xdif:String
            /// 원환산당일등락
            let t_xrat:String
            /// 원환산전일가격
            let p_xprc:String
            /// 원환산전일대비
            let p_xdif:String
            /// 원환산전일등락
            let p_xrat:String
            /// 당일환율
            let t_rate:String
            /// 전일환율
            let p_rate:String
            /// 원환산당일기호
            /// HTS 색상표시용
            let t_xsgn:String
            /// 원환산전일기호
            /// HTS 색상표시용
            let p_xsng:String
            /// 거래가능여부
            let e_ordyn:String
            /// 호가단위
            let e_hogau:String
            /// 업종(섹터)
            let e_icod:String
            /// 액면가
            let e_parp:String
            /// 거래량
            let tvol:String
            /// 거래대금
            let tamt:String
            /// ETP 분류명
            let etyp_nm:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-price/v1/quotations/price-detail"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76200200", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS76200200
                "tr_cont", // 공백 : 초기 조회
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

    /// 해외주식분봉조회[v1_해외주식-030]
    /// 해외주식분봉조회 API입니다. 실전계좌의 경우, 한 번의 호출에 최근 120건까지 확인 가능합니다.NEXT 및 KEYB 값을 사용하여 데이터를 계속해서 다음 조회할 수 있으며, 최대 다음조회 가능 기간은 약 1개월입니다. ※ 해외주식분봉조회 조회 방법params. 초기 조회:  - PINC: "1" 입력 - NEXT: 처음 조회 시, "" 공백 입력 - KEYB: 처음 조회 시, "" 공백 입력. 다음 조회: - PINC: "1" 입력 - NEXT: "1" 입력 - KEYB: 이전 조회 결과의 마지막 분봉 데이터를 이용하여, 1분 전 혹은 n분 전의 시간을 입력 (형식: YYYYMMDDHHMMSS, ex. 20241014140100)* 따라서 분봉데이터를 기간별로 수집하고자 하실 경우 NEXT, KEYB 값을 이용하시면서 다음조회하시면 됩니다.* 한국투자 Github에서 해외주식 분봉 다음조회 파이썬 샘플코드 참고하실 수 있습니다. (아래 링크 참고)  https://github.com/koreainvestment/open-trading-api/blob/main/rest/get_ovsstk_chart_price.py※ 해외주식 분봉은 정규장만 과거조회 가능합니다.미국주식 주간거래( EXCD: BAY, BAQ, BAA )의 경우 본 API로 최대 1일치 분봉만 조회가 가능합니다.※ 지연시세 지연시간 : 미국 - 실시간무료(0분지연) / 홍콩, 베트남, 중국, 일본 - 15분지연   미국의 경우 0분지연시세로 제공되나, 장중 당일 시가는 상이할 수 있으며, 익일 정정 표시됩니다.※ 2024년 12월 13일(금) 오후 5시부터 HTS(efriend Plus) [7781] 시세신청(실시간) 화면에서 유료 서비스 신청 후 접근토큰 발급하면 최대 2시간 이후 실시간 유료 시세 수신 가능[미국주식시세 이용시 유의사항]■ 무료 실시간 시세 서비스가 기본 제공되며, 유료 실시간 시세 서비스는 HTS ‘[7781] 시세신청 (실시간)’과 MTS(모바일) ‘고객서비스 > 거래 서비스신청 > 해외주식 > 해외 실시간시세 신청’ 에서 신청 가능합니다. ※ 무료(매수/매도 각 10호가) : 나스닥 마켓센터에서 거래되는 호가 및 호가 잔량 정보※ 유료(매수/매도 각 1호가) : 미국 전체 거래소들의 통합 주문체결 및 최우선 호가■ 무료 실시간 시세 서비스는 유료 실시간 시세 서비스 대비 평균 50% 수준에 해당하는 정보이므로 현재가/호가/순간체결량/차트 등에서 일시적·부분적 차이가 있을 수 있습니다. ■ 무료∙유료 모두 미국에 상장된 종목(뉴욕, 나스닥, 아멕스 등)의 시세를 제공하며, 동일한 시스템을 사용하여 주문∙체결됩니다. 단, 무료∙유료의 기반 데이터 차이로 호가 및 체결 데이터는 차이가 발생할 수 있고, 이로 인해 발생하는 손실에 대해서 당사가 책임지지 않습니다.■ 무료 실시간 시세 서비스의 시가, 저가, 고가, 종가는 유료 실시간 시세 서비스와 다를 수 있으며, 종목별 과거 데이터(거래량, 시가, 종가, 고가, 차트 데이터 등)는 장 종료 후(오후 12시경) 유료 실시간 시세 서비스 데이터와 동일하게 업데이트됩니다.■ 유료 실시간 시세 서비스는 신청 시 1~12개월까지 기간 선택 후 해당 요금을 일괄 납부하며, 해지 시 해지한 달의 말일까지 시세 제공 후 남은 기간 해당 금액이 환급되니 유의하시기 바랍니다.(출처: 한국투자증권 외화증권 거래설명서 - https://www.truefriend.com/main/customer/guide/Guide.jsp?&cmd=TF04ag010002¤tPage=1&num=64)
    struct inquiretimeitemchartprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// "" 공백으로 입력
            let AUTH:String
            /// 거래소코드
            /// NYS : 뉴욕 NAS : 나스닥 AMS : 아멕스 HKS : 홍콩 SHS : 상해 SZS : 심천 HSX : 호치민 HNX : 하노이 TSE : 도쿄 ※ 주간거래는 최대 1일치 분봉만 조회 가능 BAY : 뉴욕(주간) BAQ : 나스닥(주간) BAA : 아멕스(주간)
            let EXCD:String
            /// 종목코드
            /// 종목코드(ex. TSLA)
            let SYMB:String
            /// 분갭
            /// 분단위(1: 1분봉, 2: 2분봉, ...)
            let NMIN:String
            /// 전일포함여부
            /// 0:당일 1:전일포함 ※ 다음조회 시 반드시 "1"로 입력
            let PINC:String
            /// 다음여부
            /// 처음조회 시, "" 공백 입력 다음조회 시, "1" 입력
            let NEXT:String
            /// 요청갯수
            /// 레코드요청갯수 (최대 120)
            let NREC:String
            /// 미체결채움구분
            /// "" 공백으로 입력
            let FILL:String
            /// NEXT KEY BUFF
            /// 처음 조회 시, "" 공백 입력 다음 조회 시, 이전 조회 결과의 마지막 분봉 데이터를 이용하여, 1분 전 혹은 n분 전의 시간을 입력 (형식: YYYYMMDDHHMMSS, ex. 20241014140100)
            let KEYB:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            let Output1: [Output1]
            /// 응답상세2 : Object
            /// array
            let Output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 실시간종목코드
            let rsym:String
            /// 소수점자리수
            let zdiv:String
            /// 장시작현지시간
            let stim:String
            /// 장종료현지시간
            let etim:String
            /// 장시작한국시간
            let sktm:String
            /// 장종료한국시간
            let ektm:String
            /// 다음가능여부
            let next:String
            /// 추가데이타여부
            let more:String
            /// 레코드갯수
            let nrec:String
        }
        public struct Output2 : Codable {
            /// 현지영업일자
            let tymd:String
            /// 현지기준일자
            let xymd:String
            /// 현지기준시간
            let xhms:String
            /// 한국기준일자
            let kymd:String
            /// 한국기준시간
            let khms:String
            /// 시가
            let open:String
            /// 고가
            let high:String
            /// 저가
            let low:String
            /// 종가
            let last:String
            /// 체결량
            let evol:String
            /// 체결대금
            let eamt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-price/v1/quotations/inquire-time-itemchartprice"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76950200", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS76950200
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

    /// 해외지수분봉조회[v1_해외주식-031]
    /// 해외지수분봉조회 API입니다.실전계좌의 경우, 최근 102건까지 확인 가능합니다.
    struct inquiretimeindexchartprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// N 해외지수 X 환율 KX 원화환율
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력 종목코드
            /// 종목번호(ex. TSLA)
            let FID_INPUT_ISCD:String
            /// 시간 구분 코드
            /// 0: 정규장, 1: 시간외
            let FID_HOUR_CLS_CODE:String
            /// 과거 데이터 포함 여부
            /// Y/N
            let FID_PW_DATA_INCU_YN:String
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
            /// 응답상세2 : Object Array
            /// array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 해외 지수 전일 대비
            let ovrs_nmix_prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 해외 지수 전일 종가
            let ovrs_nmix_prdy_clpr:String
            /// 누적 거래량
            let acml_vol:String
            /// 해외 지수 현재가
            let ovrs_nmix_prpr:String
            /// 주식 단축 종목코드
            let stck_shrn_iscd:String
            /// 해외 상품 시가2
            /// 시가
            let ovrs_prod_oprc:String
            /// 해외 상품 최고가
            /// 최고가
            let ovrs_prod_hgpr:String
            /// 해외 상품 최저가
            /// 최저가
            let ovrs_prod_lwpr:String
        }
        public struct Output2 : Codable {
            /// 주식 영업 일자
            /// 영업 일자
            let stck_bsop_date:String
            /// 주식 체결 시간
            /// 체결 시간
            let stck_cntg_hour:String
            /// 옵션 현재가
            /// 현재가
            let optn_prpr:String
            /// 옵션 시가2
            /// 시가
            let optn_oprc:String
            /// 옵션 최고가
            /// 최고가
            let optn_hgpr:String
            /// 옵션 최저가
            /// 최저가
            let optn_lwpr:String
            /// 체결 거래량
            let cntg_vol:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-price/v1/quotations/inquire-time-indexchartprice"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKST03030200", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST03030200
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

    /// 해외주식 상품기본정보[v1_해외주식-034]
    /// 해외주식 상품기본정보 API입니다.시세제공기관(연합)에서 제공하는 해외주식 상품기본정보 데이터를 확인하실 수 있습니다.※ 해당자료는 시세제공기관(연합)의 자료를 제공하고 있으며, 오류와 지연이 발생할 수 있습니다.※ 위 정보에 의한 투자판단의 최종책임은 정보이용자에게 있으며, 당사와 시세제공기관(연합)는 어떠한 법적인 책임도 지지 않사오니 투자에 참고로만 이용하시기 바랍니다.
    struct searchinfo : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 상품유형코드
            /// 512 미국 나스닥 / 513 미국 뉴욕 / 529 미국 아멕스 515 일본 501 홍콩 / 543 홍콩CNY / 558 홍콩USD 507 베트남 하노이 / 508 베트남 호치민 551 중국 상해A / 552 중국 심천A
            let PRDT_TYPE_CD:String
            /// 상품번호
            /// 예) AAPL (애플)
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
            let output1: Output1
        }
        public struct Output1 : Codable {
            /// 표준상품번호
            let std_pdno:String
            /// 상품영문명
            let prdt_eng_name:String
            /// 국가코드
            let natn_cd:String
            /// 국가명
            let natn_name:String
            /// 거래시장코드
            let tr_mket_cd:String
            /// 거래시장명
            let tr_mket_name:String
            /// 해외거래소코드
            let ovrs_excg_cd:String
            /// 해외거래소명
            let ovrs_excg_name:String
            /// 거래통화코드
            let tr_crcy_cd:String
            /// 해외액면가
            let ovrs_papr:String
            /// 통화명
            let crcy_name:String
            /// 해외주식구분코드
            /// 01.주식 02.WARRANT 03.ETF 04.우선주
            let ovrs_stck_dvsn_cd:String
            /// 상품분류코드
            let prdt_clsf_cd:String
            /// 상품분류명
            let prdt_clsf_name:String
            /// 매도단위수량
            let sll_unit_qty:String
            /// 매수단위수량
            let buy_unit_qty:String
            /// 거래단위금액
            let tr_unit_amt:String
            /// 상장주식수
            let lstg_stck_num:String
            /// 상장일자
            let lstg_dt:String
            /// 해외주식거래정지구분코드
            /// ※ 해당 값 지연 반영될 수 있는 점 유의 부탁드립니다. 01.정상 02.거래정지(ALL) 03.거래중단 04.매도정지 05.거래정지(위탁) 06.매수정지
            let ovrs_stck_tr_stop_dvsn_cd:String
            /// 상장폐지종목여부
            let lstg_abol_item_yn:String
            /// 해외주식상품그룹번호
            let ovrs_stck_prdt_grp_no:String
            /// 상장여부
            let lstg_yn:String
            /// 세금징수여부
            let tax_levy_yn:String
            /// 해외주식등록사유코드
            let ovrs_stck_erlm_rosn_cd:String
            /// 해외주식이력권리구분코드
            let ovrs_stck_hist_rght_dvsn_cd:String
            /// 변경전상품번호
            let chng_bf_pdno:String
            /// 상품유형코드2
            let prdt_type_cd_2:String
            /// 해외종목명
            let ovrs_item_name:String
            /// SEDOL번호
            let sedol_no:String
            /// 블름버그티커내용
            let blbg_tckr_text:String
            /// 해외주식ETF위험지표코드
            /// 001.ETF 002.ETN 003.ETC(Exchage Traded Commodity) 004.Others(REIT's, Mutual Fund) 005.VIX Underlying ETF 006.VIX Underlying ETN
            let ovrs_stck_etf_risk_drtp_cd:String
            /// ETP추적수익율배수
            let etp_chas_erng_rt_dbnb:String
            /// 기관용도ISIN코드
            let istt_usge_isin_cd:String
            /// MINT서비스여부
            let mint_svc_yn:String
            /// MINT서비스여부변경일자
            let mint_svc_yn_chng_dt:String
            /// 상품명
            let prdt_name:String
            /// LEI코드
            let lei_cd:String
            /// 해외주식정지사유코드
            /// 01.권리발생 02.ISIN상이 03.기타 04.급등락종목 05.상장폐지(예정) 06.종목코드,거래소변경 07.PTP종목
            let ovrs_stck_stop_rson_cd:String
            /// 상장폐지일자
            let lstg_abol_dt:String
            /// 미니스탁거래상태구분코드
            /// 01.정상 02.매매 불가 03.매수 불가 04.매도 불가
            let mini_stk_tr_stat_dvsn_cd:String
            /// MINT최초서비스등록일자
            let mint_frst_svc_erlm_dt:String
            /// MINT소수점매매가능여부
            let mint_dcpt_trad_psbl_yn:String
            /// MINT정수매매가능여부
            let mint_fnum_trad_psbl_yn:String
            /// MINT잔고전환불가여부
            let mint_cblc_cvsn_ipsb_yn:String
            /// PTP종목여부
            let ptp_item_yn:String
            /// PTP종목양도세면제여부
            let ptp_item_trfx_exmt_yn:String
            /// PTP종목양도세면제시작일자
            let ptp_item_trfx_exmt_strt_dt:String
            /// PTP종목양도세면제종료일자
            let ptp_item_trfx_exmt_end_dt:String
            /// 주간거래가능여부
            let dtm_tr_psbl_yn:String
            /// 급등락정지제외여부
            let sdrf_stop_ecls_yn:String
            /// 급등락정지제외등록일자
            let sdrf_stop_ecls_erlm_dt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-price/v1/quotations/search-info"
        public var customHeader: [String : String]?
        init(tr_id: String = "CTPF1702R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // CTPF1702R
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

    /// 해외주식 체결추이[해외주식-037]
    struct inquireccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// 공백
            let AUTH:String
            /// 거래소명
            /// 'NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 HKS : 홍콩, SHS : 상해 , SZS : 심천 HSX : 호치민, HNX : 하노이 TSE : 도쿄 '
            let EXCD:String
            /// 종목코드
            /// 해외종목코드
            let SYMB:String
            /// 당일전일구분
            /// 0:전일, 1:당일
            let TDAY:String
            /// NEXT KEY BUFF
            /// 공백
            let KEYB:String
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
            /// array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 실시간조회종목코드
            let rsym:String
            /// 소수점자리수
            let zdiv:String
            /// RecordCount
            let nrec:String
        }
        public struct Output2 : Codable {
            /// 한국기준시간
            let khms:String
            /// 체결량
            let evol:String
            /// 체결강도
            let vpow:String
            /// 체결가
            let last:String
            /// 거래량
            let tvol:String
            /// 기호
            let sign:String
            /// 시장구분
            let mtyp:String
            /// 대비
            let diff:String
            /// 매수호가
            let pbid:String
            /// 등락율
            let rate:String
            /// 매도호가
            let pask:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-price/v1/quotations/inquire-ccnl"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76200300", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS76200300
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

    /// 해외주식 업종별시세[해외주식-048]
    struct industrytheme : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// 공백
            let AUTH:String
            /// 거래소코드
            /// 'NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 HKS : 홍콩, SHS : 상해 , SZS : 심천 HSX : 호치민, HNX : 하노이 TSE : 도쿄 '
            let EXCD:String
            /// 업종코드
            /// 업종코드별조회(HHDFS76370100) 를 통해 확인
            let ICOD:String
            /// 거래량조건
            /// 0(전체), 1(1백주이상), 2(1천주이상), 3(1만주이상), 4(10만주이상), 5(100만주이상), 6(1000만주이상)
            let VOL_RANG:String
            /// NEXT KEY BUFF
            /// 공백
            let KEYB:String
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
            /// array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 소수점자리수
            let zdiv:String
            /// 거래상태종보
            let stat:String
            /// 현재조회종목수
            let crec:String
            /// 전체조회종목수
            let trec:String
            /// RecordCount
            let nrec:String
        }
        public struct Output2 : Codable {
            /// 실시간조회심볼
            let rsym:String
            /// 거래소코드
            let excd:String
            /// 종목코드
            let symb:String
            /// 종목명
            let name:String
            /// 현재가
            let last:String
            /// 기호
            let sign:String
            /// 대비
            let diff:String
            /// 등락율
            let rate:String
            /// 거래량
            let tvol:String
            /// 매도잔량
            let vask:String
            /// 매도호가
            let pask:String
            /// 매수호가
            let pbid:String
            /// 매수잔량
            let vbid:String
            /// 순위
            let seqn:String
            /// 영문종목명
            let ename:String
            /// 매매가능
            let e_ordyn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-price/v1/quotations/industry-theme"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76370000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS76370000
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

    /// 해외주식 업종별코드조회[해외주식-049]
    struct industryprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// 공백
            let AUTH:String
            /// 거래소코드
            /// 'NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 HKS : 홍콩, SHS : 상해 , SZS : 심천 HSX : 호치민, HNX : 하노이 TSE : 도쿄 '
            let EXCD:String
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
            /// array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// RecordCount
            let nrec:String
        }
        public struct Output2 : Codable {
            /// 업종코드
            let icod:String
            /// 업종명
            let name:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-price/v1/quotations/industry-price"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76370100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS76370100
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

    /// 해외주식 현재가 10호가 [해외주식-033]
    /// 해외주식 현재가 10호가 API입니다. 한국투자 HTS(eFriend Plus) > [7620] 해외주식 현재가 화면에서 "왼쪽 호가 창" 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.미국의 경우 실시간호가 10호가까지 무료로 제공됩니다. ('23.05.01 ~ )※ 지연시세 지연시간 : 미국 - 실시간무료(0분지연, 나스닥 마켓센터에서 거래되는 호가 및 호가 잔량 정보)                                홍콩, 베트남, 중국, 일본 - 15분지연   미국의 경우 0분지연시세로 제공되나, 장중 당일 시가는 상이할 수 있으며, 익일 정정 표시됩니다.※ 2024년 12월 13일(금) 오후 5시부터 HTS(efriend Plus) [7781] 시세신청(실시간) 화면에서 유료 서비스 신청 후 접근토큰 발급하면 최대 2시간 이후 실시간 유료 시세 수신 가능※ 미국주식 시세의 경우 주간거래시간을 제외한 정규장, 애프터마켓, 프리마켓 시간대에 동일한 API(TR)로 시세 조회가 되는 점 유의 부탁드립니다.[미국주식시세 이용시 유의사항]■ 무료 실시간 시세 서비스가 기본 제공되며, 유료 실시간 시세 서비스는 HTS ‘[7781] 시세신청 (실시간)’과 MTS(모바일) ‘고객서비스 > 거래 서비스신청 > 해외주식 > 해외 실시간시세 신청’ 에서 신청 가능합니다. ※ 무료(매수/매도 각 10호가) : 나스닥 마켓센터에서 거래되는 호가 및 호가 잔량 정보※ 유료(매수/매도 각 1호가) : 미국 전체 거래소들의 통합 주문체결 및 최우선 호가■ 무료 실시간 시세 서비스는 유료 실시간 시세 서비스 대비 평균 50% 수준에 해당하는 정보이므로 현재가/호가/순간체결량/차트 등에서 일시적·부분적 차이가 있을 수 있습니다. ■ 무료∙유료 모두 미국에 상장된 종목(뉴욕, 나스닥, 아멕스 등)의 시세를 제공하며, 동일한 시스템을 사용하여 주문∙체결됩니다. 단, 무료∙유료의 기반 데이터 차이로 호가 및 체결 데이터는 차이가 발생할 수 있고, 이로 인해 발생하는 손실에 대해서 당사가 책임지지 않습니다.■ 무료 실시간 시세 서비스의 시가, 저가, 고가, 종가는 유료 실시간 시세 서비스와 다를 수 있으며, 종목별 과거 데이터(거래량, 시가, 종가, 고가, 차트 데이터 등)는 장 종료 후(오후 12시경) 유료 실시간 시세 서비스 데이터와 동일하게 업데이트됩니다.■ 유료 실시간 시세 서비스는 신청 시 1~12개월까지 기간 선택 후 해당 요금을 일괄 납부하며, 해지 시 해지한 달의 말일까지 시세 제공 후 남은 기간 해당 금액이 환급되니 유의하시기 바랍니다.(출처: 한국투자증권 외화증권 거래설명서 - https://www.truefriend.com/main/customer/guide/Guide.jsp?&cmd=TF04ag010002¤tPage=1&num=64)
    struct inquireaskingprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// 공백
            let AUTH:String
            /// 거래소코드
            /// NYS : 뉴욕 NAS : 나스닥 AMS : 아멕스 HKS : 홍콩 SHS : 상해 SZS : 심천 HSX : 호치민 HNX : 하노이 TSE : 도쿄 BAY : 뉴욕(주간) BAQ : 나스닥(주간) BAA : 아멕스(주간)
            let EXCD:String
            /// 종목코드
            /// 종목코드 예)TSLA
            let SYMB:String
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
            /// 응답상세 : Number
            let output2: Output2
            /// 응답상세 : Object Array
            let output3: [Output3]
        }
        public struct Output1 : Codable {
            /// 실시간조회종목코드
            let rsym:String
            /// 소수점자리수
            let zdiv:String
            /// 통화
            let curr:String
            /// 전일종가
            let base:String
            /// 시가
            let open:String
            /// 고가
            let high:String
            /// 저가
            let low:String
            /// 현재가
            let last:String
            /// 호가일자
            let dymd:String
            /// 호가시간
            let dhms:String
            /// 매수호가총잔량
            let bvol:String
            /// 매도호가총잔량
            let avol:String
            /// 매수호가총잔량대비
            let bdvl:String
            /// 매도호가총잔량대비
            let advl:String
            /// 종목코드
            let code:String
            /// 시가율
            let ropen:String
            /// 고가율
            let rhigh:String
            /// 저가율
            let rlow:String
            /// 현재가율
            let rclose:String
        }
        public struct Output2 : Codable {
            /// 매수호가가격1
            let pbid1:String
            /// 매도호가가격1
            let pask1:String
            /// 매수호가잔량1
            let vbid1:String
            /// 매도호가잔량1
            let vask1:String
            /// 매수호가대비1
            let dbid1:String
            /// 매도호가대비1
            let dask1:String
            /// 매수호가가격2
            let pbid2:String
            /// 매도호가가격2
            let pask2:String
            /// 매수호가잔량2
            let vbid2:String
            /// 매도호가잔량2
            let vask2:String
            /// 매수호가대비2
            let dbid2:String
            /// 매도호가대비2
            let dask2:String
            /// 매수호가가격3
            let pbid3:String
            /// 매도호가가격3
            let pask3:String
            /// 매수호가잔량3
            let vbid3:String
            /// 매도호가잔량3
            let vask3:String
            /// 매수호가대비3
            let dbid3:String
            /// 매도호가대비3
            let dask3:String
            /// 매수호가가격4
            let pbid4:String
            /// 매도호가가격4
            let pask4:String
            /// 매수호가잔량4
            let vbid4:String
            /// 매도호가잔량4
            let vask4:String
            /// 매수호가대비4
            let dbid4:String
            /// 매도호가대비4
            let dask4:String
            /// 매수호가가격5
            let pbid5:String
            /// 매도호가가격5
            let pask5:String
            /// 매수호가잔량5
            let vbid5:String
            /// 매도호가잔량5
            let vask5:String
            /// 매수호가대비5
            let dbid5:String
            /// 매도호가대비5
            let dask5:String
            /// 매수호가가격6
            let pbid6:String
            /// 매도호가가격6
            let pask6:String
            /// 매수호가잔량6
            let vbid6:String
            /// 매도호가잔량6
            let vask6:String
            /// 매수호가대비6
            let dbid6:String
            /// 매도호가대비6
            let dask6:String
            /// 매수호가가격7
            let pbid7:String
            /// 매도호가가격7
            let pask7:String
            /// 매수호가잔량7
            let vbid7:String
            /// 매도호가잔량7
            let vask7:String
            /// 매수호가대비7
            let dbid7:String
            /// 매도호가대비7
            let dask7:String
            /// 매수호가가격8
            let pbid8:String
            /// 매도호가가격8
            let pask8:String
            /// 매수호가잔량8
            let vbid8:String
            /// 매도호가잔량8
            let vask8:String
            /// 매수호가대비8
            let dbid8:String
            /// 매도호가대비8
            let dask8:String
            /// 매수호가가격9
            let pbid9:String
            /// 매도호가가격9
            let pask9:String
            /// 매수호가잔량9
            let vbid9:String
            /// 매도호가잔량9
            let vask9:String
            /// 매수호가대비9
            let dbid9:String
            /// 매도호가대비9
            let dask9:String
            /// 매수호가가격10
            let pbid10:String
            /// 매도호가가격10
            let pask10:String
            /// 매수호가잔량10
            let vbid10:String
            /// 매도호가잔량10
            let vask10:String
            /// 매수호가대비10
            let dbid10:String
            /// 매도호가대비10
            let dask10:String
        }
        public struct Output3 : Codable {
            /// VCMStart시간
            /// 데이터 없음
            let vstm:String
            /// VCMEnd시간
            /// 데이터 없음
            let vetm:String
            /// CAS/VCM기준가
            /// 데이터 없음
            let csbp:String
            /// CAS/VCMHighprice
            /// 데이터 없음
            let cshi:String
            /// CAS/VCMLowprice
            /// 데이터 없음
            let cslo:String
            /// IEP
            /// 데이터 없음
            let iep:String
            /// IEV
            /// 데이터 없음
            let iev:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-price/v1/quotations/inquire-asking-price"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76200100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS76200100
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
