//
//  국내선물옵션_기본시세.swift
//  KoreaInvestSwift
//
//  Created by kin on 4/10/25.
//
import FullyRESTful
public extension KISAPI {
    enum 국내선물옵션_기본시세 {}
}
public extension KISAPI.국내선물옵션_기본시세 {
    /// 선물옵션 시세[v1_국내선물-006]
    /// 선물옵션 시세 API입니다. ※ 종목코드 마스터파일 파이썬 정제코드는 한국투자증권 Github 참고 부탁드립니다.   https://github.com/koreainvestment/open-trading-api/tree/main/stocks_info
    struct inquireprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FID 조건 시장 분류 코드
            /// F: 지수선물, O:지수옵션 JF: 주식선물, JO:주식옵션 CF: 상품선물(금), 금리선물(국채), 통화선물(달러) CM: 야간선물, EU: 야간옵션
            let FID_COND_MRKT_DIV_CODE:String
            /// FID 입력 종목코드
            /// 종목코드 (예: 101S03)
            let FID_INPUT_ISCD:String
        }
        public struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            let rt_cd: String
            /// 응답코드 - 응답코드
            let msg_cd: String
            /// 응답메세지 - 응답메세지
            let msg1: String
            /// 응답상세1 : Object
            let output1: Output1
            /// 응답상세2 : Object
            let output2: Output2
            /// 응답상세3 : Object
            let output3: Output3
        }
        public struct Output1 : Codable {
            /// HTS 한글 종목명
            /// 종목명
            let hts_kor_isnm:String
            /// 선물 현재가
            /// 선물의 현재가격
            let futs_prpr:String
            /// 선물 전일 대비
            /// 선물의 전일 종가와 당일 현재가의 차이 (당일 현재가-전일 종가)
            let futs_prdy_vrss:String
            /// 전일 대비 부호
            /// 1 : 상한 2 : 상승 3 : 보합 4 : 하한 5 : 하락
            let prdy_vrss_sign:String
            /// 선물 전일 종가
            /// 해당 선물 종목의 전일 종가
            let futs_prdy_clpr:String
            /// 선물 전일 대비율
            /// 선물 전일 대비 / 당일 현재가 * 100
            let futs_prdy_ctrt:String
            /// 누적 거래량
            /// 당일 조회시점까지 전체 거래량
            let acml_vol:String
            /// 누적 거래 대금
            /// 당일 조회시점까지 전체 거래금액
            let acml_tr_pbmn:String
            /// HTS 미결제 약정 수량
            /// 현재까지 반대매매로 청산되지 않은 계약수
            let hts_otst_stpl_qty:String
            /// 미결제 약정 수량 증감
            /// 전일대비 미결제 약정 수량의 증감
            let otst_stpl_qty_icdc:String
            /// 선물 시가2
            /// 당일 최초 거래가격
            let futs_oprc:String
            /// 선물 최고가
            /// 당일 조회 시점까지 가장 높은 거래가격
            let futs_hgpr:String
            /// 선물 최저가
            /// 당일 조회 시점까지 가장 낮은 거래가격
            let futs_lwpr:String
            /// 선물 상한가
            /// 당일 거래 가능한 최고 가격
            let futs_mxpr:String
            /// 선물 하한가
            /// 당일 거래 가능한 최저 가격
            let futs_llam:String
            /// 베이시스
            /// 이론베이시스 선물 이론가격과 현물가격과의 차이
            let basis:String
            /// 선물 기준가
            let futs_sdpr:String
            /// HTS 이론가
            /// 해당 월물의 이론적 가치를 계산한 것으로 주가지수 선물 이론가격은 (주가지수 선물 이론가격 = 주가지수 + 기간이자비용 - 기간배당수입) 로 계산
            let hts_thpr:String
            /// 괴리율
            /// 현재의 시장가가 이론가격으로부터 얼마나 벗어나 있는지에 대한 측정 자료 괴리도 = (현재가 - 이론가격)
            let dprt:String
            /// 서킷브레이커 적용 상한가
            let crbr_aply_mxpr:String
            /// 서킷브레이커 적용 하한가
            let crbr_aply_llam:String
            /// 선물 최종 거래 일자
            /// 해당 선물 종목의 마지막 거래일
            let futs_last_tr_date:String
            /// HTS 잔존 일수
            /// 최종 거래일까지 남은 일수
            let hts_rmnn_dynu:String
            /// 선물 상장 중 최고가
            /// 해당 선물 종목의 상장일 이후 최고 거래가격
            let futs_lstn_medm_hgpr:String
            /// 선물 상장 중 최저가
            /// 해당 선물 종목의 상장일 이후 최저 거래가격
            let futs_lstn_medm_lwpr:String
            /// 델타 값
            /// 옵션 종목의 지표값
            let delta_val:String
            /// 감마
            /// 옵션 종목의 지표값
            let gama:String
            /// 세타
            /// 옵션 종목의 지표값
            let theta:String
            /// 베가
            /// 옵션 종목의 지표값
            let vega:String
            /// 로우
            /// 옵션 종목의 지표값
            let rho:String
            /// 역사적 변동성
            /// 옵션 종목의 지표값
            let hist_vltl:String
            /// HTS 내재 변동성
            /// 옵션 종목의 지표값
            let hts_ints_vltl:String
            /// 시장 베이시스
            /// 시장베이시스 현재 시장에서 형성된 선물가격과 현물가격과의 차이
            let mrkt_basis:String
            /// 행사가
            /// 옵션의 행사가격
            let acpr:String
        }
        public struct Output2 : Codable {
            /// 업종 구분 코드
            let bstp_cls_code:String
            /// HTS 한글 종목명
            /// 종목명
            let hts_kor_isnm:String
            /// 업종 지수 현재가
            let bstp_nmix_prpr:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 업종 지수 전일 대비
            let bstp_nmix_prdy_vrss:String
            /// 업종 지수 전일 대비율
            let bstp_nmix_prdy_ctrt:String
        }
        public struct Output3 : Codable {
            /// 업종 구분 코드
            let bstp_cls_code:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 업종 지수 현재가
            let bstp_nmix_prpr:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 업종 지수 전일 대비
            let bstp_nmix_prdy_vrss:String
            /// 업종 지수 전일 대비율
            let bstp_nmix_prdy_ctrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/quotations/inquire-price"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHMIF10000000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전/모의투자] FHMIF10000000 : 선물 옵션 시세
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

    /// 선물옵션 시세호가[v1_국내선물-007]
    /// 선물옵션 시세호가 API입니다.
    struct inquireaskingprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FID 조건 시장 분류 코드
            /// F: 지수선물, O:지수옵션 JF: 주식선물, JO:주식옵션 CF: 상품선물(금), 금리선물(국채), 통화선물(달러) CM: 야간선물, EU: 야간옵션
            let FID_COND_MRKT_DIV_CODE:String
            /// FID 입력 종목코드
            /// 종목코드 (예: 101S03)
            let FID_INPUT_ISCD:String
        }
        public struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            let rt_cd: String
            /// 응답코드 - 응답코드
            let msg_cd: String
            /// 응답메세지 - 응답메세지
            let msg1: String
            /// 응답상세1 : Array
            let output1: [Output1]
            /// 응답상세2 : Array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// HTS 한글 종목명
            /// 종목명
            let hts_kor_isnm:String
            /// 선물 현재가
            /// 선물의 현재가격
            let futs_prpr:String
            /// 전일 대비 부호
            /// 1 : 상한 2 : 상승 3 : 보합 4 : 하한 5 : 하락
            let prdy_vrss_sign:String
            /// 선물 전일 대비
            /// 선물의 전일 종가와 당일 현재가의 차이 (당일 현재가-전일 종가)
            let futs_prdy_vrss:String
            /// 선물 전일 대비율
            /// 선물 전일 대비 / 당일 현재가 * 100
            let futs_prdy_ctrt:String
            /// 누적 거래량
            /// 당일 조회시점까지 전체 거래량
            let acml_vol:String
            /// 선물 전일 종가
            /// 해당 선물 종목의 전일 종가
            let futs_prdy_clpr:String
            /// 선물 단축 종목코드
            let futs_shrn_iscd:String
        }
        public struct Output2 : Codable {
            /// 선물 매도호가1
            /// 해당 종목의 매도호가 중 1번째 낮은 호가
            let futs_askp1:String
            /// 선물 매도호가2
            /// 해당 종목의 매도호가 중 2번째 낮은 호가
            let futs_askp2:String
            /// 선물 매도호가3
            /// 해당 종목의 매도호가 중 3번째 낮은 호가
            let futs_askp3:String
            /// 선물 매도호가4
            /// 해당 종목의 매도호가 중 4번째 낮은 호가
            let futs_askp4:String
            /// 선물 매도호가5
            /// 해당 종목의 매도호가 중 5번째 낮은 호가
            let futs_askp5:String
            /// 선물 매수호가1
            /// 해당 종목의 매수호가 중 가장 높은 호가
            let futs_bidp1:String
            /// 선물 매수호가1
            /// 해당 종목의 매수호가 중 2번째 높은 호가
            let futs_bidp2:String
            /// 선물 매수호가3
            /// 해당 종목의 매수호가 중 3번째 높은 호가
            let futs_bidp3:String
            /// 선물 매수호가4
            /// 해당 종목의 매수호가 중 4번째 높은 호가
            let futs_bidp4:String
            /// 선물 매수호가5
            /// 해당 종목의 매수호가 중 5번째 높은 호가
            let futs_bidp5:String
            /// 매도호가 잔량1
            /// 매도호가 1의 미체결수량
            let askp_rsqn1:String
            /// 매도호가 잔량2
            /// 매도호가 2의 미체결수량
            let askp_rsqn2:String
            /// 매도호가 잔량3
            /// 매도호가 3의 미체결수량
            let askp_rsqn3:String
            /// 매도호가 잔량4
            /// 매도호가 4의 미체결수량
            let askp_rsqn4:String
            /// 매도호가 잔량5
            /// 매도호가 5의 미체결수량
            let askp_rsqn5:String
            /// 매수호가 잔량1
            /// 매수호가 1의 미체결수량
            let bidp_rsqn1:String
            /// 매수호가 잔량2
            /// 매수호가 2의 미체결수량
            let bidp_rsqn2:String
            /// 매수호가 잔량3
            /// 매수호가 3의 미체결수량
            let bidp_rsqn3:String
            /// 매수호가 잔량4
            /// 매수호가 4의 미체결수량
            let bidp_rsqn4:String
            /// 매수호가 잔량5
            /// 매수호가 5의 미체결수량
            let bidp_rsqn5:String
            /// 매도호가 건수1
            /// 매도호가 1의 미체결 주문 건수
            let askp_csnu1:String
            /// 매도호가 건수2
            /// 매도호가 2의 미체결 주문 건수
            let askp_csnu2:String
            /// 매도호가 건수3
            /// 매도호가 3의 미체결 주문 건수
            let askp_csnu3:String
            /// 매도호가 건수4
            /// 매도호가 4의 미체결 주문 건수
            let askp_csnu4:String
            /// 매도호가 건수5
            /// 매도호가 5의 미체결 주문 건수
            let askp_csnu5:String
            /// 매수호가 건수1
            /// 매수호가 1의 미체결 주문 건수
            let bidp_csnu1:String
            /// 매수호가 건수2
            /// 매수호가 2의 미체결 주문 건수
            let bidp_csnu2:String
            /// 매수호가 건수3
            /// 매수호가 3의 미체결 주문 건수
            let bidp_csnu3:String
            /// 매수호가 건수4
            /// 매수호가 4의 미체결 주문 건수
            let bidp_csnu4:String
            /// 매수호가 건수5
            /// 매수호가 5의 미체결 주문 건수
            let bidp_csnu5:String
            /// 총 매도호가 잔량
            /// 매도호가 1~5의 잔량 합계
            let total_askp_rsqn:String
            /// 총 매수호가 잔량
            /// 매수호가 1~5의 잔량 합계
            let total_bidp_rsqn:String
            /// 총 매도호가 건수
            /// 매도호가 1~5의 미체결 주문 건수 합계
            let total_askp_csnu:String
            /// 총 매수호가 건수
            /// 매수호가 1~5의 미체결 주문 건수 합계
            let total_bidp_csnu:String
            /// 호가 접수 시간
            /// 가장 최근 호가의 접수 시간
            let aspr_acpt_hour:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/quotations/inquire-asking-price"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHMIF10010000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전/모의투자] FHMIF10010000 : 선물 옵션 시세 호가
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

    /// 선물옵션기간별시세(일/주/월/년)[v1_국내선물-008]
    /// (지수)선물옵션 기간별시세 데이터(일/주/월/년) 조회 (최대 100건 조회)실전계좌의 경우, 한 번의 호출에 최대 100건까지 확인 가능하며, 이후의 값은 연속조회를 통해 확인하실 수 있습니다. 모의계좌의 경우, 한 번의 호출에 최대 100건까지 확인 가능하며, 이후의 값은 연속조회를 통해 확인하실 수 있습니다.
    struct inquiredailyfuopchartprice : APIITEM {
        
        public var header: [String : String] = .init()
        
        public struct Request : Codable {
            /// FID 조건 시장 분류 코드
            /// F: 지수선물, O:지수옵션 JF: 주식선물, JO:주식옵션, CF: 상품선물(금), 금리선물(국채), 통화선물(달러) CM: 야간선물, EU: 야간옵션
            let FID_COND_MRKT_DIV_CODE:String
            /// 종목코드
            /// 종목번호 (지수선물:6자리, 지수옵션 9자리)
            let FID_INPUT_ISCD:String
            /// 조회 시작일자
            /// 조회 시작일자 (ex. 20220401)
            let FID_INPUT_DATE_1:String
            /// 조회 종료일자
            /// 조회 종료일자 (ex. 20220524) ※ 주(W), 월(M), 년(Y) 봉 조회 시에 아래 참고 ㅁ FID_INPUT_DATE_2 가 현재일 까지일때 . 주봉 조회 : 해당 주의 첫번째 영업일이 포함되어야함 . 월봉 조회 : 해당 월의 전월 일자로 시작되어야함 . 년봉 조회 : 해당 년의 전년도 일자로 시작되어야함 ㅁ FID_INPUT_DATE_2 가 현재일보다 이전일 때 . 주봉 조회 : 해당 주의 첫번째 영업일이 포함되어야함 . 월봉 조회 : 해당 월의 영업일이 포함되어야함 . 년봉 조회 : 해당 년의 영업일이 포함되어야함
            let FID_INPUT_DATE_2:String
            /// 기간분류코드
            /// D:일봉 W:주봉, M:월봉, Y:년봉
            let FID_PERIOD_DIV_CODE:String
        }
        public struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            let rt_cd: String
            /// 응답코드 - 응답코드
            let msg_cd: String
            /// 응답메세지 - 응답메세지
            let msg1: String
            /// 상세기본정보 : Object
            /// 상세기본정보
            let output1: Output1
            /// 기간별 조회데이터 (배열) : Array
            /// 기간별 조회데이터 (배열)
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 전일 대비
            /// 전일 대비
            let futs_prdy_vrss:String
            /// 전일 대비 부호
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 선물 전일 대비율
            /// 선물 전일 대비율
            let futs_prdy_ctrt:String
            /// 선물 전일 종가
            /// 선물 전일 종가
            let futs_prdy_clpr:String
            /// 누적 거래량
            /// 누적 거래량
            let acml_vol:String
            /// 누적 거래 대금
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// HTS 한글 종목명
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 현재가
            /// 현재가
            let futs_prpr:String
            /// 단축 종목코드
            /// 단축 종목코드
            let futs_shrn_iscd:String
            /// 전일 거래량
            /// 전일 거래량
            let prdy_vol:String
            /// 상한가
            /// 상한가
            let futs_mxpr:String
            /// 하한가
            /// 하한가
            let futs_llam:String
            /// 시가
            /// 시가
            let futs_oprc:String
            /// 최고가
            /// 최고가
            let futs_hgpr:String
            /// 최저가
            /// 최저가
            let futs_lwpr:String
            /// 전일 시가
            /// 전일 시가
            let futs_prdy_oprc:String
            /// 전일 최고가
            /// 전일 최고가
            let futs_prdy_hgpr:String
            /// 전일 최저가
            /// 전일 최저가
            let futs_prdy_lwpr:String
            /// 매도호가
            /// 매도호가
            let futs_askp:String
            /// 매수호가
            /// 매수호가
            let futs_bidp:String
            /// 베이시스
            /// 베이시스
            let basis:String
            /// KOSPI200 지수
            /// KOSPI200 지수
            let kospi200_nmix:String
            /// KOSPI200 전일 대비
            /// KOSPI200 전일 대비
            let kospi200_prdy_vrss:String
            /// KOSPI200 전일 대비율
            /// KOSPI200 전일 대비율
            let kospi200_prdy_ctrt:String
            /// 전일 대비 부호
            /// 전일 대비 부호
            let kospi200_prdy_vrss_sign:String
            /// HTS 미결제 약정 수량
            /// HTS 미결제 약정 수량
            let hts_otst_stpl_qty:String
            /// 미결제 약정 수량 증감
            /// 미결제 약정 수량 증감
            let otst_stpl_qty_icdc:String
            /// 당일 체결강도
            /// 당일 체결강도
            let tday_rltv:String
            /// HTS 이론가
            /// HTS 이론가
            let hts_thpr:String
            /// 괴리율
            /// 괴리율
            let dprt:String
        }
        public struct Output2 : Codable {
            /// 영업 일자
            /// 영업 일자
            let stck_bsop_date:String
            /// 현재가
            /// 현재가
            let futs_prpr:String
            /// 시가
            /// 시가
            let futs_oprc:String
            /// 최고가
            /// 최고가
            let futs_hgpr:String
            /// 최저가
            /// 최저가
            let futs_lwpr:String
            /// 누적 거래량
            /// 누적 거래량
            let acml_vol:String
            /// 누적 거래 대금
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// 변경 여부
            /// 변경 여부
            let mod_yn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/quotations/inquire-daily-fuopchartprice"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKIF03020100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "tr_id", // [실전/모의투자] FHKIF03020100
                "custtype", // B : 법인 P : 개인
            ])
            self.customHeader?["authorization"] = await KISManager.getAccessToken()?.token
            self.customHeader?["tr_id"] = tr_id
        }
    }

    /// 선물옵션 분봉조회[v1_국내선물-012]
    /// 선물옵션 분봉조회 API입니다.실전계좌의 경우, 한 번의 호출에 최대 102건까지 확인 가능하며, FID_INPUT_DATE_1(입력날짜), FID_INPUT_HOUR_1(입력시간)을 이용하여 다음조회 가능합니다.
    struct inquiretimefuopchartprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FID 조건 시장 분류 코드
            /// F: 지수선물, O:지수옵션 JF: 주식선물, JO:주식옵션, CF: 상품선물(금), 금리선물(국채), 통화선물(달러) CM: 야간선물, EU: 야간옵션
            let FID_COND_MRKT_DIV_CODE:String
            /// FID 입력 종목코드
            /// 종목번호 (지수선물:6자리, 지수옵션 9자리)
            let FID_INPUT_ISCD:String
            /// FID 시간 구분 코드
            /// FID 시간 구분 코드(30: 30초, 60: 1분, 3600: 1시간)
            let FID_HOUR_CLS_CODE:String
            /// FID 과거 데이터 포함 여부
            /// Y(과거) / N (당일)
            let FID_PW_DATA_INCU_YN:String
            /// FID 허봉 포함 여부
            /// N으로 입력
            let FID_FAKE_TICK_INCU_YN:String
            /// FID 입력 날짜1
            /// 입력 날짜 기준으로 이전 기간 조회(YYYYMMDD) ex) 20230908 입력 시, 2023년 9월 8일부터 일자 역순으로 조회
            let FID_INPUT_DATE_1:String
            /// FID 입력 시간1
            /// 입력 시간 기준으로 이전 시간 조회(HHMMSS) ex) 093000 입력 시, 오전 9시 30분부터 역순으로 분봉 조회 * CM(야간선물), EU(야간옵션)인 경우, 자정 이후 시간은 +24시간으로 입력 ex) 253000 입력 시, 새벽 1시 30분부터 역순으로 분봉 조회
            let FID_INPUT_HOUR_1:String
        }
        public struct Response: Codable {
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
            /// 선물 전일 대비
            let futs_prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 선물 전일 대비율
            let futs_prdy_ctrt:String
            /// 선물 전일 종가
            let futs_prdy_clpr:String
            /// 전일 지수
            let prdy_nmix:String
            /// 누적 거래량
            let acml_vol:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 선물 현재가
            let futs_prpr:String
            /// 선물 단축 종목코드
            let futs_shrn_iscd:String
            /// 전일 거래량
            let prdy_vol:String
            /// 선물 상한가
            let futs_mxpr:String
            /// 선물 하한가
            let futs_llam:String
            /// 선물 시가2
            let futs_oprc:String
            /// 선물 최고가
            let futs_hgpr:String
            /// 선물 최저가
            let futs_lwpr:String
            /// 선물 전일 시가
            let futs_prdy_oprc:String
            /// 선물 전일 최고가
            let futs_prdy_hgpr:String
            /// 선물 전일 최저가
            let futs_prdy_lwpr:String
            /// 선물 매도호가
            let futs_askp:String
            /// 선물 매수호가
            let futs_bidp:String
            /// 베이시스
            let basis:String
            /// KOSPI200 지수
            let kospi200_nmix:String
            /// KOSPI200 전일 대비
            let kospi200_prdy_vrss:String
            /// KOSPI200 전일 대비율
            let kospi200_prdy_ctrt:String
            /// KOSPI200 전일 대비 부호
            let kospi200_prdy_vrss_sign:String
            /// HTS 미결제 약정 수량
            let hts_otst_stpl_qty:String
            /// 미결제 약정 수량 증감
            let otst_stpl_qty_icdc:String
            /// 당일 체결강도
            let tday_rltv:String
            /// HTS 이론가
            let hts_thpr:String
            /// 괴리율
            let dprt:String
        }
        public struct Output2 : Codable {
            /// 주식 영업 일자
            let stck_bsop_date:String
            /// 주식 체결 시간
            /// CM(야간선물), EU(야간옵션)인 경우, 자정 이후 시간은 +24시간으로 표시 ex) "260000"인 경우, 오전 4시를 의미
            let stck_cntg_hour:String
            /// 선물 현재가
            let futs_prpr:String
            /// 선물 시가2
            let futs_oprc:String
            /// 선물 최고가
            let futs_hgpr:String
            /// 선물 최저가
            let futs_lwpr:String
            /// 체결 거래량
            let cntg_vol:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/quotations/inquire-time-fuopchartprice"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKIF03020200", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKIF03020200
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

    /// 선물옵션 일중예상체결추이[국내선물-018]
    /// 선물옵션 일중예상체결추이 API입니다. 한국투자 HTS(eFriend Plus) > [0548] 선물옵션 예상체결추이 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct exppricetrend : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 입력 종목코드
            /// 종목번호 (지수선물:6자리, 지수옵션 9자리)
            let FID_INPUT_ISCD:String
            /// 조건 시장 분류 코드
            /// F : 지수선물, O : 지수옵션
            let FID_COND_MRKT_DIV_CODE:String
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
            /// 응답상세 : Object Array
            /// array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 영업 시간
            let hts_kor_isnm:String
            /// 업종 지수 현재가
            let futs_antc_cnpr:String
            /// 업종 지수 전일 대비
            let antc_cntg_vrss_sign:String
            /// 전일 대비 부호
            let futs_antc_cntg_vrss:String
            /// 업종 지수 전일 대비율
            let antc_cntg_prdy_ctrt:String
            /// 누적 거래 대금
            let futs_sdpr:String
        }
        public struct Output2 : Codable {
            /// 주식체결시간
            let stck_cntg_hour:String
            /// 선물예상체결가
            let futs_antc_cnpr:String
            /// 예상체결대비부호
            let antc_cntg_vrss_sign:String
            /// 선물예상체결대비
            let futs_antc_cntg_vrss:String
            /// 예상체결전일대비율
            let antc_cntg_prdy_ctrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/quotations/exp-price-trend"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPIF05110100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPIF05110100
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

    /// 국내옵션전광판_옵션월물리스트[국내선물-020]
    /// 국내업종 국내옵션전광판_옵션월물리스트 API입니다. 한국투자 HTS(eFriend Plus) > [0503] 선물옵션 종합시세(Ⅰ) 화면의 "월물리스트 목록 확인" 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct displayboardoptionlist : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 화면 분류 코드
            /// Unique key(509)
            let FID_COND_SCR_DIV_CODE:String
            /// 조건 시장 분류 코드
            /// 공백
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건 시장 구분 코드
            /// 공백
            let FID_COND_MRKT_CLS_CODE:String
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
            /// 만기 년월 코드
            let mtrt_yymm_code:String
            /// 만기 년월
            let mtrt_yymm:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/quotations/display-board-option-list"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPIO056104C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPIO056104C0
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

    /// 국내선물 기초자산 시세[국내선물-021]
    /// 국내선물 기초자산 시세 API입니다. 한국투자 HTS(eFriend Plus) > [0503] 선물옵션 종합시세(Ⅰ) 화면의 "상단 바" 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct displayboardtop : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// 시장구분코드 (F: 선물)
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력 종목코드
            /// 선물최근월물 ex)(101V06)
            let FID_INPUT_ISCD:String
            /// 조건 시장 분류 코드
            /// 공백
            let FID_COND_MRKT_DIV_CODE1:String
            /// 조건 화면 분류 코드
            /// 공백
            let FID_COND_SCR_DIV_CODE:String
            /// 만기 수
            /// 공백
            let FID_MTRT_CNT:String
            /// 조건 시장 구분 코드
            /// 공백
            let FID_COND_MRKT_CLS_CODE:String
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
            /// 응답상세 : Object Array
            /// array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 기초자산 현재가
            let unas_prpr:String
            /// 기초자산 전일 대비
            let unas_prdy_vrss:String
            /// 기초자산 전일 대비 부호
            let unas_prdy_vrss_sign:String
            /// 기초자산 전일 대비율
            let unas_prdy_ctrt:String
            /// 기초자산 누적 거래량
            let unas_acml_vol:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 선물 현재가
            let futs_prpr:String
            /// 선물 전일 대비
            let futs_prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 선물 전일 대비율
            let futs_prdy_ctrt:String
        }
        public struct Output2 : Codable {
            /// HTS 잔존 일수
            let hts_rmnn_dynu:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/quotations/display-board-top"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPIF05030000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPIF05030000
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

    /// 국내옵션전광판_콜풋[국내선물-022]
    /// 국내옵션전광판_콜풋 API입니다.한국투자 HTS(eFriend Plus) > [0503] 선물옵션 종합시세(Ⅰ) 화면의 "중앙" 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ output1, output2 각각 100건까지만 확인이 가능합니다. (FY25년도 서비스 개선 예정)※ 조회시간이 긴 API인 점 참고 부탁드리며, 잦은 호출을 삼가해주시기 바랍니다. (1초당 최대 1건 권장)
    struct displayboardcallput : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// 시장구분코드 (O: 옵션)
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건 화면 분류 코드
            /// Unique key(20503)
            let FID_COND_SCR_DIV_CODE:String
            /// 시장 구분 코드
            /// 시장구분코드 (CO: 콜옵션)
            let FID_MRKT_CLS_CODE:String
            /// 만기 수
            /// - FID_COND_MRKT_CLS_CODE : 공백(KOSPI200), MKI(미니KOSPI200), KQI(KOSDAQ150) 인 경우 : 만기년월(YYYYMM) 입력 (ex. 202407) - FID_COND_MRKT_CLS_CODE : WKM(KOSPI200위클리(월)), WKI(KOSPI200위클리(목)) 인 경우 : 만기년월주차(YYMMWW) 입력 (ex. 2024년도 7월 3주차인 경우, 240703 입력)
            let FID_MTRT_CNT:String
            /// 조건 시장 구분 코드
            /// 공백: KOSPI200 MKI: 미니KOSPI200 WKM: KOSPI200위클리(월) WKI: KOSPI200위클리(목) KQI: KOSDAQ150
            let FID_COND_MRKT_CLS_CODE:String
            /// 시장 구분 코드
            /// 시장구분코드 (PO: 풋옵션)
            let FID_MRKT_CLS_CODE1:String
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
            /// 응답상세 : Object Array
            /// array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 행사가
            let acpr:String
            /// 환산 현재가
            let unch_prpr:String
            /// 옵션 단축 종목코드
            let optn_shrn_iscd:String
            /// 옵션 현재가
            let optn_prpr:String
            /// 옵션 전일 대비
            let optn_prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 옵션 전일 대비율
            let optn_prdy_ctrt:String
            /// 옵션 매수호가
            let optn_bidp:String
            /// 옵션 매도호가
            let optn_askp:String
            /// 시간가치 값
            let tmvl_val:String
            /// 지수 기준가
            let nmix_sdpr:String
            /// 누적 거래량
            let acml_vol:String
            /// 매도 잔량
            let seln_rsqn:String
            /// 매수2 잔량
            let shnu_rsqn:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// HTS 미결제 약정 수량
            let hts_otst_stpl_qty:String
            /// 미결제 약정 수량 증감
            let otst_stpl_qty_icdc:String
            /// 델타 값
            let delta_val:String
            /// 감마
            let gama:String
            /// 베가
            let vega:String
            /// 세타
            let theta:String
            /// 로우
            let rho:String
            /// HTS 내재 변동성
            let hts_ints_vltl:String
            /// 내재가치 값
            let invl_val:String
            /// 괴리도
            let esdg:String
            /// 괴리율
            let dprt:String
            /// 역사적 변동성
            let hist_vltl:String
            /// HTS 이론가
            let hts_thpr:String
            /// 옵션 시가2
            let optn_oprc:String
            /// 옵션 최고가
            let optn_hgpr:String
            /// 옵션 최저가
            let optn_lwpr:String
            /// 옵션 상한가
            let optn_mxpr:String
            /// 옵션 하한가
            let optn_llam:String
            /// ATM 구분 명
            let atm_cls_name:String
            /// 직전 대비 증감
            let rgbf_vrss_icdc:String
            /// 총 매도호가 잔량
            let total_askp_rsqn:String
            /// 총 매수호가 잔량
            let total_bidp_rsqn:String
            /// 선물예상체결가
            let futs_antc_cnpr:String
            /// 선물예상체결대비
            let futs_antc_cntg_vrss:String
            /// 예상 체결 대비 부호
            let antc_cntg_vrss_sign:String
            /// 예상 체결 전일 대비율
            let antc_cntg_prdy_ctrt:String
        }
        public struct Output2 : Codable {
            /// 행사가
            let acpr:String
            /// 환산 현재가
            let unch_prpr:String
            /// 옵션 단축 종목코드
            let optn_shrn_iscd:String
            /// 옵션 현재가
            let optn_prpr:String
            /// 옵션 전일 대비
            let optn_prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 옵션 전일 대비율
            let optn_prdy_ctrt:String
            /// 옵션 매수호가
            let optn_bidp:String
            /// 옵션 매도호가
            let optn_askp:String
            /// 시간가치 값
            let tmvl_val:String
            /// 지수 기준가
            let nmix_sdpr:String
            /// 누적 거래량
            let acml_vol:String
            /// 매도 잔량
            let seln_rsqn:String
            /// 매수2 잔량
            let shnu_rsqn:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// HTS 미결제 약정 수량
            let hts_otst_stpl_qty:String
            /// 미결제 약정 수량 증감
            let otst_stpl_qty_icdc:String
            /// 델타 값
            let delta_val:String
            /// 감마
            let gama:String
            /// 베가
            let vega:String
            /// 세타
            let theta:String
            /// 로우
            let rho:String
            /// HTS 내재 변동성
            let hts_ints_vltl:String
            /// 내재가치 값
            let invl_val:String
            /// 괴리도
            let esdg:String
            /// 괴리율
            let dprt:String
            /// 역사적 변동성
            let hist_vltl:String
            /// HTS 이론가
            let hts_thpr:String
            /// 옵션 시가2
            let optn_oprc:String
            /// 옵션 최고가
            let optn_hgpr:String
            /// 옵션 최저가
            let optn_lwpr:String
            /// 옵션 상한가
            let optn_mxpr:String
            /// 옵션 하한가
            let optn_llam:String
            /// ATM 구분 명
            let atm_cls_name:String
            /// 직전 대비 증감
            let rgbf_vrss_icdc:String
            /// 총 매도호가 잔량
            let total_askp_rsqn:String
            /// 총 매수호가 잔량
            let total_bidp_rsqn:String
            /// 선물예상체결가
            let futs_antc_cnpr:String
            /// 선물예상체결대비
            let futs_antc_cntg_vrss:String
            /// 예상 체결 대비 부호
            let antc_cntg_vrss_sign:String
            /// 예상 체결 전일 대비율
            let antc_cntg_prdy_ctrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/quotations/display-board-callput"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPIF05030100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPIF05030100
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

    /// 국내옵션전광판_선물[국내선물-023]
    /// 국내옵션전광판_선물 API입니다. 한국투자 HTS(eFriend Plus) > [0503] 선물옵션 종합시세(Ⅰ) 화면의 "하단" 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct displayboardfutures : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// 시장구분코드 (F: 선물)
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건 화면 분류 코드
            /// Unique key(20503)
            let FID_COND_SCR_DIV_CODE:String
            /// 조건 시장 구분 코드
            /// 공백: KOSPI200 MKI: 미니KOSPI200 WKM: KOSPI200위클리(월) WKI: KOSPI200위클리(목) KQI: KOSDAQ150
            let FID_COND_MRKT_CLS_CODE:String
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
            /// 선물 단축 종목코드
            let futs_shrn_iscd:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 선물 현재가
            let futs_prpr:String
            /// 선물 전일 대비
            let futs_prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 선물 전일 대비율
            let futs_prdy_ctrt:String
            /// HTS 이론가
            let hts_thpr:String
            /// 누적 거래량
            let acml_vol:String
            /// 선물 매도호가
            let futs_askp:String
            /// 선물 매수호가
            let futs_bidp:String
            /// HTS 미결제 약정 수량
            let hts_otst_stpl_qty:String
            /// 선물 최고가
            let futs_hgpr:String
            /// 선물 최저가
            let futs_lwpr:String
            /// HTS 잔존 일수
            let hts_rmnn_dynu:String
            /// 총 매도호가 잔량
            let total_askp_rsqn:String
            /// 총 매수호가 잔량
            let total_bidp_rsqn:String
            /// 선물예상체결가
            let futs_antc_cnpr:String
            /// 선물예상체결대비
            let futs_antc_cntg_vrss:String
            /// 예상 체결 대비 부호
            let antc_cntg_vrss_sign:String
            /// 예상 체결 전일 대비율
            let antc_cntg_prdy_ctrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-futureoption/v1/quotations/display-board-futures"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPIF05030200", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPIF05030200
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
