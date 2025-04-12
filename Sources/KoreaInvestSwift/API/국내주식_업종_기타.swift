//
//  국내주식_업종_기타.swift
//  KoreaInvestSwift
//
//  Created by kin on 4/6/25.
//

import FullyRESTful

extension KISAPI {
    enum 국내주식_업종_기타 {}
}
extension KISAPI.국내주식_업종_기타 {
    /// 국내주식업종기간별시세(일/주/월/년)[v1_국내주식-021]
    /// 국내주식 업종기간별시세(일/주/월/년) API입니다.실전계좌/모의계좌의 경우, 한 번의 호출에 최대 50건까지 확인 가능합니다.
    struct inquiredailyindexchartprice : APIITEM {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// 업종 : U
            let FID_COND_MRKT_DIV_CODE:String
            /// 업종 상세코드
            /// 0001 : 종합 0002 : 대형주 ... 포탈 (FAQ : 종목정보 다운로드(국내) - 업종코드 참조)
            let FID_INPUT_ISCD:String
            /// 조회 시작일자
            /// 조회 시작일자 (ex. 20220501)
            let FID_INPUT_DATE_1:String
            /// 조회 종료일자
            /// 조회 종료일자 (ex. 20220530)
            let FID_INPUT_DATE_2:String
            /// 기간분류코드
            /// D:일봉 W:주봉, M:월봉, Y:년봉
            let FID_PERIOD_DIV_CODE:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 - 0 : 성공 0 이외의 값 : 실패
            let rt_cd: String
            /// 응답코드 - 응답코드
            let msg_cd: String
            /// 응답메세지 - 응답메세지
            let msg1: String
            /// 응답상세 : Object
            /// 응답상세 1
            let output1: Output1
            /// 조회 기간별 시세 (배열) : Array
            /// 조회 기간별 시세 (배열)
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 업종 지수 전일 대비
            /// 업종 지수 전일 대비
            let BSTP_NMIX_PRDY_VRSS:String
            /// 전일 대비 부호
            /// 전일 대비 부호
            let PRDY_VRSS_SIGN:String
            /// 업종 지수 전일 대비율
            /// 업종 지수 전일 대비율
            let BSTP_NMIX_PRDY_CTRT:String
            /// 전일 지수
            /// 전일 지수
            let PRDY_NMIX:String
            /// 누적 거래량
            /// 누적 거래량
            let ACML_VOL:String
            /// 누적 거래 대금
            /// 누적 거래 대금
            let ACML_TR_PBMN:String
            /// HTS 한글 종목명
            /// HTS 한글 종목명
            let HTS_KOR_ISNM:String
            /// 업종 지수 현재가
            /// 업종 지수 현재가
            let BSTP_NMIX_PRPR:String
            /// 업종 구분 코드
            /// 업종 구분 코드
            let BSTP_CLS_CODE:String
            /// 전일 거래량
            /// 전일 거래량
            let PRDY_VOL:String
            /// 업종 지수 시가
            /// 업종 지수 시가
            let BSTP_NMIX_OPRC:String
            /// 업종 지수 최고가
            /// 업종 지수 최고가
            let BSTP_NMIX_HGPR:String
            /// 업종 지수 최저가
            /// 업종 지수 최저가
            let BSTP_NMIX_LWPR:String
            /// 업종 전일 시가
            /// 업종 전일 시가
            let FUTS_PRDY_OPRC:String
            /// 업종 전일 최고가
            /// 업종 전일 최고가
            let FUTS_PRDY_HGPR:String
            /// 업종 전일 최저가
            /// 업종 전일 최저가
            let FUTS_PRDY_LWPR:String
        }
        public struct Output2 : Codable {
            /// 영업 일자
            /// 영업 일자
            let STCK_BSOP_DATE:String
            /// 업종 지수 현재가
            /// 업종 지수 현재가
            let BSTP_NMIX_PRPR:String
            /// 업종 지수 시가
            /// 업종 지수 시가
            let BSTP_NMIX_OPRC:String
            /// 업종 지수 최고가
            /// 업종 지수 최고가
            let BSTP_NMIX_HGPR:String
            /// 업종 지수 최저가
            /// 업종 지수 최저가
            let BSTP_NMIX_LWPR:String
            /// 누적 거래량
            /// 누적 거래량
            let ACML_VOL:String
            /// 누적 거래 대금
            /// 누적 거래 대금
            let ACML_TR_PBMN:String
            /// 변경 여부
            /// 변경 여부
            let MOD_YN:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-daily-indexchartprice"
        public var header: [String : String]
        init(tr_id: String = "FHKUP03500100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "tr_id", // [실전투자/모의투자] FHKUP03500100
                "custtype", // B : 법인 P : 개인
            ])
            self.header["authorization"] = await KISManager.getAccessToken()?.token
            self.header["tr_id"] = tr_id
        }
    }

    /// 국내휴장일조회[국내주식-040]
    /// (★중요) 국내휴장일조회(TCA0903R) 서비스는 당사 원장서비스와 연관되어 있어 단시간 내 다수 호출시 서비스에 영향을 줄 수 있어 가급적 1일 1회 호출 부탁드립니다.국내휴장일조회 API입니다.영업일, 거래일, 개장일, 결제일 여부를 조회할 수 있습니다.주문을 넣을 수 있는지 확인하고자 하실 경우 개장일여부(opnd_yn)을 사용하시면 됩니다.
    struct chkholiday : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 기준일자
            /// 기준일자(YYYYMMDD)
            let BASS_DT:String
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
            /// 기준일자
            /// 기준일자(YYYYMMDD)
            let bass_dt:String
            /// 요일구분코드
            /// 01:일요일, 02:월요일, 03:화요일, 04:수요일, 05:목요일, 06:금요일, 07:토요일
            let wday_dvsn_cd:String
            /// 영업일여부
            /// Y/N 금융기관이 업무를 하는 날
            let bzdy_yn:String
            /// 거래일여부
            /// Y/N 증권 업무가 가능한 날(입출금, 이체 등의 업무 포함)
            let tr_day_yn:String
            /// 개장일여부
            /// Y/N 주식시장이 개장되는 날 * 주문을 넣고자 할 경우 개장일여부(opnd_yn)를 사용
            let opnd_yn:String
            /// 결제일여부
            /// Y/N 주식 거래에서 실제로 주식을 인수하고 돈을 지불하는 날
            let sttl_day_yn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/chk-holiday"
        public var header: [String : String]
        init(tr_id: String = "CTCA0903R", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // CTCA0903R
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

    /// 업종 분봉조회[v1_국내주식-045]
    /// 업종분봉조회 API입니다.실전계좌의 경우, 한 번의 호출에 최대 102건까지 확인 가능합니다.
    struct inquiretimeindexchartprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FID 조건 시장 분류 코드
            /// U
            let FID_COND_MRKT_DIV_CODE:String
            /// FID 기타 구분 코드
            /// 0: 기본 1:장마감,시간외 제외
            let FID_ETC_CLS_CODE:String
            /// FID 입력 종목코드
            /// 0001 : 종합 0002 : 대형주 ... 포탈 (FAQ : 종목정보 다운로드(국내) - 업종코드 참조)
            let FID_INPUT_ISCD:String
            /// FID 입력 시간1
            /// 30, 60 -> 1분, 600-> 10분, 3600 -> 1시간
            let FID_INPUT_HOUR_1:String
            /// FID 과거 데이터 포함 여부
            /// Y (과거) / N (당일)
            let FID_PW_DATA_INCU_YN:String
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
            /// 업종 지수 전일 대비
            let bstp_nmix_prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 업종 지수 전일 대비율
            let bstp_nmix_prdy_ctrt:String
            /// 전일 지수
            let prdy_nmix:String
            /// 누적 거래량
            let acml_vol:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 업종 지수 현재가
            let bstp_nmix_prpr:String
            /// 업종 구분 코드
            let bstp_cls_code:String
            /// 전일 거래량
            let prdy_vol:String
            /// 업종 지수 시가2
            let bstp_nmix_oprc:String
            /// 업종 지수 최고가
            let bstp_nmix_hgpr:String
            /// 업종 지수 최저가
            let bstp_nmix_lwpr:String
            /// 선물 전일 시가
            let futs_prdy_oprc:String
            /// 선물 전일 최고가
            let futs_prdy_hgpr:String
            /// 선물 전일 최저가
            let futs_prdy_lwpr:String
        }
        public struct Output2 : Codable {
            /// 주식 영업 일자
            let stck_bsop_date:String
            /// 주식 체결 시간
            let stck_cntg_hour:String
            /// 업종 지수 현재가
            let bstp_nmix_prpr:String
            /// 업종 지수 시가2
            let bstp_nmix_oprc:String
            /// 업종 지수 최고가
            let bstp_nmix_hgpr:String
            /// 업종 지수 최저가
            let bstp_nmix_lwpr:String
            /// 체결 거래량
            let cntg_vol:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-time-indexchartprice"
        public var header: [String : String]
        init(tr_id: String = "FHKUP03500200", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKUP03500200
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

    /// 변동성완화장치(VI) 현황 [v1_국내주식-055]
    /// HTS(eFriend Plus) [0139] 변동성 완화장치(VI) 현황 데이터를 확인할 수 있는 API입니다.최근 30건까지 확인 가능합니다.
    struct inquirevistatus : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FID 분류 구분 코드
            /// 0:전체 1:상승 2:하락
            let FID_DIV_CLS_CODE:String
            /// FID 조건 화면 분류 코드
            /// 20139
            let FID_COND_SCR_DIV_CODE:String
            /// FID 시장 구분 코드
            /// 0:전체 K:거래소 Q:코스닥
            let FID_MRKT_CLS_CODE:String
            /// FID 입력 종목코드
            let FID_INPUT_ISCD:String
            /// FID 순위 정렬 구분 코드
            /// 0:전체1:정적2:동적3:정적&동적
            let FID_RANK_SORT_CLS_CODE:String
            /// FID 입력 날짜1
            /// 영업일
            let FID_INPUT_DATE_1:String
            /// FID 대상 구분 코드
            let FID_TRGT_CLS_CODE:String
            /// FID 대상 제외 구분 코드
            let FID_TRGT_EXLS_CLS_CODE:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object
            let Output1: Output1
        }
        public struct Output1 : Codable {
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 유가증권 단축 종목코드
            let mksc_shrn_iscd:String
            /// VI발동상태
            /// Y: 발동 / N: 해제
            let vi_cls_code:String
            /// 영업 일자
            let bsop_date:String
            /// VI발동시간
            /// VI발동시간
            let cntg_vi_hour:String
            /// VI해제시간
            /// VI해제시간
            let vi_cncl_hour:String
            /// VI종류코드
            /// 1:정적 2:동적 3:정적&동적
            let vi_kind_code:String
            /// VI발동가격
            let vi_prc:String
            /// 정적VI발동기준가격
            let vi_stnd_prc:String
            /// 정적VI발동괴리율
            /// %
            let vi_dprt:String
            /// 동적VI발동기준가격
            let vi_dmc_stnd_prc:String
            /// 동적VI발동괴리율
            /// %
            let vi_dmc_dprt:String
            /// VI발동횟수
            let vi_count:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-vi-status"
        public var header: [String : String]
        init(tr_id: String = "FHPST01390000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01390000
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

    /// 국내업종 현재지수[v1_국내주식-063]
    /// 국내업종 현재지수 API입니다.한국투자 HTS(eFriend Plus) > [0210] 업종 현재지수 화면 의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct inquireindexprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FID 조건 시장 분류 코드
            /// 업종(U)
            let FID_COND_MRKT_DIV_CODE:String
            /// FID 입력 종목코드
            /// 코스피(0001), 코스닥(1001), 코스피200(2001) ... 포탈 (FAQ : 종목정보 다운로드(국내) - 업종코드 참조)
            let FID_INPUT_ISCD:String
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
            /// 업종 지수 현재가
            let bstp_nmix_prpr:String
            /// 업종 지수 전일 대비
            let bstp_nmix_prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 업종 지수 전일 대비율
            let bstp_nmix_prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 전일 거래량
            let prdy_vol:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// 전일 거래 대금
            let prdy_tr_pbmn:String
            /// 업종 지수 시가2
            let bstp_nmix_oprc:String
            /// 전일 지수 대비 지수 시가2
            let prdy_nmix_vrss_nmix_oprc:String
            /// 시가2 대비 현재가 부호
            let oprc_vrss_prpr_sign:String
            /// 업종 지수 시가2 전일 대비율
            let bstp_nmix_oprc_prdy_ctrt:String
            /// 업종 지수 최고가
            let bstp_nmix_hgpr:String
            /// 전일 지수 대비 지수 최고가
            let prdy_nmix_vrss_nmix_hgpr:String
            /// 최고가 대비 현재가 부호
            let hgpr_vrss_prpr_sign:String
            /// 업종 지수 최고가 전일 대비율
            let bstp_nmix_hgpr_prdy_ctrt:String
            /// 업종 지수 최저가
            let bstp_nmix_lwpr:String
            /// 전일 종가 대비 최저가
            let prdy_clpr_vrss_lwpr:String
            /// 최저가 대비 현재가 부호
            let lwpr_vrss_prpr_sign:String
            /// 전일 종가 대비 최저가 비율
            let prdy_clpr_vrss_lwpr_rate:String
            /// 상승 종목 수
            let ascn_issu_cnt:String
            /// 상한 종목 수
            let uplm_issu_cnt:String
            /// 보합 종목 수
            let stnr_issu_cnt:String
            /// 하락 종목 수
            let down_issu_cnt:String
            /// 하한 종목 수
            let lslm_issu_cnt:String
            /// 연중업종지수최고가
            let dryy_bstp_nmix_hgpr:String
            /// 연중 최고가 대비 현재가 비율
            let dryy_hgpr_vrss_prpr_rate:String
            /// 연중업종지수최고가일자
            let dryy_bstp_nmix_hgpr_date:String
            /// 연중업종지수최저가
            let dryy_bstp_nmix_lwpr:String
            /// 연중 최저가 대비 현재가 비율
            let dryy_lwpr_vrss_prpr_rate:String
            /// 연중업종지수최저가일자
            let dryy_bstp_nmix_lwpr_date:String
            /// 총 매도호가 잔량
            let total_askp_rsqn:String
            /// 총 매수호가 잔량
            let total_bidp_rsqn:String
            /// 매도 잔량 비율
            let seln_rsqn_rate:String
            /// 매수2 잔량 비율
            let shnu_rsqn_rate:String
            /// 순매수 잔량
            let ntby_rsqn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-index-price"
        public var header: [String : String]
        init(tr_id: String = "FHPUP02100000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPUP02100000
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

    /// 국내업종 일자별지수[v1_국내주식-065]
    /// 국내업종 일자별지수 API입니다. 한 번의 조회에 100건까지 확인 가능합니다.한국투자 HTS(eFriend Plus) > [0212] 업종 일자별지수 화면 의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct inquireindexdailyprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FID 기간 분류 코드
            /// 일/주/월 구분코드 ( D:일별 , W:주별, M:월별 )
            let FID_PERIOD_DIV_CODE:String
            /// FID 조건 시장 분류 코드
            /// 시장구분코드 (업종 U)
            let FID_COND_MRKT_DIV_CODE:String
            /// FID 입력 종목코드
            /// 코스피(0001), 코스닥(1001), 코스피200(2001) ... 포탈 (FAQ : 종목정보 다운로드(국내) - 업종코드 참조)
            let FID_INPUT_ISCD:String
            /// FID 입력 날짜1
            /// 입력 날짜(ex. 20240223)
            let FID_INPUT_DATE_1:String
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
            /// 응답상세2 : Object Array
            /// array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 업종 지수 현재가
            let bstp_nmix_prpr:String
            /// 업종 지수 전일 대비
            let bstp_nmix_prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 업종 지수 전일 대비율
            let bstp_nmix_prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// 업종 지수 시가2
            let bstp_nmix_oprc:String
            /// 업종 지수 최고가
            let bstp_nmix_hgpr:String
            /// 업종 지수 최저가
            let bstp_nmix_lwpr:String
            /// 전일 거래량
            let prdy_vol:String
            /// 상승 종목 수
            let ascn_issu_cnt:String
            /// 하락 종목 수
            let down_issu_cnt:String
            /// 보합 종목 수
            let stnr_issu_cnt:String
            /// 상한 종목 수
            let uplm_issu_cnt:String
            /// 하한 종목 수
            let lslm_issu_cnt:String
            /// 전일 거래 대금
            let prdy_tr_pbmn:String
            /// 연중업종지수최고가일자
            let dryy_bstp_nmix_hgpr_date:String
            /// 연중업종지수최고가
            let dryy_bstp_nmix_hgpr:String
            /// 연중업종지수최저가
            let dryy_bstp_nmix_lwpr:String
            /// 연중업종지수최저가일자
            let dryy_bstp_nmix_lwpr_date:String
        }
        public struct Output2 : Codable {
            /// 주식 영업 일자
            let stck_bsop_date:String
            /// 업종 지수 현재가
            let bstp_nmix_prpr:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 업종 지수 전일 대비
            let bstp_nmix_prdy_vrss:String
            /// 업종 지수 전일 대비율
            let bstp_nmix_prdy_ctrt:String
            /// 업종 지수 시가2
            let bstp_nmix_oprc:String
            /// 업종 지수 최고가
            let bstp_nmix_hgpr:String
            /// 업종 지수 최저가
            let bstp_nmix_lwpr:String
            /// 누적 거래량 비중
            let acml_vol_rlim:String
            /// 누적 거래량
            let acml_vol:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// 투자 신 심리도
            let invt_new_psdg:String
            /// 20일 이격도
            let d20_dsrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-index-daily-price"
        public var header: [String : String]
        init(tr_id: String = "FHPUP02120000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPUP02120000
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

    /// 국내업종 구분별전체시세[v1_국내주식-066]
    /// 국내업종 구분별전체시세 API입니다.한국투자 HTS(eFriend Plus) > [0214] 업종 전체시세 화면 의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct inquireindexcategoryprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FID 조건 시장 분류 코드
            /// 시장구분코드 (업종 U)
            let FID_COND_MRKT_DIV_CODE:String
            /// FID 입력 종목코드
            /// 코스피(0001), 코스닥(1001), 코스피200(2001) ... 포탈 (FAQ : 종목정보 다운로드(국내) - 업종코드 참조)
            let FID_INPUT_ISCD:String
            /// FID 조건 화면 분류 코드
            /// Unique key( 20214 )
            let FID_COND_SCR_DIV_CODE:String
            /// FID 시장 구분 코드
            /// 시장구분코드(K:거래소, Q:코스닥, K2:코스피200)
            let FID_MRKT_CLS_CODE:String
            /// FID 소속 구분 코드
            /// 시장구분코드에 따라 아래와 같이 입력 시장구분코드(K:거래소) 0:전업종, 1:기타구분, 2:자본금구분 3:상업별구분 시장구분코드(Q:코스닥) 0:전업종, 1:기타구분, 2:벤처구분 3:일반구분 시장구분코드(K2:코스닥) 0:전업종
            let FID_BLNG_CLS_CODE:String
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
            /// 응답상세2 : Object Array
            /// array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 업종 지수 현재가
            let bstp_nmix_prpr:String
            /// 업종 지수 전일 대비
            let bstp_nmix_prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 업종 지수 전일 대비율
            let bstp_nmix_prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// 업종 지수 시가2
            let bstp_nmix_oprc:String
            /// 업종 지수 최고가
            let bstp_nmix_hgpr:String
            /// 업종 지수 최저가
            let bstp_nmix_lwpr:String
            /// 전일 거래량
            let prdy_vol:String
            /// 상승 종목 수
            let ascn_issu_cnt:String
            /// 하락 종목 수
            let down_issu_cnt:String
            /// 보합 종목 수
            let stnr_issu_cnt:String
            /// 상한 종목 수
            let uplm_issu_cnt:String
            /// 하한 종목 수
            let lslm_issu_cnt:String
            /// 전일 거래 대금
            let prdy_tr_pbmn:String
            /// 연중업종지수최고가일자
            let dryy_bstp_nmix_hgpr_date:String
            /// 연중업종지수최고가
            let dryy_bstp_nmix_hgpr:String
            /// 연중업종지수최저가
            let dryy_bstp_nmix_lwpr:String
            /// 연중업종지수최저가일자
            let dryy_bstp_nmix_lwpr_date:String
        }
        public struct Output2 : Codable {
            /// 업종 구분 코드
            let bstp_cls_code:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 업종 지수 현재가
            let bstp_nmix_prpr:String
            /// 업종 지수 전일 대비
            let bstp_nmix_prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 업종 지수 전일 대비율
            let bstp_nmix_prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// 누적 거래량 비중
            let acml_vol_rlim:String
            /// 누적 거래 대금 비중
            let acml_tr_pbmn_rlim:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-index-category-price"
        public var header: [String : String]
        init(tr_id: String = "FHPUP02140000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPUP02140000
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

    /// 국내주식 예상체결 전체지수[국내주식-122]
    /// 국내주식 예상체결 전체지수 API입니다.한국투자 HTS(eFriend Plus) > [0185] 예상체결 전체지수 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct exptotalindex : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 시장 구분 코드
            /// 0:전체 K:거래소 Q:코스닥
            let fid_mrkt_cls_code:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (업종 U)
            let fid_cond_mrkt_div_code:String
            /// 조건 화면 분류 코드
            /// Unique key(11175)
            let fid_cond_scr_div_code:String
            /// 입력 종목코드
            /// 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200, 4001: KRX100
            let fid_input_iscd:String
            /// 장운영 구분 코드
            /// 1:장시작전, 2:장마감
            let fid_mkop_cls_code:String
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
            /// 업종 지수 현재가
            let bstp_nmix_prpr:String
            /// 업종 지수 전일 대비
            let bstp_nmix_prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 상승 종목 수
            let ascn_issu_cnt:String
            /// 하락 종목 수
            let down_issu_cnt:String
            /// 보합 종목 수
            let stnr_issu_cnt:String
            /// 업종 구분 코드
            let bstp_cls_code:String
        }
        public struct Output2 : Codable {
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 업종 지수 현재가
            let bstp_nmix_prpr:String
            /// 업종 지수 전일 대비
            let bstp_nmix_prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 업종 지수 전일 대비율
            let bstp_nmix_prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 지수 기준가
            let nmix_sdpr:String
            /// 상승 종목 수
            let ascn_issu_cnt:String
            /// 보합 종목 수
            let stnr_issu_cnt:String
            /// 하락 종목 수
            let down_issu_cnt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/exp-total-index"
        public var header: [String : String]
        init(tr_id: String = "FHKUP11750000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKUP11750000
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

    /// 국내업종 시간별지수(초)[국내주식-064]
    /// 국내업종 시간별지수(초) API입니다. 한국투자 HTS(eFriend Plus) > [0211] 업종 시간별지수 화면에서 우측 '10초' 선택 시의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct inquireindextickprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 입력 종목코드
            /// 0001:거래소, 1001:코스닥, 2001:코스피200, 3003:KSQ150
            let FID_INPUT_ISCD:String
            /// 시장 분류 코드
            /// 시장구분코드 (업종 U)
            let FID_COND_MRKT_DIV_CODE:String
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
            /// 주식 체결 시간
            let stck_cntg_hour:String
            /// 업종 지수 현재가
            let bstp_nmix_prpr:String
            /// 업종 지수 전일 대비
            let bstp_nmix_prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 업종 지수 전일 대비율
            let bstp_nmix_prdy_ctrt:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// 누적 거래량
            let acml_vol:String
            /// 체결 거래량
            let cntg_vol:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-index-tickprice"
        public var header: [String : String]
        init(tr_id: String = "FHPUP02110100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPUP02110100
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

    /// 국내업종 시간별지수(분)[국내주식-119]
    /// 국내업종 시간별지수(분) API입니다. 한국투자 HTS(eFriend Plus) > [0211] 업종 시간별지수 화면에서 우측 '1분' 선택 시의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct inquireindextimeprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// ?입력 시간1
            /// 초단위, 60(1분), 300(5분), 600(10분)
            let FID_INPUT_HOUR_1:String
            /// 입력 종목코드
            /// 0001:거래소, 1001:코스닥, 2001:코스피200, 3003:KSQ150
            let FID_INPUT_ISCD:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (업종 U)
            let FID_COND_MRKT_DIV_CODE:String
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
            /// 영업 시간
            let bsop_hour:String
            /// 업종 지수 현재가
            let bstp_nmix_prpr:String
            /// 업종 지수 전일 대비
            let bstp_nmix_prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 업종 지수 전일 대비율
            let bstp_nmix_prdy_ctrt:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// 누적 거래량
            let acml_vol:String
            /// 체결 거래량
            let cntg_vol:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-index-timeprice"
        public var header: [String : String]
        init(tr_id: String = "FHPUP02110200", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPUP02110200
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

    /// 국내주식 예상체결지수 추이[국내주식-121]
    /// 국내주식 예상체결지수 추이 API입니다. 한국투자 HTS(eFriend Plus) > [0184] 예상체결지수 추이 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct expindextrend : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 장운영 구분 코드
            /// 1: 장시작전, 2: 장마감
            let FID_MKOP_CLS_CODE:String
            /// 입력 시간1
            /// 10(10초), 30(30초), 60(1분), 600(10분)
            let FID_INPUT_HOUR_1:String
            /// 입력 종목코드
            /// 0000:전체, 0001:코스피, 1001:코스닥, 2001:코스피200, 4001: KRX100
            let FID_INPUT_ISCD:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 U)
            let FID_COND_MRKT_DIV_CODE:String
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
            let stck_cntg_hour:String
            /// HTS 한글 종목명
            let bstp_nmix_prpr:String
            /// 주식 현재가
            let prdy_vrss_sign:String
            /// 전일 대비
            let bstp_nmix_prdy_vrss:String
            /// 전일 대비 부호
            let prdy_ctrt:String
            /// 전일 대비율
            let acml_vol:String
            /// 기준가 대비 현재가
            let acml_tr_pbmn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/exp-index-trend"
        public var header: [String : String]
        init(tr_id: String = "FHPST01840000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01840000
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

    /// 금리 종합(국내채권/금리) [국내주식-155]
    /// 금리 종합(국내채권/금리) API입니다.한국투자 HTS(eFriend Plus) > [0702] 금리 종합 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.※ 11:30 이후에 신규데이터가 수신되는 점 참고하시기 바랍니다.
    struct compinterest : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// Unique key(I)
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건화면분류코드
            /// Unique key(20702)
            let FID_COND_SCR_DIV_CODE:String
            /// 분류구분코드
            /// 1: 해외금리지표
            let FID_DIV_CLS_CODE:String
            /// 분류구분코드
            /// 공백 : 전체
            let FID_DIV_CLS_CODE1:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object
            /// array
            let output1: [Output1]
            /// 응답상세 : Object Array
            /// array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 자료코드
            let bcdt_code:String
            /// HTS한글종목명
            let hts_kor_isnm:String
            /// 채권금리현재가
            let bond_mnrt_prpr:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 채권금리전일대비
            let bond_mnrt_prdy_vrss:String
            /// 전일대비율
            let prdy_ctrt:String
            /// 주식영업일자
            let stck_bsop_date:String
        }
        public struct Output2 : Codable {
            /// 자료코드
            let bcdt_code:String
            /// HTS한글종목명
            let hts_kor_isnm:String
            /// 채권금리현재가
            let bond_mnrt_prpr:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 채권금리전일대비
            let bond_mnrt_prdy_vrss:String
            /// 업종지수전일대비율
            let bstp_nmix_prdy_ctrt:String
            /// 주식영업일자
            let stck_bsop_date:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/comp-interest"
        public var header: [String : String]
        init(tr_id: String = "FHPST07020000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST07020000
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

    /// 종합 시황/공시(제목) [국내주식-141]
    /// 종합 시황/공시(제목) API입니다. 한국투자 HTS(eFriend Plus) > [0601] 종합 시황/공시 화면의 "우측 상단 리스트" 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct newstitle : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 뉴스 제공 업체 코드
            /// 공백
            let FID_NEWS_OFER_ENTP_CODE:String
            /// 조건 시장 구분 코드
            /// 공백
            let FID_COND_MRKT_CLS_CODE:String
            /// 입력 종목코드
            /// 공백: 전체, 종목코드 : 해당코드가 등록된 뉴스
            let FID_INPUT_ISCD:String
            /// 제목 내용
            /// 공백
            let FID_TITL_CNTT:String
            /// 입력 날짜
            /// 공백: 현재기준, 조회일자(ex 00YYYYMMDD)
            let FID_INPUT_DATE_1:String
            /// 입력 시간
            /// 공백: 현재기준, 조회시간(ex 0000HHMMSS)
            let FID_INPUT_HOUR_1:String
            /// 순위 정렬 구분 코드
            /// 공백
            let FID_RANK_SORT_CLS_CODE:String
            /// 입력 일련번호
            /// 공백
            let FID_INPUT_SRNO:String
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
            /// 내용 조회용 일련번호
            let cntt_usiq_srno:String
            /// 뉴스 제공 업체 코드
            /// '2' /* 한경 news */ '3' /* 사용안함 */ '4' /* 이데일리 */ '5' /* 머니투데이 */ '6' /* 연합뉴스 */ '7' /* 인포스탁 */ '8' /* 아시아경제 */ '9' /* 뉴스핌 */ 'A' /* 매일경제 */ 'B' /* 헤럴드경제 */ 'C' /* 파이낸셜 */ 'D' /* 이투데이 */ 'F' /* 장내공시 */ 'G' /* 코스닥공시 */ 'H' /* 프리보드공시*/ 'I' /* 기타공시 */ 'N' /* 코넥스공시 */ 'J' /* 동향 */ /* 'L' 리서치 */ 'K' /* 청약안내 전송 */ 'M' /* 타사 추천종목 */ 'O' /* edaily fx */ 'U' /* 서울 경제 */ 'V' /* 조선 경제 */ 'X' /* CEO스코어 */ 'Y' /* 이프렌드 Air 뉴스 */ 'Z' /* 인베스트조선 */ 'd' /* NSP통신 */
            let news_ofer_entp_code:String
            /// 작성일자
            let data_dt:String
            /// 작성시간
            let data_tm:String
            /// HTS 공시 제목 내용
            let hts_pbnt_titl_cntt:String
            /// 뉴스 대구분
            /// 1:0:종합 1:FGHIN:공시 2:F:거래소 3:01:수시공시 3:02:공정공시 3:03:시장조치 3:04:신고사항 3:05:정기공시 3:06:특수공시 3:07:발행공시 3:08:지분공시 3:09:워런트공시 3:10:의결권행사공시 3:11:공정위공시 3:12:선물시장공시 3:A1:시장조치안내 3:A2:상장안내 3:A3:안내사항 3:A4:투자유의사항 3:A5:수익증권 3:A6:투자자참고사항 3:A7:뮤츄얼펀드 2:G:코스닥 3:01:수시공시 3:02:공정공시 3:03:시장조치 3:04:신고사항 3:05:정기공시 3:06:특수공시 3:07:발행공시 3:08:지분공시 3:09:워런트공시 3:10:의결권행사공시 3:11:공정위공시 3:12:선물시장공시 3:A1:시장조치안내 3:A2:상장안내 3:A3:안내사항 3:A4:투자유의사항 3:A5:수익증권 3:A6:투자자참고사항 3:A7:뮤츄얼펀드 2:N:코넥스 3:01:수시공시 3:02:공정공시 3:03:시장조치 3:04:신고사항 3:05:정기공시 3:06:특수공시 3:07:발행공시 3:08:지분공시 3:09:워런트공시 3:10:의결권행사공시 3:11:공정위공시 3:12:선물시장공시 3:A1:시장조치안내 3:A2:상장안내 3:A3:안내사항 3:A4:투자유의사항 3:A5:수익증권 3:A6:투자자참고사항 3:A7:뮤츄얼펀드 2:H:K-OTC 2:I:기타 1:6:연합뉴스 3:01:정치 3:02:경제 3:03:증권/금융 3:04:산업 3:05:사회 3:06:사건사고 3:07:문화 3:08:생활건강 3:09:IT. 과학 3:10:북한 3:11:국제 3:12:스포츠 3:13:기타 1:2:한경 3:01:증권 3:04:경제 3:03:부동산 3:07:IT/과학 3:08:정치 3:09:국제 3:10:사회 3:11:생활/문화 3:00:오피니언 3:12:스포츠 3:20:연예 3:18:보도자료 1:A:매경 3:01:경제 3:02:금융 3:03:산업/기업 3:04:중기/벤쳐/과기 3:05:증권 3:06:부동산 3:07:정치 3:08:사회 3:09:인물/동정 3:10:국제 3:11:문화 3:12:레저/스포츠 3:13:사설/칼럼 3:14:기획/분석 3:15:섹션 3:16:English News 3:17:매경이코노미 3:18:mbn 3:90:기타 1:4:이데일리 3:B1:채권시황 3:B2:신종채권 3:F1:외환시황 3:G1:보도자료 3:H1:정책뉴스 3:H2:금융뉴스 3:H3:금융금리/수익율 3:I1:IPO뉴스 3:J1:뉴욕 3:J2:아시아/유럽 3:J3:월드마켓 3:J4:국제기업/산업 3:J5:경제흐름 3:L1:기업뉴스 3:L2:IT 3:L3:벤처 3:L4:e3비즈월드 3:S1:주식시황 3:S2:거래소 3:S3:코스닥&장외 3:S4:루머 3:S5:증권가 1:5:머니투데이 3:A01:주식 3:A02:선물옵션 3:A05:해외증시 3:A06:외환 3:A07:채권 3:A08:펀드 3:B01:경제 3:B02:산업 3:B03:정보과학 3:B04:국제 3:B05:금융보험 3:B07:부동산 3:B08:성공학 3:B09:재테크 3:B10:바이오 1:9:뉴스핌 3:01:주식 3:02:채권 3:03:외환 3:04:국제 3:05:금융/제테크 3:06:산업 3:07:경제 3:08:광장 3:09:전문가기고 3:90:기타 1:8:아시아경제 3:A0:증권 3:B0:금융 3:C0:부동산 3:D0:산업 3:E0:경제 3:F0:정치,사회 3:G0:사설,칼럼 3:H0:인사,동정,부고 3:I0:루머&팩트 3:J0:국내뉴스 3:K0:아시아시각 3:L0:골프 3:M0:모닝브리핑 3:N0:연예 3:10:국제 3:20:중국 3:30:인도 3:40:일본 3:50:이머징마켓 1:B:헤럴드경제 3:01:뉴스 3:02:기업 3:03:재테크 3:04:스타 3:05:문화 3:90:기타 1:C:파이낸셜 3:01:증권 3:02:금융 3:03:부동산 3:04:산업 3:05:경제 3:06:정보과학 3:07:유통 3:08:국제 3:09:정치 3:10:전국/사회 3:11:문화 3:12:스포츠 3:13:교육 3:14:피플 3:15:사설/컬럼 3:16:기획/연재 3:17:fn재테크 3:18:광고 3:90:기타 1:D:이투데이 3:21:증권 3:51:금융 3:22:정치/정책 3:31:글로벌 3:23:산업 3:24:부동산 3:26:라이프 3:25:칼럼/인물 3:41:연예/스포츠 3:90:기타 1:U:서울경제 3:31:증권 3:32:부동산 3:33:경제/금융 3:34:산업/기업 3:35:IT/과학 3:36:정치 3:37:사회 3:38:국제 3:39:칼럼 3:3A:인사/동정/부음 3:3B:문화/건강/레저 3:3C:골프/스포츠 1:V:조선경제i 3:1:뉴스 3:2:Market 3:4:부동산 3:6:글로벌경제 3:8:위클리비즈 3:B:자동차 3:C:녹색BIZ 1:7:인포스탁 3:01:거래소종목 3:02:코스닥종목 3:03:해외증시 3:04:선물동향 3:00:기타 1:X:CEO스코어 3:01:경제 3:02:산업 3:03:금융 3:04:공기업 3:05:전자 3:06:통신 3:07:게임,인터넷 3:08:자동차 3:09:조선,철강 3:10:식음료 3:11:유통 3:12:건설 3:13:제약 3:14:화학,에너지 3:15:생활산업 3:16:기타 1:S:컨슈머타임스 3:01:종합 3:02:파이낸셜컨슈머 3:03:컨슈머리뷰 3:04:정치,사회 3:05:스포츠,연예 3:06:컨슈머뷰티 3:07:오피니언 3:09:기타 1:Z:인베스트조선 3:01:증권/금융 1:d:NSP통신 3:11:IT/과학 3:12:금융/증권 3:13:부동산 3:14:자동차 3:15:연예/문화 3:16:생활경제 3:17:물류/유통 3:18:인사/동정 3:19:정치/사회 3:20:기업 3:21:의학/건강 3:23:신상품/리뷰 3:24:해명/반론 1:a:IRGO 3:10:IR정보 3:20:IR일정 3:50:IR FOCUS 1:Y:eFriend Air 3:01:종목상담 3:02:VOD 1:J:동향 1:L:한투리서치
            let news_lrdv_code:String
            /// 자료원
            let dorg:String
            /// 종목 코드1
            let iscd1:String
            /// 종목 코드2
            let iscd2:String
            /// 종목 코드3
            let iscd3:String
            /// 종목 코드4
            let iscd4:String
            /// 종목 코드5
            let iscd5:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/news-title"
        public var header: [String : String]
        init(tr_id: String = "FHKST01011800", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST01011800
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

    /// 국내선물 영업일조회 [국내주식-160]
    /// 국내선물 영업일조회 API입니다.API호출 시 body 혹은 params로 입력하는 사항이 없습니다.
    struct markettime : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type:String
            /// 거래ID
            /// 요청한 tr_id
            let tr_id:String
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont:String?
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid:String?
            enum CodingKeys : String, CodingKey {
                case content_type = "content-type"
                case tr_id, tr_cont, gt_uid
            }
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
            /// 영업일1
            let date1:String
            /// 영업일2
            let date2:String
            /// 영업일3
            /// 영업일 당일
            let date3:String
            /// 영업일4
            let date4:String
            /// 영업일5
            let date5:String
            /// 오늘일자
            let today:String
            /// 현재시간
            let time:String
            /// 장시작시간
            let s_time:String
            /// 장마감시간
            let e_time:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/market-time"
        public var header: [String : String]
        init(tr_id: String = "HHMCM000002C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHMCM000002C0
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
