//
//  국내주식_순위분석.swift
//  KoreaInvestSwift
//
//  Created by kin on 4/6/25.
//
import FullyRESTful

extension KISAPI {
    enum 국내주식_순위분석 {}
}
extension KISAPI.국내주식_순위분석 {
    /// 거래량순위[v1_국내주식-047]
    /// 국내주식 거래량순위 API입니다. 한국투자 HTS(eFriend Plus) > [0171] 거래량 순위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.+30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,HTS [0110]에서 여러가지 조건을 설정할 수 있는데, 그 중 거래량 순위(ex. 0봉전 거래량 상위순 100종목) 에 대해서도 설정해서 종목을 검색할 수 있습니다.자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct volumerank : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// J
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건 화면 분류 코드
            /// 20171
            let FID_COND_SCR_DIV_CODE:String
            /// 입력 종목코드
            /// 0000(전체) 기타(업종코드)
            let FID_INPUT_ISCD:String
            /// 분류 구분 코드
            /// 0(전체) 1(보통주) 2(우선주)
            let FID_DIV_CLS_CODE:String
            /// 소속 구분 코드
            /// 0 : 평균거래량 1:거래증가율 2:평균거래회전율 3:거래금액순 4:평균거래금액회전율
            let FID_BLNG_CLS_CODE:String
            /// 대상 구분 코드
            /// 1 or 0 9자리 (차례대로 증거금 30% 40% 50% 60% 100% 신용보증금 30% 40% 50% 60%) ex) "111111111"
            let FID_TRGT_CLS_CODE:String
            /// 대상 제외 구분 코드
            /// 1 or 0 10자리 (차례대로 투자위험/경고/주의 관리종목 정리매매 불성실공시 우선주 거래정지 ETF ETN 신용주문불가 SPAC) ex) "0000000000"
            let FID_TRGT_EXLS_CLS_CODE:String
            /// 입력 가격1
            /// 가격 ~ ex) "0" 전체 가격 대상 조회 시 FID_INPUT_PRICE_1, FID_INPUT_PRICE_2 모두 ""(공란) 입력
            let FID_INPUT_PRICE_1:String
            /// 입력 가격2
            /// ~ 가격 ex) "1000000" 전체 가격 대상 조회 시 FID_INPUT_PRICE_1, FID_INPUT_PRICE_2 모두 ""(공란) 입력
            let FID_INPUT_PRICE_2:String
            /// 거래량 수
            /// 거래량 ~ ex) "100000" 전체 거래량 대상 조회 시 FID_VOL_CNT ""(공란) 입력
            let FID_VOL_CNT:String
            /// 입력 날짜1
            /// ""(공란) 입력
            let FID_INPUT_DATE_1:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object Array
            /// Array
            let Output: [Output]
        }
        public struct Output : Codable {
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 유가증권 단축 종목코드
            let mksc_shrn_iscd:String
            /// 데이터 순위
            let data_rank:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 전일 거래량
            let prdy_vol:String
            /// 상장 주수
            let lstn_stcn:String
            /// 평균 거래량
            let avrg_vol:String
            /// N일전종가대비현재가대비율
            let n_befr_clpr_vrss_prpr_rate:String
            /// 거래량증가율
            let vol_inrt:String
            /// 거래량 회전율
            let vol_tnrt:String
            /// N일 거래량 회전율
            let nday_vol_tnrt:String
            /// 평균 거래 대금
            let avrg_tr_pbmn:String
            /// 거래대금회전율
            let tr_pbmn_tnrt:String
            /// N일 거래대금 회전율
            let nday_tr_pbmn_tnrt:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/volume-rank"
        public var header: [String : String]
        init(tr_id: String = "FHPST01710000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01710000
                "tr_cont", // 공백 : 초기 조회
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

    /// 국내주식 등락률 순위[v1_국내주식-088]
    /// 국내주식 등락률 순위 API입니다. 한국투자 HTS(eFriend Plus) > [0170] 등락률 순위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct fluctuation : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 등락 비율2
            /// 입력값 없을때 전체 (~ 비율
            let fid_rsfl_rate2:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let fid_cond_mrkt_div_code:String
            /// 조건 화면 분류 코드
            /// Unique key( 20170 )
            let fid_cond_scr_div_code:String
            /// 입력 종목코드
            /// 0000(전체) 코스피(0001), 코스닥(1001), 코스피200(2001)
            let fid_input_iscd:String
            /// 순위 정렬 구분 코드
            /// 0:상승율순 1:하락율순 2:시가대비상승율 3:시가대비하락율 4:변동율
            let fid_rank_sort_cls_code:String
            /// 입력 수1
            /// 0:전체 , 누적일수 입력
            let fid_input_cnt_1:String
            /// 가격 구분 코드
            /// 'fid_rank_sort_cls_code :0 상승율 순일때 (0:저가대비, 1:종가대비) fid_rank_sort_cls_code :1 하락율 순일때 (0:고가대비, 1:종가대비) fid_rank_sort_cls_code : 기타 (0:전체)'
            let fid_prc_cls_code:String
            /// 입력 가격1
            /// 입력값 없을때 전체 (가격 ~)
            let fid_input_price_1:String
            /// 입력 가격2
            /// 입력값 없을때 전체 (~ 가격)
            let fid_input_price_2:String
            /// 거래량 수
            /// 입력값 없을때 전체 (거래량 ~)
            let fid_vol_cnt:String
            /// 대상 구분 코드
            /// 0:전체
            let fid_trgt_cls_code:String
            /// 대상 제외 구분 코드
            /// 0:전체
            let fid_trgt_exls_cls_code:String
            /// 분류 구분 코드
            /// 0:전체
            let fid_div_cls_code:String
            /// 등락 비율1
            /// 입력값 없을때 전체 (비율 ~)
            let fid_rsfl_rate1:String
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
            let stck_shrn_iscd:String
            /// 데이터 순위
            let data_rank:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 주식 최고가
            let stck_hgpr:String
            /// 최고가 시간
            let hgpr_hour:String
            /// 누적 최고가 일자
            let acml_hgpr_date:String
            /// 주식 최저가
            let stck_lwpr:String
            /// 최저가 시간
            let lwpr_hour:String
            /// 누적 최저가 일자
            let acml_lwpr_date:String
            /// 최저가 대비 현재가 비율
            let lwpr_vrss_prpr_rate:String
            /// 지정 일자 종가 대비 현재가 비
            let dsgt_date_clpr_vrss_prpr_rate:String
            /// 연속 상승 일수
            let cnnt_ascn_dynu:String
            /// 최고가 대비 현재가 비율
            let hgpr_vrss_prpr_rate:String
            /// 연속 하락 일수
            let cnnt_down_dynu:String
            /// 시가2 대비 현재가 부호
            let oprc_vrss_prpr_sign:String
            /// 시가2 대비 현재가
            let oprc_vrss_prpr:String
            /// 시가2 대비 현재가 비율
            let oprc_vrss_prpr_rate:String
            /// 기간 등락
            let prd_rsfl:String
            /// 기간 등락 비율
            let prd_rsfl_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/fluctuation"
        public var header: [String : String]
        init(tr_id: String = "FHPST01700000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01700000
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

    /// 국내주식 수익자산지표 순위[v1_국내주식-090]
    /// 국내주식 수익자산지표 순위 API입니다.한국투자 HTS(eFriend Plus) > [0173] 수익자산지표 순위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct profitassetindex : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let fid_cond_mrkt_div_code:String
            /// 대상 구분 코드
            /// 0:전체
            let fid_trgt_cls_code:String
            /// 조건 화면 분류 코드
            /// Unique key( 20173 )
            let fid_cond_scr_div_code:String
            /// 입력 종목코드
            /// 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200
            let fid_input_iscd:String
            /// 분류 구분 코드
            /// 0:전체
            let fid_div_cls_code:String
            /// 입력 가격1
            /// 입력값 없을때 전체 (가격 ~)
            let fid_input_price_1:String
            /// 입력 가격2
            /// 입력값 없을때 전체 (~ 가격)
            let fid_input_price_2:String
            /// 거래량 수
            /// 입력값 없을때 전체 (거래량 ~)
            let fid_vol_cnt:String
            /// 입력 옵션1
            /// 회계연도 (2023)
            let fid_input_option_1:String
            /// 입력 옵션2
            /// 0: 1/4분기 , 1: 반기, 2: 3/4분기, 3: 결산
            let fid_input_option_2:String
            /// 순위 정렬 구분 코드
            /// 0:매출이익 1:영업이익 2:경상이익 3:당기순이익 4:자산총계 5:부채총계 6:자본총계
            let fid_rank_sort_cls_code:String
            /// 소속 구분 코드
            /// 0:전체
            let fid_blng_cls_code:String
            /// 대상 제외 구분 코드
            /// 0:전체
            let fid_trgt_exls_cls_code:String
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
            /// 데이터 순위
            let data_rank:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 유가증권 단축 종목코드
            let mksc_shrn_iscd:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 매출 총 이익
            let sale_totl_prfi:String
            /// 영업 이익
            let bsop_prti:String
            /// 경상 이익
            let op_prfi:String
            /// 당기순이익
            let thtr_ntin:String
            /// 자산총계
            let total_aset:String
            /// 부채총계
            let total_lblt:String
            /// 자본총계
            let total_cptl:String
            /// 결산 월
            let stac_month:String
            /// 결산 월 구분 코드
            let stac_month_cls_code:String
            /// 조회 건수
            let iqry_csnu:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/profit-asset-index"
        public var header: [String : String]
        init(tr_id: String = "FHPST01730000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01730000
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

    /// 국내주식 시가총액 상위[v1_국내주식-091]
    /// 국내주식 시가총액 상위 API입니다.한국투자 HTS(eFriend Plus) > [0174] 시가총액 상위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct marketcap : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 입력 가격2
            /// 입력값 없을때 전체 (~ 가격)
            let fid_input_price_2:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let fid_cond_mrkt_div_code:String
            /// 조건 화면 분류 코드
            /// Unique key( 20174 )
            let fid_cond_scr_div_code:String
            /// 분류 구분 코드
            /// 0: 전체, 1:보통주, 2:우선주
            let fid_div_cls_code:String
            /// 입력 종목코드
            /// 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200
            let fid_input_iscd:String
            /// 대상 구분 코드
            /// 0 : 전체
            let fid_trgt_cls_code:String
            /// 대상 제외 구분 코드
            /// 0 : 전체
            let fid_trgt_exls_cls_code:String
            /// 입력 가격1
            /// 입력값 없을때 전체 (가격 ~)
            let fid_input_price_1:String
            /// 거래량 수
            /// 입력값 없을때 전체 (거래량 ~)
            let fid_vol_cnt:String
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
            /// 유가증권 단축 종목코드
            let mksc_shrn_iscd:String
            /// 데이터 순위
            let data_rank:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 상장 주수
            let lstn_stcn:String
            /// 시가 총액
            let stck_avls:String
            /// 시장 전체 시가총액 비중
            let mrkt_whol_avls_rlim:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/market-cap"
        public var header: [String : String]
        init(tr_id: String = "FHPST01740000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01740000
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

    /// 국내주식 재무비율 순위[v1_국내주식-092]
    /// 국내주식 재무비율 순위 API입니다.한국투자 HTS(eFriend Plus) > [0175] 재무비율순위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct financeratio : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 대상 구분 코드
            /// 0 : 전체
            let fid_trgt_cls_code:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let fid_cond_mrkt_div_code:String
            /// 조건 화면 분류 코드
            /// Unique key( 20175 )
            let fid_cond_scr_div_code:String
            /// 입력 종목코드
            /// 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200
            let fid_input_iscd:String
            /// 분류 구분 코드
            /// 0 : 전체
            let fid_div_cls_code:String
            /// 입력 가격1
            /// 입력값 없을때 전체 (가격 ~)
            let fid_input_price_1:String
            /// 입력 가격2
            /// 입력값 없을때 전체 (~ 가격)
            let fid_input_price_2:String
            /// 거래량 수
            /// 입력값 없을때 전체 (거래량 ~)
            let fid_vol_cnt:String
            /// 입력 옵션1
            /// 회계년도 입력 (ex 2023)
            let fid_input_option_1:String
            /// 입력 옵션2
            /// 0: 1/4분기 , 1: 반기, 2: 3/4분기, 3: 결산
            let fid_input_option_2:String
            /// 순위 정렬 구분 코드
            /// 7: 수익성 분석, 11 : 안정성 분석, 15: 성장성 분석, 20: 활동성 분석
            let fid_rank_sort_cls_code:String
            /// 소속 구분 코드
            /// 0
            let fid_blng_cls_code:String
            /// 대상 제외 구분 코드
            /// 0 : 전체
            let fid_trgt_exls_cls_code:String
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
            /// 데이터 순위
            let data_rank:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 유가증권 단축 종목코드
            let mksc_shrn_iscd:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 총자본경상이익율
            let cptl_op_prfi:String
            /// 총자본 순이익율
            let cptl_ntin_rate:String
            /// 매출액 총이익율
            let sale_totl_rate:String
            /// 매출액 순이익율
            let sale_ntin_rate:String
            /// 자기자본비율
            let bis:String
            /// 부채 비율
            let lblt_rate:String
            /// 차입금 의존도
            let bram_depn:String
            /// 유보 비율
            let rsrv_rate:String
            /// 매출액 증가율
            let grs:String
            /// 경상 이익 증가율
            let op_prfi_inrt:String
            /// 영업 이익 증가율
            let bsop_prfi_inrt:String
            /// 순이익 증가율
            let ntin_inrt:String
            /// 자기자본 증가율
            let equt_inrt:String
            /// 총자본회전율
            let cptl_tnrt:String
            /// 매출 채권 회전율
            let sale_bond_tnrt:String
            /// 총자산 증가율
            let totl_aset_inrt:String
            /// 결산 월
            let stac_month:String
            /// 결산 월 구분 코드
            let stac_month_cls_code:String
            /// 조회 건수
            let iqry_csnu:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/finance-ratio"
        public var header: [String : String]
        init(tr_id: String = "FHPST01750000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01750000
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

    /// 국내주식 시간외잔량 순위[v1_국내주식-093]
    /// 국내주식 시간외잔량 순위 API입니다.한국투자 HTS(eFriend Plus) > [0176] 시간외잔량 상위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct afterhourbalance : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 입력 가격1
            /// 입력값 없을때 전체 (가격 ~)
            let fid_input_price_1:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let fid_cond_mrkt_div_code:String
            /// 조건 화면 분류 코드
            /// Unique key( 20176 )
            let fid_cond_scr_div_code:String
            /// 순위 정렬 구분 코드
            /// 1: 장전 시간외, 2: 장후 시간외, 3:매도잔량, 4:매수잔량
            let fid_rank_sort_cls_code:String
            /// 분류 구분 코드
            /// 0 : 전체
            let fid_div_cls_code:String
            /// 입력 종목코드
            /// 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200
            let fid_input_iscd:String
            /// 대상 제외 구분 코드
            /// 0 : 전체
            let fid_trgt_exls_cls_code:String
            /// 대상 구분 코드
            /// 0 : 전체
            let fid_trgt_cls_code:String
            /// 거래량 수
            /// 입력값 없을때 전체 (거래량 ~)
            let fid_vol_cnt:String
            /// 입력 가격2
            /// 입력값 없을때 전체 (~ 가격)
            let fid_input_price_2:String
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
            let stck_shrn_iscd:String
            /// 데이터 순위
            let data_rank:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 시간외 총 매도호가 잔량
            let ovtm_total_askp_rsqn:String
            /// 시간외 총 매수호가 잔량
            let ovtm_total_bidp_rsqn:String
            /// 장개시전 시간외종가 거래량
            let mkob_otcp_vol:String
            /// 장종료후 시간외종가 거래량
            let mkfa_otcp_vol:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/after-hour-balance"
        public var header: [String : String]
        init(tr_id: String = "FHPST01760000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01760000
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

    /// 국내주식 우선주/괴리율 상위[v1_국내주식-094]
    /// 국내주식 우선주/괴리율 상위 API입니다.한국투자 HTS(eFriend Plus) > [0177] 우선주/괴리율 상위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct preferdisparateratio : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 거래량 수
            /// 입력값 없을때 전체 (거래량 ~)
            let fid_vol_cnt:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let fid_cond_mrkt_div_code:String
            /// 조건 화면 분류 코드
            /// Unique key( 20177 )
            let fid_cond_scr_div_code:String
            /// 분류 구분 코드
            /// 0: 전체
            let fid_div_cls_code:String
            /// 입력 종목코드
            /// 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200
            let fid_input_iscd:String
            /// 대상 구분 코드
            /// 0 : 전체
            let fid_trgt_cls_code:String
            /// 대상 제외 구분 코드
            /// 0 : 전체
            let fid_trgt_exls_cls_code:String
            /// 입력 가격1
            /// 입력값 없을때 전체 (가격 ~)
            let fid_input_price_1:String
            /// 입력 가격2
            /// 입력값 없을때 전체 (~ 가격)
            let fid_input_price_2:String
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
            /// 유가증권 단축 종목코드
            let mksc_shrn_iscd:String
            /// 데이터 순위
            let data_rank:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 누적 거래량
            let acml_vol:String
            /// 우선주 종목코드
            let prst_iscd:String
            /// 우선주 한글 종목명
            let prst_kor_isnm:String
            /// 우선주 현재가
            let prst_prpr:String
            /// 우선주 전일대비
            let prst_prdy_vrss:String
            /// 우선주 전일 대비 부호
            let prst_prdy_vrss_sign:String
            /// 우선주 누적 거래량
            let prst_acml_vol:String
            /// 차이 현재가
            let diff_prpr:String
            /// 괴리율
            let dprt:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 우선주 전일 대비율
            let prst_prdy_ctrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/prefer-disparate-ratio"
        public var header: [String : String]
        init(tr_id: String = "FHPST01770000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01770000
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

    /// 국내주식 호가잔량 순위[국내주식-089]
    /// 국내주식 호가잔량 순위 API입니다. 한국투자 HTS(eFriend Plus) > [0172] 호가잔량 순위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct quotebalance : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 거래량 수
            /// 입력값 없을때 전체 (거래량 ~)
            let fid_vol_cnt:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let fid_cond_mrkt_div_code:String
            /// 조건 화면 분류 코드
            /// Unique key( 20172 )
            let fid_cond_scr_div_code:String
            /// 입력 종목코드
            /// 0000(전체) 코스피(0001), 코스닥(1001), 코스피200(2001)
            let fid_input_iscd:String
            /// 순위 정렬 구분 코드
            /// 0: 순매수잔량순, 1:순매도잔량순, 2:매수비율순, 3:매도비율순
            let fid_rank_sort_cls_code:String
            /// 분류 구분 코드
            /// 0:전체
            let fid_div_cls_code:String
            /// 대상 구분 코드
            /// 0:전체
            let fid_trgt_cls_code:String
            /// 대상 제외 구분 코드
            /// 0:전체
            let fid_trgt_exls_cls_code:String
            /// 입력 가격1
            /// 입력값 없을때 전체 (가격 ~)
            let fid_input_price_1:String
            /// 입력 가격2
            /// 입력값 없을때 전체 (~ 가격)
            let fid_input_price_2:String
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
            /// 유가증권 단축 종목코드
            let mksc_shrn_iscd:String
            /// 데이터 순위
            let data_rank:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 총 매도호가 잔량
            let total_askp_rsqn:String
            /// 총 매수호가 잔량
            let total_bidp_rsqn:String
            /// 총 순 매수호가 잔량
            let total_ntsl_bidp_rsqn:String
            /// 매수 잔량 비율
            let shnu_rsqn_rate:String
            /// 매도 잔량 비율
            let seln_rsqn_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/quote-balance"
        public var header: [String : String]
        init(tr_id: String = "FHPST01720000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01720000
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

    /// 국내주식 이격도 순위[v1_국내주식-095]
    /// 국내주식 이격도 순위 API입니다.한국투자 HTS(eFriend Plus) > [0178] 이격도 순위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct disparity : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 입력 가격2
            /// 입력값 없을때 전체 (~ 가격)
            let fid_input_price_2:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let fid_cond_mrkt_div_code:String
            /// 조건 화면 분류 코드
            /// Unique key( 20178 )
            let fid_cond_scr_div_code:String
            /// 분류 구분 코드
            /// 0: 전체, 1:관리종목, 2:투자주의, 3:투자경고, 4:투자위험예고, 5:투자위험, 6:보톧주, 7:우선주
            let fid_div_cls_code:String
            /// 순위 정렬 구분 코드
            /// 0: 이격도상위순, 1:이격도하위순
            let fid_rank_sort_cls_code:String
            /// 시간 구분 코드
            /// 5:이격도5, 10:이격도10, 20:이격도20, 60:이격도60, 120:이격도120
            let fid_hour_cls_code:String
            /// 입력 종목코드
            /// 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200
            let fid_input_iscd:String
            /// 대상 구분 코드
            /// 0 : 전체
            let fid_trgt_cls_code:String
            /// 대상 제외 구분 코드
            /// 0 : 전체
            let fid_trgt_exls_cls_code:String
            /// 입력 가격1
            /// 입력값 없을때 전체 (가격 ~)
            let fid_input_price_1:String
            /// 거래량 수
            /// 입력값 없을때 전체 (거래량 ~)
            let fid_vol_cnt:String
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
            /// 유가증권 단축 종목코드
            let mksc_shrn_iscd:String
            /// 데이터 순위
            let data_rank:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 누적 거래량
            let acml_vol:String
            /// 5일 이격도
            let d5_dsrt:String
            /// 10일 이격도
            let d10_dsrt:String
            /// 20일 이격도
            let d20_dsrt:String
            /// 60일 이격도
            let d60_dsrt:String
            /// 120일 이격도
            let d120_dsrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/disparity"
        public var header: [String : String]
        init(tr_id: String = "FHPST01780000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01780000
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

    /// 국내주식 시장가치 순위[v1_국내주식-096]
    /// 국내주식 시장가치 순위 API입니다.한국투자 HTS(eFriend Plus) > [0179] 시장가치순위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct marketvalue : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 대상 구분 코드
            /// 0 : 전체
            let fid_trgt_cls_code:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let fid_cond_mrkt_div_code:String
            /// 조건 화면 분류 코드
            /// Unique key( 20179 )
            let fid_cond_scr_div_code:String
            /// 입력 종목코드
            /// 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200
            let fid_input_iscd:String
            /// 분류 구분 코드
            /// 0: 전체, 1:관리종목, 2:투자주의, 3:투자경고, 4:투자위험예고, 5:투자위험, 6:보톧주, 7:우선주
            let fid_div_cls_code:String
            /// 입력 가격1
            /// 입력값 없을때 전체 (가격 ~)
            let fid_input_price_1:String
            /// 입력 가격2
            /// 입력값 없을때 전체 (~ 가격)
            let fid_input_price_2:String
            /// 거래량 수
            /// 입력값 없을때 전체 (거래량 ~)
            let fid_vol_cnt:String
            /// 입력 옵션1
            /// 회계연도 입력 (ex 2023)
            let fid_input_option_1:String
            /// 입력 옵션2
            /// 0: 1/4분기 , 1: 반기, 2: 3/4분기, 3: 결산
            let fid_input_option_2:String
            /// 순위 정렬 구분 코드
            /// '가치분석(23:PER, 24:PBR, 25:PCR, 26:PSR, 27: EPS, 28:EVA, 29: EBITDA, 30: EV/EBITDA, 31:EBITDA/금융비율'
            let fid_rank_sort_cls_code:String
            /// 소속 구분 코드
            /// 0 : 전체
            let fid_blng_cls_code:String
            /// 대상 제외 구분 코드
            /// 0 : 전체
            let fid_trgt_exls_cls_code:String
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
            /// 데이터 순위
            let data_rank:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 유가증권 단축 종목코드
            let mksc_shrn_iscd:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// PER
            let per:String
            /// PBR
            let pbr:String
            /// PCR
            let pcr:String
            /// PSR
            let psr:String
            /// EPS
            let eps:String
            /// EVA
            let eva:String
            /// EBITDA
            let ebitda:String
            /// PV DIV EBITDA
            let pv_div_ebitda:String
            /// EBITDA DIV 금융비용
            let ebitda_div_fnnc_expn:String
            /// 결산 월
            let stac_month:String
            /// 결산 월 구분 코드
            let stac_month_cls_code:String
            /// 조회 건수
            let iqry_csnu:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/market-value"
        public var header: [String : String]
        init(tr_id: String = "FHPST01790000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01790000
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

    /// 국내주식 체결강도 상위[v1_국내주식-101]
    /// 국내주식 체결강도 상위 API입니다.한국투자 HTS(eFriend Plus) > [0168] 체결강도 상위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct volumepower : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 대상 제외 구분 코드
            /// 0 : 전체
            let fid_trgt_exls_cls_code:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let fid_cond_mrkt_div_code:String
            /// 조건 화면 분류 코드
            /// Unique key( 20168 )
            let fid_cond_scr_div_code:String
            /// 입력 종목코드
            /// 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200
            let fid_input_iscd:String
            /// 분류 구분 코드
            /// 0: 전체, 1: 보통주 2: 우선주
            let fid_div_cls_code:String
            /// 입력 가격1
            /// 입력값 없을때 전체 (가격 ~)
            let fid_input_price_1:String
            /// 입력 가격2
            /// 입력값 없을때 전체 (~ 가격)
            let fid_input_price_2:String
            /// 거래량 수
            /// 입력값 없을때 전체 (거래량 ~)
            let fid_vol_cnt:String
            /// 대상 구분 코드
            /// 0 : 전체
            let fid_trgt_cls_code:String
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
            let stck_shrn_iscd:String
            /// 데이터 순위
            let data_rank:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 당일 체결강도
            let tday_rltv:String
            /// 매도 체결량 합계
            let seln_cnqn_smtn:String
            /// 매수2 체결량 합계
            let shnu_cnqn_smtn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/volume-power"
        public var header: [String : String]
        init(tr_id: String = "FHPST01680000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01680000
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

    /// 국내주식 관심종목등록 상위[v1_국내주식-102]
    /// 국내주식 관심종목등록 상위 API입니다.한국투자 HTS(eFriend Plus) > [0180] 관심종목등록상위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct topintereststock : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 입력 종목코드2
            /// 000000 : 필수입력값
            let fid_input_iscd_2:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let fid_cond_mrkt_div_code:String
            /// 조건 화면 분류 코드
            /// Unique key(20180)
            let fid_cond_scr_div_code:String
            /// 입력 종목코드
            /// 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200
            let fid_input_iscd:String
            /// 대상 구분 코드
            /// 0 : 전체
            let fid_trgt_cls_code:String
            /// 대상 제외 구분 코드
            /// 0 : 전체
            let fid_trgt_exls_cls_code:String
            /// 입력 가격1
            /// 입력값 없을때 전체 (가격 ~)
            let fid_input_price_1:String
            /// 입력 가격2
            /// 입력값 없을때 전체 (~ 가격)
            let fid_input_price_2:String
            /// 거래량 수
            /// 입력값 없을때 전체 (거래량 ~)
            let fid_vol_cnt:String
            /// 분류 구분 코드
            /// 0: 전체 1: 관리종목 2: 투자주의 3: 투자경고 4: 투자위험예고 5: 투자위험 6: 보통주 7: 우선주
            let fid_div_cls_code:String
            /// 입력 수1
            /// 순위검색 입력값(1: 1위부터, 10:10위부터)
            let fid_input_cnt_1:String
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
            /// 시장 분류 구분 명
            let mrkt_div_cls_name:String
            /// 유가증권 단축 종목코드
            let mksc_shrn_iscd:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// 매도호가
            let askp:String
            /// 매수호가
            let bidp:String
            /// 데이터 순위
            let data_rank:String
            /// 관심 종목 등록 건수
            let inter_issu_reg_csnu:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/top-interest-stock"
        public var header: [String : String]
        init(tr_id: String = "FHPST01800000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01800000
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

    /// 국내주식 예상체결 상승/하락상위[v1_국내주식-103]
    /// 국내주식 예상체결 상승/하락상위 API입니다.한국투자 HTS(eFriend Plus) > [0182] 예상체결 상승/하락상위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct exptransupdown : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 순위 정렬 구분 코드
            /// 0:상승률1:상승폭2:보합3:하락율4:하락폭5:체결량6:거래대금
            let fid_rank_sort_cls_code:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let fid_cond_mrkt_div_code:String
            /// 조건 화면 분류 코드
            /// Unique key(20182)
            let fid_cond_scr_div_code:String
            /// 입력 종목코드
            /// 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200, 4001: KRX100
            let fid_input_iscd:String
            /// 분류 구분 코드
            /// 0:전체 1:보통주 2:우선주
            let fid_div_cls_code:String
            /// 적용 범위 가격1
            /// 입력값 없을때 전체 (가격 ~)
            let fid_aply_rang_prc_1:String
            /// 거래량 수
            /// 입력값 없을때 전체 (거래량 ~)
            let fid_vol_cnt:String
            /// 거래대금
            /// 입력값 없을때 전체 (거래대금 ~) 천원단위
            let fid_pbmn:String
            /// 소속 구분 코드
            /// 0: 전체
            let fid_blng_cls_code:String
            /// 장운영 구분 코드
            /// 0:장전예상1:장마감예상
            let fid_mkop_cls_code:String
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
            let stck_shrn_iscd:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 주식 기준가
            let stck_sdpr:String
            /// 매도 잔량
            let seln_rsqn:String
            /// 매도호가
            let askp:String
            /// 매수호가
            let bidp:String
            /// 매수2 잔량
            let shnu_rsqn:String
            /// 체결 거래량
            let cntg_vol:String
            /// 체결 거래대금
            let antc_tr_pbmn:String
            /// 총 매도호가 잔량
            let total_askp_rsqn:String
            /// 총 매수호가 잔량
            let total_bidp_rsqn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/exp-trans-updown"
        public var header: [String : String]
        init(tr_id: String = "FHPST01820000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01820000
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

    /// 국내주식 당사매매종목 상위[v1_국내주식-104]
    /// 국내주식 당사매매종목 상위 API입니다.한국투자 HTS(eFriend Plus) > [0186] 당사매매종목 상위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct tradedbycompany : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 대상 제외 구분 코드
            /// 0: 전체
            let fid_trgt_exls_cls_code:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let fid_cond_mrkt_div_code:String
            /// 조건 화면 분류 코드
            /// Unique key(20186)
            let fid_cond_scr_div_code:String
            /// 분류 구분 코드
            /// 0:전체, 1:관리종목, 2:투자주의, 3:투자경고, 4:투자위험예고, 5:투자위험, 6:보통주, 7:우선주
            let fid_div_cls_code:String
            /// 순위 정렬 구분 코드
            /// 0:매도상위,1:매수상위
            let fid_rank_sort_cls_code:String
            /// 입력 날짜1
            /// 기간~
            let fid_input_date_1:String
            /// 입력 날짜2
            /// ~기간
            let fid_input_date_2:String
            /// 입력 종목코드
            /// 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200, 4001: KRX100
            let fid_input_iscd:String
            /// 대상 구분 코드
            /// 0: 전체
            let fid_trgt_cls_code:String
            /// 적용 범위 거래량
            /// 0: 전체, 100: 100주 이상
            let fid_aply_rang_vol:String
            /// 적용 범위 가격2
            /// ~ 가격
            let fid_aply_rang_prc_2:String
            /// 적용 범위 가격1
            /// 가격 ~
            let fid_aply_rang_prc_1:String
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
            /// 데이터 순위
            let data_rank:String
            /// 유가증권 단축 종목코드
            let mksc_shrn_iscd:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// 매도 체결량 합계
            let seln_cnqn_smtn:String
            /// 매수2 체결량 합계
            let shnu_cnqn_smtn:String
            /// 순매수 체결량
            let ntby_cnqn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/traded-by-company"
        public var header: [String : String]
        init(tr_id: String = "FHPST01860000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01860000
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

    /// 국내주식 신고/신저근접종목 상위[v1_국내주식-105]
    /// 국내주식 신고/신저근접종목 상위 API입니다.한국투자 HTS(eFriend Plus) > [0187] 신고/신저 근접종목 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct nearnewhighlow : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 적용 범위 거래량
            /// 0: 전체, 100: 100주 이상
            let fid_aply_rang_vol:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let fid_cond_mrkt_div_code:String
            /// 조건 화면 분류 코드
            /// Unique key(20187)
            let fid_cond_scr_div_code:String
            /// 분류 구분 코드
            /// 0:전체, 1:관리종목, 2:투자주의, 3:투자경고
            let fid_div_cls_code:String
            /// 입력 수1
            /// 괴리율 최소
            let fid_input_cnt_1:String
            /// 입력 수2
            /// 괴리율 최대
            let fid_input_cnt_2:String
            /// 가격 구분 코드
            /// 0:신고근접, 1:신저근접
            let fid_prc_cls_code:String
            /// 입력 종목코드
            /// 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200, 4001: KRX100
            let fid_input_iscd:String
            /// 대상 구분 코드
            /// 0: 전체
            let fid_trgt_cls_code:String
            /// 대상 제외 구분 코드
            /// 0:전체, 1:관리종목, 2:투자주의, 3:투자경고, 4:투자위험예고, 5:투자위험, 6:보통주, 7:우선주
            let fid_trgt_exls_cls_code:String
            /// 적용 범위 가격1
            /// 가격 ~
            let fid_aply_rang_prc_1:String
            /// 적용 범위 가격2
            /// ~ 가격
            let fid_aply_rang_prc_2:String
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
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 유가증권 단축 종목코드
            let mksc_shrn_iscd:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 매도호가
            let askp:String
            /// 매도호가 잔량1
            let askp_rsqn1:String
            /// 매수호가
            let bidp:String
            /// 매수호가 잔량1
            let bidp_rsqn1:String
            /// 누적 거래량
            let acml_vol:String
            /// 신 최고가
            let new_hgpr:String
            /// 고가 근접 비율
            let hprc_near_rate:String
            /// 신 최저가
            let new_lwpr:String
            /// 저가 근접 비율
            let lwpr_near_rate:String
            /// 주식 기준가
            let stck_sdpr:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/near-new-highlow"
        public var header: [String : String]
        init(tr_id: String = "FHPST01870000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01870000
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

    /// 국내주식 대량체결건수 상위[국내주식-107]
    /// 국내주식 대량체결건수 상위 API입니다.한국투자 HTS(eFriend Plus) > [0169] 대량체결건수 상위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct bulktransnum : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 적용 범위 가격2
            /// ~ 가격
            let fid_aply_rang_prc_2:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let fid_cond_mrkt_div_code:String
            /// 조건 화면 분류 코드
            /// Unique key(11909)
            let fid_cond_scr_div_code:String
            /// 입력 종목코드
            /// 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200, 4001: KRX100
            let fid_input_iscd:String
            /// 순위 정렬 구분 코드
            /// 0:매수상위, 1:매도상위
            let fid_rank_sort_cls_code:String
            /// 분류 구분 코드
            /// 0:전체
            let fid_div_cls_code:String
            /// 입력 가격1
            /// 건별금액 ~
            let fid_input_price_1:String
            /// 적용 범위 가격1
            /// 가격 ~
            let fid_aply_rang_prc_1:String
            /// 입력 종목코드2
            /// 공백:전체종목, 개별종목 조회시 종목코드 (000660)
            let fid_input_iscd_2:String
            /// 대상 제외 구분 코드
            /// 0:전체
            let fid_trgt_exls_cls_code:String
            /// 대상 구분 코드
            /// 0:전체
            let fid_trgt_cls_code:String
            /// 거래량 수
            /// 거래량 ~
            let fid_vol_cnt:String
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
            /// 유가증권 단축 종목코드
            let mksc_shrn_iscd:String
            /// 데이터 순위
            let data_rank:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 매수2 체결 건수
            let shnu_cntg_csnu:String
            /// 매도 체결 건수
            let seln_cntg_csnu:String
            /// 순매수 체결량
            let ntby_cnqn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/bulk-trans-num"
        public var header: [String : String]
        init(tr_id: String = "FHKST190900C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST190900C0
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

    /// 국내주식 공매도 상위종목[국내주식-133]
    /// 공매도 상위종목 API입니다. 한국투자 HTS(eFriend Plus) > [0482] 공매도 상위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct shortsale : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FID 적용 범위 거래량
            /// 공백
            let FID_APLY_RANG_VOL:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건 화면 분류 코드
            /// Unique key(20482)
            let FID_COND_SCR_DIV_CODE:String
            /// 입력 종목코드
            /// 0000:전체, 0001:코스피, 1001:코스닥, 2001:코스피200, 4001: KRX100, 3003: 코스닥150
            let FID_INPUT_ISCD:String
            /// 조회구분 (일/월)
            /// 조회구분 (일/월) D: 일, M:월
            let FID_PERIOD_DIV_CODE:String
            /// 조회가간(일수
            /// '조회가간(일수): 조회구분(D) 0:1일, 1:2일, 2:3일, 3:4일, 4:1주일, 9:2주일, 14:3주일, 조회구분(M) 1:1개월, 2:2개월, 3:3개월'
            let FID_INPUT_CNT_1:String
            /// 대상 제외 구분 코드
            /// 공백
            let FID_TRGT_EXLS_CLS_CODE:String
            /// FID 대상 구분 코드
            /// 공백
            let FID_TRGT_CLS_CODE:String
            /// FID 적용 범위 가격1
            /// 가격 ~
            let FID_APLY_RANG_PRC_1:String
            /// FID 적용 범위 가격2
            /// ~ 가격
            let FID_APLY_RANG_PRC_2:String
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
            /// 유가증권 단축 종목코드
            let mksc_shrn_iscd:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// 공매도 체결 수량
            let ssts_cntg_qty:String
            /// 공매도 거래량 비중
            let ssts_vol_rlim:String
            /// 공매도 거래 대금
            let ssts_tr_pbmn:String
            /// 공매도 거래대금 비중
            let ssts_tr_pbmn_rlim:String
            /// 기준 일자1
            let stnd_date1:String
            /// 기준 일자2
            let stnd_date2:String
            /// 평균가격
            let avrg_prc:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/short-sale"
        public var header: [String : String]
        init(tr_id: String = "FHPST04820000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST04820000
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

    /// 국내주식 신용잔고 상위[국내주식-109]
    /// 국내주식 신용잔고 상위 API입니다. 한국투자 HTS(eFriend Plus) > [0475] 신용잔고 상위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct creditbalance : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 화면 분류 코드
            /// Unique key(11701)
            let FID_COND_SCR_DIV_CODE:String
            /// 입력 종목코드
            /// 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200,
            let FID_INPUT_ISCD:String
            /// 증가율기간
            /// 2~999
            let FID_OPTION:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let FID_COND_MRKT_DIV_CODE:String
            /// 순위 정렬 구분 코드
            /// '(융자)0:잔고비율 상위, 1: 잔고수량 상위, 2: 잔고금액 상위, 3: 잔고비율 증가상위, 4: 잔고비율 감소상위 (대주)5:잔고비율 상위, 6: 잔고수량 상위, 7: 잔고금액 상위, 8: 잔고비율 증가상위, 9: 잔고비율 감소상위 '
            let FID_RANK_SORT_CLS_CODE:String
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
            /// 응답상세 : Object Array
            /// array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 업종 구분 코드
            let bstp_cls_code:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 기준 일자1
            let stnd_date1:String
            /// 기준 일자2
            let stnd_date2:String
        }
        public struct Output2 : Codable {
            /// 유가증권 단축 종목코드
            let mksc_shrn_iscd:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 전체 융자 잔고 주수
            let whol_loan_rmnd_stcn:String
            /// 전체 융자 잔고 금액
            let whol_loan_rmnd_amt:String
            /// 전체 융자 잔고 비율
            let whol_loan_rmnd_rate:String
            /// 전체 대주 잔고 주수
            let whol_stln_rmnd_stcn:String
            /// 전체 대주 잔고 금액
            let whol_stln_rmnd_amt:String
            /// 전체 대주 잔고 비율
            let whol_stln_rmnd_rate:String
            /// N일 대비 융자 잔고 증가율
            let nday_vrss_loan_rmnd_inrt:String
            /// N일 대비 대주 잔고 증가율
            let nday_vrss_stln_rmnd_inrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/credit-balance"
        public var header: [String : String]
        init(tr_id: String = "FHKST17010000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST17010000
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

    /// 국내주식 배당률 상위[국내주식-106]
    /// 국내주식 배당률 상위 API입니다. 한국투자 HTS(eFriend Plus) > [0188] 배당률 상위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.※ 30건 이상의 목록 조회가 필요한 경우, 대안으로 종목조건검색 API를 이용해서 원하는 종목 100개까지 검색할 수 있는 기능을 제공하고 있습니다.종목조건검색 API는 HTS(efriend Plus) [0110] 조건검색에서 등록 및 서버저장한 나의 조건 목록을 확인할 수 있는 API로,자세한 사용 방법은 공지사항 - [조건검색 필독] 조건검색 API 이용안내 참고 부탁드립니다.
    struct dividendrate : APIITEM, NeedHash {
        public struct Request : Codable {
            /// CTS_AREA
            /// 공백
            let CTS_AREA:String
            /// KOSPI
            /// 0:전체, 1:코스피, 2: 코스피200, 3: 코스닥,
            let GB1:String
            /// 업종구분
            /// '코스피(0001:종합, 0002:대형주.…0027:제조업 ), 코스닥(1001:종합, …. 1041:IT부품 코스피200 (2001:KOSPI200, 2007:KOSPI100, 2008:KOSPI50)'
            let UPJONG:String
            /// 종목선택
            /// 0:전체, 6:보통주, 7:우선주
            let GB2:String
            /// 배당구분
            /// 1:주식배당, 2: 현금배당
            let GB3:String
            /// 기준일From
            let F_DT:String
            /// 기준일To
            let T_DT:String
            /// 결산/중간배당
            /// 0:전체, 1:결산배당, 2:중간배당
            let GB4:String
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
            /// 순위
            let rank:String
            /// 종목코드
            let sht_cd:String
            /// 종목명
            let isin_name:String
            /// 기준일
            let record_date:String
            /// 현금/주식배당금
            let per_sto_divi_amt:String
            /// 현금/주식배당률(%)
            let divi_rate:String
            /// 배당종류
            let divi_kind:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/dividend-rate"
        public var header: [String : String]
        init(tr_id: String = "HHKDB13470100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHKDB13470100
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

    /// 국내주식 시간외등락율순위 [국내주식-138]
    /// 국내주식 시간외등락율순위 API입니다. 한국투자 HTS(eFriend Plus) > [0234] 시간외 등락률순위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.
    struct overtimefluctuation : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// 시장구분코드 (J: 주식)
            let FID_COND_MRKT_DIV_CODE:String
            /// 시장 구분 코드
            /// 공백 입력
            let FID_MRKT_CLS_CODE:String
            /// 조건 화면 분류 코드
            /// Unique key(20234)
            let FID_COND_SCR_DIV_CODE:String
            /// 입력 종목코드
            /// 0000(전체), 0001(코스피), 1001(코스닥)
            let FID_INPUT_ISCD:String
            /// 분류 구분 코드
            /// 1(상한가), 2(상승률), 3(보합),4(하한가),5(하락률)
            let FID_DIV_CLS_CODE:String
            /// 입력 가격1
            /// 입력값 없을때 전체 (가격 ~)
            let FID_INPUT_PRICE_1:String
            /// 입력 가격2
            /// 입력값 없을때 전체 (~ 가격)
            let FID_INPUT_PRICE_2:String
            /// 거래량 수
            /// 입력값 없을때 전체 (거래량 ~)
            let FID_VOL_CNT:String
            /// 대상 구분 코드
            /// 공백 입력
            let FID_TRGT_CLS_CODE:String
            /// 대상 제외 구분 코드
            /// 공백 입력
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
            let output1: Output1
            /// 응답상세 : Object Array
            /// array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 시간외 단일가 상한 종목 수
            let ovtm_untp_uplm_issu_cnt:String
            /// 시간외 단일가 상승 종목 수
            let ovtm_untp_ascn_issu_cnt:String
            /// 시간외 단일가 보합 종목 수
            let ovtm_untp_stnr_issu_cnt:String
            /// 시간외 단일가 하한 종목 수
            let ovtm_untp_lslm_issu_cnt:String
            /// 시간외 단일가 하락 종목 수
            let ovtm_untp_down_issu_cnt:String
            /// 시간외 단일가 누적 거래량
            let ovtm_untp_acml_vol:String
            /// 시간외 단일가 누적 거래대금
            let ovtm_untp_acml_tr_pbmn:String
            /// 시간외 단일가 거래소 거래량
            let ovtm_untp_exch_vol:String
            /// 시간외 단일가 거래소 거래대금
            let ovtm_untp_exch_tr_pbmn:String
            /// 시간외 단일가 KOSDAQ 거래량
            let ovtm_untp_kosdaq_vol:String
            /// 시간외 단일가 KOSDAQ 거래대금
            let ovtm_untp_kosdaq_tr_pbmn:String
        }
        public struct Output2 : Codable {
            /// 유가증권 단축 종목코드
            let mksc_shrn_iscd:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 시간외 단일가 현재가
            let ovtm_untp_prpr:String
            /// 시간외 단일가 전일 대비
            let ovtm_untp_prdy_vrss:String
            /// 시간외 단일가 전일 대비 부호
            let ovtm_untp_prdy_vrss_sign:String
            /// 시간외 단일가 전일 대비율
            let ovtm_untp_prdy_ctrt:String
            /// 시간외 단일가 매도호가1
            let ovtm_untp_askp1:String
            /// 시간외 단일가 매도 잔량
            let ovtm_untp_seln_rsqn:String
            /// 시간외 단일가 매수호가1
            let ovtm_untp_bidp1:String
            /// 시간외 단일가 매수 잔량
            let ovtm_untp_shnu_rsqn:String
            /// 시간외 단일가 거래량
            let ovtm_untp_vol:String
            /// 시간외 대비 누적 거래량 비중
            let ovtm_vrss_acml_vol_rlim:String
            /// 주식 현재가
            let stck_prpr:String
            /// 누적 거래량
            let acml_vol:String
            /// 매수호가
            let bidp:String
            /// 매도호가
            let askp:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/overtime-fluctuation"
        public var header: [String : String]
        init(tr_id: String = "FHPST02340000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST02340000
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

    /// 국내주식 시간외거래량순위 [국내주식-139]
    /// 국내주식 시간외거래량순위 API입니다. 한국투자 HTS(eFriend Plus) > [0235] 시간외 거래량순위 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.최대 30건 확인 가능하며, 다음 조회가 불가합니다.
    struct overtimevolume : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// 시장구분코드 (J: 주식)
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건 화면 분류 코드
            /// Unique key(20235)
            let FID_COND_SCR_DIV_CODE:String
            /// 입력 종목코드
            /// 0000(전체), 0001(코스피), 1001(코스닥)
            let FID_INPUT_ISCD:String
            /// 순위 정렬 구분 코드
            /// 0(매수잔량), 1(매도잔량), 2(거래량)
            let FID_RANK_SORT_CLS_CODE:String
            /// 입력 가격1
            /// 가격 ~
            let FID_INPUT_PRICE_1:String
            /// 입력 가격2
            /// ~ 가격
            let FID_INPUT_PRICE_2:String
            /// 거래량 수
            /// 거래량 ~
            let FID_VOL_CNT:String
            /// 대상 구분 코드
            /// 공백
            let FID_TRGT_CLS_CODE:String
            /// 대상 제외 구분 코드
            /// 공백
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
            let output1: Output1
            /// 응답상세 : Object Array
            /// array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 시간외 단일가 거래소 거래량
            let ovtm_untp_exch_vol:String
            /// 시간외 단일가 거래소 거래대금
            let ovtm_untp_exch_tr_pbmn:String
            /// 시간외 단일가 KOSDAQ 거래량
            let ovtm_untp_kosdaq_vol:String
            /// 시간외 단일가 KOSDAQ 거래대금
            let ovtm_untp_kosdaq_tr_pbmn:String
        }
        public struct Output2 : Codable {
            /// 주식 단축 종목코드
            let stck_shrn_iscd:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 시간외 단일가 현재가
            let ovtm_untp_prpr:String
            /// 시간외 단일가 전일 대비
            let ovtm_untp_prdy_vrss:String
            /// 시간외 단일가 전일 대비 부호
            let ovtm_untp_prdy_vrss_sign:String
            /// 시간외 단일가 전일 대비율
            let ovtm_untp_prdy_ctrt:String
            /// 시간외 단일가 매도 잔량
            let ovtm_untp_seln_rsqn:String
            /// 시간외 단일가 매수 잔량
            let ovtm_untp_shnu_rsqn:String
            /// 시간외 단일가 거래량
            let ovtm_untp_vol:String
            /// 시간외 대비 누적 거래량 비중
            let ovtm_vrss_acml_vol_rlim:String
            /// 주식 현재가
            let stck_prpr:String
            /// 누적 거래량
            let acml_vol:String
            /// 매수호가
            let bidp:String
            /// 매도호가
            let askp:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/overtime-volume"
        public var header: [String : String]
        init(tr_id: String = "FHPST02350000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST02350000
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

    /// HTS조회상위20종목 [국내주식-214]
    /// HTS조회상위20종목 API입니다. 한국투자 HTS(eFriend Plus) > [0158] 조회종목상위 화면의 "종목명", "종목코드" 표시 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct htstopview : APIITEM, NeedHash {
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
            /// 응답상세 : Object
            let output1: Output1
        }
        public struct Output1 : Codable {
            /// 시장구분
            /// J : 코스피, Q : 코스닥
            let mrkt_div_cls_code:String
            /// 종목코드
            /// 종목코드
            let mksc_shrn_iscd:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/ranking/hts-top-view"
        public var header: [String : String]
        init(tr_id: String = "HHMCM000100C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // HHMCM000100C0
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
