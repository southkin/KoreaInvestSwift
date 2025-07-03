//
//  국내선물옵션_실시간시세.swift
//  KoreaInvestSwift
//
//  Created by kin on 4/10/25.
//

import FullyRESTful

public extension KISAPI {
    enum 국내선물옵션_실시간시세 {}
}
public extension KISAPI.국내선물옵션_실시간시세 {
    struct 지수선물_실시간체결가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0IFCNT0"
        struct Header : Codable {
            /// 웹소켓접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객 타입
            /// B : 법인 / P : 개인
            let custtype: String
            /// 등록/해제
            /// "1: 등록, 2:해제"
            let tr_type: String
            /// 컨텐츠타입
            /// utf-8
            let content_type: String
            enum CodingKeys : String, CodingKey {
                case approval_key
                case custtype
                case tr_type
                case content_type = "content-type"
            }
            init(tr_type: String) async {
                self.approval_key = await KISManager.currentManager?.getWebsocketAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "custtype",
                ])
                self.custtype = headers["custtype"] ?? ""
                self.tr_type = tr_type
                self.content_type = "utf-8"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// H0IFCNT0
            var tr_id: String = "H0IFCNT0"
            /// 코드
            /// 예:101S12
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 선물 단축 종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let futs_shrn_iscd: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 영업 시간
            let bsop_hour: String
            /// 선물 전일 대비
            let futs_prdy_vrss: String
            /// 전일 대비 부호
            let prdy_vrss_sign: String
            /// 선물 전일 대비율
            let futs_prdy_ctrt: String
            /// 선물 현재가
            let futs_prpr: String
            /// 선물 시가2
            let futs_oprc: String
            /// 선물 최고가
            let futs_hgpr: String
            /// 선물 최저가
            let futs_lwpr: String
            /// 최종 거래량
            /// 체결량
            let last_cnqn: String
            /// 누적 거래량
            let acml_vol: String
            /// 누적 거래 대금
            let acml_tr_pbmn: String
            /// HTS 이론가
            let hts_thpr: String
            /// 시장 베이시스
            let mrkt_basis: String
            /// 괴리율
            let dprt: String
            /// 근월물 약정가
            let nmsc_fctn_stpl_prc: String
            /// 원월물 약정가
            let fmsc_fctn_stpl_prc: String
            /// 스프레드1
            let spead_prc: String
            /// HTS 미결제 약정 수량
            let hts_otst_stpl_qty: String
            /// 미결제 약정 수량 증감
            let otst_stpl_qty_icdc: String
            /// 시가 시간
            let oprc_hour: String
            /// 시가2 대비 현재가 부호
            let oprc_vrss_prpr_sign: String
            /// 시가 대비 지수 현재가
            let oprc_vrss_nmix_prpr: String
            /// 최고가 시간
            let hgpr_hour: String
            /// 최고가 대비 현재가 부호
            let hgpr_vrss_prpr_sign: String
            /// 최고가 대비 지수 현재가
            let hgpr_vrss_nmix_prpr: String
            /// 최저가 시간
            let lwpr_hour: String
            /// 최저가 대비 현재가 부호
            let lwpr_vrss_prpr_sign: String
            /// 최저가 대비 지수 현재가
            let lwpr_vrss_nmix_prpr: String
            /// 매수2 비율
            let shnu_rate: String
            /// 체결강도
            let cttr: String
            /// 괴리도
            let esdg: String
            /// 미결제 약정 직전 수량 증감
            let otst_stpl_rgbf_qty_icdc: String
            /// 이론 베이시스
            let thpr_basis: String
            /// 선물 매도호가1
            let futs_askp1: String
            /// 선물 매수호가1
            let futs_bidp1: String
            /// 매도호가 잔량1
            let askp_rsqn1: String
            /// 매수호가 잔량1
            let bidp_rsqn1: String
            /// 매도 체결 건수
            let seln_cntg_csnu: String
            /// 매수 체결 건수
            let shnu_cntg_csnu: String
            /// 순매수 체결 건수
            let ntby_cntg_csnu: String
            /// 총 매도 수량
            let seln_cntg_smtn: String
            /// 총 매수 수량
            let shnu_cntg_smtn: String
            /// 총 매도호가 잔량
            let total_askp_rsqn: String
            /// 총 매수호가 잔량
            let total_bidp_rsqn: String
            /// 전일 거래량 대비 등락율
            let prdy_vol_vrss_acml_vol_rate: String
            /// 협의 대량 거래량
            let dscs_bltr_acml_qty: String
            /// 실시간상한가
            let dynm_mxpr: String
            /// 실시간하한가
            let dynm_llam: String
            /// 실시간가격제한구분
            let dynm_prc_limt_yn: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 지수선물_실시간호가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0IFASP0"
        struct Header : Codable {
            /// 웹소켓접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 등록/해제
            /// "1: 등록, 2:해제"
            let tr_type: String
            /// 고객 타입
            /// B : 법인 / P : 개인
            let custtype: String
            /// 컨텐츠타입
            /// utf-8
            let content_type: String
            enum CodingKeys : String, CodingKey {
                case approval_key
                case tr_type
                case custtype
                case content_type = "content-type"
            }
            init(tr_type: String) async {
                self.approval_key = await KISManager.currentManager?.getWebsocketAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "custtype",
                ])
                self.custtype = headers["custtype"] ?? ""
                self.tr_type = tr_type
                self.content_type = "utf-8"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// H0IFASP0
            var tr_id: String = "H0IFASP0"
            /// 코드
            /// 예:101S12
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 선물 단축 종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let futs_shrn_iscd: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 영업 시간
            let bsop_hour: String
            /// 선물 매도호가1
            let futs_askp1: String
            /// 선물 매도호가2
            let futs_askp2: String
            /// 선물 매도호가3
            let futs_askp3: String
            /// 선물 매도호가4
            let futs_askp4: String
            /// 선물 매도호가5
            let futs_askp5: String
            /// 선물 매수호가1
            let futs_bidp1: String
            /// 선물 매수호가2
            let futs_bidp2: String
            /// 선물 매수호가3
            let futs_bidp3: String
            /// 선물 매수호가4
            let futs_bidp4: String
            /// 선물 매수호가5
            let futs_bidp5: String
            /// 매도호가 건수1
            let askp_csnu1: String
            /// 매도호가 건수2
            let askp_csnu2: String
            /// 매도호가 건수3
            let askp_csnu3: String
            /// 매도호가 건수4
            let askp_csnu4: String
            /// 매도호가 건수5
            let askp_csnu5: String
            /// 매수호가 건수1
            let bidp_csnu1: String
            /// 매수호가 건수2
            let bidp_csnu2: String
            /// 매수호가 건수3
            let bidp_csnu3: String
            /// 매수호가 건수4
            let bidp_csnu4: String
            /// 매수호가 건수5
            let bidp_csnu5: String
            /// 매도호가 잔량1
            let askp_rsqn1: String
            /// 매도호가 잔량2
            let askp_rsqn2: String
            /// 매도호가 잔량3
            let askp_rsqn3: String
            /// 매도호가 잔량4
            let askp_rsqn4: String
            /// 매도호가 잔량5
            let askp_rsqn5: String
            /// 매수호가 잔량1
            let bidp_rsqn1: String
            /// 매수호가 잔량2
            let bidp_rsqn2: String
            /// 매수호가 잔량3
            let bidp_rsqn3: String
            /// 매수호가 잔량4
            let bidp_rsqn4: String
            /// 매수호가 잔량5
            let bidp_rsqn5: String
            /// 총 매도호가 건수
            let total_askp_csnu: String
            /// 총 매수호가 건수
            let total_bidp_csnu: String
            /// 총 매도호가 잔량
            let total_askp_rsqn: String
            /// 총 매수호가 잔량
            let total_bidp_rsqn: String
            /// 총 매도호가 잔량 증감
            let total_askp_rsqn_icdc: String
            /// 총 매수호가 잔량 증감
            let total_bidp_rsqn_icdc: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 선물옵션_실시간체결통보 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "ws://ops.koreainvestment.com:31000") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0IFCNI0"
        struct Header : Codable {
            /// 웹소켓접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 등록/해제
            /// 1: 등록, 2:해제
            let tr_type: String
            /// 고객 타입
            /// B : 법인 / P : 개인
            let custtype: String
            /// 컨텐츠타입
            /// utf-8
            let content_type: String
            enum CodingKeys : String, CodingKey {
                case approval_key
                case tr_type
                case custtype
                case content_type = "content-type"
            }
            init(tr_type: String) async {
                self.approval_key = await KISManager.currentManager?.getWebsocketAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "custtype",
                ])
                self.custtype = headers["custtype"] ?? ""
                self.tr_type = tr_type
                self.content_type = "utf-8"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// [실전투자] H0IFCNI0 : 실시간 선물옵션 체결통보 [모의투자] H0IFCNI9 : 실시간 선물옵션 체결통보
            var tr_id: String = KISManager.currentManager!.getValueForCurrentTargetServer(실전서버: "H0IFCNI0", 모의투자서버: "H0IFCNI9")
            /// 코드
            /// 예:101S12
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 고객 ID
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let cust_id: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 계좌번호
            let acnt_no: String
            /// 주문번호
            let oder_no: String
            /// 원주문번호
            let ooder_no: String
            /// 매도매수구분
            /// 01:매도, 02매수
            let seln_byov_cls: String
            /// 정정구분
            let rctf_cls: String
            /// 주문종류2
            /// L: 주문접수통보, 0: 체결통보
            let oder_kind2: String
            /// 주식 단축 종목코드
            let stck_shrn_iscd: String
            /// 체결 수량
            let cntg_qty: String
            /// 체결단가
            let cntg_unpr: String
            /// 주식 체결 시간
            let stck_cntg_hour: String
            /// 거부여부
            let rfus_yn: String
            /// 체결여부
            /// 1: 주문,정정,취소,거부 통보, 2 체결
            let cntg_yn: String
            /// 접수여부
            /// 1:주문접수, 2:확인, 3, 취소
            let acpt_yn: String
            /// 지점번호
            let brnc_no: String
            /// 주문수량
            let oder_qty: String
            /// 계좌명
            let acnt_name: String
            /// 체결종목명
            let cntg_isnm: String
            /// 주문조건
            let oder_cond: String
            /// 주문그룹ID
            let ord_grp: String
            /// 주문그룹SEQ
            let ord_grpseq: String
            /// 주문가격
            let order_prc: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 지수옵션_실시간체결가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0IOCNT0"
        struct Header : Codable {
            /// 웹소켓접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객 타입
            /// B : 법인 / P : 개인
            let custtype: String
            /// 등록/해제
            /// "1: 등록, 2:해제"
            let tr_type: String
            /// 컨텐츠타입
            /// utf-8
            let content_type: String
            enum CodingKeys : String, CodingKey {
                case approval_key
                case custtype
                case tr_type
                case content_type = "content-type"
            }
            init(tr_type: String) async {
                self.approval_key = await KISManager.currentManager?.getWebsocketAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "custtype",
                ])
                self.custtype = headers["custtype"] ?? ""
                self.tr_type = tr_type
                self.content_type = "utf-8"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// H0IOCNT0
            var tr_id: String = "H0IOCNT0"
            /// 코드
            /// 예:201S11305
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 옵션 단축 종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let optn_shrn_iscd: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 영업 시간
            let bsop_hour: String
            /// 옵션 현재가
            let optn_prpr: String
            /// 전일 대비 부호
            let prdy_vrss_sign: String
            /// 옵션 전일 대비
            let optn_prdy_vrss: String
            /// 전일 대비율
            let prdy_ctrt: String
            /// 옵션 시가2
            let optn_oprc: String
            /// 옵션 최고가
            let optn_hgpr: String
            /// 옵션 최저가
            let optn_lwpr: String
            /// 최종 거래량
            let last_cnqn: String
            /// 누적 거래량
            let acml_vol: String
            /// 누적 거래 대금
            let acml_tr_pbmn: String
            /// HTS 이론가
            let hts_thpr: String
            /// HTS 미결제 약정 수량
            let hts_otst_stpl_qty: String
            /// 미결제 약정 수량 증감
            let otst_stpl_qty_icdc: String
            /// 시가 시간
            let oprc_hour: String
            /// 시가2 대비 현재가 부호
            let oprc_vrss_prpr_sign: String
            /// 시가 대비 지수 현재가
            let oprc_vrss_nmix_prpr: String
            /// 최고가 시간
            let hgpr_hour: String
            /// 최고가 대비 현재가 부호
            let hgpr_vrss_prpr_sign: String
            /// 최고가 대비 지수 현재가
            let hgpr_vrss_nmix_prpr: String
            /// 최저가 시간
            let lwpr_hour: String
            /// 최저가 대비 현재가 부호
            let lwpr_vrss_prpr_sign: String
            /// 최저가 대비 지수 현재가
            let lwpr_vrss_nmix_prpr: String
            /// 매수2 비율
            let shnu_rate: String
            /// 프리미엄 값
            let prmm_val: String
            /// 내재가치 값
            let invl_val: String
            /// 시간가치 값
            let tmvl_val: String
            /// 델타
            let delta: String
            /// 감마
            let gama: String
            /// 베가
            let vega: String
            /// 세타
            let theta: String
            /// 로우
            let rho: String
            /// HTS 내재 변동성
            let hts_ints_vltl: String
            /// 괴리도
            let esdg: String
            /// 미결제 약정 직전 수량 증감
            let otst_stpl_rgbf_qty_icdc: String
            /// 이론 베이시스
            let thpr_basis: String
            /// 역사적변동성
            let unas_hist_vltl: String
            /// 체결강도
            let cttr: String
            /// 괴리율
            let dprt: String
            /// 시장 베이시스
            let mrkt_basis: String
            /// 옵션 매도호가1
            let optn_askp1: String
            /// 옵션 매수호가1
            let optn_bidp1: String
            /// 매도호가 잔량1
            let askp_rsqn1: String
            /// 매수호가 잔량1
            let bidp_rsqn1: String
            /// 매도 체결 건수
            let seln_cntg_csnu: String
            /// 매수 체결 건수
            let shnu_cntg_csnu: String
            /// 순매수 체결 건수
            let ntby_cntg_csnu: String
            /// 총 매도 수량
            let seln_cntg_smtn: String
            /// 총 매수 수량
            let shnu_cntg_smtn: String
            /// 총 매도호가 잔량
            let total_askp_rsqn: String
            /// 총 매수호가 잔량
            let total_bidp_rsqn: String
            /// 전일 거래량 대비 등락율
            let prdy_vol_vrss_acml_vol_rate: String
            /// 평균 변동성
            let avrg_vltl: String
            /// 협의대량누적 거래량
            let dscs_lrqn_vol: String
            /// 실시간상한가
            let dynm_mxpr: String
            /// 실시간하한가
            let dynm_llam: String
            /// 실시간가격제한구분
            let dynm_prc_limt_yn: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 지수옵션_실시간호가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0IOASP0"
        struct Header : Codable {
            /// 웹소켓접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 등록/해제
            /// "1: 등록, 2:해제"
            let tr_type: String
            /// 고객 타입
            /// B : 법인 / P : 개인
            let custtype: String
            /// 컨텐츠타입
            /// utf-8
            let content_type: String
            enum CodingKeys : String, CodingKey {
                case approval_key
                case tr_type
                case custtype
                case content_type = "content-type"
            }
            init(tr_type: String) async {
                self.approval_key = await KISManager.currentManager?.getWebsocketAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "custtype",
                ])
                self.custtype = headers["custtype"] ?? ""
                self.tr_type = tr_type
                self.content_type = "utf-8"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// H0IOASP0
            var tr_id: String = "H0IOASP0"
            /// 코드
            /// 예:201S11305
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 옵션 단축 종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let optn_shrn_iscd: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 영업 시간
            let bsop_hour: String
            /// 옵션 매도호가1
            let optn_askp1: String
            /// 옵션 매도호가2
            let optn_askp2: String
            /// 옵션 매도호가3
            let optn_askp3: String
            /// 옵션 매도호가4
            let optn_askp4: String
            /// 옵션 매도호가5
            let optn_askp5: String
            /// 옵션 매수호가1
            let optn_bidp1: String
            /// 옵션 매수호가2
            let optn_bidp2: String
            /// 옵션 매수호가3
            let optn_bidp3: String
            /// 옵션 매수호가4
            let optn_bidp4: String
            /// 옵션 매수호가5
            let optn_bidp5: String
            /// 매도호가 건수1
            let askp_csnu1: String
            /// 매도호가 건수2
            let askp_csnu2: String
            /// 매도호가 건수3
            let askp_csnu3: String
            /// 매도호가 건수4
            let askp_csnu4: String
            /// 매도호가 건수5
            let askp_csnu5: String
            /// 매수호가 건수1
            let bidp_csnu1: String
            /// 매수호가 건수2
            let bidp_csnu2: String
            /// 매수호가 건수3
            let bidp_csnu3: String
            /// 매수호가 건수4
            let bidp_csnu4: String
            /// 매수호가 건수5
            let bidp_csnu5: String
            /// 매도호가 잔량1
            let askp_rsqn1: String
            /// 매도호가 잔량2
            let askp_rsqn2: String
            /// 매도호가 잔량3
            let askp_rsqn3: String
            /// 매도호가 잔량4
            let askp_rsqn4: String
            /// 매도호가 잔량5
            let askp_rsqn5: String
            /// 매수호가 잔량1
            let bidp_rsqn1: String
            /// 매수호가 잔량2
            let bidp_rsqn2: String
            /// 매수호가 잔량3
            let bidp_rsqn3: String
            /// 매수호가 잔량4
            let bidp_rsqn4: String
            /// 매수호가 잔량5
            let bidp_rsqn5: String
            /// 총 매도호가 건수
            let total_askp_csnu: String
            /// 총 매수호가 건수
            let total_bidp_csnu: String
            /// 총 매도호가 잔량
            let total_askp_rsqn: String
            /// 총 매수호가 잔량
            let total_bidp_rsqn: String
            /// 총 매도호가 잔량 증감
            let total_askp_rsqn_icdc: String
            /// 총 매수호가 잔량 증감
            let total_bidp_rsqn_icdc: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 상품선물_실시간체결가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0CFCNT0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객 타입
            /// B : 법인 / P : 개인
            let custtype: String
            /// 등록/해제
            /// "1: 등록, 2:해제"
            let tr_type: String
            /// 컨텐츠타입
            /// utf-8
            let content_type: String
            enum CodingKeys : String, CodingKey {
                case approval_key
                case custtype
                case tr_type
                case content_type = "content-type"
            }
            init(tr_type: String) async {
                self.approval_key = await KISManager.currentManager?.getWebsocketAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "custtype",
                ])
                self.custtype = headers["custtype"] ?? ""
                self.tr_type = tr_type
                self.content_type = "utf-8"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// H0CFCNT0
            var tr_id: String = "H0CFCNT0"
            /// 종목코드
            /// 종목코드
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 선물 단축 종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let futs_shrn_iscd: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 영업 시간
            let bsop_hour: String
            /// 선물 전일 대비
            let futs_prdy_vrss: String
            /// 전일 대비 부호
            let prdy_vrss_sign: String
            /// 선물 전일 대비율
            let futs_prdy_ctrt: String
            /// 선물 현재가
            let futs_prpr: String
            /// 선물 시가2
            let futs_oprc: String
            /// 선물 최고가
            let futs_hgpr: String
            /// 선물 최저가
            let futs_lwpr: String
            /// 최종 거래량
            let last_cnqn: String
            /// 누적 거래량
            let acml_vol: String
            /// 누적 거래 대금
            let acml_tr_pbmn: String
            /// HTS 이론가
            let hts_thpr: String
            /// 시장 베이시스
            let mrkt_basis: String
            /// 괴리율
            let dprt: String
            /// 근월물 약정가
            let nmsc_fctn_stpl_prc: String
            /// 원월물 약정가
            let fmsc_fctn_stpl_prc: String
            /// 스프레드1
            let spead_prc: String
            /// HTS 미결제 약정 수량
            let hts_otst_stpl_qty: String
            /// 미결제 약정 수량 증감
            let otst_stpl_qty_icdc: String
            /// 시가 시간
            let oprc_hour: String
            /// 시가2 대비 현재가 부호
            let oprc_vrss_prpr_sign: String
            /// 시가 대비 지수 현재가
            let oprc_vrss_nmix_prpr: String
            /// 최고가 시간
            let hgpr_hour: String
            /// 최고가 대비 현재가 부호
            let hgpr_vrss_prpr_sign: String
            /// 최고가 대비 지수 현재가
            let hgpr_vrss_nmix_prpr: String
            /// 최저가 시간
            let lwpr_hour: String
            /// 최저가 대비 현재가 부호
            let lwpr_vrss_prpr_sign: String
            /// 최저가 대비 지수 현재가
            let lwpr_vrss_nmix_prpr: String
            /// 매수2 비율
            let shnu_rate: String
            /// 체결강도
            let cttr: String
            /// 괴리도
            let esdg: String
            /// 미결제 약정 직전 수량 증감
            let otst_stpl_rgbf_qty_icdc: String
            /// 이론 베이시스
            let thpr_basis: String
            /// 선물 매도호가1
            let futs_askp1: String
            /// 선물 매수호가1
            let futs_bidp1: String
            /// 매도호가 잔량1
            let askp_rsqn1: String
            /// 매수호가 잔량1
            let bidp_rsqn1: String
            /// 매도 체결 건수
            let seln_cntg_csnu: String
            /// 매수 체결 건수
            let shnu_cntg_csnu: String
            /// 순매수 체결 건수
            let ntby_cntg_csnu: String
            /// 총 매도 수량
            let seln_cntg_smtn: String
            /// 총 매수 수량
            let shnu_cntg_smtn: String
            /// 총 매도호가 잔량
            let total_askp_rsqn: String
            /// 총 매수호가 잔량
            let total_bidp_rsqn: String
            /// 전일 거래량 대비 등락율
            let prdy_vol_vrss_acml_vol_rate: String
            /// 협의 대량 거래량
            let dscs_bltr_acml_qty: String
            /// 실시간상한가
            let dynm_mxpr: String
            /// 실시간하한가
            let dynm_llam: String
            /// 실시간가격제한구분
            let dynm_prc_limt_yn: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 상품선물_실시간호가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "https://openapi.koreainvestment.com:9443", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0CFASP0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객 타입
            /// B : 법인 / P : 개인
            let custtype: String
            /// 등록/해제
            /// "1: 등록, 2:해제"
            let tr_type: String
            /// 컨텐츠타입
            /// utf-8
            let content_type: String
            enum CodingKeys : String, CodingKey {
                case approval_key
                case custtype
                case tr_type
                case content_type = "content-type"
            }
            init(tr_type: String) async {
                self.approval_key = await KISManager.currentManager?.getWebsocketAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "custtype",
                ])
                self.custtype = headers["custtype"] ?? ""
                self.tr_type = tr_type
                self.content_type = "utf-8"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// H0CFASP0
            var tr_id: String = "H0CFASP0"
            /// 종목코드
            /// 종목코드
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 선물 단축 종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let futs_shrn_iscd: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 영업 시간
            let bsop_hour: String
            /// 선물 매도호가1
            let futs_askp1: String
            /// 선물 매도호가2
            let futs_askp2: String
            /// 선물 매도호가3
            let futs_askp3: String
            /// 선물 매도호가4
            let futs_askp4: String
            /// 선물 매도호가5
            let futs_askp5: String
            /// 선물 매수호가1
            let futs_bidp1: String
            /// 선물 매수호가2
            let futs_bidp2: String
            /// 선물 매수호가3
            let futs_bidp3: String
            /// 선물 매수호가4
            let futs_bidp4: String
            /// 선물 매수호가5
            let futs_bidp5: String
            /// 매도호가 건수1
            let askp_csnu1: String
            /// 매도호가 건수2
            let askp_csnu2: String
            /// 매도호가 건수3
            let askp_csnu3: String
            /// 매도호가 건수4
            let askp_csnu4: String
            /// 매도호가 건수5
            let askp_csnu5: String
            /// 매수호가 건수1
            let bidp_csnu1: String
            /// 매수호가 건수2
            let bidp_csnu2: String
            /// 매수호가 건수3
            let bidp_csnu3: String
            /// 매수호가 건수4
            let bidp_csnu4: String
            /// 매수호가 건수5
            let bidp_csnu5: String
            /// 매도호가 잔량1
            let askp_rsqn1: String
            /// 매도호가 잔량2
            let askp_rsqn2: String
            /// 매도호가 잔량3
            let askp_rsqn3: String
            /// 매도호가 잔량4
            let askp_rsqn4: String
            /// 매도호가 잔량5
            let askp_rsqn5: String
            /// 매수호가 잔량1
            let bidp_rsqn1: String
            /// 매수호가 잔량2
            let bidp_rsqn2: String
            /// 매수호가 잔량3
            let bidp_rsqn3: String
            /// 매수호가 잔량4
            let bidp_rsqn4: String
            /// 매수호가 잔량5
            let bidp_rsqn5: String
            /// 총 매도호가 건수
            let total_askp_csnu: String
            /// 총 매수호가 건수
            let total_bidp_csnu: String
            /// 총 매도호가 잔량
            let total_askp_rsqn: String
            /// 총 매수호가 잔량
            let total_bidp_rsqn: String
            /// 총 매도호가 잔량 증감
            let total_askp_rsqn_icdc: String
            /// 총 매수호가 잔량 증감
            let total_bidp_rsqn_icdc: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 주식선물_실시간체결가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0ZFCNT0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객 타입
            /// B : 법인 / P : 개인
            let custtype: String
            /// 등록/해제
            /// "1: 등록, 2:해제"
            let tr_type: String
            /// 컨텐츠타입
            /// utf-8
            let content_type: String
            enum CodingKeys : String, CodingKey {
                case approval_key
                case custtype
                case tr_type
                case content_type = "content-type"
            }
            init(tr_type: String) async {
                self.approval_key = await KISManager.currentManager?.getWebsocketAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "custtype",
                ])
                self.custtype = headers["custtype"] ?? ""
                self.tr_type = tr_type
                self.content_type = "utf-8"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// H0ZFCNT0
            var tr_id: String = "H0ZFCNT0"
            /// 종목코드
            /// 종목코드
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 선물단축종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let futs_shrn_iscd: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 영업시간
            let bsop_hour: String
            /// 주식현재가
            let stck_prpr: String
            /// 전일대비부호
            let prdy_vrss_sign: String
            /// 전일대비
            let prdy_vrss: String
            /// 선물전일대비율
            let futs_prdy_ctrt: String
            /// 주식시가2
            let stck_oprc: String
            /// 주식최고가
            let stck_hgpr: String
            /// 주식최저가
            let stck_lwpr: String
            /// 최종거래량
            let last_cnqn: String
            /// 누적거래량
            let acml_vol: String
            /// 누적거래대금
            let acml_tr_pbmn: String
            /// HTS이론가
            let hts_thpr: String
            /// 시장베이시스
            let mrkt_basis: String
            /// 괴리율
            let dprt: String
            /// 근월물약정가
            let nmsc_fctn_stpl_prc: String
            /// 원월물약정가
            let fmsc_fctn_stpl_prc: String
            /// 스프레드1
            let spead_prc: String
            /// HTS미결제약정수량
            let hts_otst_stpl_qty: String
            /// 미결제약정수량증감
            let otst_stpl_qty_icdc: String
            /// 시가시간
            let oprc_hour: String
            /// 시가2대비현재가부호
            let oprc_vrss_prpr_sign: String
            /// 시가2대비현재가
            let oprc_vrss_prpr: String
            /// 최고가시간
            let hgpr_hour: String
            /// 최고가대비현재가부호
            let hgpr_vrss_prpr_sign: String
            /// 최고가대비현재가
            let hgpr_vrss_prpr: String
            /// 최저가시간
            let lwpr_hour: String
            /// 최저가대비현재가부호
            let lwpr_vrss_prpr_sign: String
            /// 최저가대비현재가
            let lwpr_vrss_prpr: String
            /// 매수2비율
            let shnu_rate: String
            /// 체결강도
            let cttr: String
            /// 괴리도
            let esdg: String
            /// 미결제약정직전수량증감
            let otst_stpl_rgbf_qty_icdc: String
            /// 이론베이시스
            let thpr_basis: String
            /// 매도호가1
            let askp1: String
            /// 매수호가1
            let bidp1: String
            /// 매도호가잔량1
            let askp_rsqn1: String
            /// 매수호가잔량1
            let bidp_rsqn1: String
            /// 매도체결건수
            let seln_cntg_csnu: String
            /// 매수체결건수
            let shnu_cntg_csnu: String
            /// 순매수체결건수
            let ntby_cntg_csnu: String
            /// 총매도수량
            let seln_cntg_smtn: String
            /// 총매수수량
            let shnu_cntg_smtn: String
            /// 총매도호가잔량
            let total_askp_rsqn: String
            /// 총매수호가잔량
            let total_bidp_rsqn: String
            /// 전일거래량대비등락율
            let prdy_vol_vrss_acml_vol_rate: String
            /// 실시간상한가
            let dynm_mxpr: String
            /// 실시간하한가
            let dynm_llam: String
            /// 실시간가격제한구분
            let dynm_prc_limt_yn: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 주식선물_실시간호가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0ZFASP0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객 타입
            /// B : 법인 / P : 개인
            let custtype: String
            /// 등록/해제
            /// "1: 등록, 2:해제"
            let tr_type: String
            /// 컨텐츠타입
            /// utf-8
            let content_type: String
            enum CodingKeys : String, CodingKey {
                case approval_key
                case custtype
                case tr_type
                case content_type = "content-type"
            }
            init(tr_type: String) async {
                self.approval_key = await KISManager.currentManager?.getWebsocketAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "custtype",
                ])
                self.custtype = headers["custtype"] ?? ""
                self.tr_type = tr_type
                self.content_type = "utf-8"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// H0ZFASP0
            var tr_id: String = "H0ZFASP0"
            /// 종목코드
            /// 종목코드
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 선물단축종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let futs_shrn_iscd: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 영업시간
            let bsop_hour: String
            /// 매도호가1
            let askp1: String
            /// 매도호가2
            let askp2: String
            /// 매도호가3
            let askp3: String
            /// 매도호가4
            let askp4: String
            /// 매도호가5
            let askp5: String
            /// 매도호가6
            let askp6: String
            /// 매도호가7
            let askp7: String
            /// 매도호가8
            let askp8: String
            /// 매도호가9
            let askp9: String
            /// 매도호가10
            let askp10: String
            /// 매수호가1
            let bidp1: String
            /// 매수호가2
            let bidp2: String
            /// 매수호가3
            let bidp3: String
            /// 매수호가4
            let bidp4: String
            /// 매수호가5
            let bidp5: String
            /// 매수호가6
            let bidp6: String
            /// 매수호가7
            let bidp7: String
            /// 매수호가8
            let bidp8: String
            /// 매수호가9
            let bidp9: String
            /// 매수호가10
            let bidp10: String
            /// 매도호가건수1
            let askp_csnu1: String
            /// 매도호가건수2
            let askp_csnu2: String
            /// 매도호가건수3
            let askp_csnu3: String
            /// 매도호가건수4
            let askp_csnu4: String
            /// 매도호가건수5
            let askp_csnu5: String
            /// 매도호가건수6
            let askp_csnu6: String
            /// 매도호가건수7
            let askp_csnu7: String
            /// 매도호가건수8
            let askp_csnu8: String
            /// 매도호가건수9
            let askp_csnu9: String
            /// 매도호가건수10
            let askp_csnu10: String
            /// 매수호가건수1
            let bidp_csnu1: String
            /// 매수호가건수2
            let bidp_csnu2: String
            /// 매수호가건수3
            let bidp_csnu3: String
            /// 매수호가건수4
            let bidp_csnu4: String
            /// 매수호가건수5
            let bidp_csnu5: String
            /// 매수호가건수6
            let bidp_csnu6: String
            /// 매수호가건수7
            let bidp_csnu7: String
            /// 매수호가건수8
            let bidp_csnu8: String
            /// 매수호가건수9
            let bidp_csnu9: String
            /// 매수호가건수10
            let bidp_csnu10: String
            /// 매도호가잔량1
            let askp_rsqn1: String
            /// 매도호가잔량2
            let askp_rsqn2: String
            /// 매도호가잔량3
            let askp_rsqn3: String
            /// 매도호가잔량4
            let askp_rsqn4: String
            /// 매도호가잔량5
            let askp_rsqn5: String
            /// 매도호가잔량6
            let askp_rsqn6: String
            /// 매도호가잔량7
            let askp_rsqn7: String
            /// 매도호가잔량8
            let askp_rsqn8: String
            /// 매도호가잔량9
            let askp_rsqn9: String
            /// 매도호가잔량10
            let askp_rsqn10: String
            /// 매수호가잔량1
            let bidp_rsqn1: String
            /// 매수호가잔량2
            let bidp_rsqn2: String
            /// 매수호가잔량3
            let bidp_rsqn3: String
            /// 매수호가잔량4
            let bidp_rsqn4: String
            /// 매수호가잔량5
            let bidp_rsqn5: String
            /// 매수호가잔량6
            let bidp_rsqn6: String
            /// 매수호가잔량7
            let bidp_rsqn7: String
            /// 매수호가잔량8
            let bidp_rsqn8: String
            /// 매수호가잔량9
            let bidp_rsqn9: String
            /// 매수호가잔량10
            let bidp_rsqn10: String
            /// 총매도호가건수
            let total_askp_csnu: String
            /// 총매수호가건수
            let total_bidp_csnu: String
            /// 총매도호가잔량
            let total_askp_rsqn: String
            /// 총매수호가잔량
            let total_bidp_rsqn: String
            /// 총매도호가잔량증감
            let total_askp_rsqn_icdc: String
            /// 총매수호가잔량증감
            let total_bidp_rsqn_icdc: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 주식옵션_실시간체결가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0ZOCNT0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객 타입
            /// B : 법인 / P : 개인
            let custtype: String
            /// 등록/해제
            /// "1: 등록, 2:해제"
            let tr_type: String
            /// 컨텐츠타입
            /// utf-8
            let content_type: String
            enum CodingKeys : String, CodingKey {
                case approval_key
                case custtype
                case tr_type
                case content_type = "content-type"
            }
            init(tr_type: String) async {
                self.approval_key = await KISManager.currentManager?.getWebsocketAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "custtype",
                ])
                self.custtype = headers["custtype"] ?? ""
                self.tr_type = tr_type
                self.content_type = "utf-8"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// H0ZOCNT0
            var tr_id: String = "H0ZOCNT0"
            /// 종목코드
            /// 종목코드
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 옵션단축종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let optn_shrn_iscd: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 영업시간
            let bsop_hour: String
            /// 옵션현재가
            let optn_prpr: String
            /// 전일대비부호
            let prdy_vrss_sign: String
            /// 옵션전일대비
            let optn_prdy_vrss: String
            /// 전일대비율
            let prdy_ctrt: String
            /// 옵션시가2
            let optn_oprc: String
            /// 옵션최고가
            let optn_hgpr: String
            /// 옵션최저가
            let optn_lwpr: String
            /// 최종거래량
            let last_cnqn: String
            /// 누적거래량
            let acml_vol: String
            /// 누적거래대금
            let acml_tr_pbmn: String
            /// HTS이론가
            let hts_thpr: String
            /// HTS미결제약정수량
            let hts_otst_stpl_qty: String
            /// 미결제약정수량증감
            let otst_stpl_qty_icdc: String
            /// 시가시간
            let oprc_hour: String
            /// 시가2대비현재가부호
            let oprc_vrss_prpr_sign: String
            /// 시가대비지수현재가
            let oprc_vrss_nmix_prpr: String
            /// 최고가시간
            let hgpr_hour: String
            /// 최고가대비현재가부호
            let hgpr_vrss_prpr_sign: String
            /// 최고가대비지수현재가
            let hgpr_vrss_nmix_prpr: String
            /// 최저가시간
            let lwpr_hour: String
            /// 최저가대비현재가부호
            let lwpr_vrss_prpr_sign: String
            /// 최저가대비지수현재가
            let lwpr_vrss_nmix_prpr: String
            /// 매수2비율
            let shnu_rate: String
            /// 프리미엄값
            let prmm_val: String
            /// 내재가치값
            let invl_val: String
            /// 시간가치값
            let tmvl_val: String
            /// 델타
            let delta: String
            /// 감마
            let gama: String
            /// 베가
            let vega: String
            /// 세타
            let theta: String
            /// 로우
            let rho: String
            /// HTS내재변동성
            let hts_ints_vltl: String
            /// 괴리도
            let esdg: String
            /// 미결제약정직전수량증감
            let otst_stpl_rgbf_qty_icdc: String
            /// 이론베이시스
            let thpr_basis: String
            /// 역사적변동성
            let unas_hist_vltl: String
            /// 체결강도
            let cttr: String
            /// 괴리율
            let dprt: String
            /// 시장베이시스
            let mrkt_basis: String
            /// 옵션매도호가1
            let optn_askp1: String
            /// 옵션매수호가1
            let optn_bidp1: String
            /// 매도호가잔량1
            let askp_rsqn1: String
            /// 매수호가잔량1
            let bidp_rsqn1: String
            /// 매도체결건수
            let seln_cntg_csnu: String
            /// 매수체결건수
            let shnu_cntg_csnu: String
            /// 순매수체결건수
            let ntby_cntg_csnu: String
            /// 총매도수량
            let seln_cntg_smtn: String
            /// 총매수수량
            let shnu_cntg_smtn: String
            /// 총매도호가잔량
            let total_askp_rsqn: String
            /// 총매수호가잔량
            let total_bidp_rsqn: String
            /// 전일거래량대비등락율
            let prdy_vol_vrss_acml_vol_rate: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 주식옵션_실시간호가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0ZOASP0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객 타입
            /// B : 법인 / P : 개인
            let custtype: String
            /// 등록/해제
            /// "1: 등록, 2:해제"
            let tr_type: String
            /// 컨텐츠타입
            /// utf-8
            let content_type: String
            enum CodingKeys : String, CodingKey {
                case approval_key
                case custtype
                case tr_type
                case content_type = "content-type"
            }
            init(tr_type: String) async {
                self.approval_key = await KISManager.currentManager?.getWebsocketAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "custtype",
                ])
                self.custtype = headers["custtype"] ?? ""
                self.tr_type = tr_type
                self.content_type = "utf-8"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// H0ZOASP0
            var tr_id: String = "H0ZOASP0"
            /// 종목코드
            /// 종목코드
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 옵션단축종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let optn_shrn_iscd: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 영업시간
            let bsop_hour: String
            /// 옵션매도호가1
            let optn_askp1: String
            /// 옵션매도호가2
            let optn_askp2: String
            /// 옵션매도호가3
            let optn_askp3: String
            /// 옵션매도호가4
            let optn_askp4: String
            /// 옵션매도호가5
            let optn_askp5: String
            /// 옵션매수호가1
            let optn_bidp1: String
            /// 옵션매수호가2
            let optn_bidp2: String
            /// 옵션매수호가3
            let optn_bidp3: String
            /// 옵션매수호가4
            let optn_bidp4: String
            /// 옵션매수호가5
            let optn_bidp5: String
            /// 매도호가건수1
            let askp_csnu1: String
            /// 매도호가건수2
            let askp_csnu2: String
            /// 매도호가건수3
            let askp_csnu3: String
            /// 매도호가건수4
            let askp_csnu4: String
            /// 매도호가건수5
            let askp_csnu5: String
            /// 매수호가건수1
            let bidp_csnu1: String
            /// 매수호가건수2
            let bidp_csnu2: String
            /// 매수호가건수3
            let bidp_csnu3: String
            /// 매수호가건수4
            let bidp_csnu4: String
            /// 매수호가건수5
            let bidp_csnu5: String
            /// 매도호가잔량1
            let askp_rsqn1: String
            /// 매도호가잔량2
            let askp_rsqn2: String
            /// 매도호가잔량3
            let askp_rsqn3: String
            /// 매도호가잔량4
            let askp_rsqn4: String
            /// 매도호가잔량5
            let askp_rsqn5: String
            /// 매수호가잔량1
            let bidp_rsqn1: String
            /// 매수호가잔량2
            let bidp_rsqn2: String
            /// 매수호가잔량3
            let bidp_rsqn3: String
            /// 매수호가잔량4
            let bidp_rsqn4: String
            /// 매수호가잔량5
            let bidp_rsqn5: String
            /// 총매도호가건수
            let total_askp_csnu: String
            /// 총매수호가건수
            let total_bidp_csnu: String
            /// 총매도호가잔량
            let total_askp_rsqn: String
            /// 총매수호가잔량
            let total_bidp_rsqn: String
            /// 총매도호가잔량증감
            let total_askp_rsqn_icdc: String
            /// 총매수호가잔량증감
            let total_bidp_rsqn_icdc: String
            /// 옵션매도호가6
            let optn_askp6: String
            /// 옵션매도호가7
            let optn_askp7: String
            /// 옵션매도호가8
            let optn_askp8: String
            /// 옵션매도호가9
            let optn_askp9: String
            /// 옵션매도호가10
            let optn_askp10: String
            /// 옵션매수호가6
            let optn_bidp6: String
            /// 옵션매수호가7
            let optn_bidp7: String
            /// 옵션매수호가8
            let optn_bidp8: String
            /// 옵션매수호가9
            let optn_bidp9: String
            /// 옵션매수호가10
            let optn_bidp10: String
            /// 매도호가건수6
            let askp_csnu6: String
            /// 매도호가건수7
            let askp_csnu7: String
            /// 매도호가건수8
            let askp_csnu8: String
            /// 매도호가건수9
            let askp_csnu9: String
            /// 매도호가건수10
            let askp_csnu10: String
            /// 매수호가건수6
            let bidp_csnu6: String
            /// 매수호가건수7
            let bidp_csnu7: String
            /// 매수호가건수8
            let bidp_csnu8: String
            /// 매수호가건수9
            let bidp_csnu9: String
            /// 매수호가건수10
            let bidp_csnu10: String
            /// 매도호가잔량6
            let askp_rsqn6: String
            /// 매도호가잔량7
            let askp_rsqn7: String
            /// 매도호가잔량8
            let askp_rsqn8: String
            /// 매도호가잔량9
            let askp_rsqn9: String
            /// 매도호가잔량10
            let askp_rsqn10: String
            /// 매수호가잔량6
            let bidp_rsqn6: String
            /// 매수호가잔량7
            let bidp_rsqn7: String
            /// 매수호가잔량8
            let bidp_rsqn8: String
            /// 매수호가잔량9
            let bidp_rsqn9: String
            /// 매수호가잔량10
            let bidp_rsqn10: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 주식선물_실시간예상체결 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0ZFANC0"
        struct Header : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 접근토큰
            /// OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
            let authorization: String
            /// 앱키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appkey: String
            /// 앱시크릿키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appsecret: String
            /// 고객식별키
            /// [법인 필수] 제휴사 회원 관리를 위한 고객식별키
            let personalseckey: String
            /// 거래ID
            /// H0ZFANC0
            var tr_id: String = "H0ZFANC0"
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// 고객 타입
            /// B : 법인 P : 개인
            let custtype: String
            /// 일련번호
            /// [법인 필수] 001
            let seq_no: String
            /// 맥주소
            /// 법인고객 혹은 개인고객의 Mac address 값
            let mac_address: String
            /// 핸드폰번호
            /// [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
            let phone_number: String
            /// 접속 단말 공인 IP
            /// [법인 필수] 사용자(회원)의 IP Address
            let ip_addr: String
            /// 해쉬키
            /// [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
            let hashkey: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case content_type = "content-type"
                case authorization
                case appkey
                case appsecret
                case personalseckey
                case tr_id
                case tr_cont
                case custtype
                case seq_no
                case mac_address
                case phone_number
                case ip_addr
                case hashkey
                case gt_uid
            }
            init() async {
                self.authorization = await KISManager.currentManager?.getAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "appkey",
                    "appsecret",
                    "personalseckey",
                    "tr_cont",
                    "custtype",
                    "seq_no",
                    "mac_address",
                    "phone_number",
                    "ip_addr",
                    "hashkey",
                    "gt_uid",
                ])
                self.appkey = headers["appkey"] ?? ""
                self.appsecret = headers["appsecret"] ?? ""
                self.personalseckey = headers["personalseckey"] ?? ""
                self.tr_cont = headers["tr_cont"] ?? ""
                self.custtype = headers["custtype"] ?? ""
                self.seq_no = headers["seq_no"] ?? ""
                self.mac_address = headers["mac_address"] ?? ""
                self.phone_number = headers["phone_number"] ?? ""
                self.ip_addr = headers["ip_addr"] ?? ""
                self.hashkey = headers["hashkey"] ?? ""
                self.gt_uid = headers["gt_uid"] ?? ""
                self.content_type = "application/json; charset=utf-8"
            }
        }
        struct Body : Codable {
            /// 선물 단축 종목코드
            let FUTS_SHRN_ISCD: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 거래ID
            /// 요청한 tr_id
            let tr_id: String
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case tr_id,tr_cont,gt_uid
                case content_type = "content-type"
            }
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct EUREX야간옵션_실시간체결가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0EUCNT0"
        struct Header : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 접근토큰
            /// OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
            let authorization: String
            /// 앱키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appkey: String
            /// 앱시크릿키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appsecret: String
            /// 고객식별키
            /// [법인 필수] 제휴사 회원 관리를 위한 고객식별키
            let personalseckey: String
            /// 거래ID
            /// H0EUCNT0
            var tr_id: String = "H0EUCNT0"
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// 고객 타입
            /// B : 법인 P : 개인
            let custtype: String
            /// 일련번호
            /// [법인 필수] 001
            let seq_no: String
            /// 맥주소
            /// 법인고객 혹은 개인고객의 Mac address 값
            let mac_address: String
            /// 핸드폰번호
            /// [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
            let phone_number: String
            /// 접속 단말 공인 IP
            /// [법인 필수] 사용자(회원)의 IP Address
            let ip_addr: String
            /// 해쉬키
            /// [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
            let hashkey: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case content_type = "content-type"
                case authorization
                case appkey
                case appsecret
                case personalseckey
                case tr_id
                case tr_cont
                case custtype
                case seq_no
                case mac_address
                case phone_number
                case ip_addr
                case hashkey
                case gt_uid
            }
            init() async {
                self.authorization = await KISManager.currentManager?.getAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "appkey",
                    "appsecret",
                    "personalseckey",
                    "tr_cont",
                    "custtype",
                    "seq_no",
                    "mac_address",
                    "phone_number",
                    "ip_addr",
                    "hashkey",
                    "gt_uid",
                ])
                self.appkey = headers["appkey"] ?? ""
                self.appsecret = headers["appsecret"] ?? ""
                self.personalseckey = headers["personalseckey"] ?? ""
                self.tr_cont = headers["tr_cont"] ?? ""
                self.custtype = headers["custtype"] ?? ""
                self.seq_no = headers["seq_no"] ?? ""
                self.mac_address = headers["mac_address"] ?? ""
                self.phone_number = headers["phone_number"] ?? ""
                self.ip_addr = headers["ip_addr"] ?? ""
                self.hashkey = headers["hashkey"] ?? ""
                self.gt_uid = headers["gt_uid"] ?? ""
                self.content_type = "application/json; charset=utf-8"
            }
        }
        struct Body : Codable {
            /// 옵션 단축 종목코드
            /// 옵션 단축 종목코드 입력 ※ 포럼 > FAQ > 종목정보 다운로드(국내) > EUREX연계 야간옵션 참조
            let OPTN_SHRN_ISCD: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 거래ID
            /// 요청한 tr_id
            let tr_id: String
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case tr_id,tr_cont,gt_uid
                case content_type = "content-type"
            }
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct EUREX야간옵션_실시간호가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0EUASP0"
        struct Header : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 접근토큰
            /// OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
            let authorization: String
            /// 앱키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appkey: String
            /// 앱시크릿키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appsecret: String
            /// 고객식별키
            /// [법인 필수] 제휴사 회원 관리를 위한 고객식별키
            let personalseckey: String
            /// 거래ID
            /// H0EUASP0
            var tr_id: String = "H0EUASP0"
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// 고객 타입
            /// B : 법인 P : 개인
            let custtype: String
            /// 일련번호
            /// [법인 필수] 001
            let seq_no: String
            /// 맥주소
            /// 법인고객 혹은 개인고객의 Mac address 값
            let mac_address: String
            /// 핸드폰번호
            /// [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
            let phone_number: String
            /// 접속 단말 공인 IP
            /// [법인 필수] 사용자(회원)의 IP Address
            let ip_addr: String
            /// 해쉬키
            /// [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
            let hashkey: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case content_type = "content-type"
                case authorization
                case appkey
                case appsecret
                case personalseckey
                case tr_id
                case tr_cont
                case custtype
                case seq_no
                case mac_address
                case phone_number
                case ip_addr
                case hashkey
                case gt_uid
            }
            init() async {
                self.authorization = await KISManager.currentManager?.getAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "appkey",
                    "appsecret",
                    "personalseckey",
                    "tr_cont",
                    "custtype",
                    "seq_no",
                    "mac_address",
                    "phone_number",
                    "ip_addr",
                    "hashkey",
                    "gt_uid",
                ])
                self.appkey = headers["appkey"] ?? ""
                self.appsecret = headers["appsecret"] ?? ""
                self.personalseckey = headers["personalseckey"] ?? ""
                self.tr_cont = headers["tr_cont"] ?? ""
                self.custtype = headers["custtype"] ?? ""
                self.seq_no = headers["seq_no"] ?? ""
                self.mac_address = headers["mac_address"] ?? ""
                self.phone_number = headers["phone_number"] ?? ""
                self.ip_addr = headers["ip_addr"] ?? ""
                self.hashkey = headers["hashkey"] ?? ""
                self.gt_uid = headers["gt_uid"] ?? ""
                self.content_type = "application/json; charset=utf-8"
            }
        }
        struct Body : Codable {
            /// 옵션 단축 종목코드
            /// 옵션 단축 종목코드 입력 ※ 포럼 > FAQ > 종목정보 다운로드(국내) > EUREX연계 야간옵션 참조
            let OPTN_SHRN_ISCD: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 거래ID
            /// 요청한 tr_id
            let tr_id: String
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case tr_id,tr_cont,gt_uid
                case content_type = "content-type"
            }
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct EUREX야간옵션실시간예상체결 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0EUANC0"
        struct Header : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 접근토큰
            /// OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
            let authorization: String
            /// 앱키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appkey: String
            /// 앱시크릿키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appsecret: String
            /// 고객식별키
            /// [법인 필수] 제휴사 회원 관리를 위한 고객식별키
            let personalseckey: String
            /// 거래ID
            /// H0EUANC0
            var tr_id: String = "H0EUANC0"
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// 고객 타입
            /// B : 법인 P : 개인
            let custtype: String
            /// 일련번호
            /// [법인 필수] 001
            let seq_no: String
            /// 맥주소
            /// 법인고객 혹은 개인고객의 Mac address 값
            let mac_address: String
            /// 핸드폰번호
            /// [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
            let phone_number: String
            /// 접속 단말 공인 IP
            /// [법인 필수] 사용자(회원)의 IP Address
            let ip_addr: String
            /// 해쉬키
            /// [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
            let hashkey: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case content_type = "content-type"
                case authorization
                case appkey
                case appsecret
                case personalseckey
                case tr_id
                case tr_cont
                case custtype
                case seq_no
                case mac_address
                case phone_number
                case ip_addr
                case hashkey
                case gt_uid
            }
            init() async {
                self.authorization = await KISManager.currentManager?.getAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "appkey",
                    "appsecret",
                    "personalseckey",
                    "tr_cont",
                    "custtype",
                    "seq_no",
                    "mac_address",
                    "phone_number",
                    "ip_addr",
                    "hashkey",
                    "gt_uid",
                ])
                self.appkey = headers["appkey"] ?? ""
                self.appsecret = headers["appsecret"] ?? ""
                self.personalseckey = headers["personalseckey"] ?? ""
                self.tr_cont = headers["tr_cont"] ?? ""
                self.custtype = headers["custtype"] ?? ""
                self.seq_no = headers["seq_no"] ?? ""
                self.mac_address = headers["mac_address"] ?? ""
                self.phone_number = headers["phone_number"] ?? ""
                self.ip_addr = headers["ip_addr"] ?? ""
                self.hashkey = headers["hashkey"] ?? ""
                self.gt_uid = headers["gt_uid"] ?? ""
                self.content_type = "application/json; charset=utf-8"
            }
        }
        struct Body : Codable {
            /// 옵션 단축 종목코드
            /// 옵션 단축 종목코드 입력 ※ 포럼 > FAQ > 종목정보 다운로드(국내) > EUREX연계 야간옵션 참조
            let OPTN_SHRN_ISCD: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 거래ID
            /// 요청한 tr_id
            let tr_id: String
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case tr_id,tr_cont,gt_uid
                case content_type = "content-type"
            }
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 주식옵션_실시간예상체결 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0ZOANC0"
        struct Header : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 접근토큰
            /// OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
            let authorization: String
            /// 앱키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appkey: String
            /// 앱시크릿키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appsecret: String
            /// 고객식별키
            /// [법인 필수] 제휴사 회원 관리를 위한 고객식별키
            let personalseckey: String
            /// 거래ID
            /// H0ZOANC0
            var tr_id: String = "H0ZOANC0"
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// 고객 타입
            /// B : 법인 P : 개인
            let custtype: String
            /// 일련번호
            /// [법인 필수] 001
            let seq_no: String
            /// 맥주소
            /// 법인고객 혹은 개인고객의 Mac address 값
            let mac_address: String
            /// 핸드폰번호
            /// [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
            let phone_number: String
            /// 접속 단말 공인 IP
            /// [법인 필수] 사용자(회원)의 IP Address
            let ip_addr: String
            /// 해쉬키
            /// [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
            let hashkey: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case content_type = "content-type"
                case authorization
                case appkey
                case appsecret
                case personalseckey
                case tr_id
                case tr_cont
                case custtype
                case seq_no
                case mac_address
                case phone_number
                case ip_addr
                case hashkey
                case gt_uid
            }
            init() async {
                self.authorization = await KISManager.currentManager?.getAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "appkey",
                    "appsecret",
                    "personalseckey",
                    "tr_cont",
                    "custtype",
                    "seq_no",
                    "mac_address",
                    "phone_number",
                    "ip_addr",
                    "hashkey",
                    "gt_uid",
                ])
                self.appkey = headers["appkey"] ?? ""
                self.appsecret = headers["appsecret"] ?? ""
                self.personalseckey = headers["personalseckey"] ?? ""
                self.tr_cont = headers["tr_cont"] ?? ""
                self.custtype = headers["custtype"] ?? ""
                self.seq_no = headers["seq_no"] ?? ""
                self.mac_address = headers["mac_address"] ?? ""
                self.phone_number = headers["phone_number"] ?? ""
                self.ip_addr = headers["ip_addr"] ?? ""
                self.hashkey = headers["hashkey"] ?? ""
                self.gt_uid = headers["gt_uid"] ?? ""
                self.content_type = "application/json; charset=utf-8"
            }
        }
        struct Body : Codable {
            /// 옵션단축종목코드
            let OPTN_SHRN_ISCD: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 거래ID
            /// 요청한 tr_id
            let tr_id: String
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case tr_id,tr_cont,gt_uid
                case content_type = "content-type"
            }
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct CME야간선물_실시간종목체결 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0MFCNT0"
        struct Header : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 접근토큰
            /// OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
            let authorization: String
            /// 앱키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appkey: String
            /// 앱시크릿키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appsecret: String
            /// 고객식별키
            /// [법인 필수] 제휴사 회원 관리를 위한 고객식별키
            let personalseckey: String
            /// 거래ID
            /// H0MFCNT0
            var tr_id: String = "H0MFCNT0"
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// 고객 타입
            /// B : 법인 P : 개인
            let custtype: String
            /// 일련번호
            /// [법인 필수] 001
            let seq_no: String
            /// 맥주소
            /// 법인고객 혹은 개인고객의 Mac address 값
            let mac_address: String
            /// 핸드폰번호
            /// [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
            let phone_number: String
            /// 접속 단말 공인 IP
            /// [법인 필수] 사용자(회원)의 IP Address
            let ip_addr: String
            /// 해쉬키
            /// [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
            let hashkey: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case content_type = "content-type"
                case authorization
                case appkey
                case appsecret
                case personalseckey
                case tr_id
                case tr_cont
                case custtype
                case seq_no
                case mac_address
                case phone_number
                case ip_addr
                case hashkey
                case gt_uid
            }
            init() async {
                self.authorization = await KISManager.currentManager?.getAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "appkey",
                    "appsecret",
                    "personalseckey",
                    "tr_cont",
                    "custtype",
                    "seq_no",
                    "mac_address",
                    "phone_number",
                    "ip_addr",
                    "hashkey",
                    "gt_uid",
                ])
                self.appkey = headers["appkey"] ?? ""
                self.appsecret = headers["appsecret"] ?? ""
                self.personalseckey = headers["personalseckey"] ?? ""
                self.tr_cont = headers["tr_cont"] ?? ""
                self.custtype = headers["custtype"] ?? ""
                self.seq_no = headers["seq_no"] ?? ""
                self.mac_address = headers["mac_address"] ?? ""
                self.phone_number = headers["phone_number"] ?? ""
                self.ip_addr = headers["ip_addr"] ?? ""
                self.hashkey = headers["hashkey"] ?? ""
                self.gt_uid = headers["gt_uid"] ?? ""
                self.content_type = "application/json; charset=utf-8"
            }
        }
        struct Body : Codable {
            /// 선물 단축 종목코드
            /// 선물 종목코드 입력 ※ 포럼 > FAQ > 종목정보 다운로드(국내) > CME연계 야간선물 참조
            let FUTS_SHRN_ISCD: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 거래ID
            /// 요청한 tr_id
            let tr_id: String
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case tr_id,tr_cont,gt_uid
                case content_type = "content-type"
            }
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct CME야간선물_실시간호가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0MFASP0"
        struct Header : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 접근토큰
            /// OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
            let authorization: String
            /// 앱키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appkey: String
            /// 앱시크릿키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appsecret: String
            /// 고객식별키
            /// [법인 필수] 제휴사 회원 관리를 위한 고객식별키
            let personalseckey: String
            /// 거래ID
            /// H0MFASP0
            var tr_id: String = "H0MFASP0"
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// 고객 타입
            /// B : 법인 P : 개인
            let custtype: String
            /// 일련번호
            /// [법인 필수] 001
            let seq_no: String
            /// 맥주소
            /// 법인고객 혹은 개인고객의 Mac address 값
            let mac_address: String
            /// 핸드폰번호
            /// [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
            let phone_number: String
            /// 접속 단말 공인 IP
            /// [법인 필수] 사용자(회원)의 IP Address
            let ip_addr: String
            /// 해쉬키
            /// [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
            let hashkey: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case content_type = "content-type"
                case authorization
                case appkey
                case appsecret
                case personalseckey
                case tr_id
                case tr_cont
                case custtype
                case seq_no
                case mac_address
                case phone_number
                case ip_addr
                case hashkey
                case gt_uid
            }
            init() async {
                self.authorization = await KISManager.currentManager?.getAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "appkey",
                    "appsecret",
                    "personalseckey",
                    "tr_cont",
                    "custtype",
                    "seq_no",
                    "mac_address",
                    "phone_number",
                    "ip_addr",
                    "hashkey",
                    "gt_uid",
                ])
                self.appkey = headers["appkey"] ?? ""
                self.appsecret = headers["appsecret"] ?? ""
                self.personalseckey = headers["personalseckey"] ?? ""
                self.tr_cont = headers["tr_cont"] ?? ""
                self.custtype = headers["custtype"] ?? ""
                self.seq_no = headers["seq_no"] ?? ""
                self.mac_address = headers["mac_address"] ?? ""
                self.phone_number = headers["phone_number"] ?? ""
                self.ip_addr = headers["ip_addr"] ?? ""
                self.hashkey = headers["hashkey"] ?? ""
                self.gt_uid = headers["gt_uid"] ?? ""
                self.content_type = "application/json; charset=utf-8"
            }
        }
        struct Body : Codable {
            /// 선물 단축 종목코드
            /// 선물 종목코드 입력 ※ 포럼 > FAQ > 종목정보 다운로드(국내) > CME연계 야간선물 참조
            let FUTS_SHRN_ISCD: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 거래ID
            /// 요청한 tr_id
            let tr_id: String
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case tr_id,tr_cont,gt_uid
                case content_type = "content-type"
            }
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct CME야간선물_실시간체결통보 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0MFCNI0"
        struct Header : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 접근토큰
            /// OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
            let authorization: String
            /// 앱키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appkey: String
            /// 앱시크릿키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appsecret: String
            /// 고객식별키
            /// [법인 필수] 제휴사 회원 관리를 위한 고객식별키
            let personalseckey: String
            /// 거래ID
            /// H0MFCNI0
            var tr_id: String = "H0MFCNI0"
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// 고객 타입
            /// B : 법인 P : 개인
            let custtype: String
            /// 일련번호
            /// [법인 필수] 001
            let seq_no: String
            /// 맥주소
            /// 법인고객 혹은 개인고객의 Mac address 값
            let mac_address: String
            /// 핸드폰번호
            /// [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
            let phone_number: String
            /// 접속 단말 공인 IP
            /// [법인 필수] 사용자(회원)의 IP Address
            let ip_addr: String
            /// 해쉬키
            /// [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
            let hashkey: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case content_type = "content-type"
                case authorization
                case appkey
                case appsecret
                case personalseckey
                case tr_id
                case tr_cont
                case custtype
                case seq_no
                case mac_address
                case phone_number
                case ip_addr
                case hashkey
                case gt_uid
            }
            init() async {
                self.authorization = await KISManager.currentManager?.getAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "appkey",
                    "appsecret",
                    "personalseckey",
                    "tr_cont",
                    "custtype",
                    "seq_no",
                    "mac_address",
                    "phone_number",
                    "ip_addr",
                    "hashkey",
                    "gt_uid",
                ])
                self.appkey = headers["appkey"] ?? ""
                self.appsecret = headers["appsecret"] ?? ""
                self.personalseckey = headers["personalseckey"] ?? ""
                self.tr_cont = headers["tr_cont"] ?? ""
                self.custtype = headers["custtype"] ?? ""
                self.seq_no = headers["seq_no"] ?? ""
                self.mac_address = headers["mac_address"] ?? ""
                self.phone_number = headers["phone_number"] ?? ""
                self.ip_addr = headers["ip_addr"] ?? ""
                self.hashkey = headers["hashkey"] ?? ""
                self.gt_uid = headers["gt_uid"] ?? ""
                self.content_type = "application/json; charset=utf-8"
            }
        }
        struct Body : Codable {
            /// 고객 ID
            /// HTS ID 입력
            let CUST_ID: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 거래ID
            /// 요청한 tr_id
            let tr_id: String
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case tr_id,tr_cont,gt_uid
                case content_type = "content-type"
            }
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct EUREX야간옵션실시간체결통보 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0EUCNI0"
        struct Header : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 접근토큰
            /// OAuth 토큰이 필요한 API 경우 발급한 Access token 일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용) 법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
            let authorization: String
            /// 앱키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appkey: String
            /// 앱시크릿키
            /// 한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appsecret: String
            /// 고객식별키
            /// [법인 필수] 제휴사 회원 관리를 위한 고객식별키
            let personalseckey: String
            /// 거래ID
            /// H0EUCNI0
            var tr_id: String = "H0EUCNI0"
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// 고객 타입
            /// B : 법인 P : 개인
            let custtype: String
            /// 일련번호
            /// [법인 필수] 001
            let seq_no: String
            /// 맥주소
            /// 법인고객 혹은 개인고객의 Mac address 값
            let mac_address: String
            /// 핸드폰번호
            /// [법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호 ex) 01011112222 (하이픈 등 구분값 제거)
            let phone_number: String
            /// 접속 단말 공인 IP
            /// [법인 필수] 사용자(회원)의 IP Address
            let ip_addr: String
            /// 해쉬키
            /// [POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값 * API문서 > hashkey 참조
            let hashkey: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case content_type = "content-type"
                case authorization
                case appkey
                case appsecret
                case personalseckey
                case tr_id
                case tr_cont
                case custtype
                case seq_no
                case mac_address
                case phone_number
                case ip_addr
                case hashkey
                case gt_uid
            }
            init() async {
                self.authorization = await KISManager.currentManager?.getAccessToken()?.token ?? ""
                var headers = KISManager.currentManager!.headerPick(names: [
                    "appkey",
                    "appsecret",
                    "personalseckey",
                    "tr_cont",
                    "custtype",
                    "seq_no",
                    "mac_address",
                    "phone_number",
                    "ip_addr",
                    "hashkey",
                    "gt_uid",
                ])
                self.appkey = headers["appkey"] ?? ""
                self.appsecret = headers["appsecret"] ?? ""
                self.personalseckey = headers["personalseckey"] ?? ""
                self.tr_cont = headers["tr_cont"] ?? ""
                self.custtype = headers["custtype"] ?? ""
                self.seq_no = headers["seq_no"] ?? ""
                self.mac_address = headers["mac_address"] ?? ""
                self.phone_number = headers["phone_number"] ?? ""
                self.ip_addr = headers["ip_addr"] ?? ""
                self.hashkey = headers["hashkey"] ?? ""
                self.gt_uid = headers["gt_uid"] ?? ""
                self.content_type = "application/json; charset=utf-8"
            }
        }
        struct Body : Codable {
            /// 고객 ID
            /// HTS ID 입력
            let CUST_ID: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 컨텐츠타입
            /// application/json; charset=utf-8
            let content_type: String
            /// 거래ID
            /// 요청한 tr_id
            let tr_id: String
            /// 연속 거래 여부
            /// 공백 : 초기 조회 N : 다음 데이터 조회 (output header의 tr_cont가 M일 경우)
            let tr_cont: String
            /// Global UID
            /// [법인 필수] 거래고유번호로 사용하므로 거래별로 UNIQUE해야 함
            let gt_uid: String
            enum CodingKeys : String, CodingKey {
                case tr_id,tr_cont,gt_uid
                case content_type = "content-type"
            }
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }
}
