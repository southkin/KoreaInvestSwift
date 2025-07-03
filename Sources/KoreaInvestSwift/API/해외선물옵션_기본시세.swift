//
//  해외선물옵션_기본시세.swift
//  KoreaInvestSwift
//
//  Created by kin on 4/12/25.
//

import FullyRESTful
public extension KISAPI {
    enum 해외선물옵션_기본시세 {}
}
public extension KISAPI.해외선물옵션_기본시세 {
    /// 해외선물종목상세 [v1_해외선물-008]
    /// (중요) 해외선물시세 출력값을 해석하실 때 ffcode.mst(해외선물종목마스터 파일)에 있는 sCalcDesz(계산 소수점) 값을 활용하셔야 정확한 값을 받아오실 수 있습니다.- ffcode.mst(해외선물종목마스터 파일) 다운로드 방법 2가지  1) 한국투자증권 Github의 파이썬 샘플코드를 사용하여 mst 파일 다운로드 및 excel 파일로 정제        https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/overseas_future_code.py   2) 혹은 포럼 - FAQ - 종목정보 다운로드(해외) - 해외지수선물 클릭하셔서 ffcode.mst(해외선물종목마스터 파일)을 다운로드 후     Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외선물정보.h)를 참고하여 해석- 소수점 계산 시, ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고  EX) ffcode.mst 파일의 sCalcDesz(계산 소수점) 값       품목코드 6A 계산소수점 -4 → 시세 6882.5 수신 시 0.68825 로 해석       품목코드 GC 계산소수점 -1 → 시세 19225 수신 시 1922.5 로 해석※ CME, SGX 거래소 API시세는 유료시세로 HTS/MTS에서 유료가입 후 익일부터 시세 이용 가능합니다.포럼 > FAQ > 해외선물옵션 API 유료시세 신청방법(CME, SGX 거래소)
    struct stockdetail : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// ex) CNHU24 ※ 종목코드 "포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수선물" 참고
            let SRS_CD:String
        }
        public struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세1 : Object
            let output1: Output1?
        }
        public struct Output1 : Codable {
            /// 거래소코드
            /// 거래소코드
            let exch_cd:String?
            /// 틱사이즈
            /// 틱사이즈
            let tick_sz:String?
            /// 가격표시진법
            /// 가격표시진법
            let disp_digit:String?
            /// 증거금
            /// 증거금
            let trst_mgn:String?
            /// 정산일
            /// 정산일
            let sttl_date:String?
            /// 전일종가
            /// 전일종가 ※ ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고
            let prev_price:String?
            /// 거래통화
            /// 거래통화
            let crc_cd:String?
            /// 품목종류
            /// 품목종류
            let clas_cd:String?
            /// 틱가치
            /// 틱가치
            let tick_val:String?
            /// 장개시일자
            /// 장개시일자
            let mrkt_open_date:String?
            /// 장개시시각
            /// 장개시시각
            let mrkt_open_time:String?
            /// 장마감일자
            /// 장마감일자
            let mrkt_close_date:String?
            /// 장마감시각
            /// 장마감시각
            let mrkt_close_time:String?
            /// 상장일
            /// 상장일
            let trd_fr_date:String?
            /// 만기일
            /// 만기일
            let expr_date:String?
            /// 최종거래일
            /// 최종거래일
            let trd_to_date:String?
            /// 잔존일수
            /// 잔존일수
            let remn_cnt:String?
            /// 매매여부
            /// 매매여부
            let stat_tp:String?
            /// 계약크기
            /// 계약크기
            let ctrt_size:String?
            /// 최종결제구분
            /// 최종결제구분
            let stl_tp:String?
            /// 최초식별일
            /// 최초식별일
            let frst_noti_date:String?
            ///
            let sprd_srs_cd1:String?
            ///
            let sprd_srs_cd2:String?
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/stock-detail"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFC55010100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFC55010100
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 / P : 개인
                "seq_no", // 법인 : "001" / default 개인: ""
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

    /// 해외선물종목현재가 [v1_해외선물-009]
    /// (중요) 해외선물시세 출력값을 해석하실 때 ffcode.mst(해외선물종목마스터 파일)에 있는 sCalcDesz(계산 소수점) 값을 활용하셔야 정확한 값을 받아오실 수 있습니다.- ffcode.mst(해외선물종목마스터 파일) 다운로드 방법 2가지  1) 한국투자증권 Github의 파이썬 샘플코드를 사용하여 mst 파일 다운로드 및 excel 파일로 정제        https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/overseas_future_code.py   2) 혹은 포럼 - FAQ - 종목정보 다운로드(해외) - 해외지수선물 클릭하셔서 ffcode.mst(해외선물종목마스터 파일)을 다운로드 후     Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외선물정보.h)를 참고하여 해석- 소수점 계산 시, ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고  EX) ffcode.mst 파일의 sCalcDesz(계산 소수점) 값       품목코드 6A 계산소수점 -4 → 시세 6882.5 수신 시 0.68825 로 해석       품목코드 GC 계산소수점 -1 → 시세 19225 수신 시 1922.5 로 해석[참고자료]※ 종목코드 마스터파일 파이썬 정제코드는 한국투자증권 Github 참고 부탁드립니다.   https://github.com/koreainvestment/open-trading-api/tree/main/stocks_info※ CME, SGX 거래소 API시세는 유료시세로 HTS/MTS에서 유료가입 후 익일부터 시세 이용 가능합니다.포럼 > FAQ > 해외선물옵션 API 유료시세 신청방법(CME, SGX 거래소)
    struct inquireprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// ex) CNHU24 ※ 종목코드 "포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수선물" 참고
            let SRS_CD:String
        }
        public struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세1 : Object
            let output1: Output1?
        }
        public struct Output1 : Codable {
            /// 최종처리일자
            /// 최종처리일자
            let proc_date:String?
            /// 고가
            /// 고가 ※ ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고
            let high_price:String?
            /// 최종처리시각
            /// 최종처리시각
            let proc_time:String?
            /// 시가
            /// 시가 ※ ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고
            let open_price:String?
            /// 증거금
            /// 증거금
            let trst_mgn:String?
            /// 저가
            /// 저가 ※ ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고
            let low_price:String?
            /// 현재가
            /// 현재가 ※ ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고
            let last_price:String?
            /// 누적거래수량
            /// 누적거래수량
            let vol:String?
            /// 전일대비구분
            /// 전일대비구분 '1':상한 '2':상승 '3':보합 '4':하한 '5':하락
            let prev_diff_flag:String?
            /// 전일대비가격
            /// 전일대비가격
            let prev_diff_price:String?
            /// 전일대비율
            /// 전일대비율
            let prev_diff_rate:String?
            /// 매수1수량
            /// 매수1수량
            let bid_qntt:String?
            /// 매수1호가
            /// 매수1호가 ※ ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고
            let bid_price:String?
            /// 매도1수량
            /// 매도1수량
            let ask_qntt:String?
            /// 매도1호가
            /// 매도1호가 ※ ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고
            let ask_price:String?
            /// 전일종가
            /// 전일종가 ※ ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고
            let prev_price:String?
            /// 거래소코드
            /// 거래소코드
            let exch_cd:String?
            /// 거래통화
            /// 거래통화
            let crc_cd:String?
            /// 상장일
            /// 상장일
            let trd_fr_date:String?
            /// 만기일
            /// 만기일
            let expr_date:String?
            /// 최종거래일
            /// 최종거래일
            let trd_to_date:String?
            /// 잔존일수
            /// 잔존일수
            let remn_cnt:String?
            /// 체결량
            /// 체결량
            let last_qntt:String?
            /// 총매도잔량
            /// 총매도잔량
            let tot_ask_qntt:String?
            /// 총매수잔량
            /// 총매수잔량
            let tot_bid_qntt:String?
            /// 틱사이즈
            /// 틱사이즈
            let tick_size:String?
            /// 장개시일자
            /// 장개시일자
            let open_date:String?
            /// 장개시시각
            /// 장개시시각
            let open_time:String?
            /// 장종료일자
            /// 장종료일자
            let close_date:String?
            /// 장종료시각
            /// 장종료시각
            let close_time:String?
            /// 영업일자
            /// 영업일자
            let sbsnsdate:String?
            /// 정산가
            /// 정산가
            let sttl_price:String?
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/inquire-price"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFC55010000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용) ※ 토큰 지정시 토큰 타입("Bearer") 지정 필요. 즉, 발급받은 접근토큰 앞에 앞에 "Bearer" 붙여서 호출 EX) "Bearer eyJ..........8GA"
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFC55010000
                "tr_cont", // 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
                "custtype", // B : 법인 / P : 개인
                "seq_no", // 법인 : "001" / default 개인: ""
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

    /// 해외선물 분봉조회[해외선물-016]
    /// 해외선물분봉조회 API입니다. ★ 반드시 아래 호출방법을 확인하시고 호출 사용하시기 바랍니다.한국투자 HTS(eFriend Force) > [5502] 해외선물옵션 체결추이 화면에서 "분" 선택 시 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 해외선물분봉조회 조회 방법params. START_DATE_TIME: 공란 입력 (""). CLOSE_DATE_TIME: 조회일자 입력 ("20231214"). QRY_CNT: 120 입력 시, 가장 최근 분봉 120건 조회( 한번에 최대 120건 조회 가능)                240 입력 시, 240 이전 분봉 ~ 120 이전 분봉 조회                360 입력 시, 360 이전 분봉 ~ 240 이전 분봉 조회. QRY_TP: 처음조회시, 공백 입력              다음조회시, P 입력. INDEX_KEY: 처음조회시, 공백 입력                  다음조회시, 이전 조회 응답의 output2 > index_key 값 입력* 따라서 분봉데이터를 기간별로 수집하고자 하실 경우 QRY_TP, INDEX_KEY 값을 이용하시면서 다음조회하시면 됩니다.(중요) 해외옵션시세 출력값을 해석하실 때 focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)에 있는 sCalcDesz(계산 소수점) 값을 활용하셔야 정확한 값을 받아오실 수 있습니다.- focode.mst(해외지수옵션 종목마스터파일), (해외주식옵션 종목마스터파일) 다운로드 방법  1) focode.mst(해외지수옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외옵션정보.h)를 참고하여 해석  2) fostkcode.mst(해외주식옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외주식옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외주식옵션정보.h)를 참고하여 해석- 소수점 계산 시, focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)의 sCalcDesz(계산 소수점) 값 참고  EX) focode.mst 파일의 sCalcDesz(계산 소수점) 값       품목코드 OES 계산소수점 -2 → 시세 7525 수신 시 75.25 로 해석       품목코드 O6E 계산소수점 -4 → 시세 54.0 수신 시 0.0054 로 해석※ CME, SGX 거래소 API시세는 유료시세로 HTS/MTS에서 유료가입 후 익일부터 시세 이용 가능합니다.포럼 > FAQ > 해외선물옵션 API 유료시세 신청방법(CME, SGX 거래소)
    struct inquiretimefuturechartprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// ex) CNHU24 ※ 종목코드 "포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수선물" 참고
            let SRS_CD:String
            /// 거래소코드
            /// CME
            let EXCH_CD:String
            /// 조회시작일시
            /// 공백
            let START_DATE_TIME:String
            /// 조회종료일시
            /// ex) 20230823
            let CLOSE_DATE_TIME:String
            /// 조회구분
            /// Q : 최초조회시 , P : 다음키(INDEX_KEY) 입력하여 조회시
            let QRY_TP:String
            /// 요청개수
            /// 120 (조회갯수)
            let QRY_CNT:String
            /// 묶음개수
            /// 5 (분간격)
            let QRY_GAP:String
            /// 이전조회KEY
            /// 다음조회(QRY_TP를 P로 입력) 시, 이전 호출의 "output1 > index_key" 기입하여 조회
            let INDEX_KEY:String
        }
        public struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object
            let output2: Output2
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
        }
        public struct Output2 : Codable {
            /// 자료개수
            let ret_cnt:String
            /// N틱최종개수
            let last_n_cnt:String
            /// 이전조회KEY
            let index_key:String
        }
        public struct Output1 : Codable {
            /// 일자
            let data_date:String
            /// 시각
            let data_time:String
            /// 시가
            let open_price:String
            /// 고가
            let high_price:String
            /// 저가
            let low_price:String
            /// 체결가격
            /// 체결가격 ※ ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고
            let last_price:String
            /// 체결수량
            let last_qntt:String
            /// 누적거래수량
            let vol:String
            /// 전일대비구분
            let prev_diff_flag:String
            /// 전일대비가격
            let prev_diff_price:String
            /// 전일대비율
            let prev_diff_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/inquire-time-futurechartprice"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFC55020400", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFC55020400
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

    /// 해외선물 체결추이(주간)[해외선물-017]
    /// 해외선물옵션 체결추이(주간) API입니다. 한국투자 HTS(eFriend Force) > [5502] 해외선물옵션 체결추이 화면에서 "주간" 선택 시 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.(중요) 해외선물시세 출력값을 해석하실 때 ffcode.mst(해외선물종목마스터 파일)에 있는 sCalcDesz(계산 소수점) 값을 활용하셔야 정확한 값을 받아오실 수 있습니다.- ffcode.mst(해외선물종목마스터 파일) 다운로드 방법 2가지  1) 한국투자증권 Github의 파이썬 샘플코드를 사용하여 mst 파일 다운로드 및 excel 파일로 정제        https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/overseas_future_code.py   2) 혹은 포럼 - FAQ - 종목정보 다운로드(해외) - 해외지수선물 클릭하셔서 ffcode.mst(해외선물종목마스터 파일)을 다운로드 후     Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외선물정보.h)를 참고하여 해석- 소수점 계산 시, ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고  EX) ffcode.mst 파일의 sCalcDesz(계산 소수점) 값       품목코드 6A 계산소수점 -4 → 시세 6882.5 수신 시 0.68825 로 해석       품목코드 GC 계산소수점 -1 → 시세 19225 수신 시 1922.5 로 해석※ CME, SGX 거래소 API시세는 유료시세로 HTS/MTS에서 유료가입 후 익일부터 시세 이용 가능합니다.포럼 > FAQ > 해외선물옵션 API 유료시세 신청방법(CME, SGX 거래소)
    struct weeklyccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// 예) 6AM24
            let SRS_CD:String
            /// 거래소코드
            /// 예) CME
            let EXCH_CD:String
            /// 조회시작일시
            /// 공백
            let START_DATE_TIME:String
            /// 조회종료일시
            /// 예) 20240402
            let CLOSE_DATE_TIME:String
            /// 조회구분
            /// Q : 최초조회시 , P : 다음키(INDEX_KEY) 입력하여 조회시
            let QRY_TP:String
            /// 요청개수
            /// 예) 30 (최대 40)
            let QRY_CNT:String
            /// 묶음개수
            /// 공백 (분만 사용)
            let QRY_GAP:String
            /// 이전조회KEY
            /// 공백
            let INDEX_KEY:String
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
            /// 자료개수
            let ret_cnt:String
            /// N틱최종개수
            let last_n_cnt:String
            /// 이전조회KEY
            let index_key:String
        }
        public struct Output2 : Codable {
            /// 일자
            let data_date:String
            /// 시각
            let data_time:String
            /// 시가
            let open_price:String
            /// 고가
            let high_price:String
            /// 저가
            let low_price:String
            /// 체결가격
            let last_price:String
            /// 체결수량
            let last_qntt:String
            /// 누적거래수량
            let vol:String
            /// 전일대비구분
            let prev_diff_flag:String
            /// 전일대비가격
            let prev_diff_price:String
            /// 전일대비율
            let prev_diff_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/weekly-ccnl"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFC55020000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFC55020000
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

    /// 해외선물 체결추이(일간)[해외선물-018]
    /// 해외선물옵션 체결추이(일간) API입니다. 한국투자 HTS(eFriend Force) > [5502] 해외선물옵션 체결추이 화면에서 "일간" 선택 시 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.(중요) 해외선물시세 출력값을 해석하실 때 ffcode.mst(해외선물종목마스터 파일)에 있는 sCalcDesz(계산 소수점) 값을 활용하셔야 정확한 값을 받아오실 수 있습니다.- ffcode.mst(해외선물종목마스터 파일) 다운로드 방법 2가지  1) 한국투자증권 Github의 파이썬 샘플코드를 사용하여 mst 파일 다운로드 및 excel 파일로 정제        https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/overseas_future_code.py   2) 혹은 포럼 - FAQ - 종목정보 다운로드(해외) - 해외지수선물 클릭하셔서 ffcode.mst(해외선물종목마스터 파일)을 다운로드 후     Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외선물정보.h)를 참고하여 해석- 소수점 계산 시, ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고  EX) ffcode.mst 파일의 sCalcDesz(계산 소수점) 값       품목코드 6A 계산소수점 -4 → 시세 6882.5 수신 시 0.68825 로 해석       품목코드 GC 계산소수점 -1 → 시세 19225 수신 시 1922.5 로 해석※ CME, SGX 거래소 API시세는 유료시세로 HTS/MTS에서 유료가입 후 익일부터 시세 이용 가능합니다.포럼 > FAQ > 해외선물옵션 API 유료시세 신청방법(CME, SGX 거래소)
    struct dailyccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// 예) 6AM24
            let SRS_CD:String
            /// 거래소코드
            /// 예) CME
            let EXCH_CD:String
            /// 조회시작일시
            /// 공백
            let START_DATE_TIME:String
            /// 조회종료일시
            /// 예) 20240402
            let CLOSE_DATE_TIME:String
            /// 조회구분
            /// Q : 최초조회시 , P : 다음키(INDEX_KEY) 입력하여 조회시
            let QRY_TP:String
            /// 요청개수
            /// 예) 30 (최대 40)
            let QRY_CNT:String
            /// 묶음개수
            /// 공백 (분만 사용)
            let QRY_GAP:String
            /// 이전조회KEY
            /// 공백
            let INDEX_KEY:String
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
            /// 자료개수
            let tret_cnt:String
            /// N틱최종개수
            let last_n_cnt:String
            /// 이전조회KEY
            let index_key:String
        }
        public struct Output2 : Codable {
            /// 일자
            let data_date:String
            /// 시각
            let data_time:String
            /// 시가
            let open_price:String
            /// 고가
            let high_price:String
            /// 저가
            let low_price:String
            /// 체결가격
            let last_price:String
            /// 체결수량
            let last_qntt:String
            /// 누적거래수량
            let vol:String
            /// 전일대비구분
            let prev_diff_flag:String
            /// 전일대비가격
            let prev_diff_price:String
            /// 전일대비율
            let prev_diff_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/daily-ccnl"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFC55020100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFC55020100
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

    /// 해외선물 체결추이(틱)[해외선물-019]
    /// 해외선물옵션 체결추이(틱) API입니다. 한국투자 HTS(eFriend Force) > [5502] 해외선물옵션 체결추이 화면에서 "Tick" 선택 시 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.(중요) 해외선물시세 출력값을 해석하실 때 ffcode.mst(해외선물종목마스터 파일)에 있는 sCalcDesz(계산 소수점) 값을 활용하셔야 정확한 값을 받아오실 수 있습니다.- ffcode.mst(해외선물종목마스터 파일) 다운로드 방법 2가지  1) 한국투자증권 Github의 파이썬 샘플코드를 사용하여 mst 파일 다운로드 및 excel 파일로 정제        https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/overseas_future_code.py   2) 혹은 포럼 - FAQ - 종목정보 다운로드(해외) - 해외지수선물 클릭하셔서 ffcode.mst(해외선물종목마스터 파일)을 다운로드 후     Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외선물정보.h)를 참고하여 해석- 소수점 계산 시, ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고  EX) ffcode.mst 파일의 sCalcDesz(계산 소수점) 값       품목코드 6A 계산소수점 -4 → 시세 6882.5 수신 시 0.68825 로 해석       품목코드 GC 계산소수점 -1 → 시세 19225 수신 시 1922.5 로 해석※ CME, SGX 거래소 API시세는 유료시세로 HTS/MTS에서 유료가입 후 익일부터 시세 이용 가능합니다.포럼 > FAQ > 해외선물옵션 API 유료시세 신청방법(CME, SGX 거래소)
    struct tickccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// 예) 6AM24
            let SRS_CD:String
            /// 거래소코드
            /// 예) CME
            let EXCH_CD:String
            /// 조회시작일시
            /// 공백
            let START_DATE_TIME:String
            /// 조회종료일시
            /// 예) 20240402
            let CLOSE_DATE_TIME:String
            /// 조회구분
            /// Q : 최초조회시 , P : 다음키(INDEX_KEY) 입력하여 조회시
            let QRY_TP:String
            /// 요청개수
            /// 예) 30 (최대 40)
            let QRY_CNT:String
            /// 묶음개수
            /// 공백 (분만 사용)
            let QRY_GAP:String
            /// 이전조회KEY
            /// 공백
            let INDEX_KEY:String
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
            /// 자료개수
            let tret_cnt:String
            /// N틱최종개수
            let last_n_cnt:String
            /// 이전조회KEY
            let index_key:String
        }
        public struct Output2 : Codable {
            /// 일자
            let data_date:String
            /// 시각
            let data_time:String
            /// 시가
            let open_price:String
            /// 고가
            let high_price:String
            /// 저가
            let low_price:String
            /// 체결가격
            /// 체결가격 ※ ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고
            let last_price:String
            /// 체결수량
            let last_qntt:String
            /// 누적거래수량
            let vol:String
            /// 전일대비구분
            let prev_diff_flag:String
            /// 전일대비가격
            let prev_diff_price:String
            /// 전일대비율
            let prev_diff_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/tick-ccnl"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFC55020200", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFC55020200
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

    /// 해외선물 체결추이(월간)[해외선물-020]
    /// 해외선물옵션 체결추이(월간) API입니다. 한국투자 HTS(eFriend Force) > [5502] 해외선물옵션 체결추이 화면에서 "월간" 선택 시 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.(중요) 해외선물시세 출력값을 해석하실 때 ffcode.mst(해외선물종목마스터 파일)에 있는 sCalcDesz(계산 소수점) 값을 활용하셔야 정확한 값을 받아오실 수 있습니다.- ffcode.mst(해외선물종목마스터 파일) 다운로드 방법 2가지  1) 한국투자증권 Github의 파이썬 샘플코드를 사용하여 mst 파일 다운로드 및 excel 파일로 정제        https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/overseas_future_code.py   2) 혹은 포럼 - FAQ - 종목정보 다운로드(해외) - 해외지수선물 클릭하셔서 ffcode.mst(해외선물종목마스터 파일)을 다운로드 후     Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외선물정보.h)를 참고하여 해석- 소수점 계산 시, ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고  EX) ffcode.mst 파일의 sCalcDesz(계산 소수점) 값       품목코드 6A 계산소수점 -4 → 시세 6882.5 수신 시 0.68825 로 해석       품목코드 GC 계산소수점 -1 → 시세 19225 수신 시 1922.5 로 해석※ CME, SGX 거래소 API시세는 유료시세로 HTS/MTS에서 유료가입 후 익일부터 시세 이용 가능합니다.포럼 > FAQ > 해외선물옵션 API 유료시세 신청방법(CME, SGX 거래소)
    struct monthlyccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// 예) 6AM24
            let SRS_CD:String
            /// 거래소코드
            /// 예) CME
            let EXCH_CD:String
            /// 조회시작일시
            /// 공백
            let START_DATE_TIME:String
            /// 조회종료일시
            /// 예) 20240402
            let CLOSE_DATE_TIME:String
            /// 조회구분
            /// Q : 최초조회시 , P : 다음키(INDEX_KEY) 입력하여 조회시
            let QRY_TP:String
            /// 요청개수
            /// 예) 30 (최대 40)
            let QRY_CNT:String
            /// 묶음개수
            /// 공백 (분만 사용)
            let QRY_GAP:String
            /// 이전조회KEY
            /// 공백
            let INDEX_KEY:String
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
            /// 자료개수
            let tret_cnt:String
            /// N틱최종개수
            let last_n_cnt:String
            /// 이전조회KEY
            let index_key:String
        }
        public struct Output2 : Codable {
            /// 일자
            let data_date:String
            /// 시각
            let data_time:String
            /// 시가
            let open_price:String
            /// 고가
            let high_price:String
            /// 저가
            let low_price:String
            /// 체결가격
            let last_price:String
            /// 체결수량
            let last_qntt:String
            /// 누적거래수량
            let vol:String
            /// 전일대비구분
            let prev_diff_flag:String
            /// 전일대비가격
            let prev_diff_price:String
            /// 전일대비율
            let prev_diff_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/monthly-ccnl"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFC55020300", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFC55020300
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

    /// 해외선물 호가 [해외선물-031]
    /// 해외선물 호가 API입니다. 한국투자 HTS(eFriend Force) > [8602] 해외선물옵션 종합주문(Ⅰ) 화면에서 "왼쪽 호가 창" 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.(중요) 해외선물옵션시세 출력값을 해석하실 때 ffcode.mst(해외선물종목마스터 파일)에 있는 sCalcDesz(계산 소수점) 값을 활용하셔야 정확한 값을 받아오실 수 있습니다.- ffcode.mst(해외선물종목마스터 파일) 다운로드 방법 2가지  1) 한국투자증권 Github의 파이썬 샘플코드를 사용하여 mst 파일 다운로드 및 excel 파일로 정제        https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/overseas_future_code.py   2) 혹은 포럼 - FAQ - 종목정보 다운로드 - 해외선물옵션 클릭하셔서 ffcode.mst(해외선물종목마스터 파일)을 다운로드 후     Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외선물옵션정보.h)를 참고하여 해석- 소수점 계산 시, ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고  EX) ffcode.mst 파일의 sCalcDesz(계산 소수점) 값       품목코드 6A 계산소수점 -4 → 시세 6882.5 수신 시 0.68825 로 해석       품목코드 GC 계산소수점 -1 → 시세 19225 수신 시 1922.5 로 해석[참고자료]※ 종목코드 마스터파일 파이썬 정제코드는 한국투자증권 Github 참고 부탁드립니다.   https://github.com/koreainvestment/open-trading-api/tree/main/stocks_info
    struct inquireaskingprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목명
            /// 종목코드
            let SRS_CD:String
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
            /// 시가
            let open_price:String
            /// 고가
            let high_price:String
            /// 저가
            let lowp_rice:String
            /// 현재가
            let last_price:String
            /// 전일종가
            let prev_price:String
            /// 거래량
            let vol:String
            /// 전일대비가
            let prev_diff_price:String
            /// 전일대비율
            let prev_diff_rate:String
            /// 호가수신일자
            let quot_date:String
            /// 호가수신시각
            let quot_time:String
        }
        public struct Output2 : Codable {
            /// 매수수량
            let bid_qntt:String
            /// 매수번호
            let bid_num:String
            /// 매수호가
            let bid_price:String
            /// 매도수량
            let ask_qntt:String
            /// 매도번호
            let ask_num:String
            /// 매도호가
            let ask_price:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/inquire-asking-price"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFC86000000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFC86000000
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

    /// 해외선물 상품기본정보 [해외선물-023]
    /// 해외선물옵션 상품기본정보 API입니다.QRY_CNT에 SRS_CD 요청 개수 입력, SRS_CD_01 ~SRS_CD_32 까지 최대 32건의 상품코드 추가 입력하여 해외선물옵션 상품기본정보 확인이 가능합니다. (아래 Example 참고)
    struct searchcontractdetail : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 요청개수
            /// 입력한 코드 개수
            let QRY_CNT:String
            /// 품목종류
            /// 최대 32개 까지 가능
            let SRS_CD_01:String
            /// 품목종류…
            let SRS_CD_02:String
            /// 품목종류
            let SRS_CD_32:String
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
            /// 거래소코드
            let exch_cd:String
            /// 품목종류
            let clas_cd:String
            /// 거래통화
            let crc_cd:String
            /// 정산가
            let sttl_price:String
            /// 정산일
            let sttl_date:String
            /// 증거금
            let trst_mgn:String
            /// 가격표시진법
            let disp_digit:String
            /// 틱사이즈
            let tick_sz:String
            /// 틱가치
            let tick_val:String
            /// 장개시일자
            let mrkt_open_date:String
            /// 장개시시각
            let mrkt_open_time:String
            /// 장마감일자
            let mrkt_close_date:String
            /// 장마감시각
            let mrkt_close_time:String
            /// 상장일
            let trd_fr_date:String
            /// 만기일
            let expr_date:String
            /// 최종거래일
            let trd_to_date:String
            /// 잔존일수
            let remn_cnt:String
            /// 매매여부
            let stat_tp:String
            /// 계약크기
            let ctrt_size:String
            /// 최종결제구분
            let stl_tp:String
            /// 최초식별일
            let frst_noti_date:String
            /// 서브거래소코드
            let sub_exch_nm:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/search-contract-detail"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFC55200000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFC55200000
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

    /// 해외선물옵션 장운영시간 [해외선물-030]
    /// 해외선물 장운영시간 API입니다.한국투자 HTS(eFriend Force) > [6773] 해외선물 장운영시간 화면 의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct markettime : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FM상품군코드
            /// 공백
            let FM_PDGR_CD:String
            /// FM클래스코드
            /// '공백(전체), 001(통화), 002(금리), 003(지수), 004(농산물),005(축산물),006(금속),007(에너지)'
            let FM_CLAS_CD:String
            /// FM거래소코드
            /// 'CME(CME), EUREX(EUREX), HKEx(HKEx), ICE(ICE), SGX(SGX), OSE(OSE), ASX(ASX), CBOE(CBOE), MDEX(MDEX), NYSE(NYSE), BMF(BMF),FTX(FTX), HNX(HNX), ETC(기타)'
            let FM_EXCG_CD:String
            /// 옵션여부
            /// %(전체), N(선물), Y(옵션)
            let OPT_YN:String
            /// 연속조회키200
            let CTX_AREA_NK200:String
            /// 연속조회검색조건200
            let CTX_AREA_FK200:String
        }
        public struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            let output1: [Output1]
        }
        public struct Output1 : Codable {
            /// FM상품군코드
            let fm_pdgr_cd:String
            /// FM상품군명
            let fm_pdgr_name:String
            /// FM거래소코드
            let fm_excg_cd:String
            /// FM거래소명
            let fm_excg_name:String
            /// 선물옵션구분명
            let fuop_dvsn_name:String
            /// FM클래스코드
            let fm_clas_cd:String
            /// FM클래스명
            let fm_clas_name:String
            /// 오전장운영시작시각
            let am_mkmn_strt_tmd:String
            /// 오전장운영종료시각
            let am_mkmn_end_tmd:String
            /// 오후장운영시작시각
            let pm_mkmn_strt_tmd:String
            /// 오후장운영종료시각
            let pm_mkmn_end_tmd:String
            /// 장운영익일시작시각
            let mkmn_nxdy_strt_tmd:String
            /// 장운영익일종료시각
            let mkmn_nxdy_end_tmd:String
            /// 기본시장시작시각
            let base_mket_strt_tmd:String
            /// 기본시장종료시각
            let base_mket_end_tmd:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/market-time"
        public var customHeader: [String : String]?
        init(tr_id: String = "OTFM2229R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // OTFM2229R
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

    /// 해외선물 미결제추이 [해외선물-029]
    /// 해외선물 미결제추이 API입니다.한국투자 HTS(eFriend Force) > [5503] 해외선물 미결제약정추이 화면 의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 해외선물 투자자별 미결제약정 추이 자료설명1. 해외선물 투자자별 미결제약정 자료는 미국상품선물위원회(CFTC)에서 매주 1회 발표하고 있습니다.2. 기준일은 매주 화요일이며, 발표는 매주 금요일 15:30 (미국동부표준시)에 하며, 당사는 매주 토요일 아침에 자료를 업데이트하고 있습니다.3. 활용방법 : CFTC에서 발표하는 미결제약점 동향자료는 각 선물시장의 투기자금 동향을 파약하는데 용이하며, 특히, 상품시장에서 유용하게 활용할 수 있습니다.4. 주요항목 설명. 투기거래자 : 실물보유 또는 보유중인 실물에 대한 헤지목적이 아닌 가격변동에 따른 이익을 목적으로 거래하는 고객으로 주로 투자은행, 자산운용사, 헤지펀드, 개인투자자등임﻿﻿. 헤지거래자 : 실물보유 또는 보유중인 실물에 대한 헤지목적으로 거래하는 고객으로 주로 일반기업, 생산업체, 원자재공급업체등임.﻿﻿. 보고누락분 : 시장전체 미결제약정과 투기거래자와 헤지거래자 보고분 합계와의 차이로 투자주제가 확인안된 거래임.. 투자자 : 최종거래고객 기준이 아닌 거래소 회원 단위 기준임.5. CFTC 홈페이지: http://www.cftc.gov/index.htm
    struct investorunpdtrend : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 상품
            /// 금리 (GE, ZB, ZF,ZN,ZT), 금속(GC, PA, PL,SI, HG), 농산물(CC, CT,KC, OJ, SB, ZC,ZL, ZM, ZO, ZR, ZS, ZW), 에너지(CL, HO, NG, WBS), 지수(ES, NQ, TF, YM, VX), 축산물(GF, HE, LE), 통화(6A, 6B, 6C, 6E, 6J, 6N, 6S, DX)
            let PROD_ISCD:String
            /// 일자
            /// 기준일(ex)20240513)
            let BSOP_DATE:String
            /// 구분
            /// 0(수량), 1(증감)
            let UPMU_GUBUN:String
            /// CTS_KEY
            /// 공백
            let CTS_KEY:String
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
            /// 응답레코드카운트
            let row_cnt:String
        }
        public struct Output2 : Codable {
            /// 상품
            let prod_iscd:String
            /// CFTC코드
            let cftc_iscd:String
            /// 일자
            let bsop_date:String
            /// 매수투기
            let bidp_spec:String
            /// 매도투기
            let askp_spec:String
            /// 스프레드투기
            let spread_spec:String
            /// 매수헤지
            let bidp_hedge:String
            /// 매도헤지
            let askp_hedge:String
            /// 미결제합계
            let hts_otst_smtn:String
            /// 매수누락
            let bidp_missing:String
            /// 매도누락
            let askp_missing:String
            /// 매수투기고객
            let bidp_spec_cust:String
            /// 매도투기고객
            let askp_spec_cust:String
            /// 스프레드투기고객
            let spread_spec_cust:String
            /// 매수헤지고객
            let bidp_hedge_cust:String
            /// 매도헤지고객
            let askp_hedge_cust:String
            /// 고객합계
            let cust_smtn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/investor-unpd-trend"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDDB95030000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDDB95030000
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

    /// 해외옵션 호가 [해외선물-033]
    /// 해외옵션 호가 API입니다.한국투자 HTS(eFriend Force) > [5501] 해외선물옵션 현재가 화면 의 "왼쪽 상단 현재가" 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct optaskingprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목명
            /// 예)OESM24 C5340
            let SRS_CD:String
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
            /// array (1호가~ 5호가 순서대로 표시)
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 시가
            let open_price:String
            /// 고가
            let high_price:String
            /// 저가
            let lowp_rice:String
            /// 현재가
            let last_price:String
            /// 정산가
            let sttl_price:String
            /// 거래량
            let vol:String
            /// 전일대비가
            let prev_diff_price:String
            /// 전일대비율
            let prev_diff_rate:String
            /// 호가수신일자
            let quot_date:String
            /// 호가수신시각
            let quot_time:String
        }
        public struct Output2 : Codable {
            /// 매수수량
            let bid_qntt:String
            /// 매수번호
            let bid_num:String
            /// 매수호가
            let bid_price:String
            /// 매도수량
            let ask_qntt:String
            /// 매도번호
            let ask_num:String
            /// 매도호가
            let ask_price:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/opt-asking-price"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFO86000000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFO86000000
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

    /// 해외옵션종목상세 [해외선물-034]
    /// 해외옵션종목상세 API입니다.(주의) sstl_price 자리에 정산가 X 전일종가 O 가 수신되는 점 유의 부탁드립니다.(중요) 해외옵션시세 출력값을 해석하실 때 focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)에 있는 sCalcDesz(계산 소수점) 값을 활용하셔야 정확한 값을 받아오실 수 있습니다.- focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일) 다운로드 방법  1) focode.mst(해외지수옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외옵션정보.h)를 참고하여 해석  2) fostkcode.mst(해외주식옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외주식옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외주식옵션정보.h)를 참고하여 해석- 소수점 계산 시, focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)의 sCalcDesz(계산 소수점) 값 참고  EX) focode.mst 파일의 sCalcDesz(계산 소수점) 값       품목코드 OES 계산소수점 -2 → 시세 7525 수신 시 75.25 로 해석       품목코드 O6E 계산소수점 -4 → 시세 54.0 수신 시 0.0054 로 해석
    struct optdetail : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목명
            /// ex) OESU24 C5500 ※ 종목코드 "포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션/해외주식옵션" 참고
            let SRS_CD:String
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
            /// 거래소코드
            let exch_cd:String
            /// 품목종류
            let clas_cd:String
            /// 거래통화
            let crc_cd:String
            /// 전일종가
            /// (★주의) 정산가 X 전일종가 O 가 수신됨 ※ focode.mst, fostkcode.mst* 의 sCalcDesz(계산 소수점) 값 참고 * 포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션/해외주식옵션
            let sttl_price:String
            /// 정산일
            let sttl_date:String
            /// 증거금
            let trst_mgn:String
            /// 가격표시진법
            let disp_digit:String
            /// 틱사이즈
            let tick_sz:String
            /// 틱가치
            let tick_val:String
            /// 장개시일자
            let mrkt_open_date:String
            /// 장개시시각
            let mrkt_open_time:String
            /// 장마감일자
            let mrkt_close_date:String
            /// 장마감시각
            let mrkt_close_time:String
            /// 상장일
            let trd_fr_date:String
            /// 만기일
            let expr_date:String
            /// 최종거래일
            let trd_to_date:String
            /// 잔존일수
            let remn_cnt:String
            /// 매매여부
            let stat_tp:String
            /// 계약크기
            let ctrt_size:String
            /// 최종결제구분
            let stl_tp:String
            /// 최초식별일
            let frst_noti_date:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/opt-detail"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFO55010100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFO55010100
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

    /// 해외옵션종목현재가 [해외선물-035]
    /// 해외옵션종목현재가 API입니다.(중요) 해외옵션시세 출력값을 해석하실 때 focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)에 있는 sCalcDesz(계산 소수점) 값을 활용하셔야 정확한 값을 받아오실 수 있습니다.- focode.mst(해외지수옵션 종목마스터파일), (해외주식옵션 종목마스터파일) 다운로드 방법  1) focode.mst(해외지수옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외옵션정보.h)를 참고하여 해석  2) fostkcode.mst(해외주식옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외주식옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외주식옵션정보.h)를 참고하여 해석- 소수점 계산 시, focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)의 sCalcDesz(계산 소수점) 값 참고  EX) focode.mst 파일의 sCalcDesz(계산 소수점) 값       품목코드 OES 계산소수점 -2 → 시세 7525 수신 시 75.25 로 해석       품목코드 O6E 계산소수점 -4 → 시세 54.0 수신 시 0.0054 로 해석
    struct optprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목명
            /// ex) OESU24 C5500 ※ 종목코드 "포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션/해외주식옵션" 참고
            let SRS_CD:String
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
            /// 최종처리일자
            let proc_date:String
            /// 최종처리시각
            let proc_time:String
            /// 시가
            let open_price:String
            /// 고가
            let high_price:String
            /// 저가
            let low_price:String
            /// 현재가
            /// 현재가 ※ focode.mst, fostkcode.mst* 의 sCalcDesz(계산 소수점) 값 참고 * 포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션/해외주식옵션
            let last_price:String
            /// 누적거래수량
            let vol:String
            /// 전일대비구분
            let prev_diff_flag:String
            /// 전일대비가격
            let prev_diff_price:String
            /// 전일대비율
            let prev_diff_rate:String
            /// 매수1수량
            let bid_qntt:String
            /// 매수1호가
            let bid_price:String
            /// 매도1수량
            let ask_qntt:String
            /// 매도1호가
            let ask_price:String
            /// 증거금
            let trst_mgn:String
            /// 거래소코드
            let exch_cd:String
            /// 거래통화
            let crc_cd:String
            /// 상장일
            let trd_fr_date:String
            /// 만기일
            let expr_date:String
            /// 최종거래일
            let trd_to_date:String
            /// 잔존일수
            let remn_cnt:String
            /// 체결량
            let last_qntt:String
            /// 총매도잔량
            let tot_ask_qntt:String
            /// 총매수잔량
            let tot_bid_qntt:String
            /// 틱사이즈
            let tick_size:String
            /// 장개시일자
            let open_date:String
            /// 장개시시각
            let open_time:String
            /// 장종료일자
            let close_date:String
            /// 장종료시각
            let close_time:String
            /// 영업일자
            let sbsnsdate:String
            /// 정산가
            /// 정산가
            let sttl_price:String?
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/opt-price"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFO55010000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFO55010000
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

    /// 해외옵션 체결추이(주간) [해외선물-036]
    /// 해외옵션 체결추이(주간) API입니다.최근 120건까지 데이터 확인이 가능합니다. (START_DATE_TIME, CLOSE_DATE_TIME은 공란 입력)(중요) 해외옵션시세 출력값을 해석하실 때 focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)에 있는 sCalcDesz(계산 소수점) 값을 활용하셔야 정확한 값을 받아오실 수 있습니다.- focode.mst(해외지수옵션 종목마스터파일), (해외주식옵션 종목마스터파일) 다운로드 방법  1) focode.mst(해외지수옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외옵션정보.h)를 참고하여 해석  2) fostkcode.mst(해외주식옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외주식옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외주식옵션정보.h)를 참고하여 해석- 소수점 계산 시, focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)의 sCalcDesz(계산 소수점) 값 참고  EX) focode.mst 파일의 sCalcDesz(계산 소수점) 값       품목코드 OES 계산소수점 -2 → 시세 7525 수신 시 75.25 로 해석       품목코드 O6E 계산소수점 -4 → 시세 54.0 수신 시 0.0054 로 해석
    struct optweeklyccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// ex) OESU24 C5500 ※ 종목코드 "포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션/해외주식옵션" 참고
            let SRS_CD:String
            /// 거래소코드
            /// 종목코드에 맞는 거래소 코드 ex) CME
            let EXCH_CD:String
            /// 조회시작일시
            /// "" 공란 입력
            let START_DATE_TIME:String
            /// 조회종료일시
            /// "" 공란 입력
            let CLOSE_DATE_TIME:String
            /// 조회구분
            /// Q
            let QRY_TP:String
            /// 요청개수
            /// 예) 20 (최대 120)
            let QRY_CNT:String
            /// 묶음개수
            /// "" 공란 입력
            let QRY_GAP:String
            /// 이전조회KEY
            /// "" 공란 입력
            let INDEX_KEY:String
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
            /// 자료개수
            let ret_cnt:String
            /// N틱최종개수
            let last_n_cnt:String
            /// 이전조회KEY
            let index_key:String
        }
        public struct Output2 : Codable {
            /// 일자
            /// 과거일자 ~ 최근일자 순으로 조회됨
            let data_date:String
            /// 시간
            /// ""
            let data_time:String
            /// 시가
            let open_price:String
            /// 고가
            let high_price:String
            /// 저가
            let low_price:String
            /// 체결가격
            /// 체결가격 ※ focode.mst, fostkcode.mst* 의 sCalcDesz(계산 소수점) 값 참고 * 포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션/해외주식옵션
            let last_price:String
            /// 체결수량
            let last_qntt:String
            /// 누적거래수량
            let vol:String
            /// 전일대비구분
            let prev_diff_flag:String
            /// 전일대비가격
            let prev_diff_price:String
            /// 전일대비율
            let prev_diff_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/opt-weekly-ccnl"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFO55020000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFO55020000
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

    /// 해외옵션 체결추이(일간) [해외선물-037]
    /// 해외옵션 체결추이(일간) API입니다.최근 120건까지 데이터 확인이 가능합니다. ("QRY_CNT: 119 입력", START_DATE_TIME, CLOSE_DATE_TIME은 공란)※ 호출 시 유의사항 : START_DATE_TIME, CLOSE_DATE_TIME은 공란 입력, QRY_CNT는 확인 데이터 개수의 -1 개 입력ex) "START_DATE_TIME":"","CLOSE_DATE_TIME":"","QRY_CNT":"119" → 최근 120건 데이터 조회(중요) 해외옵션시세 출력값을 해석하실 때 focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)에 있는 sCalcDesz(계산 소수점) 값을 활용하셔야 정확한 값을 받아오실 수 있습니다.- focode.mst(해외지수옵션 종목마스터파일), (해외주식옵션 종목마스터파일) 다운로드 방법  1) focode.mst(해외지수옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외옵션정보.h)를 참고하여 해석  2) fostkcode.mst(해외주식옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외주식옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외주식옵션정보.h)를 참고하여 해석- 소수점 계산 시, focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)의 sCalcDesz(계산 소수점) 값 참고  EX) focode.mst 파일의 sCalcDesz(계산 소수점) 값       품목코드 OES 계산소수점 -2 → 시세 7525 수신 시 75.25 로 해석       품목코드 O6E 계산소수점 -4 → 시세 54.0 수신 시 0.0054 로 해석
    struct optdailyccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// ex) OESU24 C5500 ※ 종목코드 "포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션/해외주식옵션" 참고
            let SRS_CD:String
            /// 거래소코드
            /// 종목코드에 맞는 거래소 코드 ex) CME
            let EXCH_CD:String
            /// 조회시작일시
            /// "" 공란 입력
            let START_DATE_TIME:String
            /// 조회종료일시
            /// "" 공란 입력
            let CLOSE_DATE_TIME:String
            /// 조회구분
            /// Q
            let QRY_TP:String
            /// 요청개수
            /// 예) 100 (최대 119) ※ QRY_CNT 입력값의 +1 개 데이터가 조회됩니다.
            let QRY_CNT:String
            /// 묶음개수
            /// "" 공란 입력
            let QRY_GAP:String
            /// 이전조회KEY
            /// "" 공란 입력 ※ 다음조회 불가
            let INDEX_KEY:String
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
            /// 자료개수
            /// ※ "input > QRY_CNT" +1 개 만큼 조회됨
            let ret_cnt:String
            /// N틱최종개수
            let last_n_cnt:String
            /// 이전조회KEY
            let index_key:String
        }
        public struct Output2 : Codable {
            /// 일자
            /// 과거일자 ~ 최근일자 순으로 조회됨
            let data_date:String
            /// 시간
            /// ""
            let data_time:String
            /// 시가
            let open_price:String
            /// 고가
            let high_price:String
            /// 저가
            let low_price:String
            /// 체결가격
            /// 체결가격 ※ focode.mst, fostkcode.mst* 의 sCalcDesz(계산 소수점) 값 참고 * 포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션/해외주식옵션
            let last_price:String
            /// 체결수량
            let last_qntt:String
            /// 누적거래수량
            let vol:String
            /// 전일대비구분
            let prev_diff_flag:String
            /// 전일대비가격
            let prev_diff_price:String
            /// 전일대비율
            let prev_diff_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/opt-daily-ccnl"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFO55020100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFO55020100
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

    /// 해외옵션 체결추이(틱) [해외선물-038]
    /// 해외옵션 체결추이(틱) API입니다. 한 번의 호출에 40건까지 확인 가능하며, QRY_TP, INDEX_KEY 를 이용하여 다음조회 가능합니다.※ 다음조회 방법(처음조회) "QRY_TP":"Q", "QRY_CNT":"40", "INDEX_KEY":""(다음조회) "QRY_TP":"P", "QRY_CNT":"40", "INDEX_KEY":"20240906       221"  ◀ 이전 호출의 "output1 > index_key" 기입(중요) 해외옵션시세 출력값을 해석하실 때 focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)에 있는 sCalcDesz(계산 소수점) 값을 활용하셔야 정확한 값을 받아오실 수 있습니다.- focode.mst(해외지수옵션 종목마스터파일), (해외주식옵션 종목마스터파일) 다운로드 방법  1) focode.mst(해외지수옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외옵션정보.h)를 참고하여 해석  2) fostkcode.mst(해외주식옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외주식옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외주식옵션정보.h)를 참고하여 해석- 소수점 계산 시, focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)의 sCalcDesz(계산 소수점) 값 참고  EX) focode.mst 파일의 sCalcDesz(계산 소수점) 값       품목코드 OES 계산소수점 -2 → 시세 7525 수신 시 75.25 로 해석       품목코드 O6E 계산소수점 -4 → 시세 54.0 수신 시 0.0054 로 해석
    struct opttickccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// ex) OESU24 C5500 ※ 종목코드 "포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션/해외주식옵션" 참고
            let SRS_CD:String
            /// 거래소코드
            /// 종목코드에 맞는 거래소 코드 ex) CME
            let EXCH_CD:String
            /// 조회시작일시
            /// "" 공란 입력
            let START_DATE_TIME:String
            /// 조회종료일시
            /// "" 공란 입력 ※ 날짜 입력해도 처리 안됨
            let CLOSE_DATE_TIME:String
            /// 조회구분
            /// Q : 최초조회시 , P : 다음키(INDEX_KEY) 입력하여 조회시
            let QRY_TP:String
            /// 요청개수
            /// 예) 30 (최대 40)
            let QRY_CNT:String
            /// 묶음개수
            /// 공백
            let QRY_GAP:String
            /// 이전조회KEY
            /// 다음조회(QRY_TP를 P로 입력) 시, 이전 호출의 "output1 > index_key" 기입하여 조회
            let INDEX_KEY:String
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
            /// 자료개수
            let ret_cnt:String
            /// N틱최종개수
            let last_n_cnt:String
            /// 이전조회KEY
            let index_key:String
        }
        public struct Output2 : Codable {
            /// 일자
            /// 과거일자 ~ 최근일자 순으로 조회됨
            let data_date:String
            /// 시간
            /// HHMMSS
            let data_time:String
            /// 시가
            let open_price:String
            /// 고가
            let high_price:String
            /// 저가
            let low_price:String
            /// 체결가격
            /// 체결가격 ※ focode.mst, fostkcode.mst* 의 sCalcDesz(계산 소수점) 값 참고 * 포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션/해외주식옵션
            let last_price:String
            /// 체결수량
            let last_qntt:String
            /// 누적거래수량
            let vol:String
            /// 전일대비구분
            let prev_diff_flag:String
            /// 전일대비가격
            let prev_diff_price:String
            /// 전일대비율
            let prev_diff_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/opt-tick-ccnl"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFO55020200", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFO55020200
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

    /// 해외옵션 체결추이(월간) [해외선물-039]
    /// 해외옵션 체결추이(월간) API입니다. 최근 120건까지 데이터 확인이 가능합니다. (START_DATE_TIME, CLOSE_DATE_TIME은 공란 입력)(중요) 해외옵션시세 출력값을 해석하실 때 focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)에 있는 sCalcDesz(계산 소수점) 값을 활용하셔야 정확한 값을 받아오실 수 있습니다.- focode.mst(해외지수옵션 종목마스터파일), (해외주식옵션 종목마스터파일) 다운로드 방법  1) focode.mst(해외지수옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외옵션정보.h)를 참고하여 해석  2) fostkcode.mst(해외주식옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외주식옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외주식옵션정보.h)를 참고하여 해석- 소수점 계산 시, focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)의 sCalcDesz(계산 소수점) 값 참고  EX) focode.mst 파일의 sCalcDesz(계산 소수점) 값       품목코드 OES 계산소수점 -2 → 시세 7525 수신 시 75.25 로 해석       품목코드 O6E 계산소수점 -4 → 시세 54.0 수신 시 0.0054 로 해석
    struct optmonthlyccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// ex) OESU24 C5500 ※ 종목코드 "포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션/해외주식옵션" 참고
            let SRS_CD:String
            /// 거래소코드
            /// 종목코드에 맞는 거래소 코드 ex) CME
            let EXCH_CD:String
            /// 조회시작일시
            /// "" 공란 입력
            let START_DATE_TIME:String
            /// 조회종료일시
            /// "" 공란 입력
            let CLOSE_DATE_TIME:String
            /// 조회구분
            /// Q
            let QRY_TP:String
            /// 요청개수
            /// 예) 20 (최대 120)
            let QRY_CNT:String
            /// 묶음개수
            /// "" 공란 입력
            let QRY_GAP:String
            /// 이전조회KEY
            /// "" 공란 입력
            let INDEX_KEY:String
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
            /// 자료개수
            let ret_cnt:String
            /// N틱최종개수
            let last_n_cnt:String
            /// 이전조회KEY
            let index_key:String
        }
        public struct Output2 : Codable {
            /// 일자
            /// 과거일자 ~ 최근일자 순으로 조회됨
            let data_date:String
            /// 시간
            /// ""
            let data_time:String
            /// 시가
            let open_price:String
            /// 고가
            let high_price:String
            /// 저가
            let low_price:String
            /// 체결가격
            /// 체결가격 ※ focode.mst, fostkcode.mst* 의 sCalcDesz(계산 소수점) 값 참고 * 포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션/해외주식옵션
            let last_price:String
            /// 체결수량
            let last_qntt:String
            /// 누적거래수량
            let vol:String
            /// 전일대비구분
            let prev_diff_flag:String
            /// 전일대비가격
            let prev_diff_price:String
            /// 전일대비율
            let prev_diff_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/opt-monthly-ccnl"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFO55020300", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFO55020300
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

    /// 해외옵션 분봉조회 [해외선물-040]
    /// 해외옵션 분봉조회 API입니다. 한 번의 호출에 120건까지 확인 가능하며, QRY_TP, INDEX_KEY 를 이용하여 다음조회 가능합니다.※ 다음조회 방법(처음조회) "QRY_TP":"Q", "QRY_CNT":"120", "INDEX_KEY":""(다음조회) "QRY_TP":"P", "QRY_CNT":"120", "INDEX_KEY":"20240902         5"  ◀ 이전 호출의 "output1 > index_key" 기입(중요) 해외옵션시세 출력값을 해석하실 때 focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)에 있는 sCalcDesz(계산 소수점) 값을 활용하셔야 정확한 값을 받아오실 수 있습니다.- focode.mst(해외지수옵션 종목마스터파일), (해외주식옵션 종목마스터파일) 다운로드 방법  1) focode.mst(해외지수옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외옵션정보.h)를 참고하여 해석  2) fostkcode.mst(해외주식옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외주식옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외주식옵션정보.h)를 참고하여 해석- 소수점 계산 시, focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)의 sCalcDesz(계산 소수점) 값 참고  EX) focode.mst 파일의 sCalcDesz(계산 소수점) 값       품목코드 OES 계산소수점 -2 → 시세 7525 수신 시 75.25 로 해석       품목코드 O6E 계산소수점 -4 → 시세 54.0 수신 시 0.0054 로 해석
    struct inquiretimeoptchartprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 종목코드
            /// ex) OESU24 C5500 ※ 종목코드 "포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션/해외주식옵션" 참고
            let SRS_CD:String
            /// 거래소코드
            /// 종목코드에 맞는 거래소 코드 ex) CME
            let EXCH_CD:String
            /// 조회시작일시
            /// "" 공란 입력
            let START_DATE_TIME:String
            /// 조회종료일시
            /// "" 공란 입력 ※ 날짜 입력해도 처리 안됨
            let CLOSE_DATE_TIME:String
            /// 조회구분
            /// Q : 최초조회시 , P : 다음키(INDEX_KEY) 입력하여 조회시
            let QRY_TP:String
            /// 요청개수
            /// 예) 120 (최대 120)
            let QRY_CNT:String
            /// 묶음개수
            /// 1: 1분봉, 5: 5분봉 ...
            let QRY_GAP:String
            /// 이전조회KEY
            /// 다음조회(QRY_TP를 P로 입력) 시, 이전 호출의 "output1 > index_key" 기입하여 조회
            let INDEX_KEY:String
        }
        public struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object
            let output2: Output2
            /// 응답상세 : Object Array
            /// array
            let output1: [Output1]
        }
        public struct Output2 : Codable {
            /// 자료개수
            let ret_cnt:String
            /// N틱최종개수
            let last_n_cnt:String
            /// 이전조회KEY
            let index_key:String
        }
        public struct Output1 : Codable {
            /// 일자
            let data_date:String
            /// 시간
            let data_time:String
            /// 시가
            let open_price:String
            /// 고가
            let high_price:String
            /// 저가
            let low_price:String
            /// 체결가격
            /// 체결가격 ※ focode.mst, fostkcode.mst* 의 sCalcDesz(계산 소수점) 값 참고 * 포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션/해외주식옵션
            let last_price:String
            /// 체결수량
            let last_qntt:String
            /// 누적거래수량
            let vol:String
            /// 전일대비구분
            let prev_diff_flag:String
            /// 전일대비가격
            let prev_diff_price:String
            /// 전일대비율
            let prev_diff_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/inquire-time-optchartprice"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFO55020400", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFO55020400
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

    /// 해외옵션 상품기본정보 [해외선물-041]
    /// 해외옵션 상품기본정보 API입니다.(중요) 해외옵션시세 출력값을 해석하실 때 focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)에 있는 sCalcDesz(계산 소수점) 값을 활용하셔야 정확한 값을 받아오실 수 있습니다.- focode.mst(해외지수옵션 종목마스터파일), (해외주식옵션 종목마스터파일) 다운로드 방법  1) focode.mst(해외지수옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외옵션정보.h)를 참고하여 해석  2) fostkcode.mst(해외주식옵션 종목마스터파일)     : 포럼 > FAQ > 종목정보 다운로드(해외) - 해외주식옵션 클릭하여 다운로드 후       Github의 헤더정보(https://github.com/koreainvestment/open-trading-api/blob/main/stocks_info/해외주식옵션정보.h)를 참고하여 해석- 소수점 계산 시, focode.mst(해외지수옵션 종목마스터파일), fostkcode.mst(해외주식옵션 종목마스터파일)의 sCalcDesz(계산 소수점) 값 참고  EX) focode.mst 파일의 sCalcDesz(계산 소수점) 값       품목코드 OES 계산소수점 -2 → 시세 7525 수신 시 75.25 로 해석       품목코드 O6E 계산소수점 -4 → 시세 54.0 수신 시 0.0054 로 해석
    struct searchoptdetail : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 요청개수
            /// 입력한 코드 개수
            let QRY_CNT:String
            /// 종목코드1
            /// SRS_CD_01부터 차례로 입력(ex ) OESU24 C5500 최대 30개 까지 가능
            let SRS_CD_01:String
            /// 종목코드2
            let SRS_CD_02:String
            /// 종목코드30
            let SRS_CD_30:String
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
            let output2: [Output2]
        }
        public struct Output2 : Codable {
            /// 거래소코드
            let exch_cd:String
            /// 품목종류
            let clas_cd:String
            /// 거래통화
            let crc_cd:String
            /// 정산가
            /// 정산가 ※ focode.mst, fostkcode.mst* 의 sCalcDesz(계산 소수점) 값 참고 * 포럼 > FAQ > 종목정보 다운로드(해외) - 해외지수옵션/해외주식옵션
            let sttl_price:String
            /// 정산일
            let sttl_date:String
            /// 증거금
            let trst_mgn:String
            /// 가격표시진법
            let disp_digit:String
            /// 틱사이즈
            let tick_sz:String
            /// 틱가치
            let tick_val:String
            /// 장개시일자
            let mrkt_open_date:String
            /// 장개시시각
            let mrkt_open_time:String
            /// 장마감일자
            let mrkt_close_date:String
            /// 장마감시각
            let mrkt_close_time:String
            /// 상장일
            let trd_fr_date:String
            /// 만기일
            let expr_date:String
            /// 최종거래일
            let trd_to_date:String
            /// 잔존일수
            let remn_cnt:String
            /// 매매여부
            let stat_tp:String
            /// 계약크기
            let ctrt_size:String
            /// 최종결제구분
            let stl_tp:String
            /// 최초식별일
            let frst_noti_date:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-futureoption/v1/quotations/search-opt-detail"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFO55200000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFO55200000
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
