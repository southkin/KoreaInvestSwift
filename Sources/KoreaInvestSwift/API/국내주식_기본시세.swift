//
//  국내주식_기본시세.swift
//  KoreaInvestSwift
//
//  Created by kin on 4/4/25.
//
import FullyRESTful

extension KISAPI {
    enum 국내주식_기본시세 {
    }
}
extension KISAPI.국내주식_기본시세 {
    /// 주식현재가 시세[v1_국내주식-008]
    /// 주식 현재가 시세 API입니다. 실시간 시세를 원하신다면 웹소켓 API를 활용하세요.※ 종목코드 마스터파일 파이썬 정제코드는 한국투자증권 Github 참고 부탁드립니다.   https://github.com/koreainvestment/open-trading-api/tree/main/stocks_info
    struct inquireprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// J:KRX, NX:NXT, UN:통합
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력 종목코드
            /// 종목코드 (ex 005930 삼성전자)
            let FID_INPUT_ISCD:String
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
            /// 종목 상태 구분 코드
            let iscd_stat_cls_code:String
            /// 증거금 비율
            let marg_rate:String
            /// 대표 시장 한글 명
            let rprs_mrkt_kor_name:String
            /// 신 고가 저가 구분 코드
            let new_hgpr_lwpr_cls_code:String
            /// 업종 한글 종목명
            let bstp_kor_isnm:String
            /// 임시 정지 여부
            let temp_stop_yn:String
            /// 시가 범위 연장 여부
            let oprc_rang_cont_yn:String
            /// 종가 범위 연장 여부
            let clpr_rang_cont_yn:String
            /// 신용 가능 여부
            let crdt_able_yn:String
            /// 보증금 비율 구분 코드
            let grmn_rate_cls_code:String
            /// ELW 발행 여부
            let elw_pblc_yn:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// 누적 거래량
            let acml_vol:String
            /// 전일 대비 거래량 비율
            let prdy_vrss_vol_rate:String
            /// 주식 시가2
            let stck_oprc:String
            /// 주식 최고가
            let stck_hgpr:String
            /// 주식 최저가
            let stck_lwpr:String
            /// 주식 상한가
            let stck_mxpr:String
            /// 주식 하한가
            let stck_llam:String
            /// 주식 기준가
            let stck_sdpr:String
            /// 가중 평균 주식 가격
            let wghn_avrg_stck_prc:String
            /// HTS 외국인 소진율
            let hts_frgn_ehrt:String
            /// 외국인 순매수 수량
            let frgn_ntby_qty:String
            /// 프로그램매매 순매수 수량
            let pgtr_ntby_qty:String
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
            /// 디저항 값
            let dmrs_val:String
            /// 디지지 값
            let dmsp_val:String
            /// 자본금
            let cpfn:String
            /// 제한 폭 가격
            let rstc_wdth_prc:String
            /// 주식 액면가
            let stck_fcam:String
            /// 주식 대용가
            let stck_sspr:String
            /// 호가단위
            let aspr_unit:String
            /// HTS 매매 수량 단위 값
            let hts_deal_qty_unit_val:String
            /// 상장 주수
            let lstn_stcn:String
            /// HTS 시가총액
            let hts_avls:String
            /// PER
            let per:String
            /// PBR
            let pbr:String
            /// 결산 월
            let stac_month:String
            /// 거래량 회전율
            let vol_tnrt:String
            /// EPS
            let eps:String
            /// BPS
            let bps:String
            /// 250일 최고가
            let d250_hgpr:String
            /// 250일 최고가 일자
            let d250_hgpr_date:String
            /// 250일 최고가 대비 현재가 비율
            let d250_hgpr_vrss_prpr_rate:String
            /// 250일 최저가
            let d250_lwpr:String
            /// 250일 최저가 일자
            let d250_lwpr_date:String
            /// 250일 최저가 대비 현재가 비율
            let d250_lwpr_vrss_prpr_rate:String
            /// 주식 연중 최고가
            let stck_dryy_hgpr:String
            /// 연중 최고가 대비 현재가 비율
            let dryy_hgpr_vrss_prpr_rate:String
            /// 연중 최고가 일자
            let dryy_hgpr_date:String
            /// 주식 연중 최저가
            let stck_dryy_lwpr:String
            /// 연중 최저가 대비 현재가 비율
            let dryy_lwpr_vrss_prpr_rate:String
            /// 연중 최저가 일자
            let dryy_lwpr_date:String
            /// 52주일 최고가
            let w52_hgpr:String
            /// 52주일 최고가 대비 현재가 대비
            let w52_hgpr_vrss_prpr_ctrt:String
            /// 52주일 최고가 일자
            let w52_hgpr_date:String
            /// 52주일 최저가
            let w52_lwpr:String
            /// 52주일 최저가 대비 현재가 대비
            let w52_lwpr_vrss_prpr_ctrt:String
            /// 52주일 최저가 일자
            let w52_lwpr_date:String
            /// 전체 융자 잔고 비율
            let whol_loan_rmnd_rate:String
            /// 공매도가능여부
            let ssts_yn:String
            /// 주식 단축 종목코드
            let stck_shrn_iscd:String
            /// 액면가 통화명
            let fcam_cnnm:String
            /// 자본금 통화명
            let cpfn_cnnm:String
            /// 접근도
            let apprch_rate:String
            /// 외국인 보유 수량
            let frgn_hldn_qty:String
            /// VI적용구분코드
            let vi_cls_code:String
            /// 시간외단일가VI적용구분코드
            let ovtm_vi_cls_code:String
            /// 최종 공매도 체결 수량
            let last_ssts_cntg_qty:String
            /// 투자유의여부
            let invt_caful_yn:String
            /// 시장경고코드
            let mrkt_warn_cls_code:String
            /// 단기과열여부
            let short_over_yn:String
            /// 정리매매여부
            let sltr_yn:String
            /// 관리종목여부
            let mang_issu_cls_code:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-price"
        public var header: [String : String]
        init(tr_id: String = "FHKST01010100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // 'FHKST01010100'
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

    /// 주식현재가 체결[v1_국내주식-009]
    /// 국내현재가 체결 API 입니다. 종목의 체결 정보를 확인할 수 있습니다.
    struct inquireccnl : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// J:KRX, NX:NXT, UN:통합
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력 종목코드
            /// 종목코드 (ex 005930 삼성전자)
            let FID_INPUT_ISCD:String
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
            /// 주식 체결 시간
            let stck_cntg_hour:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 체결 거래량
            let cntg_vol:String
            /// 당일 체결강도
            let tday_rltv:String
            /// 전일 대비율
            let prdy_ctrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-ccnl"
        public var header: [String : String]
        init(tr_id: String = "FHKST01010300", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST01010300
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

    /// 주식현재가 일자별[v1_국내주식-010]
    /// 주식현재가 일자별 API입니다. 일/주/월별 주가를 확인할 수 있으며 최근 30일(주,별)로 제한되어 있습니다.
    struct inquiredailyprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// J:KRX, NX:NXT, UN:통합
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력 종목코드
            /// 종목코드 (ex 005930 삼성전자)
            let FID_INPUT_ISCD:String
            /// 기간 분류 코드
            /// 'D : (일)최근 30거래일 W : (주)최근 30주 M : (월)최근 30개월'
            let FID_PERIOD_DIV_CODE:String
            /// 수정주가 원주가 가격
            /// '0 : 수정주가미반영 1 : 수정주가반영 * 수정주가는 액면분할/액면병합 등 권리 발생 시 과거 시세를 현재 주가에 맞게 보정한 가격'
            let FID_ORG_ADJ_PRC:String
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
            /// 주식 영업 일자
            let stck_bsop_date:String
            /// 주식 시가2
            let stck_oprc:String
            /// 주식 최고가
            let stck_hgpr:String
            /// 주식 최저가
            let stck_lwpr:String
            /// 주식 종가
            let stck_clpr:String
            /// 누적 거래량
            let acml_vol:String
            /// 전일 대비 거래량 비율
            /// 13(8.4)
            let prdy_vrss_vol_rate:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            /// 11(8.2)
            let prdy_ctrt:String
            /// HTS 외국인 소진율
            /// 11(8.2)
            let hts_frgn_ehrt:String
            /// 외국인 순매수 수량
            let frgn_ntby_qty:String
            /// 락 구분 코드
            /// '01 : 권리락 02 : 배당락 03 : 분배락 04 : 권배락 05 : 중간(분기)배당락 06 : 권리중간배당락 07 : 권리분기배당락'
            let flng_cls_code:String
            /// 누적 분할 비율
            /// 13(8.4)
            let acml_prtt_rate:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-daily-price"
        public var header: [String : String]
        init(tr_id: String = "FHKST01010400", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST01010400
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

    /// 주식현재가 호가/예상체결[v1_국내주식-011]
    /// 주식현재가 호가 예상체결 API입니다. 매수 매도 호가를 확인하실 수 있습니다. 실시간 데이터를 원하신다면 웹소켓 API를 활용하세요.
    struct inquireaskingpriceexpccn : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// J:KRX, NX:NXT, UN:통합
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력 종목코드
            /// 종목코드 (ex 005930 삼성전자)
            let FID_INPUT_ISCD:String
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
            /// 응답상세 : Object
            let output2: Output2
        }
        public struct Output1 : Codable {
            /// 호가 접수 시간
            let aspr_acpt_hour:String
            /// 매도호가1
            let askp1:String
            /// 매도호가2
            let askp2:String
            /// 매도호가3
            let askp3:String
            /// 매도호가4
            let askp4:String
            /// 매도호가5
            let askp5:String
            /// 매도호가6
            let askp6:String
            /// 매도호가7
            let askp7:String
            /// 매도호가8
            let askp8:String
            /// 매도호가9
            let askp9:String
            /// 매도호가10
            let askp10:String
            /// 매수호가1
            let bidp1:String
            /// 매수호가2
            let bidp2:String
            /// 매수호가3
            let bidp3:String
            /// 매수호가4
            let bidp4:String
            /// 매수호가5
            let bidp5:String
            /// 매수호가6
            let bidp6:String
            /// 매수호가7
            let bidp7:String
            /// 매수호가8
            let bidp8:String
            /// 매수호가9
            let bidp9:String
            /// 매수호가10
            let bidp10:String
            /// 매도호가 잔량1
            let askp_rsqn1:String
            /// 매도호가 잔량2
            let askp_rsqn2:String
            /// 매도호가 잔량3
            let askp_rsqn3:String
            /// 매도호가 잔량4
            let askp_rsqn4:String
            /// 매도호가 잔량5
            let askp_rsqn5:String
            /// 매도호가 잔량6
            let askp_rsqn6:String
            /// 매도호가 잔량7
            let askp_rsqn7:String
            /// 매도호가 잔량8
            let askp_rsqn8:String
            /// 매도호가 잔량9
            let askp_rsqn9:String
            /// 매도호가 잔량10
            let askp_rsqn10:String
            /// 매수호가 잔량1
            let bidp_rsqn1:String
            /// 매수호가 잔량2
            let bidp_rsqn2:String
            /// 매수호가 잔량3
            let bidp_rsqn3:String
            /// 매수호가 잔량4
            let bidp_rsqn4:String
            /// 매수호가 잔량5
            let bidp_rsqn5:String
            /// 매수호가 잔량6
            let bidp_rsqn6:String
            /// 매수호가 잔량7
            let bidp_rsqn7:String
            /// 매수호가 잔량8
            let bidp_rsqn8:String
            /// 매수호가 잔량9
            let bidp_rsqn9:String
            /// 매수호가 잔량10
            let bidp_rsqn10:String
            /// 매도호가 잔량 증감1
            let askp_rsqn_icdc1:String
            /// 매도호가 잔량 증감2
            let askp_rsqn_icdc2:String
            /// 매도호가 잔량 증감3
            let askp_rsqn_icdc3:String
            /// 매도호가 잔량 증감4
            let askp_rsqn_icdc4:String
            /// 매도호가 잔량 증감5
            let askp_rsqn_icdc5:String
            /// 매도호가 잔량 증감6
            let askp_rsqn_icdc6:String
            /// 매도호가 잔량 증감7
            let askp_rsqn_icdc7:String
            /// 매도호가 잔량 증감8
            let askp_rsqn_icdc8:String
            /// 매도호가 잔량 증감9
            let askp_rsqn_icdc9:String
            /// 매도호가 잔량 증감10
            let askp_rsqn_icdc10:String
            /// 매수호가 잔량 증감1
            let bidp_rsqn_icdc1:String
            /// 매수호가 잔량 증감2
            let bidp_rsqn_icdc2:String
            /// 매수호가 잔량 증감3
            let bidp_rsqn_icdc3:String
            /// 매수호가 잔량 증감4
            let bidp_rsqn_icdc4:String
            /// 매수호가 잔량 증감5
            let bidp_rsqn_icdc5:String
            /// 매수호가 잔량 증감6
            let bidp_rsqn_icdc6:String
            /// 매수호가 잔량 증감7
            let bidp_rsqn_icdc7:String
            /// 매수호가 잔량 증감8
            let bidp_rsqn_icdc8:String
            /// 매수호가 잔량 증감9
            let bidp_rsqn_icdc9:String
            /// 매수호가 잔량 증감10
            let bidp_rsqn_icdc10:String
            /// 총 매도호가 잔량
            let total_askp_rsqn:String
            /// 총 매수호가 잔량
            let total_bidp_rsqn:String
            /// 총 매도호가 잔량 증감
            let total_askp_rsqn_icdc:String
            /// 총 매수호가 잔량 증감
            let total_bidp_rsqn_icdc:String
            /// 시간외 총 매도호가 증감
            let ovtm_total_askp_icdc:String
            /// 시간외 총 매수호가 증감
            let ovtm_total_bidp_icdc:String
            /// 시간외 총 매도호가 잔량
            let ovtm_total_askp_rsqn:String
            /// 시간외 총 매수호가 잔량
            let ovtm_total_bidp_rsqn:String
            /// 순매수 호가 잔량
            let ntby_aspr_rsqn:String
            /// 신 장운영 구분 코드
            /// ' '00' : 장전 예상체결가와 장마감 동시호가 '49' : 장후 예상체결가 (1) 첫 번째 비트 1 : 장개시전 2 : 장중 3 : 장종료후 4 : 시간외단일가 7 : 일반Buy-in 8 : 당일Buy-in (2) 두 번째 비트 0 : 보통 1 : 종가 2 : 대량 3 : 바스켓 7 : 정리매매 8 : Buy-in'
            let new_mkop_cls_code:String
        }
        public struct Output2 : Codable {
            /// 예상 장운영 구분 코드
            let antc_mkop_cls_code:String
            /// 주식 현재가
            let stck_prpr:String
            /// 주식 시가2
            let stck_oprc:String
            /// 주식 최고가
            let stck_hgpr:String
            /// 주식 최저가
            let stck_lwpr:String
            /// 주식 기준가
            let stck_sdpr:String
            /// 예상 체결가
            let antc_cnpr:String
            /// 예상 체결 대비 부호
            let antc_cntg_vrss_sign:String
            /// 예상 체결 대비
            let antc_cntg_vrss:String
            /// 예상 체결 전일 대비율
            let antc_cntg_prdy_ctrt:String
            /// 예상 거래량
            let antc_vol:String
            /// 주식 단축 종목코드
            let stck_shrn_iscd:String
            /// VI적용구분코드
            let vi_cls_code:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-asking-price-exp-ccn"
        public var header: [String : String]
        init(tr_id: String = "FHKST01010200", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST01010200
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

    /// 주식현재가 투자자[v1_국내주식-012]
    /// 주식현재가 투자자 API입니다. 개인, 외국인, 기관 등 투자 정보를 확인할 수 있습니다.[유의사항]- 외국인은 외국인(외국인투자등록 고유번호가 있는 경우)+기타 외국인을 지칭합니다.- 당일 데이터는 장 종료 후 제공됩니다.
    struct inquireinvestor : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// J:KRX
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력 종목코드
            /// 종목코드 (ex 005930 삼성전자)
            let FID_INPUT_ISCD:String
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
            let output1: [Output1]
        }
        public struct Output1 : Codable {
            /// 주식 영업 일자
            let stck_bsop_date:String
            /// 주식 종가
            let stck_clpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 개인 순매수 수량
            let prsn_ntby_qty:String
            /// 외국인 순매수 수량
            let frgn_ntby_qty:String
            /// 기관계 순매수 수량
            let orgn_ntby_qty:String
            /// 개인 순매수 거래 대금
            let prsn_ntby_tr_pbmn:String
            /// 외국인 순매수 거래 대금
            let frgn_ntby_tr_pbmn:String
            /// 기관계 순매수 거래 대금
            let orgn_ntby_tr_pbmn:String
            /// 개인 매수2 거래량
            let prsn_shnu_vol:String
            /// 외국인 매수2 거래량
            let frgn_shnu_vol:String
            /// 기관계 매수2 거래량
            let orgn_shnu_vol:String
            /// 개인 매수2 거래 대금
            let prsn_shnu_tr_pbmn:String
            /// 외국인 매수2 거래 대금
            let frgn_shnu_tr_pbmn:String
            /// 기관계 매수2 거래 대금
            let orgn_shnu_tr_pbmn:String
            /// 개인 매도 거래량
            let prsn_seln_vol:String
            /// 외국인 매도 거래량
            let frgn_seln_vol:String
            /// 기관계 매도 거래량
            let orgn_seln_vol:String
            /// 개인 매도 거래 대금
            let prsn_seln_tr_pbmn:String
            /// 외국인 매도 거래 대금
            let frgn_seln_tr_pbmn:String
            /// 기관계 매도 거래 대금
            let orgn_seln_tr_pbmn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-investor"
        public var header: [String : String]
        init(tr_id: String = "FHKST01010900", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST01010900
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

    /// 주식현재가 회원사[v1_국내주식-013]
    /// 주식 현재가 회원사 API입니다. 회원사의 투자 정보를 확인할 수 있습니다.
    struct inquiremember : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FID 조건 시장 분류 코드
            /// J : 주식, ETF, ETN
            let FID_COND_MRKT_DIV_CODE:String
            /// FID 입력 종목코드
            /// 종목번호 (6자리) ETN의 경우, Q로 시작 (EX. Q500001)
            let FID_INPUT_ISCD:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 - 성공 실패 여부 성공 : 0 실패 : 0외 값
            let rt_cd: String
            /// 응답코드 - 응답코드
            let msg_cd: String
            /// 응답메세지 - 응답메세지
            let msg1: String
            /// 응답상세 : Array
            let output: [Output]
        }
        public struct Output : Codable {
            /// 매도 회원사 번호1
            let seln_mbcr_no1:String
            /// 매도 회원사 번호2
            let seln_mbcr_no2:String
            /// 매도 회원사 번호3
            let seln_mbcr_no3:String
            /// 매도 회원사 번호4
            let seln_mbcr_no4:String
            /// 매도 회원사 번호5
            let seln_mbcr_no5:String
            /// 매도 회원사 명1
            let seln_mbcr_name1:String
            /// 매도 회원사 명2
            let seln_mbcr_name2:String
            /// 매도 회원사 명3
            let seln_mbcr_name3:String
            /// 매도 회원사 명4
            let seln_mbcr_name4:String
            /// 매도 회원사 명5
            let seln_mbcr_name5:String
            /// 총 매도 수량1
            let total_seln_qty1:String
            /// 총 매도 수량2
            let total_seln_qty2:String
            /// 총 매도 수량3
            let total_seln_qty3:String
            /// 총 매도 수량4
            let total_seln_qty4:String
            /// 총 매도 수량5
            let total_seln_qty5:String
            /// 매도 회원사 비중1
            let seln_mbcr_rlim1:String
            /// 매도 회원사 비중2
            let seln_mbcr_rlim2:String
            /// 매도 회원사 비중3
            let seln_mbcr_rlim3:String
            /// 매도 회원사 비중4
            let seln_mbcr_rlim4:String
            /// 매도 회원사 비중5
            let seln_mbcr_rlim5:String
            /// 매도 수량 증감1
            let seln_qty_icdc1:String
            /// 매도 수량 증감2
            let seln_qty_icdc2:String
            /// 매도 수량 증감3
            let seln_qty_icdc3:String
            /// 매도 수량 증감4
            let seln_qty_icdc4:String
            /// 매도 수량 증감5
            let seln_qty_icdc5:String
            /// 매수2 회원사 번호1
            let shnu_mbcr_no1:String
            /// 매수2 회원사 번호2
            let shnu_mbcr_no2:String
            /// 매수2 회원사 번호3
            let shnu_mbcr_no3:String
            /// 매수2 회원사 번호4
            let shnu_mbcr_no4:String
            /// 매수2 회원사 번호5
            let shnu_mbcr_no5:String
            /// 매수2 회원사 명1
            let shnu_mbcr_name1:String
            /// 매수2 회원사 명2
            let shnu_mbcr_name2:String
            /// 매수2 회원사 명3
            let shnu_mbcr_name3:String
            /// 매수2 회원사 명4
            let shnu_mbcr_name4:String
            /// 매수2 회원사 명5
            let shnu_mbcr_name5:String
            /// 총 매수2 수량1
            let total_shnu_qty1:String
            /// 총 매수2 수량2
            let total_shnu_qty2:String
            /// 총 매수2 수량3
            let total_shnu_qty3:String
            /// 총 매수2 수량4
            let total_shnu_qty4:String
            /// 총 매수2 수량5
            let total_shnu_qty5:String
            /// 매수2 회원사 비중1
            let shnu_mbcr_rlim1:String
            /// 매수2 회원사 비중2
            let shnu_mbcr_rlim2:String
            /// 매수2 회원사 비중3
            let shnu_mbcr_rlim3:String
            /// 매수2 회원사 비중4
            let shnu_mbcr_rlim4:String
            /// 매수2 회원사 비중5
            let shnu_mbcr_rlim5:String
            /// 매수2 수량 증감1
            let shnu_qty_icdc1:String
            /// 매수2 수량 증감2
            let shnu_qty_icdc2:String
            /// 매수2 수량 증감3
            let shnu_qty_icdc3:String
            /// 매수2 수량 증감4
            let shnu_qty_icdc4:String
            /// 매수2 수량 증감5
            let shnu_qty_icdc5:String
            /// 외국계 총 매도 수량
            let glob_total_seln_qty:String
            /// 외국계 매도 비중
            let glob_seln_rlim:String
            /// 외국계 순매수 수량
            let glob_ntby_qty:String
            /// 외국계 총 매수2 수량
            let glob_total_shnu_qty:String
            /// 외국계 매수2 비중
            let glob_shnu_rlim:String
            /// 매도 회원사 외국계 여부1
            let seln_mbcr_glob_yn_1:String
            /// 매도 회원사 외국계 여부2
            let seln_mbcr_glob_yn_2:String
            /// 매도 회원사 외국계 여부3
            let seln_mbcr_glob_yn_3:String
            /// 매도 회원사 외국계 여부4
            let seln_mbcr_glob_yn_4:String
            /// 매도 회원사 외국계 여부5
            let seln_mbcr_glob_yn_5:String
            /// 매수2 회원사 외국계 여부1
            let shnu_mbcr_glob_yn_1:String
            /// 매수2 회원사 외국계 여부2
            let shnu_mbcr_glob_yn_2:String
            /// 매수2 회원사 외국계 여부3
            let shnu_mbcr_glob_yn_3:String
            /// 매수2 회원사 외국계 여부4
            let shnu_mbcr_glob_yn_4:String
            /// 매수2 회원사 외국계 여부5
            let shnu_mbcr_glob_yn_5:String
            /// 외국계 총 매도 수량 증감
            let glob_total_seln_qty_icdc:String
            /// 외국계 총 매수2 수량 증감
            let glob_total_shnu_qty_icdc:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-member"
        public var header: [String : String]
        init(tr_id: String = "FHKST01010600", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자/모의투자] FHKST01010600 : 주식현재가 회원사
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

    /// 국내주식기간별시세(일/주/월/년)[v1_국내주식-016]
    /// 국내주식기간별시세(일/주/월/년) API입니다.실전계좌/모의계좌의 경우, 한 번의 호출에 최대 100건까지 확인 가능합니다.
    struct inquiredailyitemchartprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// J:KRX, NX:NXT, UN:통합
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력 종목코드
            /// 종목코드 (ex 005930 삼성전자)
            let FID_INPUT_ISCD:String
            /// 입력 날짜 1
            /// 조회 시작일자
            let FID_INPUT_DATE_1:String
            /// 입력 날짜 2
            /// 조회 종료일자 (최대 100개)
            let FID_INPUT_DATE_2:String
            /// 기간분류코드
            /// D:일봉 W:주봉, M:월봉, Y:년봉
            let FID_PERIOD_DIV_CODE:String
            /// 수정주가 원주가 가격 여부
            /// 0:수정주가 1:원주가
            let FID_ORG_ADJ_PRC:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object
            /// single
            let output1: Output1
            /// 응답상세 : Object Array
            /// Array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 주식 전일 종가
            let stck_prdy_clpr:String
            /// 누적 거래량
            let acml_vol:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 주식 현재가
            let stck_prpr:String
            /// 주식 단축 종목코드
            let stck_shrn_iscd:String
            /// 전일 거래량
            let prdy_vol:String
            /// 주식 상한가
            let stck_mxpr:String
            /// 주식 하한가
            let stck_llam:String
            /// 주식 시가2
            let stck_oprc:String
            /// 주식 최고가
            let stck_hgpr:String
            /// 주식 최저가
            let stck_lwpr:String
            /// 주식 전일 시가
            let stck_prdy_oprc:String
            /// 주식 전일 최고가
            let stck_prdy_hgpr:String
            /// 주식 전일 최저가
            let stck_prdy_lwpr:String
            /// 매도호가
            let askp:String
            /// 매수호가
            let bidp:String
            /// 전일 대비 거래량
            let prdy_vrss_vol:String
            /// 거래량 회전율
            /// 11(8.2)
            let vol_tnrt:String
            /// 주식 액면가
            let stck_fcam:String
            /// 상장 주수
            let lstn_stcn:String
            /// 자본금
            let cpfn:String
            /// HTS 시가총액
            let hts_avls:String
            /// PER
            /// 11(8.2)
            let per:String
            /// EPS
            /// 14(11.2)
            let eps:String
            /// PBR
            /// 11(8.2)
            let pbr:String
            /// 전체 융자 잔고 비율
            /// 13(8.4)
            let itewhol_loan_rmnd_ratem:String
            /// 성공 실패 여부
            let rt_cd:String
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            let msg1:String
        }
        public struct Output2 : Codable {
            /// 주식 영업 일자
            let stck_bsop_date:String
            /// 주식 종가
            let stck_clpr:String
            /// 주식 시가2
            let stck_oprc:String
            /// 주식 최고가
            let stck_hgpr:String
            /// 주식 최저가
            let stck_lwpr:String
            /// 누적 거래량
            let acml_vol:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// 락 구분 코드
            let flng_cls_code:String
            /// 분할 비율
            let prtt_rate:String
            /// 변경 여부
            let mod_yn:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비
            let prdy_vrss:String
            /// 재평가사유코드
            let revl_issu_reas:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-daily-itemchartprice"
        public var header: [String : String]
        init(tr_id: String = "FHKST03010100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST03010100
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

    /// 주식현재가 당일시간대별체결[v1_국내주식-023]
    /// 주식현재가 당일시간대별체결 API입니다.
    struct inquiretimeitemconclusion : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// J:KRX, NX:NXT, UN:통합
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력 종목코드
            /// 종목코드 (ex 005930 삼성전자)
            let FID_INPUT_ISCD:String
            /// 입력 시간1
            /// 입력시간
            let FID_INPUT_HOUR_1:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object
            /// single
            let output1: Output1
            /// 응답상세 : Object
            /// single
            let output2: Output2
        }
        public struct Output1 : Codable {
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
            /// 전일 거래량
            let prdy_vol:String
            /// 대표 시장 한글 명
            let rprs_mrkt_kor_name:String
            /// 성공 실패 여부
            let rt_cd:String
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            let msg1:String
        }
        public struct Output2 : Codable {
            /// 주식 체결 시간
            let stck_cntg_hour:String
            /// 주식 현재가
            let stck_pbpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 매도호가
            let askp:String
            /// 매수호가
            let bidp:String
            /// 당일 체결강도
            let tday_rltv:String
            /// 누적 거래량
            let acml_vol:String
            /// 체결량
            let cnqn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-time-itemconclusion"
        public var header: [String : String]
        init(tr_id: String = "FHPST01060000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01060000
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

    /// 주식현재가 시간외시간별체결[v1_국내주식-025]
    /// 주식현재가 시간외시간별체결 API입니다.
    struct inquiretimeovertimeconclusion : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// J : 주식, ETF, ETN
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력 종목코드
            /// 종목번호 (6자리) ETN의 경우, Q로 시작 (EX. Q500001)
            let FID_INPUT_ISCD:String
            /// 시간 구분 코드
            /// 1 : 시간외 (Default)
            let FID_HOUR_CLS_CODE:String
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
            /// Array 시간별체결 정보
            let output2: [Output2]?
        }
        public struct Output1 : Codable {
            /// 시간외 단일가 현재가
            let ovtm_untp_prpr:String?
            /// 시간외 단일가 전일 대비
            let ovtm_untp_prdy_vrss:String?
            /// 시간외 단일가 전일 대비 부호
            let ovtm_untp_prdy_vrss_sign:String?
            /// 시간외 단일가 전일 대비율
            let ovtm_untp_prdy_ctrt:String?
            /// 시간외 단일가 거래량
            let ovtm_untp_vol:String?
            /// 시간외 단일가 거래 대금
            let ovtm_untp_tr_pbmn:String?
            /// 시간외 단일가 상한가
            let ovtm_untp_mxpr:String?
            /// 시간외 단일가 하한가
            let ovtm_untp_llam:String?
            /// 시간외 단일가 시가2
            let ovtm_untp_oprc:String?
            /// 시간외 단일가 최고가
            let ovtm_untp_hgpr:String?
            /// 시간외 단일가 최저가
            let ovtm_untp_lwpr:String?
            /// 시간외 단일가 예상 체결가
            let ovtm_untp_antc_cnpr:String?
            /// 시간외 단일가 예상 체결 대비
            let ovtm_untp_antc_cntg_vrss:String?
            /// 시간외 단일가 예상 체결 대비
            let ovtm_untp_antc_cntg_vrss_sign:String?
            /// 시간외 단일가 예상 체결 대비율
            let ovtm_untp_antc_cntg_ctrt:String?
            /// 시간외 단일가 예상 거래량
            let ovtm_untp_antc_vol:String?
            /// 상한 부호
            let uplm_sign:String?
            /// 하한 부호
            let lslm_sign:String?
        }
        public struct Output2 : Codable {
            /// 주식 체결 시간
            let stck_cntg_hour:String?
            /// 주식 현재가
            let stck_prpr:String?
            /// 전일 대비
            let prdy_vrss:String?
            /// 전일 대비 부호
            let prdy_vrss_sign:String?
            /// 전일 대비율
            let prdy_ctrt:String?
            /// 매도호가
            let askp:String?
            /// 매수호가
            let bidp:String?
            /// 누적 거래량
            let acml_vol:String?
            /// 체결 거래량
            let cntg_vol:String?
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-time-overtimeconclusion"
        public var header: [String : String]
        init(tr_id: String = "FHPST02310000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자/모의투자] FHPST02310000
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

    /// 주식현재가 시간외일자별주가[v1_국내주식-026]
    /// 주식현재가 시간외일자별주가 API입니다.  (최근일 30건만 조회 가능)
    struct inquiredailyovertimeprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FID 조건 시장 분류 코드
            /// J : 주식, ETF, ETN
            let FID_COND_MRKT_DIV_CODE:String
            /// FID 입력 종목코드
            /// 종목번호 (6자리) ETN의 경우, Q로 시작 (EX. Q500001)
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
            /// 기본정보
            let output1: Output1?
            /// 응답상세2 : Object Array
            /// Array 일자별 정보
            let output2: [Output2]?
        }
        public struct Output1 : Codable {
            /// 시간외 단일가 현재가
            let ovtm_untp_prpr:String?
            /// 시간외 단일가 전일 대비
            let ovtm_untp_prdy_vrss:String?
            /// 시간외 단일가 전일 대비 부호
            let ovtm_untp_prdy_vrss_sign:String?
            /// 시간외 단일가 전일 대비율
            /// 11(8.2)
            let ovtm_untp_prdy_ctrt:String?
            /// 시간외 단일가 거래량
            let ovtm_untp_vol:String?
            /// 시간외 단일가 거래 대금
            let ovtm_untp_tr_pbmn:String?
            /// 시간외 단일가 상한가
            let ovtm_untp_mxpr:String?
            /// 시간외 단일가 하한가
            let ovtm_untp_llam:String?
            /// 시간외 단일가 시가2
            let ovtm_untp_oprc:String?
            /// 시간외 단일가 최고가
            let ovtm_untp_hgpr:String?
            /// 시간외 단일가 최저가
            let ovtm_untp_lwpr:String?
            /// 시간외 단일가 예상 체결가
            let ovtm_untp_antc_cnpr:String?
            /// 시간외 단일가 예상 체결 대비
            let ovtm_untp_antc_cntg_vrss:String?
            /// 시간외 단일가 예상 체결 대비
            let ovtm_untp_antc_cntg_vrss_sign:String?
            /// 시간외 단일가 예상 체결 대비율
            /// 11(8.2)
            let ovtm_untp_antc_cntg_ctrt:String?
            /// 시간외 단일가 예상 거래량
            let ovtm_untp_antc_vol:String?
        }
        public struct Output2 : Codable {
            /// 주식 영업 일자
            let stck_bsop_date:String?
            /// 시간외 단일가 현재가
            let ovtm_untp_prpr:String?
            /// 시간외 단일가 전일 대비
            let ovtm_untp_prdy_vrss:String?
            /// 시간외 단일가 전일 대비 부호
            let ovtm_untp_prdy_vrss_sign:String?
            /// 시간외 단일가 전일 대비율
            /// 11(8.2)
            let ovtm_untp_prdy_ctrt:String?
            /// 시간외 단일가 거래량
            let ovtm_untp_vol:String?
            /// 주식 종가
            let stck_clpr:String?
            /// 전일 대비
            let prdy_vrss:String?
            /// 전일 대비 부호
            let prdy_vrss_sign:String?
            /// 전일 대비율
            /// 11(8.2)
            let prdy_ctrt:String?
            /// 누적 거래량
            let acml_vol:String?
            /// 시간외 단일가 거래대금
            let ovtm_untp_tr_pbmn:String?
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-daily-overtimeprice"
        public var header: [String : String]
        init(tr_id: String = "FHPST02320000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요!)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // [실전투자/모의투자] FHPST02320000
                "tr_cont", // 미사용 (최근일 30건 내역만 조회 가능)
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

    /// 주식당일분봉조회[v1_국내주식-022]
    /// 주식당일분봉조회 API입니다. 실전계좌/모의계좌의 경우, 한 번의 호출에 최대 30건까지 확인 가능합니다.※ 당일 분봉 데이터만 제공됩니다. (전일자 분봉 미제공)※ input > FID_INPUT_HOUR_1 에 미래일시 입력 시에 현재가로 조회됩니다.ex) 오전 10시에 113000 입력 시에 오전 10시~11시30분 사이의 데이터가 오전 10시 값으로 조회됨※ output2의 첫번째 배열의 체결량(cntg_vol)은 첫체결이 발생되기 전까지는 이전 분봉의 체결량이 해당 위치에 표시됩니다. 해당 분봉의 첫 체결이 발생되면 해당 이전분 체결량이 두번째 배열로 이동되면서 새로운 체결량으로 업데이트됩니다.
    struct inquiretimeitemchartprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// J:KRX, NX:NXT, UN:통합
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력 종목코드
            /// 종목코드 (ex 005930 삼성전자)
            let FID_INPUT_ISCD:String
            /// 입력 시간1
            /// 입력시간
            let FID_INPUT_HOUR_1:String
            /// 과거 데이터 포함 여부
            let FID_PW_DATA_INCU_YN:String
            /// 기타 구분 코드
            let FID_ETC_CLS_CODE:String
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
            /// Array
            let output2: [Output2]
        }
        public struct Output1 : Codable {
            /// 전일 대비
            /// 전일 대비 변동 (+-변동차이)
            let prdy_vrss:String
            /// 전일 대비 부호
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            /// 소수점 두자리까지 제공
            let prdy_ctrt:String
            /// 전일대비 종가
            /// 전일대비 종가
            let stck_prdy_clpr:String
            /// 누적 거래량
            /// 누적 거래량
            let acml_vol:String
            /// 누적 거래대금
            /// 누적 거래대금
            let acml_tr_pbmn:String
            /// 한글 종목명
            /// 한글 종목명 (HTS 기준)
            let hts_kor_isnm:String
            /// 주식 현재가
            /// 주식 현재가
            let stck_prpr:String
        }
        public struct Output2 : Codable {
            /// 주식 영업일자
            /// 주식 영업일자
            let stck_bsop_date:String
            /// 주식 체결시간
            /// 주식 체결시간
            let stck_cntg_hour:String
            /// 주식 현재가
            /// 주식 현재가
            let stck_prpr:String
            /// 주식 시가
            /// 주식 시가
            let stck_oprc:String
            /// 주식 최고가
            /// 주식 최고가
            let stck_hgpr:String
            /// 주식 최저가
            /// 주식 최저가
            let stck_lwpr:String
            /// 체결 거래량
            let cntg_vol:String
            /// 누적 거래대금
            let acml_tr_pbmn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-time-itemchartprice"
        public var header: [String : String]
        init(tr_id: String = "FHKST03010200", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST03010200
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
            self.header["Content-Type"] = "application/json; charset=UTF-8"
            self.header["tr_id"] = tr_id
        }
    }

    /// 주식현재가 시세2[v1_국내주식-054]
    /// 주식현재가 시세2 API입니다.
    struct inquireprice2 : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FID 조건 시장 분류 코드
            /// J : 주식, ETF, ETN
            let FID_COND_MRKT_DIV_CODE:String
            /// FID 입력 종목코드
            /// 000660
            let FID_INPUT_ISCD:String
        }
        struct Response: Codable {
            /// 성공 실패 여부 -
            let rt_cd: String
            /// 응답코드 -
            let msg_cd: String
            /// 응답메세지 -
            let msg1: String
            /// 응답상세 : Object
            let Output: Output
        }
        public struct Output : Codable {
            /// 대표 시장 한글 명
            let rprs_mrkt_kor_name:String
            /// 신 고가 저가 구분 코드
            /// 특정 경우에만 데이터 출력
            let new_hgpr_lwpr_cls_code:String
            /// 상하한가 구분 코드
            /// 특정 경우에만 데이터 출력
            let mxpr_llam_cls_code:String
            /// 신용 가능 여부
            let crdt_able_yn:String
            /// 주식 상한가
            let stck_mxpr:String
            /// ELW 발행 여부
            let elw_pblc_yn:String
            /// 전일 종가 대비 시가2 비율
            let prdy_clpr_vrss_oprc_rate:String
            /// 신용 비율
            let crdt_rate:String
            /// 증거금 비율
            let marg_rate:String
            /// 최저가 대비 현재가
            let lwpr_vrss_prpr:String
            /// 최저가 대비 현재가 부호
            let lwpr_vrss_prpr_sign:String
            /// 전일 종가 대비 최저가 비율
            let prdy_clpr_vrss_lwpr_rate:String
            /// 주식 최저가
            let stck_lwpr:String
            /// 최고가 대비 현재가
            let hgpr_vrss_prpr:String
            /// 최고가 대비 현재가 부호
            let hgpr_vrss_prpr_sign:String
            /// 전일 종가 대비 최고가 비율
            let prdy_clpr_vrss_hgpr_rate:String
            /// 주식 최고가
            let stck_hgpr:String
            /// 시가2 대비 현재가
            let oprc_vrss_prpr:String
            /// 시가2 대비 현재가 부호
            let oprc_vrss_prpr_sign:String
            /// 관리 종목 여부
            let mang_issu_yn:String
            /// 동시호가배분처리코드
            /// 11:매수상한배분 12:매수하한배분 13: 매도상한배분 14:매도하한배분
            let divi_app_cls_code:String
            /// 단기과열여부
            let short_over_yn:String
            /// 시장경고코드
            /// 00: 없음 01: 투자주의 02:투자경고 03:투자위험
            let mrkt_warn_cls_code:String
            /// 투자유의여부
            let invt_caful_yn:String
            /// 이상급등여부
            let stange_runup_yn:String
            /// 공매도과열 여부
            let ssts_hot_yn:String
            /// 저유동성 종목 여부
            let low_current_yn:String
            /// VI적용구분코드
            let vi_cls_code:String
            /// 단기과열구분코드
            let short_over_cls_code:String
            /// 주식 하한가
            let stck_llam:String
            /// 신규 상장 구분 명
            let new_lstn_cls_name:String
            /// 임의 매매 구분 명
            let vlnt_deal_cls_name:String
            /// 락 구분 이름
            /// 특정 경우에만 데이터 출력
            let flng_cls_name:String
            /// 재평가 종목 사유 명
            /// 특정 경우에만 데이터 출력
            let revl_issu_reas_name:String
            /// 시장 경고 구분 명
            /// 특정 경우에만 데이터 출력 "투자환기" / "투자경고"
            let mrkt_warn_cls_name:String
            /// 주식 기준가
            let stck_sdpr:String
            /// 업종 구분 코드
            let bstp_cls_code:String
            /// 주식 전일 종가
            let stck_prdy_clpr:String
            /// 불성실 공시 여부
            let insn_pbnt_yn:String
            /// 액면가 변경 구분 명
            /// 특정 경우에만 데이터 출력
            let fcam_mod_cls_name:String
            /// 주식 현재가
            let stck_prpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// 누적 거래량
            let acml_vol:String
            /// 전일 대비 거래량 비율
            let prdy_vrss_vol_rate:String
            /// 업종 한글 종목명
            /// ※ 거래소 정보로 특정 종목은 업종구분이 없어 데이터 미회신
            let bstp_kor_isnm:String
            /// 정리매매 여부
            let sltr_yn:String
            /// 거래정지 여부
            let trht_yn:String
            /// 시가 범위 연장 여부
            let oprc_rang_cont_yn:String
            /// 임의 종료 구분 코드
            let vlnt_fin_cls_code:String
            /// 주식 시가2
            let stck_oprc:String
            /// 전일 거래량
            let prdy_vol:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-price-2"
        public var header: [String : String]
        init(tr_id: String = "FHPST01010000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST01010000
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

    /// ETF/ETN 현재가[v1_국내주식-068]
    /// ETF/ETN 현재가 API입니다.한국투자 HTS(eFriend Plus) > [0240] ETF/ETN 현재가 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct inquireprice_ : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FID 입력 종목코드
            /// 종목코드
            let fid_input_iscd:String
            /// FID 조건 시장 분류 코드
            /// J
            let fid_cond_mrkt_div_code:String
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
            /// 주식 상한가
            let stck_mxpr:String
            /// 주식 하한가
            let stck_llam:String
            /// 주식 전일 종가
            let stck_prdy_clpr:String
            /// 주식 시가2
            let stck_oprc:String
            /// 전일 종가 대비 시가2 비율
            let prdy_clpr_vrss_oprc_rate:String
            /// 주식 최고가
            let stck_hgpr:String
            /// 전일 종가 대비 최고가 비율
            let prdy_clpr_vrss_hgpr_rate:String
            /// 주식 최저가
            let stck_lwpr:String
            /// 전일 종가 대비 최저가 비율
            let prdy_clpr_vrss_lwpr_rate:String
            /// 전일 최종 NAV
            let prdy_last_nav:String
            /// NAV
            let nav:String
            /// NAV 전일 대비
            let nav_prdy_vrss:String
            /// NAV 전일 대비 부호
            let nav_prdy_vrss_sign:String
            /// NAV 전일 대비율
            let nav_prdy_ctrt:String
            /// 추적 오차율
            let trc_errt:String
            /// 주식 기준가
            let stck_sdpr:String
            /// 주식 대용가
            let stck_sspr:String
            /// 지수 대비율
            let nmix_ctrt:String
            /// ETF 유통 주수
            let etf_crcl_stcn:String
            /// ETF 순자산 총액
            let etf_ntas_ttam:String
            /// ETF 외화 순자산 총액
            let etf_frcr_ntas_ttam:String
            /// 외국인 한도 비율
            let frgn_limt_rate:String
            /// 외국인 주문 가능 수량
            let frgn_oder_able_qty:String
            /// ETF CU 단위 증권 수
            let etf_cu_unit_scrt_cnt:String
            /// ETF 구성 종목 수
            let etf_cnfg_issu_cnt:String
            /// ETF 배당 주기
            let etf_dvdn_cycl:String
            /// 통화 코드
            let crcd:String
            /// ETF 유통 순자산 총액
            let etf_crcl_ntas_ttam:String
            /// ETF 외화 유통 순자산 총액
            let etf_frcr_crcl_ntas_ttam:String
            /// ETF 외화 최종 순자산 가치 값
            let etf_frcr_last_ntas_wrth_val:String
            /// LP 주문 가능 구분 코드
            let lp_oder_able_cls_code:String
            /// 주식 연중 최고가
            let stck_dryy_hgpr:String
            /// 연중 최고가 대비 현재가 비율
            let dryy_hgpr_vrss_prpr_rate:String
            /// 연중 최고가 일자
            let dryy_hgpr_date:String
            /// 주식 연중 최저가
            let stck_dryy_lwpr:String
            /// 연중 최저가 대비 현재가 비율
            let dryy_lwpr_vrss_prpr_rate:String
            /// 연중 최저가 일자
            let dryy_lwpr_date:String
            /// 업종 한글 종목명
            /// ※ 거래소 정보로 특정 종목은 업종구분이 없어 데이터 미회신
            let bstp_kor_isnm:String
            /// VI적용구분코드
            let vi_cls_code:String
            /// 상장 주수
            let lstn_stcn:String
            /// 외국인 보유 수량
            let frgn_hldn_qty:String
            /// 외국인 보유 수량 비율
            let frgn_hldn_qty_rate:String
            /// ETF 추적 수익률 배수
            let etf_trc_ert_mltp:String
            /// 괴리율
            let dprt:String
            /// 회원사 명
            let mbcr_name:String
            /// 주식 상장 일자
            let stck_lstn_date:String
            /// 만기 일자
            let mtrt_date:String
            /// 분배금형태코드
            let shrg_type_code:String
            /// LP 보유 비율
            let lp_hldn_rate:String
            /// ETF대상지수업종코드
            let etf_trgt_nmix_bstp_code:String
            /// ETF 분류 명
            let etf_div_name:String
            /// ETF 대표 업종 한글 종목명
            let etf_rprs_bstp_kor_isnm:String
            /// ETN LP 보유량
            let lp_hldn_vol:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/etfetn/v1/quotations/inquire-price"
        public var header: [String : String]
        init(tr_id: String = "FHPST02400000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST02400000
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

    /// NAV 비교추이(종목)[v1_국내주식-069]
    /// NAV 비교추이(종목) API입니다.한국투자 HTS(eFriend Plus) > [0244] ETF/ETN 비교추이(NAV/IIV) 좌측 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct navcomparisontrend : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// J
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력 종목코드
            /// 종목코드
            let FID_INPUT_ISCD:String
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
            /// 응답상세 : Object
            let output2: Output2
        }
        public struct Output1 : Codable {
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
            /// 주식 전일 종가
            let stck_prdy_clpr:String
            /// 주식 시가2
            let stck_oprc:String
            /// 주식 최고가
            let stck_hgpr:String
            /// 주식 최저가
            let stck_lwpr:String
            /// 주식 상한가
            let stck_mxpr:String
            /// 주식 하한가
            let stck_llam:String
        }
        public struct Output2 : Codable {
            /// NAV
            let nav:String
            /// NAV 전일 대비 부호
            let nav_prdy_vrss_sign:String
            /// NAV 전일 대비
            let nav_prdy_vrss:String
            /// NAV 전일 대비율
            let nav_prdy_ctrt:String
            /// NAV전일종가
            let prdy_clpr_nav:String
            /// NAV시가
            let oprc_nav:String
            /// NAV고가
            let hprc_nav:String
            /// NAV저가
            let lprc_nav:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/etfetn/v1/quotations/nav-comparison-trend"
        public var header: [String : String]
        init(tr_id: String = "FHPST02440000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST02440000
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

    /// NAV 비교추이(분)[v1_국내주식-070]
    /// NAV 비교추이(분) API입니다.한국투자 HTS(eFriend Plus) > [0244] ETF/ETN 비교추이(NAV/IIV) 좌측 화면 "분별" 비교추이 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.실전계좌의 경우, 한 번의 호출에 최근 30건까지 확인 가능합니다.
    struct navcomparisontimetrend : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FID 시간 구분 코드
            /// 1분 :60, 3분: 180 … 120분:7200
            let fid_hour_cls_code:String
            /// FID 조건 시장 분류 코드
            /// E - 고정값
            let fid_cond_mrkt_div_code:String
            /// FID 입력 종목코드
            /// 종목코드
            let fid_input_iscd:String
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
            /// NAV
            let nav:String
            /// NAV 전일 대비 부호
            let nav_prdy_vrss_sign:String
            /// NAV 전일 대비
            let nav_prdy_vrss:String
            /// NAV 전일 대비율
            let nav_prdy_ctrt:String
            /// NAV 대비 현재가
            let nav_vrss_prpr:String
            /// 괴리율
            let dprt:String
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
            /// 체결 거래량
            let cntg_vol:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/etfetn/v1/quotations/nav-comparison-time-trend"
        public var header: [String : String]
        init(tr_id: String = "FHPST02440100", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST02440100
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

    /// NAV 비교추이(일)[v1_국내주식-071]
    /// NAV 비교추이(일) API입니다.한국투자 HTS(eFriend Plus) > [0244] ETF/ETN 비교추이(NAV/IIV) 좌측 화면 "일별" 비교추이 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.실전계좌의 경우, 한 번의 호출에 최대 100건까지 확인 가능합니다.
    struct navcomparisondailytrend : APIITEM, NeedHash {
        public struct Request : Codable {
            /// FID 조건 시장 분류 코드
            /// J 입력
            let fid_cond_mrkt_div_code:String
            /// FID 입력 종목코드
            /// 종목코드 (6자리)
            let fid_input_iscd:String
            /// FID 입력 날짜1
            /// 조회 시작일자 (ex. 20240101)
            let fid_input_date_1:String
            /// FID 입력 날짜2
            /// 조회 종료일자 (ex. 20240220)
            let fid_input_date_2:String
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
            /// 주식 영업 일자
            let stck_bsop_date:String
            /// 주식 종가
            let stck_clpr:String
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 누적 거래량
            let acml_vol:String
            /// 체결 거래량
            let cntg_vol:String
            /// 괴리율
            let dprt:String
            /// NAV 대비 현재가
            let nav_vrss_prpr:String
            /// NAV
            let nav:String
            /// NAV 전일 대비 부호
            let nav_prdy_vrss_sign:String
            /// NAV 전일 대비
            let nav_prdy_vrss:String
            /// NAV 전일 대비율
            let nav_prdy_ctrt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/etfetn/v1/quotations/nav-comparison-daily-trend"
        public var header: [String : String]
        init(tr_id: String = "FHPST02440200", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST02440200
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

    /// 국내주식 장마감 예상체결가[국내주식-120]
    /// 국내주식 장마감 예상체결가 API입니다. 한국투자 HTS(eFriend Plus) > [0183] 장마감 예상체결가 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct expclosingprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 순위 정렬 구분 코드
            /// 0:전체, 1:상한가마감예상, 2:하한가마감예상, 3:직전대비상승률상위 ,4:직전대비하락률상위
            let FID_RANK_SORT_CLS_CODE:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let FID_COND_MRKT_DIV_CODE:String
            /// 조건 화면 분류 코드
            /// Unique key(11173)
            let FID_COND_SCR_DIV_CODE:String
            /// 입력 종목코드
            /// 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200, 4001: KRX100
            let FID_INPUT_ISCD:String
            /// 소속 구분 코드
            /// 0:전체, 1:종가범위연장
            let FID_BLNG_CLS_CODE:String
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
            /// 기준가 대비 현재가
            let sdpr_vrss_prpr:String
            /// 기준가 대비 현재가 비율
            let sdpr_vrss_prpr_rate:String
            /// 체결 거래량
            let cntg_vol:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/exp-closing-price"
        public var header: [String : String]
        init(tr_id: String = "FHKST117300C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST117300C0
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

    /// ETF 구성종목시세[국내주식-073]
    /// ETF 구성종목시세 API입니다. 한국투자 HTS(eFriend Plus) > [0245] ETF/ETN 구성종목시세 화면의 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct inquirecomponentstockprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건시장분류코드
            /// 시장구분코드 (J)
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력종목코드
            /// 종목코드
            let FID_INPUT_ISCD:String
            /// 조건화면분류코드
            /// Unique key( 11216 )
            let FID_COND_SCR_DIV_CODE:String
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
            /// 매매 일자
            let stck_prpr:String
            /// 주식 현재가
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비
            let prdy_ctrt:String
            /// 전일 대비율
            let etf_cnfg_issu_avls:String
            /// 누적 거래량
            let nav:String
            /// 결제 일자
            let nav_prdy_vrss_sign:String
            /// 전체 융자 신규 주수
            let nav_prdy_vrss:String
            /// 전체 융자 상환 주수
            let nav_prdy_ctrt:String
            /// 전체 융자 잔고 주수
            let etf_ntas_ttam:String
            /// 전체 융자 신규 금액
            let prdy_clpr_nav:String
            /// 전체 융자 상환 금액
            let oprc_nav:String
            /// 전체 융자 잔고 금액
            let hprc_nav:String
            /// 전체 융자 잔고 비율
            let lprc_nav:String
            /// 전체 융자 공여율
            let etf_cu_unit_scrt_cnt:String
            /// 전체 대주 신규 주수
            let etf_cnfg_issu_cnt:String
        }
        public struct Output2 : Codable {
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
            /// 누적 거래량
            let acml_vol:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// 당일 등락 비율
            let tday_rsfl_rate:String
            /// 전일 대비 거래량
            let prdy_vrss_vol:String
            /// 거래대금회전율
            let tr_pbmn_tnrt:String
            /// HTS 시가총액
            let hts_avls:String
            /// ETF구성종목시가총액
            let etf_cnfg_issu_avls:String
            /// ETF구성종목비중
            let etf_cnfg_issu_rlim:String
            /// ETF구성종목내평가금액
            let etf_vltn_amt:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/etfetn/v1/quotations/inquire-component-stock-price"
        public var header: [String : String]
        init(tr_id: String = "FHKST121600C0", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST121600C0
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

    /// 국내주식 시간외현재가[국내주식-076]
    /// 국내주식 시간외현재가 API입니다. 한국투자 HTS(eFriend Plus) > [0230] 시간외 현재가 화면의 좌측 상단기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct inquireovertimeprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력 종목코드
            /// 종목코드
            let FID_INPUT_ISCD:String
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
            /// 업종 한글 종목명
            /// ※ 거래소 정보로 특정 종목은 업종구분이 없어 데이터 미회신
            let bstp_kor_isnm:String
            /// 관리 종목 구분 명
            let mang_issu_cls_name:String
            /// 시간외 단일가 현재가
            let ovtm_untp_prpr:String
            /// 시간외 단일가 전일 대비
            let ovtm_untp_prdy_vrss:String
            /// 시간외 단일가 전일 대비 부호
            let ovtm_untp_prdy_vrss_sign:String
            /// 시간외 단일가 전일 대비율
            let ovtm_untp_prdy_ctrt:String
            /// 시간외 단일가 거래량
            let ovtm_untp_vol:String
            /// 시간외 단일가 거래 대금
            let ovtm_untp_tr_pbmn:String
            /// 시간외 단일가 상한가
            let ovtm_untp_mxpr:String
            /// 시간외 단일가 하한가
            let ovtm_untp_llam:String
            /// 시간외 단일가 시가2
            let ovtm_untp_oprc:String
            /// 시간외 단일가 최고가
            let ovtm_untp_hgpr:String
            /// 시간외 단일가 최저가
            let ovtm_untp_lwpr:String
            /// 증거금 비율
            let marg_rate:String
            /// 시간외 단일가 예상 체결가
            let ovtm_untp_antc_cnpr:String
            /// 시간외 단일가 예상 체결 대비
            let ovtm_untp_antc_cntg_vrss:String
            /// 시간외 단일가 예상 체결 대비
            let ovtm_untp_antc_cntg_vrss_sign:String
            /// 시간외 단일가 예상 체결 대비율
            let ovtm_untp_antc_cntg_ctrt:String
            /// 시간외 단일가 예상 체결량
            let ovtm_untp_antc_cnqn:String
            /// 신용 가능 여부
            let crdt_able_yn:String
            /// 신규 상장 구분 명
            let new_lstn_cls_name:String
            /// 정리매매 여부
            let sltr_yn:String
            /// 관리 종목 여부
            let mang_issu_yn:String
            /// 시장 경고 구분 코드
            let mrkt_warn_cls_code:String
            /// 거래정지 여부
            let trht_yn:String
            /// 임의 매매 구분 명
            let vlnt_deal_cls_name:String
            /// 시간외 단일가 기준가
            let ovtm_untp_sdpr:String
            /// 시장 경구 구분 명
            let mrkt_warn_cls_name:String
            /// 재평가 종목 사유 명
            let revl_issu_reas_name:String
            /// 불성실 공시 여부
            let insn_pbnt_yn:String
            /// 락 구분 이름
            let flng_cls_name:String
            /// 대표 시장 한글 명
            let rprs_mrkt_kor_name:String
            /// 시간외단일가VI적용구분코드
            let ovtm_vi_cls_code:String
            /// 매수호가
            let bidp:String
            /// 매도호가
            let askp:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-overtime-price"
        public var header: [String : String]
        init(tr_id: String = "FHPST02300000", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST02300000
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

    /// 국내주식 시간외호가[국내주식-077]
    /// 국내주식 시간외호가 API입니다. 한국투자 HTS(eFriend Plus) > [0230] 시간외 현재가 화면의 '호가' 기능을 API로 개발한 사항으로, 해당 화면을 참고하시면 기능을 이해하기 쉽습니다.
    struct inquireovertimeaskingprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 입력 종목코드
            /// 종목코드
            let FID_INPUT_ISCD:String
            /// 조건 시장 분류 코드
            /// 시장구분코드 (주식 J)
            let FID_COND_MRKT_DIV_CODE:String
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
            /// 시간외 단일가 최종 시간
            let ovtm_untp_last_hour:String
            /// 시간외 단일가 매도호가1
            let ovtm_untp_askp1:String
            /// 시간외 단일가 매도호가2
            let ovtm_untp_askp2:String
            /// 시간외 단일가 매도호가3
            let ovtm_untp_askp3:String
            /// 시간외 단일가 매도호가4
            let ovtm_untp_askp4:String
            /// 시간외 단일가 매도호가5
            let ovtm_untp_askp5:String
            /// 시간외 단일가 매도호가6
            let ovtm_untp_askp6:String
            /// 시간외 단일가 매도호가7
            let ovtm_untp_askp7:String
            /// 시간외 단일가 매도호가8
            let ovtm_untp_askp8:String
            /// 시간외 단일가 매도호가9
            let ovtm_untp_askp9:String
            /// 시간외 단일가 매도호가10
            let ovtm_untp_askp10:String
            /// 시간외 단일가 매수호가1
            let ovtm_untp_bidp1:String
            /// 시간외 단일가 매수호가2
            let ovtm_untp_bidp2:String
            /// 시간외 단일가 매수호가3
            let ovtm_untp_bidp3:String
            /// 시간외 단일가 매수호가4
            let ovtm_untp_bidp4:String
            /// 시간외 단일가 매수호가5
            let ovtm_untp_bidp5:String
            /// 시간외 단일가 매수호가6
            let ovtm_untp_bidp6:String
            /// 시간외 단일가 매수호가7
            let ovtm_untp_bidp7:String
            /// 시간외 단일가 매수호가8
            let ovtm_untp_bidp8:String
            /// 시간외 단일가 매수호가9
            let ovtm_untp_bidp9:String
            /// 시간외 단일가 매수호가10
            let ovtm_untp_bidp10:String
            /// 시간외 단일가 매도호가 증감1
            let ovtm_untp_askp_icdc1:String
            /// 시간외 단일가 매도호가 증감2
            let ovtm_untp_askp_icdc2:String
            /// 시간외 단일가 매도호가 증감3
            let ovtm_untp_askp_icdc3:String
            /// 시간외 단일가 매도호가 증감4
            let ovtm_untp_askp_icdc4:String
            /// 시간외 단일가 매도호가 증감5
            let ovtm_untp_askp_icdc5:String
            /// 시간외 단일가 매도호가 증감6
            let ovtm_untp_askp_icdc6:String
            /// 시간외 단일가 매도호가 증감7
            let ovtm_untp_askp_icdc7:String
            /// 시간외 단일가 매도호가 증감8
            let ovtm_untp_askp_icdc8:String
            /// 시간외 단일가 매도호가 증감9
            let ovtm_untp_askp_icdc9:String
            /// 시간외 단일가 매도호가 증감10
            let ovtm_untp_askp_icdc10:String
            /// 시간외 단일가 매수호가 증감1
            let ovtm_untp_bidp_icdc1:String
            /// 시간외 단일가 매수호가 증감2
            let ovtm_untp_bidp_icdc2:String
            /// 시간외 단일가 매수호가 증감3
            let ovtm_untp_bidp_icdc3:String
            /// 시간외 단일가 매수호가 증감4
            let ovtm_untp_bidp_icdc4:String
            /// 시간외 단일가 매수호가 증감5
            let ovtm_untp_bidp_icdc5:String
            /// 시간외 단일가 매수호가 증감6
            let ovtm_untp_bidp_icdc6:String
            /// 시간외 단일가 매수호가 증감7
            let ovtm_untp_bidp_icdc7:String
            /// 시간외 단일가 매수호가 증감8
            let ovtm_untp_bidp_icdc8:String
            /// 시간외 단일가 매수호가 증감9
            let ovtm_untp_bidp_icdc9:String
            /// 시간외 단일가 매수호가 증감10
            let ovtm_untp_bidp_icdc10:String
            /// 시간외 단일가 매도호가 잔량1
            let ovtm_untp_askp_rsqn1:String
            /// 시간외 단일가 매도호가 잔량2
            let ovtm_untp_askp_rsqn2:String
            /// 시간외 단일가 매도호가 잔량3
            let ovtm_untp_askp_rsqn3:String
            /// 시간외 단일가 매도호가 잔량4
            let ovtm_untp_askp_rsqn4:String
            /// 시간외 단일가 매도호가 잔량5
            let ovtm_untp_askp_rsqn5:String
            /// 시간외 단일가 매도호가 잔량6
            let ovtm_untp_askp_rsqn6:String
            /// 시간외 단일가 매도호가 잔량7
            let ovtm_untp_askp_rsqn7:String
            /// 시간외 단일가 매도호가 잔량8
            let ovtm_untp_askp_rsqn8:String
            /// 시간외 단일가 매도호가 잔량9
            let ovtm_untp_askp_rsqn9:String
            /// 시간외 단일가 매도호가 잔량10
            let ovtm_untp_askp_rsqn10:String
            /// 시간외 단일가 매수호가 잔량1
            let ovtm_untp_bidp_rsqn1:String
            /// 시간외 단일가 매수호가 잔량2
            let ovtm_untp_bidp_rsqn2:String
            /// 시간외 단일가 매수호가 잔량3
            let ovtm_untp_bidp_rsqn3:String
            /// 시간외 단일가 매수호가 잔량4
            let ovtm_untp_bidp_rsqn4:String
            /// 시간외 단일가 매수호가 잔량5
            let ovtm_untp_bidp_rsqn5:String
            /// 시간외 단일가 매수호가 잔량6
            let ovtm_untp_bidp_rsqn6:String
            /// 시간외 단일가 매수호가 잔량7
            let ovtm_untp_bidp_rsqn7:String
            /// 시간외 단일가 매수호가 잔량8
            let ovtm_untp_bidp_rsqn8:String
            /// 시간외 단일가 매수호가 잔량9
            let ovtm_untp_bidp_rsqn9:String
            /// 시간외 단일가 매수호가 잔량10
            let ovtm_untp_bidp_rsqn10:String
            /// 시간외 단일가 총 매도호가 잔량
            let ovtm_untp_total_askp_rsqn:String
            /// 시간외 단일가 총 매수호가 잔량
            let ovtm_untp_total_bidp_rsqn:String
            /// 시간외 단일가 총 매도호가 잔량
            let ovtm_untp_total_askp_rsqn_icdc:String
            /// 시간외 단일가 총 매수호가 잔량
            let ovtm_untp_total_bidp_rsqn_icdc:String
            /// 시간외 단일가 순매수 호가 잔량
            let ovtm_untp_ntby_bidp_rsqn:String
            /// 총 매도호가 잔량
            let total_askp_rsqn:String
            /// 총 매수호가 잔량
            let total_bidp_rsqn:String
            /// 총 매도호가 잔량 증감
            let total_askp_rsqn_icdc:String
            /// 총 매수호가 잔량 증감
            let total_bidp_rsqn_icdc:String
            /// 시간외 총 매도호가 잔량
            let ovtm_total_askp_rsqn:String
            /// 시간외 총 매수호가 잔량
            let ovtm_total_bidp_rsqn:String
            /// 시간외 총 매도호가 증감
            let ovtm_total_askp_icdc:String
            /// 시간외 총 매수호가 증감
            let ovtm_total_bidp_icdc:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-overtime-asking-price"
        public var header: [String : String]
        init(tr_id: String = "FHPST02300400", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHPST02300400
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

    /// 주식일별분봉조회 [국내주식-213]
    /// 주식일별분봉조회 API입니다. 실전계좌의 경우, 한 번의 호출에 최대 120건까지 확인 가능하며, FID_INPUT_DATE_1, FID_INPUT_HOUR_1 이용하여 과거일자 분봉조회 가능합니다.※ 과거 분봉 조회 시, 당사 서버에서 보관하고 있는 만큼의 데이터만 확인이 가능합니다. (최대 1년 분봉 보관)
    struct inquiretimedailychartprice : APIITEM, NeedHash {
        public struct Request : Codable {
            /// 조건 시장 분류 코드
            /// J:KRX, NX:NXT, UN:통합
            let FID_COND_MRKT_DIV_CODE:String
            /// 입력 종목코드
            /// 종목코드 (ex 005930 삼성전자)
            let FID_INPUT_ISCD:String
            /// 입력 시간1
            /// 입력 시간(ex 13시 130000)
            let FID_INPUT_HOUR_1:String
            /// 입력 날짜1
            /// 입력 날짜(20241023)
            let FID_INPUT_DATE_1:String
            /// 과거 데이터 포함 여부
            let FID_PW_DATA_INCU_YN:String
            /// 허봉 포함 여부
            let FID_FAKE_TICK_INCU_YN:String?
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
            /// 전일 대비
            let prdy_vrss:String
            /// 전일 대비 부호
            let prdy_vrss_sign:String
            /// 전일 대비율
            let prdy_ctrt:String
            /// 주식 전일 종가
            let stck_prdy_clpr:String
            /// 누적 거래량
            let acml_vol:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
            /// HTS 한글 종목명
            let hts_kor_isnm:String
            /// 주식 현재가
            let stck_prpr:String
            /// 성공 실패 여부
            let rt_cd:String
            /// 응답코드
            let msg_cd:String
            /// 응답메세지
            let msg1:String
        }
        public struct Output2 : Codable {
            /// 주식 영업 일자
            let stck_bsop_date:String
            /// 주식 체결 시간
            let stck_cntg_hour:String
            /// 주식 현재가
            let stck_prpr:String
            /// 주식 시가2
            let stck_oprc:String
            /// 주식 최고가
            let stck_hgpr:String
            /// 주식 최저가
            let stck_lwpr:String
            /// 체결 거래량
            let cntg_vol:String
            /// 누적 거래 대금
            let acml_tr_pbmn:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .GET
        public let server: ServerInfo
        public let path = "/uapi/domestic-stock/v1/quotations/inquire-time-dailychartprice"
        public var header: [String : String]
        init(tr_id: String = "FHKST03010230", gt_uid: String? = nil) async throws {
            self.server = try KISManager.getCurrentServer()
            self.header = KISManager.headerPick(names: [
                "content-type", // application/json; charset=utf-8
                "authorization", // OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
                "appkey", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "appsecret", // 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
                "personalseckey", // [법인 필수] 제휴사 회원 관리를 위한 고객식별키
                "tr_id", // FHKST03010230
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
