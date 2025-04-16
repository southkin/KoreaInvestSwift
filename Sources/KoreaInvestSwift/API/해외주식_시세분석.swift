//
//  해외주식_시세분석.swift
//  KoreaInvestSwift
//
//  Created by kin on 4/12/25.
//

import FullyRESTful
extension KISAPI {
    enum 해외주식_시세분석 {}
}
extension KISAPI.해외주식_시세분석 {
    /// 해외주식 가격급등락[해외주식-038]
    struct pricefluct : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// 공백
            let AUTH:String
            /// 거래소코드
            /// 'NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 HKS : 홍콩, SHS : 상해 , SZS : 심천 HSX : 호치민, HNX : 하노이 TSE : 도쿄 '
            let EXCD:String
            /// 급등/급락구분
            /// 0(급락), 1(급등)
            let GUBN:String
            /// N분전콤보값
            /// N분전 : 0(1분전), 1(2분전), 2(3분전), 3(5분전), 4(10분전), 5(15분전), 6(20분전), 7(30분전), 8(60분전), 9(120분전)
            let MIXN:String
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
            /// 거래상태
            let stat:String
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
            let knam:String
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
            /// 매도호가
            let pask:String
            /// 매수호가
            let pbid:String
            /// 기준가격
            let n_base:String
            /// 기준가격대비
            let n_diff:String
            /// 기준가격대비율
            let n_rate:String
            /// 영문종목명
            let enam:String
            /// 매매가능
            let e_ordyn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/ranking/price-fluct"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76260000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS76260000
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

    /// 해외주식 거래량급증[해외주식-039]
    struct volumesurge : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// 공백
            let AUTH:String
            /// 거래소코드
            /// 'NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 HKS : 홍콩, SHS : 상해 , SZS : 심천 HSX : 호치민, HNX : 하노이 TSE : 도쿄 '
            let EXCD:String
            /// N분전콤보값
            /// N분전 : 0(1분전), 1(2분전), 2(3분전), 3(5분전), 4(10분전), 5(15분전), 6(20분전), 7(30분전), 8(60분전), 9(120분전)
            let MIXN:String
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
            /// 거래상태
            let stat:String
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
            let knam:String
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
            /// 매도호가
            let pask:String
            /// 매수호가
            let pbid:String
            /// 기준거래량
            let n_tvol:String
            /// 증가량
            let n_diff:String
            /// 증가율
            let n_rate:String
            /// 영문종목명
            let enam:String
            /// 매매가능
            let e_ordyn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/ranking/volume-surge"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76270000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS76270000
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

    /// 해외주식 매수체결강도상위[해외주식-040]
    struct volumepower : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// 공백
            let AUTH:String
            /// 거래소코드
            /// 'NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 HKS : 홍콩, SHS : 상해 , SZS : 심천 HSX : 호치민, HNX : 하노이 TSE : 도쿄 '
            let EXCD:String
            /// N일자값
            /// N분전 : 0(1분전), 1(2분전), 2(3분전), 3(5분전), 4(10분전), 5(15분전), 6(20분전), 7(30분전), 8(60분전), 9(120분전)
            let NDAY:String
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
            /// 거래상태
            let stat:String
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
            let knam:String
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
            /// 매도호가
            let pask:String
            /// 매수호가
            let pbid:String
            /// 당일체결강도
            let tpow:String
            /// 체결강도
            let powx:String
            /// 영문종목명
            let enam:String
            /// 매매가능
            let e_ordyn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/ranking/volume-power"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76280000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS76280000
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

    /// 해외주식 상승율/하락율[해외주식-041]
    struct updownrate : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// 공백
            let AUTH:String
            /// 거래소코드
            /// 'NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 HKS : 홍콩, SHS : 상해 , SZS : 심천 HSX : 호치민, HNX : 하노이 TSE : 도쿄 '
            let EXCD:String
            /// 상승율/하락율 구분
            /// 0(하락율), 1(상승율)
            let GUBN:String
            /// N일자값
            /// N일전 : 0(당일), 1(2일), 2(3일), 3(5일), 4(10일), 5(20일전), 6(30일), 7(60일), 8(120일), 9(1년)
            let NDAY:String
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
            /// 현재Count
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
            /// 매도호가
            let pask:String
            /// 매수호가
            let pbid:String
            /// 기준가격
            let n_base:String
            /// 기준가격대비
            let n_diff:String
            /// 기준가격대비율
            let n_rate:String
            /// 순위
            let rank:String
            /// 영문종목명
            let ename:String
            /// 매매가능
            let e_ordyn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/ranking/updown-rate"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76290000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS76290000
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

    /// 해외주식 신고/신저가[해외주식-042]
    struct newhighlow : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// 공백
            let AUTH:String
            /// 거래소코드
            /// 'NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 HKS : 홍콩, SHS : 상해 , SZS : 심천 HSX : 호치민, HNX : 하노이 TSE : 도쿄 '
            let EXCD:String
            /// 신고/신저 구분
            /// 신고(1) 신저(0)
            let GUBN:String
            /// 일시돌파/돌파 구분
            /// 일시돌파(0) 돌파유지(1)
            let GUBN2:String
            /// N일자값
            /// N일전 : 0(5일), 1(10일), 2(20일), 3(30일), 4(60일), 5(120일전), 6(52주), 7(1년)
            let NDAY:String
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
            /// 매도호가
            let pask:String
            /// 매수호가
            let pbid:String
            /// 기준가
            let n_base:String
            /// 기준가대비
            let n_diff:String
            /// 기준가대비율
            let n_rate:String
            /// 영문종목명
            let ename:String
            /// 매매가능
            let e_ordyn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/ranking/new-highlow"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76300000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS76300000
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

    /// 해외주식 거래량순위[해외주식-043]
    struct tradevol : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// 공백
            let AUTH:String
            /// 거래소코드
            /// 'NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 HKS : 홍콩, SHS : 상해 , SZS : 심천 HSX : 호치민, HNX : 하노이 TSE : 도쿄 '
            let EXCD:String
            /// N일자값
            /// N일전 : 0(당일), 1(2일), 2(3일), 3(5일), 4(10일), 5(20일전), 6(30일), 7(60일), 8(120일), 9(1년)
            let NDAY:String
            /// 현재가 필터범위 1
            /// 가격 ~
            let PRC1:String
            /// 현재가 필터범위 2
            /// ~ 가격
            let PRC2:String
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
            /// 매도호가
            let pask:String
            /// 매수호가
            let pbid:String
            /// 거래량
            let tvol:String
            /// 거래대금
            let tamt:String
            /// 평균거래량
            let a_tvol:String
            /// 순위
            let rank:String
            /// 영문종목명
            let ename:String
            /// 매매가능
            let e_ordyn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/ranking/trade-vol"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76310010", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS76310010
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

    /// 해외주식 거래대금순위[해외주식-044]
    struct tradepbmn : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// 공백
            let AUTH:String
            /// 거래소코드
            /// 'NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 HKS : 홍콩, SHS : 상해 , SZS : 심천 HSX : 호치민, HNX : 하노이 TSE : 도쿄 '
            let EXCD:String
            /// N일자값
            /// N일전 : 0(당일), 1(2일), 2(3일), 3(5일), 4(10일), 5(20일전), 6(30일), 7(60일), 8(120일), 9(1년)
            let NDAY:String
            /// 거래량조건
            /// 0(전체), 1(1백주이상), 2(1천주이상), 3(1만주이상), 4(10만주이상), 5(100만주이상), 6(1000만주이상)
            let VOL_RANG:String
            /// 현재가 필터범위 1
            /// 가격 ~
            let PRC1:String
            /// 현재가 필터범위 2
            /// ~ 가격
            let PRC2:String
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
            /// 매도호가
            let pask:String
            /// 매수호가
            let pbid:String
            /// 거래량
            let tvol:String
            /// 거래대금
            let tamt:String
            /// 평균거래대금
            let a_tamt:String
            /// 순위
            let rank:String
            /// 영문종목명
            let ename:String
            /// 매매가능
            let e_ordyn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/ranking/trade-pbmn"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76320010", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS76320010
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

    /// 해외주식 거래증가율순위[해외주식-045]
    struct tradegrowth : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// 공백
            let AUTH:String
            /// 거래소코드
            /// 'NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 HKS : 홍콩, SHS : 상해 , SZS : 심천 HSX : 호치민, HNX : 하노이 TSE : 도쿄 '
            let EXCD:String
            /// N일자값
            /// N일전 : 0(당일), 1(2일), 2(3일), 3(5일), 4(10일), 5(20일전), 6(30일), 7(60일), 8(120일), 9(1년)
            let NDAY:String
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
            /// 매도호가
            let pask:String
            /// 매수호가
            let pbid:String
            /// 거래량
            let tvol:String
            /// 평균거래량
            let n_tvol:String
            /// 증가율
            let n_rate:String
            /// 순위
            let rank:String
            /// 영문종목명
            let ename:String
            /// 매매가능
            let e_ordyn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/ranking/trade-growth"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76330000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS76330000
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

    /// 해외주식 거래회전율순위[해외주식-046]
    struct tradeturnover : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// 공백
            let AUTH:String
            /// 거래소코드
            /// 'NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 HKS : 홍콩, SHS : 상해 , SZS : 심천 HSX : 호치민, HNX : 하노이 TSE : 도쿄 '
            let EXCD:String
            /// N일자값
            /// N일전 : 0(당일), 1(2일), 2(3일), 3(5일), 4(10일), 5(20일전), 6(30일), 7(60일), 8(120일), 9(1년)
            let NDAY:String
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
            /// 매도호가
            let pask:String
            /// 매수호가
            let pbid:String
            /// 평균거래량
            let n_tvol:String
            /// 상장주식수
            let shar:String
            /// 회전율
            let tover:String
            /// 순위
            let rank:String
            /// 영문종목명
            let ename:String
            /// 매매가능
            let e_ordyn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/ranking/trade-turnover"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76340000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS76340000
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

    /// 해외주식 시가총액순위[해외주식-047]
    struct marketcap : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// 공백
            let AUTH:String
            /// 거래소코드
            /// 'NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 HKS : 홍콩, SHS : 상해 , SZS : 심천 HSX : 호치민, HNX : 하노이 TSE : 도쿄 '
            let EXCD:String
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
            /// 상장주식수
            let shar:String
            /// 시가총액
            let tomv:String
            /// 비중
            let grav:String
            /// 순위
            let rank:String
            /// 영문종목명
            let ename:String
            /// 매매가능
            let e_ordyn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-stock/v1/ranking/market-cap"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS76350100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS76350100
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

    /// 해외주식 기간별권리조회 [해외주식-052]
    /// 해외주식 기간별권리조회 API입니다.한국투자 HTS(eFriend Plus) > [7520] 기간별해외증권권리조회 화면을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 확정여부가 '예정'으로 표시되는 경우는 권리정보가 변경될 수 있으니 참고자료로만 활용하시기 바랍니다.
    struct periodrights : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 권리유형코드
            /// '%%(전체), 01(유상), 02(무상), 03(배당), 11(합병), 14(액면분할), 15(액면병합), 17(감자), 54(WR청구), 61(원리금상환), 71(WR소멸), 74(배당옵션), 75(특별배당), 76(ISINCODE변경), 77(실권주청약)'
            let RGHT_TYPE_CD:String
            /// 조회구분코드
            /// 02(현지기준일), 03(청약시작일), 04(청약종료일)
            let INQR_DVSN_CD:String
            /// 조회시작일자
            /// 일자 ~
            let INQR_STRT_DT:String
            /// 조회종료일자
            /// ~ 일자
            let INQR_END_DT:String
            /// 상품번호
            /// 공백
            let PDNO:String
            /// 상품유형코드
            /// 공백
            let PRDT_TYPE_CD:String
            /// 연속조회키50
            /// 공백
            let CTX_AREA_NK50:String
            /// 연속조회검색조건50
            /// 공백
            let CTX_AREA_FK50:String
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
            /// 기준일자
            let bass_dt:String
            /// 권리유형코드
            let rght_type_cd:String
            /// 상품번호
            let pdno:String
            /// 상품명
            let prdt_name:String
            /// 상품유형코드
            let prdt_type_cd:String
            /// 표준상품번호
            let std_pdno:String
            /// 현지기준일자
            let acpl_bass_dt:String
            /// 청약시작일자
            let sbsc_strt_dt:String
            /// 청약종료일자
            let sbsc_end_dt:String
            /// 현금배정비율
            let cash_alct_rt:String
            /// 주식배정비율
            let stck_alct_rt:String
            /// 통화코드
            let crcy_cd:String
            /// 통화코드2
            let crcy_cd2:String
            /// 통화코드3
            let crcy_cd3:String
            /// 통화코드4
            let crcy_cd4:String
            /// 배정외화단가
            let alct_frcr_unpr:String
            /// 주당배당외화금액2
            let stkp_dvdn_frcr_amt2:String
            /// 주당배당외화금액3
            let stkp_dvdn_frcr_amt3:String
            /// 주당배당외화금액4
            let stkp_dvdn_frcr_amt4:String
            /// 확정여부
            let dfnt_yn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-price/v1/quotations/period-rights"
        public var customHeader: [String : String]?
        init(tr_id: String = "CTRGT011R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // CTRGT011R
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

    /// 해외뉴스종합(제목) [해외주식-053]
    /// 해외뉴스종합(제목) API입니다.한국투자 HTS(eFriend Plus) > [7702] 해외뉴스종합 화면의 "우측 상단 뉴스목록" 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct newstitle : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 뉴스구분
            /// 전체: 공백
            let INFO_GB:String
            /// 중분류
            /// 전체: 공백
            let CLASS_CD:String
            /// 국가코드
            /// 전체: 공백 CN(중국), HK(홍콩), US(미국)
            let NATION_CD:String
            /// 거래소코드
            /// 전체: 공백
            let EXCHANGE_CD:String
            /// 종목코드
            /// 전체: 공백
            let SYMB:String
            /// 조회일자
            /// 전체: 공백 특정일자(YYYYMMDD) ex. 20240502
            let DATA_DT:String
            /// 조회시간
            /// 전체: 공백 전체: 공백 특정시간(HHMMSS) ex. 093500
            let DATA_TM:String
            /// 다음키
            /// 공백 입력
            let CTS:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 - array
            let outblock1:[Outblock1]
        }
        struct Outblock1: Codable {
            /// 뉴스구분 -
            let info_gb: String
            /// 뉴스키 -
            let news_key: String
            /// 조회일자 -
            let data_dt: String
            /// 조회시간 -
            let data_tm: String
            /// 중분류 -
            let class_cd: String
            /// 중분류명 -
            let class_name: String
            /// 자료원 -
            let source: String
            /// 국가코드 -
            let nation_cd: String
            /// 거래소코드 -
            let exchange_cd: String
            /// 종목코드 -
            let symb: String
            /// 종목명 -
            let symb_name: String
            /// 제목 -
            let title: String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-price/v1/quotations/news-title"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHPSTH60100C1", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHPSTH60100C1
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

    /// 해외주식 권리종합 [해외주식-050]
    /// 해외주식 권리종합 API입니다.한국투자 HTS(eFriend Plus) > [7833] 해외주식 권리(ICE제공) 화면의 "전체" 탭 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 조회기간 기준일 입력시 참고 - 상환: 상환일자, 조기상환: 조기상환일자, 티커변경: 적용일, 그 외: 발표일
    struct rightsbyice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 국가코드
            /// CN:중국 HK:홍콩 US:미국 JP:일본 VN:베트남
            let NCOD:String
            /// 심볼
            /// 종목코드
            let SYMB:String
            /// 일자 시작일
            /// 미입력 시, 오늘-3개월 기간지정 시, 종료일 입력(ex. 20240514) ※ 조회기간 기준일 입력시 참고 - 상환: 상환일자, 조기상환: 조기상환일자, 티커변경: 적용일, 그 외: 발표일
            let ST_YMD:String
            /// 일자 종료일
            /// 미입력 시, 오늘+3개월 기간지정 시, 종료일 입력(ex. 20240514) ※ 조회기간 기준일 입력시 참고 - 상환: 상환일자, 조기상환: 조기상환일자, 티커변경: 적용일, 그 외: 발표일
            let ED_YMD:String
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
            /// ICE공시일
            let anno_dt:String
            /// 권리유형
            let ca_title:String
            /// 배당락일
            let div_lock_dt:String
            /// 지급일
            let pay_dt:String
            /// 기준일
            let record_dt:String
            /// 효력일자
            let validity_dt:String
            /// 현지지시마감일
            let local_end_dt:String
            /// 권리락일
            let lock_dt:String
            /// 상장폐지일
            let delist_dt:String
            /// 상환일자
            let redempt_dt:String
            /// 조기상환일자
            let early_redempt_dt:String
            /// 적용일
            let effective_dt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-price/v1/quotations/rights-by-ice"
        public var customHeader: [String : String]?
        init(tr_id: String = "HHDFS78330900", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHDFS78330900
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

    /// 당사 해외주식담보대출 가능 종목 [해외주식-051]
    /// 당사 해외주식담보대출 가능 종목 API입니다.한국투자 HTS(eFriend Plus) > [0497] 당사 해외주식담보대출 가능 종목 화면 의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.한 번의 호출에 20건까지 조회가 가능하며 다음조회가 불가하기에, PDNO에 데이터 확인하고자 하는 종목코드를 입력하여 단건조회용으로 사용하시기 바랍니다.
    struct colablebycompany : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 상품번호
            /// ex)AMD
            let PDNO:String
            /// 상품유형코드
            /// 공백
            let PRDT_TYPE_CD:String
            /// 조회시작일자
            /// 공백
            let INQR_STRT_DT:String
            /// 조회종료일자
            /// 공백
            let INQR_END_DT:String
            /// 조회구분
            /// 공백
            let INQR_DVSN:String
            /// 국가코드
            /// 840(미국), 344(홍콩), 156(중국)
            let NATN_CD:String
            /// 조회순서구분
            /// 01(이름순), 02(코드순)
            let INQR_SQN_DVSN:String
            /// 비율구분코드
            /// 공백
            let RT_DVSN_CD:String
            /// 비율
            /// 공백
            let RT:String
            /// 대출가능여부
            /// 공백
            let LOAN_PSBL_YN:String
            /// 연속조회검색조건100
            /// 공백
            let CTX_AREA_FK100:String
            /// 연속조회키100
            /// 공백
            let CTX_AREA_NK100:String
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
            /// 상품번호
            let pdno:String
            /// 해외종목명
            let ovrs_item_name:String
            /// 대출비율
            let loan_rt:String
            /// 담보유지비율
            let mgge_mntn_rt:String
            /// 담보확보비율
            let mgge_ensu_rt:String
            /// 대출실행가능여부
            let loan_exec_psbl_yn:String
            /// 직원명
            let stff_name:String
            /// 등록일자
            let erlm_dt:String
            /// 거래시장명
            let tr_mket_name:String
            /// 통화코드
            let crcy_cd:String
            /// 국가한글명
            let natn_kor_name:String
            /// 해외거래소코드
            let ovrs_excg_cd:String
        }
        public struct Output2 : Codable {
            /// 대출가능종목수
            let loan_psbl_item_num:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-price/v1/quotations/colable-by-company"
        public var customHeader: [String : String]?
        init(tr_id: String = "CTLN4050R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // CTLN4050R
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

    /// 해외속보(제목) [해외주식-055]
    /// 해외속보(제목) API입니다.한국투자 HTS(eFriend Plus) > [7704] 해외속보 화면 의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 100건까지 조회 가능합니다.
    struct brknewstitle : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 뉴스제공업체코드
            /// 뉴스제공업체구분=>0:전체조회
            let FID_NEWS_OFER_ENTP_CODE:String
            /// 조건시장구분코드
            /// 공백
            let FID_COND_MRKT_CLS_CODE:String
            /// 입력종목코드
            /// 공백
            let FID_INPUT_ISCD:String
            /// 제목내용
            /// 공백
            let FID_TITL_CNTT:String
            /// 입력날짜1
            /// 공백
            let FID_INPUT_DATE_1:String
            /// 입력시간1
            /// 공백
            let FID_INPUT_HOUR_1:String
            /// 순위정렬구분코드
            /// 공백
            let FID_RANK_SORT_CLS_CODE:String
            /// 입력일련번호
            /// 공백
            let FID_INPUT_SRNO:String
            /// 조건화면분류코드
            /// 화면번호:11801
            let FID_COND_SCR_DIV_CODE:String
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
            /// 내용조회용일련번호
            let cntt_usiq_srno:String
            /// 뉴스제공업체코드
            let news_ofer_entp_code:String
            /// 작성일자
            let data_dt:String
            /// 작성시간
            let data_tm:String
            /// HTS공시제목내용
            let hts_pbnt_titl_cntt:String
            /// 뉴스대구분
            let news_lrdv_code:String
            /// 자료원
            let dorg:String
            /// 종목코드1
            let iscd1:String
            /// 종목코드2
            let iscd2:String
            /// 종목코드3
            let iscd3:String
            /// 종목코드4
            let iscd4:String
            /// 종목코드5
            let iscd5:String
            /// 종목코드6
            let iscd6:String
            /// 종목코드7
            let iscd7:String
            /// 종목코드8
            let iscd8:String
            /// 종목코드9
            let iscd9:String
            /// 종목코드10
            let iscd10:String
            /// 한글종목명1
            let kor_isnm1:String
            /// 한글종목명2
            let kor_isnm2:String
            /// 한글종목명3
            let kor_isnm3:String
            /// 한글종목명4
            let kor_isnm4:String
            /// 한글종목명5
            let kor_isnm5:String
            /// 한글종목명6
            let kor_isnm6:String
            /// 한글종목명7
            let kor_isnm7:String
            /// 한글종목명8
            let kor_isnm8:String
            /// 한글종목명9
            let kor_isnm9:String
            /// 한글종목명10
            let kor_isnm10:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/overseas-price/v1/quotations/brknews-title"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKST01011801", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST01011801
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
