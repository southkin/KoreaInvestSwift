//
//  국내주식_ELW시세.swift
//  KoreaInvestSwift
//
//  Created by kin on 4/5/25.
//
import FullyRESTful

public extension KISAPI {
    enum 국내주식_ELW시세 {}
}

public extension KISAPI.국내주식_ELW시세 {
    /// ELW현재가 시세[v1_국내주식-014]
    /// ELW 현재가 시세 API입니다. ELW 관련 정보를 얻을 수 있습니다.
    struct inquireelwprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FID 조건 시장 분류 코드
            /// W : ELW
            let FID_COND_MRKT_DIV_CODE:String
            /// FID 입력 종목코드
            /// 종목번호 (6자리)
            let FID_INPUT_ISCD:String
        }
        public struct Response: Codable {
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
            /// ELW 단축 종목코드
            let elw_shrn_iscd:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// ELW 현재가
            let elw_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 전일 대비 거래량 비율
            let prdy_vrss_vol_rate:String
            /// 기초자산 단축 종목코드
            let unas_shrn_iscd:String
            /// 기초자산 종목명
            let unas_isnm:String
            /// 기초자산 현재가
            let unas_prpr:String
            /// 기초자산 전일 대비
            let unas_prdy_vrss:String
            /// 기초자산 전일 대비 부호
            let unas_prdy_vrss_sign:String
            /// 기초자산 전일 대비율
            let unas_prdy_ctrt:String
            /// 매수호가
            let bidp:String
            /// 매도호가
            let askp:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// 거래량 회전율
            let vol_tnrt:String
            /// ELW 시가2
            let elw_oprc:String
            /// ELW 최고가
            let elw_hgpr:String
            /// ELW 최저가
            let elw_lwpr:String
            /// 주식 전일 종가
            let stck_prdy_clpr:String
            /// HTS 이론가
            let hts_thpr:String
            /// 괴리율
            let dprt:String
            /// ATM 구분 명
            let atm_cls_name:String
            /// HTS 내재 변동성
            let hts_ints_vltl:String
            /// 행사가
            let acpr:String
            /// 피벗 2차 디저항 가격
            let pvt_scnd_dmrs_prc:String
            /// 피벗 1차 디저항 가격
            let pvt_frst_dmrs_prc:String
            /// 피벗 포인트 값
            let pvt_pont_val:String
            /// 피벗 1차 디지지 가격
            let pvt_frst_dmsp_prc:String
            /// 피벗 2차 디지지 가격
            let pvt_scnd_dmsp_prc:String
            /// 디지지 값
            let dmsp_val:String
            /// 디저항 값
            let dmrs_val:String
            /// ELW 기준가
            let elw_sdpr:String
            /// 접근도
            let apprch_rate:String
            /// 틱환산가
            let tick_conv_prc:String
            /// 투자 유의 내용
            let invt_epmd_cntt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-elw-price"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKEW15010000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자/모의투자] FHKEW15010000 : ELW현재가 시세
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

    /// ELW 상승률순위[국내주식-167]
    /// ELW 상승률순위 API입니다. 한국투자 HTS(eFriend Plus) > [0277] ELW 상승률순위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct updownrate : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 사용자권한정보
            /// 시장구분코드 (W)
            let FID_COND_MRKT_DIV_CODE:String
            /// 거래소코드
            /// Unique key(20277)
            let FID_COND_SCR_DIV_CODE:String
            /// 상승율/하락율 구분
            /// '000000(전체), 2001(코스피200) , 3003(코스닥150), 005930(삼성전자) '
            let FID_UNAS_INPUT_ISCD:String
            /// N일자값
            /// '00000(전체), 00003(한국투자증권) , 00017(KB증권), 00005(미래에셋주식회사)'
            let FID_INPUT_ISCD:String
            /// 거래량조건
            /// '0(전체), 1(1개월이하), 2(1개월~2개월), 3(2개월~3개월), 4(3개월~6개월), 5(6개월~9개월),6(9개월~12개월), 7(12개월이상)'
            let FID_INPUT_RMNN_DYNU_1:String
            /// NEXT KEY BUFF
            /// 0(전체), 1(콜), 2(풋)
            let FID_DIV_CLS_CODE:String
            /// 사용자권한정보
            let FID_INPUT_PRICE_1:String
            /// 거래소코드
            let FID_INPUT_PRICE_2:String
            /// 상승율/하락율 구분
            let FID_INPUT_VOL_1:String
            /// N일자값
            let FID_INPUT_VOL_2:String
            /// 거래량조건
            let FID_INPUT_DATE_1:String
            /// NEXT KEY BUFF
            /// '0(상승율), 1(하락율), 2(시가대비상승율) , 3(시가대비하락율), 4(변동율)'
            let FID_RANK_SORT_CLS_CODE:String
            /// 사용자권한정보
            /// 0(전체)
            let FID_BLNG_CLS_CODE:String
            /// 거래소코드
            let FID_INPUT_DATE_2:String
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
            /// HTS한글종목명
            let hts_kor_isnm:String
            /// ELW단축종목코드
            let elw_shrn_iscd:String
            /// ELW현재가
            let elw_prpr:String
            /// 전일대비
            let prdy_vrss:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 전일대비율
            let prdy_ctrt:String
            /// 누적거래량
            let acml_vol:String
            /// 주식기준가
            let stck_sdpr:String
            /// 기준가대비현재가부호
            let sdpr_vrss_prpr_sign:String
            /// 기준가대비현재가
            let sdpr_vrss_prpr:String
            /// 기준가대비현재가비율
            let sdpr_vrss_prpr_rate:String
            /// 주식시가2
            let stck_oprc:String
            /// 시가2대비현재가부호
            let oprc_vrss_prpr_sign:String
            /// 시가2대비현재가
            let oprc_vrss_prpr:String
            /// 시가2대비현재가비율
            let oprc_vrss_prpr_rate:String
            /// 주식최고가
            let stck_hgpr:String
            /// 주식최저가
            let stck_lwpr:String
            /// 기간등락부호
            let prd_rsfl_sign:String
            /// 기간등락
            let prd_rsfl:String
            /// 기간등락비율
            let prd_rsfl_rate:String
            /// 주식전환비율
            let stck_cnvr_rate:String
            /// HTS잔존일수
            let hts_rmnn_dynu:String
            /// 행사가
            let acpr:String
            /// 기초자산명
            let unas_isnm:String
            /// 기초자산코드
            let unas_shrn_iscd:String
            /// LP보유비율
            let lp_hldn_rate:String
            /// 패리티
            let prit:String
            /// 손익분기주가가격
            let prls_qryr_stpr_prc:String
            /// 델타값
            let delta_val:String
            /// 세타
            let theta:String
            /// 손익분기비율
            let prls_qryr_rate:String
            /// 주식상장일자
            let stck_lstn_date:String
            /// 주식최종거래일자
            let stck_last_tr_date:String
            /// HTS내재변동성
            let hts_ints_vltl:String
            /// 레버리지값
            let lvrg_val:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/ranking/updown-rate"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPEW02770000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPEW02770000
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

    /// ELW 거래량순위[국내주식-168]
    /// ELW 거래량순위 API입니다. 한국투자 HTS(eFriend Plus) > [0278] ELW 거래량순위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct volumerank : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// W
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건화면분류코드
            /// 20278
            let FID_COND_SCR_DIV_CODE:String
            /// 기초자산입력종목코드
            /// 000000
            let FID_UNAS_INPUT_ISCD:String
            /// 발행사
            /// 00000(전체), 00003(한국투자증권) , 00017(KB증권), 00005(미래에셋주식회사)'
            let FID_INPUT_ISCD:String
            /// 입력잔존일수
            let FID_INPUT_RMNN_DYNU_1:String
            /// 콜풋구분코드
            /// 0(전체), 1(콜), 2(풋)
            let FID_DIV_CLS_CODE:String
            /// 가격(이상)
            /// 거래가격1(이상)
            let FID_INPUT_PRICE_1:String
            /// 가격(이하)
            /// 거래가격1(이하)
            let FID_INPUT_PRICE_2:String
            /// 거래량(이상)
            /// 거래량1(이상)
            let FID_INPUT_VOL_1:String
            /// 거래량(이하)
            /// 거래량1(이하)
            let FID_INPUT_VOL_2:String
            /// 조회기준일
            /// 입력날짜(기준가 조회기준)
            let FID_INPUT_DATE_1:String
            /// 순위정렬구분코드
            /// 0: 거래량순 1: 평균거래증가율 2: 평균거래회전율 3:거래금액순 4: 순매수잔량순 5: 순매도잔량순
            let FID_RANK_SORT_CLS_CODE:String
            /// 소속구분코드
            /// 0: 전체
            let FID_BLNG_CLS_CODE:String
            /// LP발행사
            /// 0000
            let FID_INPUT_ISCD_2:String
            /// 만기일-최종거래일조회
            /// 공백
            let FID_INPUT_DATE_2:String
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
            /// ELW한글종목명
            let elw_kor_isnm:String
            /// ELW단축종목코드
            let elw_shrn_iscd:String
            /// ELW현재가
            let elw_prpr:String
            /// 전일대비
            let prdy_vrss:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 전일대비율
            let prdy_ctrt:String
            /// 상장주수
            let lstn_stcn:String
            /// 누적거래량
            let acml_vol:String
            /// N전일거래량
            let n_prdy_vol:String
            /// N전일거래량대비
            let n_prdy_vol_vrss:String
            /// 거래량증가율
            let vol_inrt:String
            /// 거래량회전율
            let vol_tnrt:String
            /// N일거래량회전율
            let nday_vol_tnrt:String
            /// 누적거래대금
            let acml_tr_pbmn:String
            /// N전일거래대금
            let n_prdy_tr_pbmn:String
            /// N전일거래대금대비
            let n_prdy_tr_pbmn_vrss:String
            /// 총매도호가잔량
            let total_askp_rsqn:String
            /// 총매수호가잔량
            let total_bidp_rsqn:String
            /// 순매도잔량
            let ntsl_rsqn:String
            /// 순매수잔량
            let ntby_rsqn:String
            /// 매도잔량비율
            let seln_rsqn_rate:String
            /// 매수2잔량비율
            let shnu_rsqn_rate:String
            /// 주식전환비율
            let stck_cnvr_rate:String
            /// HTS잔존일수
            let hts_rmnn_dynu:String
            /// 내재가치값
            let invl_val:String
            /// 시간가치값
            let tmvl_val:String
            /// 행사가
            let acpr:String
            /// LP회원사명
            let lp_mbcr_name:String
            /// 기초자산명
            let unas_isnm:String
            /// 최종거래일
            let stck_last_tr_date:String
            /// 기초자산코드
            let unas_shrn_iscd:String
            /// 전일거래량
            let prdy_vol:String
            /// LP보유비율
            let lp_hldn_rate:String
            /// 패리티
            let prit:String
            /// 손익분기주가가격
            let prls_qryr_stpr_prc:String
            /// 델타값
            let delta_val:String
            /// 세타
            let theta:String
            /// 손익분기비율
            let prls_qryr_rate:String
            /// 주식상장일자
            let stck_lstn_date:String
            /// HTS내재변동성
            let hts_ints_vltl:String
            /// 레버리지값
            let lvrg_val:String
            /// LP순매도량
            let lp_ntby_qty:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/ranking/volume-rank"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPEW02780000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPEW02780000
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

    /// ELW 지표순위[국내주식-169]
    /// ELW 지표순위 API입니다. 한국투자 HTS(eFriend Plus) > [0279] ELW 지표순위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct indicator : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// 시장구분코드 (W)
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건화면분류코드
            /// Unique key(20279)
            let FID_COND_SCR_DIV_CODE:String
            /// 기초자산입력종목코드
            /// '000000(전체), 2001(코스피200) , 3003(코스닥150), 005930(삼성전자) '
            let FID_UNAS_INPUT_ISCD:String
            /// 발행사
            /// '00000(전체), 00003(한국투자증권) , 00017(KB증권), 00005(미래에셋주식회사)'
            let FID_INPUT_ISCD:String
            /// 콜풋구분코드
            /// 0(전체), 1(콜), 2(풋)
            let FID_DIV_CLS_CODE:String
            /// 가격(이상)
            let FID_INPUT_PRICE_1:String
            /// 가격(이하)
            let FID_INPUT_PRICE_2:String
            /// 거래량(이상)
            let FID_INPUT_VOL_1:String
            /// 거래량(이하)
            let FID_INPUT_VOL_2:String
            /// 순위정렬구분코드
            /// 0(전환비율), 1(레버리지), 2(행사가 ), 3(내재가치), 4(시간가치)
            let FID_RANK_SORT_CLS_CODE:String
            /// 결재방법
            /// 0(전체), 1(일반), 2(조기종료)
            let FID_BLNG_CLS_CODE:String
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
            /// ELW단축종목코드
            let elw_shrn_iscd:String
            /// ELW한글종목명
            let elw_kor_isnm:String
            /// ELW현재가
            let elw_prpr:String
            /// 전일대비
            let prdy_vrss:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 전일대비율
            let prdy_ctrt:String
            /// 누적거래량
            let acml_vol:String
            /// 주식전환비율
            let stck_cnvr_rate:String
            /// 레버리지값
            let lvrg_val:String
            /// 행사가
            let acpr:String
            /// 시간가치값
            let tmvl_val:String
            /// 내재가치값
            let invl_val:String
            /// 조기종료발생기준가격
            let elw_ko_barrier:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/ranking/indicator"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPEW02790000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPEW02790000
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

    /// ELW 민감도 순위[국내주식-170]
    /// ELW 민감도 순위 API입니다. 한국투자 HTS(eFriend Plus) > [0285] ELW 민감도 순위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct sensitivity : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// 시장구분코드 (W)
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건화면분류코드
            /// Unique key(20285)
            let FID_COND_SCR_DIV_CODE:String
            /// 기초자산입력종목코드
            /// '000000(전체), 2001(코스피200) , 3003(코스닥150), 005930(삼성전자) '
            let FID_UNAS_INPUT_ISCD:String
            /// 입력종목코드
            /// '00000(전체), 00003(한국투자증권) , 00017(KB증권), 00005(미래에셋주식회사)'
            let FID_INPUT_ISCD:String
            /// 콜풋구분코드
            /// 0(전체), 1(콜), 2(풋)
            let FID_DIV_CLS_CODE:String
            /// 가격(이상)
            let FID_INPUT_PRICE_1:String
            /// 가격(이하)
            let FID_INPUT_PRICE_2:String
            /// 거래량(이상)
            let FID_INPUT_VOL_1:String
            /// 거래량(이하)
            let FID_INPUT_VOL_2:String
            /// 순위정렬구분코드
            /// '0(이론가), 1(델타), 2(감마), 3(로), 4(베가) , 5(로) , 6(내재변동성), 7(90일변동성)'
            let FID_RANK_SORT_CLS_CODE:String
            /// 잔존일수(이상)
            let FID_INPUT_RMNN_DYNU_1:String
            /// 조회기준일
            let FID_INPUT_DATE_1:String
            /// 결재방법
            /// 0(전체), 1(일반), 2(조기종료)
            let FID_BLNG_CLS_CODE:String
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
            /// ELW단축종목코드
            let elw_shrn_iscd:String
            /// ELW한글종목명
            let elw_kor_isnm:String
            /// ELW현재가
            let elw_prpr:String
            /// 전일대비
            let prdy_vrss:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 전일대비율
            let prdy_ctrt:String
            /// 누적거래량
            let acml_vol:String
            /// HTS이론가
            let hts_thpr:String
            /// 델타값
            let delta_val:String
            /// 감마
            let gama:String
            /// 세타
            let theta:String
            /// 베가
            let vega:String
            /// 로우
            let rho:String
            /// HTS내재변동성
            let hts_ints_vltl:String
            /// 90일역사적변동성
            let d90_hist_vltl:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/ranking/sensitivity"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPEW02850000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPEW02850000
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

    /// ELW 당일급변종목[국내주식-171]
    /// ELW 당일급변종목 API입니다. 한국투자 HTS(eFriend Plus) > [0287] ELW 당일급변종목 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct quickchange : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// 시장구분코드 (W)
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건화면분류코드
            /// Unique key(20287)
            let FID_COND_SCR_DIV_CODE:String
            /// 기초자산입력종목코드
            /// '000000(전체), 2001(코스피200) , 3003(코스닥150), 005930(삼성전자) '
            let FID_UNAS_INPUT_ISCD:String
            /// 발행사
            /// '00000(전체), 00003(한국투자증권) , 00017(KB증권), 00005(미래에셋주식회사)'
            let FID_INPUT_ISCD:String
            /// 시장구분코드
            /// Unique key(A)
            let FID_MRKT_CLS_CODE:String
            /// 가격(이상)
            let FID_INPUT_PRICE_1:String
            /// 가격(이하)
            let FID_INPUT_PRICE_2:String
            /// 거래량(이상)
            let FID_INPUT_VOL_1:String
            /// 거래량(이하)
            let FID_INPUT_VOL_2:String
            /// 시간구분코드
            /// 1(분), 2(일)
            let FID_HOUR_CLS_CODE:String
            /// 입력 일 또는 분
            let FID_INPUT_HOUR_1:String
            /// 기준시간(분 선택 시)
            let FID_INPUT_HOUR_2:String
            /// 순위정렬구분코드
            /// '1(가격급등), 2(가격급락), 3(거래량급증) , 4(매수잔량급증), 5(매도잔량급증)'
            let FID_RANK_SORT_CLS_CODE:String
            /// 결재방법
            /// 0(전체), 1(일반), 2(조기종료)
            let FID_BLNG_CLS_CODE:String
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
            /// ELW단축종목코드
            let elw_shrn_iscd:String
            /// ELW한글종목명
            let elw_kor_isnm:String
            /// ELW현재가
            let elw_prpr:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 전일대비
            let prdy_vrss:String
            /// 전일대비율
            let prdy_ctrt:String
            /// 매도호가
            let askp:String
            /// 매수호가
            let bidp:String
            /// 총매도호가잔량
            let total_askp_rsqn:String
            /// 총매수호가잔량
            let total_bidp_rsqn:String
            /// 누적거래량
            let acml_vol:String
            /// 기준값
            let stnd_val:String
            /// 기준값대비
            let stnd_val_vrss:String
            /// 기준값대비율
            let stnd_val_ctrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/ranking/quick-change"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPEW02870000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPEW02870000
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

    /// ELW 변동성추이(체결) [국내주식-177]
    /// ELW 변동성 추이(체결) API입니다. 한국투자 HTS(eFriend Plus) > [0284] ELW 변동성 추이 화면의 "시간별" 변동성 추이 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct volatilitytrendccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// W(Unique key)
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력종목코드
            /// ex) 58J297(KBJ297삼성전자콜)
            let FID_INPUT_ISCD:String
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
            /// 주식체결시간
            let stck_cntg_hour:String
            /// ELW현재가
            let elw_prpr:String
            /// 전일대비
            let prdy_vrss:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 전일대비율
            let prdy_ctrt:String
            /// 매수호가
            let bidp:String
            /// 매도호가
            let askp:String
            /// 누적거래량
            let acml_vol:String
            /// HTS내재변동성
            let hts_ints_vltl:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/quotations/volatility-trend-ccnl"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPEW02840100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPEW02840100
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

    /// ELW 신규상장종목 [국내주식-181]
    /// ELW 신규상장종목 API입니다. 한국투자 HTS(eFriend Plus) > [0297] ELW 신규상장종목 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct newlylisted : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// 시장구분코드 (W)
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건화면분류코드
            /// Unique key(11548)
            let FID_COND_SCR_DIV_CODE:String
            /// 분류구분코드
            /// 전체(02), 콜(00), 풋(01)
            let FID_DIV_CLS_CODE:String
            /// 기초자산입력종목코드
            /// 'ex) 000000(전체), 2001(코스피200) , 3003(코스닥150), 005930(삼성전자) '
            let FID_UNAS_INPUT_ISCD:String
            /// 입력종목코드2
            /// '00003(한국투자증권), 00017(KB증권), 00005(미래에셋증권)'
            let FID_INPUT_ISCD_2:String
            /// 입력날짜1
            /// 날짜 (ex) 20240402)
            let FID_INPUT_DATE_1:String
            /// 결재방법
            /// 0(전체), 1(일반), 2(조기종료)
            let FID_BLNC_CLS_CODE:String
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
            /// 주식상장일자
            let stck_lstn_date:String
            /// ELW한글종목명
            let elw_kor_isnm:String
            /// ELW단축종목코드
            let elw_shrn_iscd:String
            /// 기초자산종목명
            let unas_isnm:String
            /// 발행회사명
            let pblc_co_name:String
            /// 상장주수
            let lstn_stcn:String
            /// 행사가
            let acpr:String
            /// 주식최종거래일자
            let stck_last_tr_date:String
            /// 조기종료발생기준가격
            let elw_ko_barrier:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/quotations/newly-listed"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKEW154800C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKEW154800C0
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

    /// ELW 변동성 추이(분별) [국내주식-179]
    /// ELW 변동성 추이(분별) API입니다. 한국투자 HTS(eFriend Plus) > [0284] ELW 변동성 추이 화면의 "분별" 변동성 추이 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct volatilitytrendminute : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// W(Unique key)
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력종목코드
            /// ex) 58J297(KBJ297삼성전자콜)
            let FID_INPUT_ISCD:String
            /// 시간구분코드
            /// '60(1분), 180(3분), 300(5분), 600(10분), 1800(30분), 3600(60분) '
            let FID_HOUR_CLS_CODE:String
            /// 과거데이터 포함 여부
            /// N(과거데이터포함X),Y(과거데이터포함O)
            let FID_PW_DATA_INCU_YN:String
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
            /// 주식 영업 일자
            let stck_bsop_date:String
            /// 주식 체결 시간
            let stck_cntg_hour:String
            /// 주식 현재가
            let stck_prpr:String
            /// ELW 시가2
            let elw_oprc:String
            /// ELW 최고가
            let elw_hgpr:String
            /// ELW 최저가
            let elw_lwpr:String
            /// HTS 내재 변동성
            let hts_ints_vltl:String
            /// 역사적 변동성
            let hist_vltl:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/quotations/volatility-trend-minute"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPEW02840300", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPEW02840300
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

    /// ELW 투자지표추이(체결) [국내주식-172]
    /// ELW 투자지표추이(체결) API입니다.한국투자 HTS(eFriend Plus) > [0274] ELW 투자지표추이 화면에서 "시간별 비교추이" 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct indicatortrendccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// 시장구분코드 (W)
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력종목코드
            /// ex) 58J297(KBJ297삼성전자콜)
            let FID_INPUT_ISCD:String
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
            /// 주식체결시간
            let stck_cntg_hour:String
            /// ELW현재가
            let elw_prpr:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 전일대비
            let prdy_vrss:String
            /// 전일대비율
            let prdy_ctrt:String
            /// 누적거래량
            let acml_vol:String
            /// 레버리지값
            let lvrg_val:String
            /// 기어링
            let gear:String
            /// 시간가치값
            let tmvl_val:String
            /// 내재가치값
            let invl_val:String
            /// 패리티
            let prit:String
            /// 접근도
            let apprch_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/quotations/indicator-trend-ccnl"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPEW02740100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPEW02740100
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

    /// ELW 투자지표추이(분별) [국내주식-174]
    /// ELW 투자지표추이(분별) API입니다.한국투자 HTS(eFriend Plus) > [0274] ELW 투자지표추이 화면 데이터의 "분별 비교추이" 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct indicatortrendminute : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// 시장구분코드 (W)
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력종목코드
            /// ex) 58J297(KBJ297삼성전자콜)
            let FID_INPUT_ISCD:String
            /// 시간구분코드
            /// '60(1분), 180(3분), 300(5분), 600(10분), 1800(30분), 3600(60분), 7200(60분) '
            let FID_HOUR_CLS_CODE:String
            /// 과거데이터 포함 여부
            /// N(과거데이터포함X),Y(과거데이터포함O)
            let FID_PW_DATA_INCU_YN:String
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
            /// 주식영업일자
            let stck_bsop_date:String
            /// 주식체결시간
            let stck_cntg_hour:String
            /// ELW현재가
            let elw_prpr:String
            /// ELW시가2
            let elw_oprc:String
            /// ELW최고가
            let elw_hgpr:String
            /// ELW최저가
            let elw_lwpr:String
            /// 레버리지값
            let lvrg_val:String
            /// 기어링
            let gear:String
            /// 프리미엄값
            let prmm_val:String
            /// 내재가치값
            let invl_val:String
            /// 패리티
            let prit:String
            /// 누적거래량
            let acml_vol:String
            /// 체결거래량
            let cntg_vol:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/quotations/indicator-trend-minute"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPEW02740300", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPEW02740300
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

    /// ELW 민감도 추이(체결) [국내주식-175]
    struct sensitivitytrendccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// 시장구분코드 (W)
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력종목코드
            /// ex) 58J297(KBJ297삼성전자콜)
            let FID_INPUT_ISCD:String
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
            /// 주식체결시간
            let stck_cntg_hour:String
            /// ELW현재가
            let elw_prpr:String
            /// 전일대비
            let prdy_vrss:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 전일대비율
            let prdy_ctrt:String
            /// hts 이론가
            let hts_thpr:String
            /// 델타 값
            let delta_val:String
            /// 감마
            let gama:String
            /// 세타
            let theta:String
            /// 베가
            let vega:String
            /// 로우
            let rho:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/quotations/sensitivity-trend-ccnl"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPEW02830100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPEW02830100
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

    /// ELW 변동성 추이(일별) [국내주식-178]
    /// ELW 변동성 추이(일별) API입니다.한국투자 HTS(eFriend Plus) > [0284] ELW 변동성 추이 화면의 "일별" 변동성 추이 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct volatilitytrenddaily : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// 시장구분코드 (W)
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력종목코드
            /// ex) 58J297(KBJ297삼성전자콜)
            let FID_INPUT_ISCD:String
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
            /// 주식 영업 일자
            let stck_cntg_hour:String
            /// ELW 현재가
            let elw_prpr:String
            /// 전일대비
            let prdy_vrss:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 전일대비율
            let prdy_ctrt:String
            /// elw 시가2
            let elw_oprc:String
            /// elw 최고가
            let elw_hgpr:String
            /// elw 최저가
            let elw_lwpr:String
            /// 누적 거래량
            let acml_vol:String
            /// 10일 역사적 변동성
            let d10_hist_vltl:String
            /// 20일 역사적 변동성
            let d20_hist_vltl:String
            /// 30일 역사적 변동성
            let d30_hist_vltl:String
            /// 60일 역사적 변동성
            let d60_hist_vltl:String
            /// 90일 역사적 변동성
            let d90_hist_vltl:String
            /// HTS 내재 변동성
            let hts_ints_vltl:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/quotations/volatility-trend-daily"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPEW02840200", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPEW02840200
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

    /// ELW 기초자산별 종목시세 [국내주식-186]
    /// ELW 기초자산별 종목시세  API입니다.한국투자 HTS(eFriend Plus) > [0288] ELW 기초자산별 ELW 시세 화면의 "우측 기초자산별 종목 리스트" 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct udrlassetprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// 시장구분(W)
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건화면분류코드
            /// Uniquekey(11541)
            let FID_COND_SCR_DIV_CODE:String
            /// 시장구분코드
            /// 전체(A),콜(C),풋(P)
            let FID_MRKT_CLS_CODE:String
            /// 입력종목코드
            /// '00000(전체), 00003(한국투자증권) , 00017(KB증권), 00005(미래에셋주식회사)'
            let FID_INPUT_ISCD:String
            /// 기초자산입력종목코드
            let FID_UNAS_INPUT_ISCD:String
            /// 거래량수
            /// 전일거래량(정수량미만)
            let FID_VOL_CNT:String
            /// 대상제외구분코드
            /// 거래불가종목제외(0:미체크,1:체크)
            let FID_TRGT_EXLS_CLS_CODE:String
            /// 입력가격1
            /// 가격~원이상
            let FID_INPUT_PRICE_1:String
            /// 입력가격2
            /// 가격~월이하
            let FID_INPUT_PRICE_2:String
            /// 입력거래량1
            /// 거래량~계약이상
            let FID_INPUT_VOL_1:String
            /// 입력거래량2
            /// 거래량~계약이하
            let FID_INPUT_VOL_2:String
            /// 입력잔존일수1
            /// 잔존일(~일이상)
            let FID_INPUT_RMNN_DYNU_1:String
            /// 입력잔존일수2
            /// 잔존일(~일이하)
            let FID_INPUT_RMNN_DYNU_2:String
            /// 옵션
            /// 옵션상태(0:없음,1:ATM,2:ITM,3:OTM)
            let FID_OPTION:String
            /// 입력옵션1
            let FID_INPUT_OPTION_1:String
            /// 입력옵션2
            let FID_INPUT_OPTION_2:String
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
            /// ELW단축종목코드
            let elw_shrn_iscd:String
            /// HTS한글종목명
            let hts_kor_isnm:String
            /// ELW현재가
            let elw_prpr:String
            /// 전일대비
            let prdy_vrss:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 전일대비율
            let prdy_ctrt:String
            /// 누적거래량
            let acml_vol:String
            /// 행사가
            let acpr:String
            /// 손익분기주가가격
            let prls_qryr_stpr_prc:String
            /// HTS잔존일수
            let hts_rmnn_dynu:String
            /// HTS내재변동성
            let hts_ints_vltl:String
            /// 주식전환비율
            let stck_cnvr_rate:String
            /// LP보유량
            let lp_hvol:String
            /// LP비중
            let lp_rlim:String
            /// 레버리지값
            let lvrg_val:String
            /// 기어링
            let gear:String
            /// 델타값
            let delta_val:String
            /// 감마
            let gama:String
            /// 베가
            let vega:String
            /// 세타
            let theta:String
            /// 손익분기비율
            let prls_qryr_rate:String
            /// 자본지지점
            let cfp:String
            /// 패리티
            let prit:String
            /// 내재가치값
            let invl_val:String
            /// 시간가치값
            let tmvl_val:String
            /// HTS이론가
            let hts_thpr:String
            /// 주식상장일자
            let stck_lstn_date:String
            /// 주식최종거래일자
            let stck_last_tr_date:String
            /// LP순매도량
            let lp_ntby_qty:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/quotations/udrl-asset-price"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKEW154101C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKEW154101C0
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

    /// ELW 투자지표추이(일별) [국내주식-173]
    /// ELW 투자지표추이(일별) API입니다.한국투자 HTS(eFriend Plus) > [0274] ELW 투자지표추이 화면에서 "일자별 비교추이" 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct indicatortrenddaily : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// 종목코드(ex) 005930(삼성전자))
            let FID_INPUT_ISCD:String
            /// 조건화면분류코드
            /// 외국계 전체(99999)
            let FID_INPUT_ISCD_2:String
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
            /// 주식영업일자
            let stck_bsop_date:String
            /// ELW현재가
            let elw_prpr:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 전일대비
            let prdy_vrss:String
            /// 전일대비율
            let prdy_ctrt:String
            /// 누적거래량
            let acml_vol:String
            /// 레버리지값
            let lvrg_val:String
            /// 기어링
            let gear:String
            /// 시간가치값
            let tmvl_val:String
            /// 내재가치값
            let invl_val:String
            /// 패리티
            let prit:String
            /// ELW시가2
            let elw_oprc:String
            /// ELW최고가
            let elw_hgpr:String
            /// ELW최저가
            let elw_lwpr:String
            /// 접근도
            let apprch_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/quotations/indicator-trend-daily"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPEW02740200", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPEW02740200
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

    /// ELW 민감도 추이(일별) [국내주식-176]
    /// ELW 민감도 추이(일별) API입니다.한국투자 HTS(eFriend Plus) > [0283] ELW 민감도 추이 화면의 "일자별" 민감도추이 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct sensitivitytrenddaily : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// 시장구분코드 (W)
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력종목코드
            /// ex)(58J438(KBJ438삼성전자풋)
            let FID_INPUT_ISCD:String
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
            /// 주식영업일자
            let stck_bsop_date:String
            /// ELW현재가
            let elw_prpr:String
            /// 전일대비
            let prdy_vrss:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 전일대비율
            let prdy_ctrt:String
            /// HTS이론가
            let hts_thpr:String
            /// 델타값
            let delta_val:String
            /// 감마
            let gama:String
            /// 세타
            let theta:String
            /// 베가
            let vega:String
            /// 로우
            let rho:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/quotations/sensitivity-trend-daily"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPEW02830200", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPEW02830200
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

    /// ELW 변동성 추이(틱) [국내주식-180]
    /// ELW 변동성 추이(틱) API입니다.한국투자 HTS(eFriend Plus) > [0284] ELW 변동성 추이 화면의 "틱 차트" 변동성 추이 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct volatilitytrendtick : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// W(Unique key)
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력종목코드
            /// ex) 58J297(KBJ297삼성전자콜)
            let FID_INPUT_ISCD:String
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
            /// 주식영업일자
            let bsop_date:String
            /// ELW현재가
            let stck_cntg_hour:String
            /// 전일대비
            let elw_prpr:String
            /// 전일대비부호
            let hts_ints_vltl:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/quotations/volatility-trend-tick"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPEW02840400", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPEW02840400
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

    /// ELW LP매매추이 [국내주식-182]
    /// ELW LP매매추이 API입니다.한국투자 HTS(eFriend Plus) > [0376] ELW LP매매추이 화면 의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct lptradetrend : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// 시장구분(W)
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력종목코드
            /// 입력종목코드(ex 52K577(미래 K577KOSDAQ150콜)
            let FID_INPUT_ISCD:String
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
            /// ELW현재가
            let elw_prpr:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 전일대비
            let prdy_vrss:String
            /// 전일대비율
            let prdy_ctrt:String
            /// 누적거래량
            let acml_vol:String
            /// 전일거래량
            let prdy_vol:String
            /// 주식전환비율
            let stck_cnvr_rate:String
            /// 패리티
            let prit:String
            /// 레버리지값
            let lvrg_val:String
            /// 기어링
            let gear:String
            /// 손익분기비율
            let prls_qryr_rate:String
            /// 자본지지점
            let cfp:String
            /// 내재가치값
            let invl_val:String
            /// 시간가치값
            let tmvl_val:String
            /// 행사가
            let acpr:String
            /// 조기종료발생기준가격
            let elw_ko_barrier:String
        }
        public struct Output2 : Codable {
            /// 주식영업일자
            let stck_bsop_date:String
            /// ELW현재가
            let elw_prpr:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 전일대비
            let prdy_vrss:String
            /// 전일대비율
            let prdy_ctrt:String
            /// LP매도수량
            let lp_seln_qty:String
            /// LP매도평균단가
            let lp_seln_avrg_unpr:String
            /// LP매수수량
            let lp_shnu_qty:String
            /// LP매수평균단가
            let lp_shnu_avrg_unpr:String
            /// LP보유량
            let lp_hvol:String
            /// LP보유비율
            let lp_hldn_rate:String
            /// 개인매매수량
            let prsn_deal_qty:String
            /// 접근도
            let apprch_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/quotations/lp-trade-trend"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHPEW03760000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPEW03760000
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

    /// ELW 비교대상종목조회 [국내주식-183]
    /// ELW 비교대상종목조회 API입니다.기초자산 종목코드를 입력하셔서 해당 종목을 기초자산으로 하는 ELW 목록을 조회하실 수 있습니다.
    struct comparestocks : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건화면분류코드
            /// 11517(Primary key)
            let FID_COND_SCR_DIV_CODE:String
            /// 입력종목코드
            /// 종목코드(ex)005930(삼성전자))
            let FID_INPUT_ISCD:String
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
            /// ELW단축종목코드
            let elw_shrn_iscd:String
            /// ELW한글종목명
            let elw_kor_isnm:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/quotations/compare-stocks"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKEW151701C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKEW151701C0
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

    /// ELW 종목검색 [국내주식-166]
    /// ELW 종목검색 API입니다.한국투자 HTS(eFriend Plus) > [0291] ELW 종목검색 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.한 번의 호출에 최대 100건까지 확인 가능합니다.
    struct condsearch : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// ELW(W)
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건화면분류코드
            /// 화면번호(11510)
            let FID_COND_SCR_DIV_CODE:String
            /// 순위정렬구분코드
            /// '정렬1정렬안함(0)종목코드(1)현재가(2)대비율(3)거래량(4)행사가격(5) 전환비율(6)상장일(7)만기일(8)잔존일수(9)레버리지(10)'
            let FID_RANK_SORT_CLS_CODE:String
            /// 입력수1
            /// 정렬1기준 - 상위(1)하위(2)
            let FID_INPUT_CNT_1:String
            /// 순위정렬구분코드2
            /// 정렬2
            let FID_RANK_SORT_CLS_CODE_2:String
            /// 입력수2
            /// 정렬2기준 - 상위(1)하위(2)
            let FID_INPUT_CNT_2:String
            /// 순위정렬구분코드3
            /// 정렬3
            let FID_RANK_SORT_CLS_CODE_3:String
            /// 입력수3
            /// 정렬3기준 - 상위(1)하위(2)
            let FID_INPUT_CNT_3:String
            /// 대상구분코드
            /// 0:발행회사종목코드,1:기초자산종목코드,2:FID시장구분코드,3:FID입력날짜1(상장일), 4:FID입력날짜2(만기일),5:LP회원사종목코드,6:행사가기초자산비교>=(1) <=(2), 7:잔존일 이상 이하, 8:현재가, 9:전일대비율, 10:거래량, 11:최종거래일, 12:레버리지
            let FID_TRGT_CLS_CODE:String
            /// 입력종목코드
            /// 발행사종목코드전체(00000)
            let FID_INPUT_ISCD:String
            /// 기초자산입력종목코드
            let FID_UNAS_INPUT_ISCD:String
            /// 시장구분코드
            /// 권리유형전체(A)콜(CO)풋(PO)
            let FID_MRKT_CLS_CODE:String
            /// 입력날짜1
            /// 상장일전체(0)금일(1)7일이하(2)8~30일(3)31~90일(4)
            let FID_INPUT_DATE_1:String
            /// 입력날짜2
            /// 만기일전체(0)1개월(1)1~2(2)2~3(3)3~6(4)6~9(5)9~12(6)12이상(7)
            let FID_INPUT_DATE_2:String
            /// 입력종목코드2
            let FID_INPUT_ISCD_2:String
            /// 기타구분코드
            /// 행사가전체(0)>=(1)
            let FID_ETC_CLS_CODE:String
            /// 입력잔존일수1
            /// 잔존일이상
            let FID_INPUT_RMNN_DYNU_1:String
            /// 입력잔존일수2
            /// 잔존일이하
            let FID_INPUT_RMNN_DYNU_2:String
            /// 현재가수1
            /// 현재가이상
            let FID_PRPR_CNT1:String
            /// 현재가수2
            /// 현재가이하
            let FID_PRPR_CNT2:String
            /// 등락비율1
            /// 전일대비율이상
            let FID_RSFL_RATE1:String
            /// 등락비율2
            /// 전일대비율이하
            let FID_RSFL_RATE2:String
            /// 거래량1
            /// 거래량이상
            let FID_VOL1:String
            /// 거래량2
            /// 거래량이하
            let FID_VOL2:String
            /// 적용범위가격1
            /// 최종거래일from
            let FID_APLY_RANG_PRC_1:String
            /// 적용범위가격2
            /// 최종거래일to
            let FID_APLY_RANG_PRC_2:String
            /// 레버리지값1
            let FID_LVRG_VAL1:String
            /// 레버리지값2
            let FID_LVRG_VAL2:String
            /// 거래량3
            /// LP종료일from
            let FID_VOL3:String
            /// 거래량4
            /// LP종료일to
            let FID_VOL4:String
            /// 내재변동성1
            /// 내재변동성이상
            let FID_INTS_VLTL1:String
            /// 내재변동성2
            /// 내재변동성이하
            let FID_INTS_VLTL2:String
            /// 프리미엄값1
            /// 프리미엄이상
            let FID_PRMM_VAL1:String
            /// 프리미엄값2
            /// 프리미엄이하
            let FID_PRMM_VAL2:String
            /// 기어링1
            /// 기어링이상
            let FID_GEAR1:String
            /// 기어링2
            /// 기어링이하
            let FID_GEAR2:String
            /// 손익분기비율1
            /// 손익분기이상
            let FID_PRLS_QRYR_RATE1:String
            /// 손익분기비율2
            /// 손익분기이하
            let FID_PRLS_QRYR_RATE2:String
            /// 델타1
            /// 델타이상
            let FID_DELTA1:String
            /// 델타2
            /// 델타이하
            let FID_DELTA2:String
            /// 행사가1
            let FID_ACPR1:String
            /// 행사가2
            let FID_ACPR2:String
            /// 주식전환비율1
            /// 전환비율이상
            let FID_STCK_CNVR_RATE1:String
            /// 주식전환비율2
            /// 전환비율이하
            let FID_STCK_CNVR_RATE2:String
            /// 분류구분코드
            /// 0:전체,1:일반,2:조기종료
            let FID_DIV_CLS_CODE:String
            /// 패리티1
            /// 패리티이상
            let FID_PRIT1:String
            /// 패리티2
            /// 패리티이하
            let FID_PRIT2:String
            /// 자본지지점1
            /// 배리어이상
            let FID_CFP1:String
            /// 자본지지점2
            /// 배리어이하
            let FID_CFP2:String
            /// 지수가격1
            /// LP보유비율이상
            let FID_INPUT_NMIX_PRICE_1:String
            /// 지수가격2
            /// LP보유비율이하
            let FID_INPUT_NMIX_PRICE_2:String
            /// E기어링값1
            /// 접근도이상
            let FID_EGEA_VAL1:String
            /// E기어링값2
            /// 접근도이하
            let FID_EGEA_VAL2:String
            /// 배당수익율
            /// 손익분기점이상
            let FID_INPUT_DVDN_ERT:String
            /// 역사적변동성
            /// 손익분기점이하
            let FID_INPUT_HIST_VLTL:String
            /// 세타1
            /// MONEYNESS이상
            let FID_THETA1:String
            /// 세타2
            /// MONEYNESS이하
            let FID_THETA2:String
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
            /// 채권단축종목코드
            let bond_shrn_iscd:String
            /// HTS한글종목명
            let hts_kor_isnm:String
            /// 권리유형명
            let rght_type_name:String
            /// ELW현재가
            let elw_prpr:String
            /// 전일대비
            let prdy_vrss:String
            /// 전일대비부호
            let prdy_vrss_sign:String
            /// 전일대비율
            let prdy_ctrt:String
            /// 누적거래량
            let acml_vol:String
            /// 행사가
            let acpr:String
            /// 주식전환비율
            let stck_cnvr_rate:String
            /// 주식상장일자
            let stck_lstn_date:String
            /// 주식최종거래일자
            let stck_last_tr_date:String
            /// HTS잔존일수
            let hts_rmnn_dynu:String
            /// 기초자산종목명
            let unas_isnm:String
            /// 기초자산현재가
            let unas_prpr:String
            /// 기초자산전일대비
            let unas_prdy_vrss:String
            /// 기초자산전일대비부호
            let unas_prdy_vrss_sign:String
            /// 기초자산전일대비율
            let unas_prdy_ctrt:String
            /// 기초자산누적거래량
            let unas_acml_vol:String
            /// MONEYNESS
            let moneyness:String
            /// ATM구분명
            let atm_cls_name:String
            /// 패리티
            let prit:String
            /// 델타값
            let delta_val:String
            /// HTS내재변동성
            let hts_ints_vltl:String
            /// 시간가치값
            let tmvl_val:String
            /// 기어링
            let gear:String
            /// 레버리지값
            let lvrg_val:String
            /// 손익분기비율
            let prls_qryr_rate:String
            /// 자본지지점
            let cfp:String
            /// 상장주수
            let lstn_stcn:String
            /// 발행회사명
            let pblc_co_name:String
            /// LP회원사명
            let lp_mbcr_name:String
            /// LP보유비율
            let lp_hldn_rate:String
            /// ELW권리형태
            let elw_rght_form:String
            /// 조기종료발생기준가격
            let elw_ko_barrier:String
            /// 접근도
            let apprch_rate:String
            /// 기초자산단축종목코드
            let unas_shrn_iscd:String
            /// 만기일자
            let mtrt_date:String
            /// 프리미엄값
            let prmm_val:String
            /// 주식LP종료일자
            let stck_lp_fin_date:String
            /// 틱환산가
            let tick_conv_prc:String
            /// 손익분기주가가격
            let prls_qryr_stpr_prc:String
            /// LP보유량
            let lp_hvol:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/quotations/cond-search"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKEW15100000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKEW15100000
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

    /// ELW 기초자산 목록조회 [국내주식-185]
    /// ELW 기초자산 목록조회 API입니다.한국투자 HTS(eFriend Plus) > [0288] ELW 기초자산별 ELW 시세 화면 의 "왼쪽 기초자산 목록" 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct udrlassetlist : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건화면분류코드
            /// 11541(Primary key)
            let FID_COND_SCR_DIV_CODE:String
            /// 순위정렬구분코드
            /// 0(종목명순), 1(콜발행종목순), 2(풋발행종목순), 3(전일대비 상승율순), 4(전일대비 하락율순), 5(현재가 크기순), 6(종목코드순)
            let FID_RANK_SORT_CLS_CODE:String
            /// 입력종목코드
            /// 00000(전체), 00003(한국투자증권), 00017(KB증권), 00005(미래에셋)
            let FID_INPUT_ISCD:String
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
            /// 기초자산단축종목코드
            let unas_shrn_iscd:String
            /// 기초자산종목명
            let unas_isnm:String
            /// 기초자산현재가
            let unas_prpr:String
            /// 기초자산전일대비
            let unas_prdy_vrss:String
            /// 기초자산전일대비부호
            let unas_prdy_vrss_sign:String
            /// 기초자산전일대비율
            let unas_prdy_ctrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/quotations/udrl-asset-list"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKEW154100C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKEW154100C0
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

    /// ELW 만기예정/만기종목 [국내주식-184]
    /// ELW 만기예정/만기종목 API입니다. 한국투자 HTS(eFriend Plus) > [0290] ELW 만기예정/만기종목 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최근 100건까지 데이터 조회 가능합니다.
    struct expirationstocks : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// W 입력
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건화면분류코드
            /// 11547 입력
            let FID_COND_SCR_DIV_CODE:String
            /// 입력날짜1
            /// 입력날짜 ~ (ex) 20240402)
            let FID_INPUT_DATE_1:String
            /// 입력날짜2
            /// ~입력날짜 (ex) 20240408)
            let FID_INPUT_DATE_2:String
            /// 분류구분코드
            /// 0(콜),1(풋),2(전체)
            let FID_DIV_CLS_CODE:String
            /// 기타구분코드
            /// 공백 입력
            let FID_ETC_CLS_CODE:String
            /// 기초자산입력종목코드
            /// 000000(전체), 2001(KOSPI 200), 기초자산코드(종목코드 ex. 삼성전자-005930)
            let FID_UNAS_INPUT_ISCD:String
            /// 발행회사코드
            /// 00000(전체), 00003(한국투자증권), 00017(KB증권), 00005(미래에셋증권)
            let FID_INPUT_ISCD_2:String
            /// 결제방법
            /// 0(전체),1(일반),2(조기종료)
            let FID_BLNG_CLS_CODE:String
            /// 입력옵션1
            /// 공백 입력
            let FID_INPUT_OPTION_1:String
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
            /// ELW단축종목코드
            let elw_shrn_iscd:String
            /// ELW한글종목명
            let elw_kor_isnm:String
            /// 기초자산종목명
            let unas_isnm:String
            /// 기초자산현재가
            let unas_prpr:String
            /// 행사가
            let acpr:String
            /// 주식전환비율
            let stck_cnvr_rate:String
            /// ELW현재가
            let elw_prpr:String
            /// 주식상장일자
            let stck_lstn_date:String
            /// 주식최종거래일자
            let stck_last_tr_date:String
            /// 총상환금액
            let total_rdmp_amt:String
            /// 상환금액
            let rdmp_amt:String
            /// 상장주수
            let lstn_stcn:String
            /// LP보유량
            let lp_hvol:String
            /// 확정지급2가격
            let ccls_paym_prc:String
            /// 만기평가금액
            let mtrt_vltn_amt:String
            /// 행사2기간종료일자
            let evnt_prd_fin_date:String
            /// 결제일자
            let stlm_date:String
            /// 발행가격
            let pblc_prc:String
            /// 기초자산단축종목코드
            let unas_shrn_iscd:String
            /// 표준종목코드
            let stnd_iscd:String
            /// 상환청구금액
            let rdmp_ask_amt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/elw/v1/quotations/expiration-stocks"
        public var customHeader: [String : String]?
        init(tr_id: String = "FHKEW154700C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.customHeader = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKEW154700C0
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
