//
//  국내주식_실시간시세.swift
//  KoreaInvestSwift
//
//  Created by kin on 4/8/25.
//
import FullyRESTful
import Foundation

public extension KISAPI {
    enum 국내주식_실시간시세{}
}
public extension KISAPI.국내주식_실시간시세 {
    struct 국내주식_실시간체결가_KRX : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "ws://ops.koreainvestment.com:31000") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0STCNT0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객타입
            /// B : 법인 P : 개인
            let custtype: String
            /// 거래타입
            /// 1 : 등록 2 : 해제
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
            /// [실전/모의투자] H0STCNT0 : 실시간 주식 체결가
            let tr_id: String
            /// 구분값
            /// 종목번호 (6자리) ETN의 경우, Q로 시작 (EX. Q500001)
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 유가증권 단축 종목코드
            let MKSC_SHRN_ISCD: String
            /// 주식 체결 시간
            let STCK_CNTG_HOUR: String
            /// 주식 현재가
            /// 체결가격
            let STCK_PRPR: Decimal
            /// 전일 대비 부호
            /// 1 : 상한 2 : 상승 3 : 보합 4 : 하한 5 : 하락
            let PRDY_VRSS_SIGN: String
            /// 전일 대비
            let PRDY_VRSS: Decimal
            /// 전일 대비율
            let PRDY_CTRT: Decimal
            /// 가중 평균 주식 가격
            let WGHN_AVRG_STCK_PRC: Decimal
            /// 주식 시가
            let STCK_OPRC: Decimal
            /// 주식 최고가
            let STCK_HGPR: Decimal
            /// 주식 최저가
            let STCK_LWPR: Decimal
            /// 매도호가1
            let ASKP1: Decimal
            /// 매수호가1
            let BIDP1: Decimal
            /// 체결 거래량
            let CNTG_VOL: Decimal
            /// 누적 거래량
            let ACML_VOL: Decimal
            /// 누적 거래 대금
            let ACML_TR_PBMN: Decimal
            /// 매도 체결 건수
            let SELN_CNTG_CSNU: Decimal
            /// 매수 체결 건수
            let SHNU_CNTG_CSNU: Decimal
            /// 순매수 체결 건수
            let NTBY_CNTG_CSNU: Decimal
            /// 체결강도
            let CTTR: Decimal
            /// 총 매도 수량
            let SELN_CNTG_SMTN: Decimal
            /// 총 매수 수량
            let SHNU_CNTG_SMTN: Decimal
            /// 체결구분
            /// 1:매수(+) 3:장전 5:매도(-)
            let CCLD_DVSN: String
            /// 매수비율
            let SHNU_RATE: Decimal
            /// 전일 거래량 대비 등락율
            let PRDY_VOL_VRSS_ACML_VOL_RATE: Decimal
            /// 시가 시간
            let OPRC_HOUR: String
            /// 시가대비구분
            /// 1 : 상한 2 : 상승 3 : 보합 4 : 하한 5 : 하락
            let OPRC_VRSS_PRPR_SIGN: String
            /// 시가대비
            let OPRC_VRSS_PRPR: Decimal
            /// 최고가 시간
            let HGPR_HOUR: String
            /// 고가대비구분
            /// 1 : 상한 2 : 상승 3 : 보합 4 : 하한 5 : 하락
            let HGPR_VRSS_PRPR_SIGN: String
            /// 고가대비
            let HGPR_VRSS_PRPR: Decimal
            /// 최저가 시간
            let LWPR_HOUR: String
            /// 저가대비구분
            /// 1 : 상한 2 : 상승 3 : 보합 4 : 하한 5 : 하락
            let LWPR_VRSS_PRPR_SIGN: String
            /// 저가대비
            let LWPR_VRSS_PRPR: Decimal
            /// 영업 일자
            let BSOP_DATE: String
            /// 신 장운영 구분 코드
            /// (1) 첫 번째 비트 1 : 장개시전 2 : 장중 3 : 장종료후 4 : 시간외단일가 7 : 일반Buy-in 8 : 당일Buy-in (2) 두 번째 비트 0 : 보통 1 : 종가 2 : 대량 3 : 바스켓 7 : 정리매매 8 : Buy-in
            let NEW_MKOP_CLS_CODE: String
            /// 거래정지 여부
            /// Y : 정지 N : 정상거래
            let TRHT_YN: String
            /// 매도호가 잔량1
            let ASKP_RSQN1: Decimal
            /// 매수호가 잔량1
            let BIDP_RSQN1: Decimal
            /// 총 매도호가 잔량
            let TOTAL_ASKP_RSQN: Decimal
            /// 총 매수호가 잔량
            let TOTAL_BIDP_RSQN: Decimal
            /// 거래량 회전율
            let VOL_TNRT: Decimal
            /// 전일 동시간 누적 거래량
            let PRDY_SMNS_HOUR_ACML_VOL: Decimal
            /// 전일 동시간 누적 거래량 비율
            let PRDY_SMNS_HOUR_ACML_VOL_RATE: Decimal
            /// 시간 구분 코드
            /// 0 : 장중 A : 장후예상 B : 장전예상 C : 9시이후의 예상가, VI발동 D : 시간외 단일가 예상
            let HOUR_CLS_CODE: String
            /// 임의종료구분코드
            let MRKT_TRTM_CLS_CODE: String
            /// 정적VI발동기준가
            let VI_STND_PRC: Decimal
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_실시간호가_KRX : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "ws://ops.koreainvestment.com:31000") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0STASP0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객타입
            /// B : 법인 P : 개인
            let custtype: String
            /// 거래타입
            /// 1 : 등록 2 : 해제
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
            /// [실전/모의투자] H0STASP0 : 주식호가
            let tr_id: String
            /// 구분값
            /// 종목번호 (6자리) ETN의 경우, Q로 시작 (EX. Q500001)
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 유가증권 단축 종목코드
            let MKSC_SHRN_ISCD: String
            /// 영업 시간
            let BSOP_HOUR: String
            /// 시간 구분 코드
            /// 0 : 장중 A : 장후예상 B : 장전예상 C : 9시이후의 예상가, VI발동 D : 시간외 단일가 예상
            let HOUR_CLS_CODE: String
            /// 매도호가1
            let ASKP1: Decimal
            /// 매도호가2
            let ASKP2: Decimal
            /// 매도호가3
            let ASKP3: Decimal
            /// 매도호가4
            let ASKP4: Decimal
            /// 매도호가5
            let ASKP5: Decimal
            /// 매도호가6
            let ASKP6: Decimal
            /// 매도호가7
            let ASKP7: Decimal
            /// 매도호가8
            let ASKP8: Decimal
            /// 매도호가9
            let ASKP9: Decimal
            /// 매도호가10
            let ASKP10: Decimal
            /// 매수호가1
            let BIDP1: Decimal
            /// 매수호가2
            let BIDP2: Decimal
            /// 매수호가3
            let BIDP3: Decimal
            /// 매수호가4
            let BIDP4: Decimal
            /// 매수호가5
            let BIDP5: Decimal
            /// 매수호가6
            let BIDP6: Decimal
            /// 매수호가7
            let BIDP7: Decimal
            /// 매수호가8
            let BIDP8: Decimal
            /// 매수호가9
            let BIDP9: Decimal
            /// 매수호가10
            let BIDP10: Decimal
            /// 매도호가 잔량1
            let ASKP_RSQN1: Decimal
            /// 매도호가 잔량2
            let ASKP_RSQN2: Decimal
            /// 매도호가 잔량3
            let ASKP_RSQN3: Decimal
            /// 매도호가 잔량4
            let ASKP_RSQN4: Decimal
            /// 매도호가 잔량5
            let ASKP_RSQN5: Decimal
            /// 매도호가 잔량6
            let ASKP_RSQN6: Decimal
            /// 매도호가 잔량7
            let ASKP_RSQN7: Decimal
            /// 매도호가 잔량8
            let ASKP_RSQN8: Decimal
            /// 매도호가 잔량9
            let ASKP_RSQN9: Decimal
            /// 매도호가 잔량10
            let ASKP_RSQN10: Decimal
            /// 매수호가 잔량1
            let BIDP_RSQN1: Decimal
            /// 매수호가 잔량2
            let BIDP_RSQN2: Decimal
            /// 매수호가 잔량3
            let BIDP_RSQN3: Decimal
            /// 매수호가 잔량4
            let BIDP_RSQN4: Decimal
            /// 매수호가 잔량5
            let BIDP_RSQN5: Decimal
            /// 매수호가 잔량6
            let BIDP_RSQN6: Decimal
            /// 매수호가 잔량7
            let BIDP_RSQN7: Decimal
            /// 매수호가 잔량8
            let BIDP_RSQN8: Decimal
            /// 매수호가 잔량9
            let BIDP_RSQN9: Decimal
            /// 매수호가 잔량10
            let BIDP_RSQN10: Decimal
            /// 총 매도호가 잔량
            let TOTAL_ASKP_RSQN: Decimal
            /// 총 매수호가 잔량
            let TOTAL_BIDP_RSQN: Decimal
            /// 시간외 총 매도호가 잔량
            let OVTM_TOTAL_ASKP_RSQN: Decimal
            /// 시간외 총 매수호가 잔량
            let OVTM_TOTAL_BIDP_RSQN: Decimal
            /// 예상 체결가
            /// 동시호가 등 특정 조건하에서만 발생
            let ANTC_CNPR: Decimal
            /// 예상 체결량
            /// 동시호가 등 특정 조건하에서만 발생
            let ANTC_CNQN: Decimal
            /// 예상 거래량
            /// 동시호가 등 특정 조건하에서만 발생
            let ANTC_VOL: Decimal
            /// 예상 체결 대비
            /// 동시호가 등 특정 조건하에서만 발생
            let ANTC_CNTG_VRSS: Decimal
            /// 예상 체결 대비 부호
            /// 동시호가 등 특정 조건하에서만 발생 1 : 상한 2 : 상승 3 : 보합 4 : 하한 5 : 하락
            let ANTC_CNTG_VRSS_SIGN: String
            /// 예상 체결 전일 대비율
            let ANTC_CNTG_PRDY_CTRT: Decimal
            /// 누적 거래량
            let ACML_VOL: Decimal
            /// 총 매도호가 잔량 증감
            let TOTAL_ASKP_RSQN_ICDC: Decimal
            /// 총 매수호가 잔량 증감
            let TOTAL_BIDP_RSQN_ICDC: Decimal
            /// 시간외 총 매도호가 증감
            let OVTM_TOTAL_ASKP_ICDC: Decimal
            /// 시간외 총 매수호가 증감
            let OVTM_TOTAL_BIDP_ICDC: Decimal
            /// 주식 매매 구분 코드
            /// 사용 X (삭제된 값)
            let STCK_DEAL_CLS_CODE: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_실시간체결통보 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "ws://ops.koreainvestment.com:31000") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0STCNI0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객 타입
            /// B : 법인 P : 개인
            let custtype: String
            /// 거래타입
            /// 1: 등록 2 : 해제
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
            /// '[실전/모의투자] H0STCNI0 : 국내주식 실시간체결통보 H0STCNI9 : 모의투자 실시간 체결통보
            let TR_ID: String
            /// 구분값
            /// HTS ID
            let TR_KEY: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 고객 ID
            let CUST_ID: String
            /// 계좌번호
            let ACNT_NO: String
            /// 주문번호
            let ODER_NO: String
            /// 원주문번호
            let OODER_NO: String
            /// 매도매수구분
            let SELN_BYOV_CLS: String
            /// 정정구분
            let RCTF_CLS: String
            /// 주문종류
            let ODER_KIND: String
            /// 주문조건
            let ODER_COND: String
            /// 주식 단축 종목코드
            let STCK_SHRN_ISCD: String
            /// 체결 수량
            let CNTG_QTY: String
            /// 체결단가
            let CNTG_UNPR: String
            /// 주식 체결 시간
            let STCK_CNTG_HOUR: String
            /// 거부여부
            let RFUS_YN: String
            /// 체결여부
            let CNTG_YN: String
            /// 접수여부
            let ACPT_YN: String
            /// 지점번호
            let BRNC_NO: String
            /// 주문수량
            let ODER_QTY: String
            /// 계좌명
            let ACNT_NAME: String
            /// 호가조건가격
            /// 스톱지정가 시 표시
            let ORD_COND_PRC: String
            /// 주문거래소 구분
            /// 1:KRX, 2:NXT, 3:SOR-KRX, 4:SOR-NXT
            let ORD_EXG_GB: String
            /// 실시간체결창 표시여부
            /// Y/N
            let POPUP_YN: String
            /// 필러
            let FILLER: String
            /// 신용구분
            let CRDT_CLS: String
            /// 신용대출일자
            let CRDT_LOAN_DATE: String
            /// 체결종목명
            let CNTG_ISNM40: String
            /// 주문가격
            let ODER_PRC: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내지수_실시간체결 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0UPCNT0"
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
            /// H0UPCNT0
            let tr_id: String
            /// 종목코드
            /// 업종구분코드
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 업종 구분 코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let bstp_cls_code: String
            /// 영업 시간
            let bsop_hour: String
            /// 현재가 지수
            let prpr_nmix: String
            /// 전일 대비 부호
            let prdy_vrss_sign: String
            /// 업종 지수 전일 대비
            let bstp_nmix_prdy_vrss: String
            /// 누적 거래량
            let acml_vol: String
            /// 누적 거래 대금
            let acml_tr_pbmn: String
            /// 건별 거래량
            let pcas_vol: String
            /// 건별 거래 대금
            let pcas_tr_pbmn: String
            /// 전일 대비율
            let prdy_ctrt: String
            /// 시가 지수
            let oprc_nmix: String
            /// 지수 최고가
            let nmix_hgpr: String
            /// 지수 최저가
            let nmix_lwpr: String
            /// 시가 대비 지수 현재가
            let oprc_vrss_nmix_prpr: String
            /// 시가 대비 지수 부호
            let oprc_vrss_nmix_sign: String
            /// 최고가 대비 지수 현재가
            let hgpr_vrss_nmix_prpr: String
            /// 최고가 대비 지수 부호
            let hgpr_vrss_nmix_sign: String
            /// 최저가 대비 지수 현재가
            let lwpr_vrss_nmix_prpr: String
            /// 최저가 대비 지수 부호
            let lwpr_vrss_nmix_sign: String
            /// 전일 종가 대비 시가2 비율
            let prdy_clpr_vrss_oprc_rate: String
            /// 전일 종가 대비 최고가 비율
            let prdy_clpr_vrss_hgpr_rate: String
            /// 전일 종가 대비 최저가 비율
            let prdy_clpr_vrss_lwpr_rate: String
            /// 상한 종목 수
            let uplm_issu_cnt: String
            /// 상승 종목 수
            let ascn_issu_cnt: String
            /// 보합 종목 수
            let stnr_issu_cnt: String
            /// 하락 종목 수
            let down_issu_cnt: String
            /// 하한 종목 수
            let lslm_issu_cnt: String
            /// 기세 상승 종목수
            let qtqt_ascn_issu_cnt: String
            /// 기세 하락 종목수
            let qtqt_down_issu_cnt: String
            /// TICK대비
            let tick_vrss: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내지수_실시간예상체결 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0UPANC0"
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
            /// H0UPANC0
            let tr_id: String
            /// 종목코드
            /// 업종구분코드
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 업종 구분 코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let bstp_cls_code: String
        }
        struct BSTP_CLS_CODE : Codable {
            /// 영업 시간
            let bsop_hour: String
            /// 현재가 지수
            let prpr_nmix: String
            /// 전일 대비 부호
            let prdy_vrss_sign: String
            /// 업종 지수 전일 대비
            let bstp_nmix_prdy_vrss: String
            /// 누적 거래량
            let acml_vol: String
            /// 누적 거래 대금
            let acml_tr_pbmn: String
            /// 건별 거래량
            let pcas_vol: String
            /// 건별 거래 대금
            let pcas_tr_pbmn: String
            /// 전일 대비율
            let prdy_ctrt: String
            /// 시가 지수
            let oprc_nmix: String
            /// 지수 최고가
            let nmix_hgpr: String
            /// 지수 최저가
            let nmix_lwpr: String
            /// 시가 대비 지수 현재가
            let oprc_vrss_nmix_prpr: String
            /// 시가 대비 지수 부호
            let oprc_vrss_nmix_sign: String
            /// 최고가 대비 지수 현재가
            let hgpr_vrss_nmix_prpr: String
            /// 최고가 대비 지수 부호
            let hgpr_vrss_nmix_sign: String
            /// 최저가 대비 지수 현재가
            let lwpr_vrss_nmix_prpr: String
            /// 최저가 대비 지수 부호
            let lwpr_vrss_nmix_sign: String
            /// 전일 종가 대비 시가2 비율
            let prdy_clpr_vrss_oprc_rate: String
            /// 전일 종가 대비 최고가 비율
            let prdy_clpr_vrss_hgpr_rate: String
            /// 전일 종가 대비 최저가 비율
            let prdy_clpr_vrss_lwpr_rate: String
            /// 상한 종목 수
            let uplm_issu_cnt: String
            /// 상승 종목 수
            let ascn_issu_cnt: String
            /// 보합 종목 수
            let stnr_issu_cnt: String
            /// 하락 종목 수
            let down_issu_cnt: String
            /// 하한 종목 수
            let lslm_issu_cnt: String
            /// 기세 상승 종목수
            let qtqt_ascn_issu_cnt: String
            /// 기세 하락 종목수
            let qtqt_down_issu_cnt: String
            /// TICK대비
            let tick_vrss: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내지수_실시간프로그램매매 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0UPPGM0"
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
            /// H0UPPGM0
            let tr_id: String
            /// 종목코드
            /// 업종구분코드
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 업종 구분 코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let bstp_cls_code: String
        }
        struct BSTP_CLS_CODE : Codable {
            /// 영업 시간
            let bsop_hour: String
            /// 차익 매도 위탁 체결량
            let arbt_seln_entm_cnqn: String
            /// 차익 매도 자기 체결량
            let arbt_seln_onsl_cnqn: String
            /// 차익 매수2 위탁 체결량
            let arbt_shnu_entm_cnqn: String
            /// 차익 매수2 자기 체결량
            let arbt_shnu_onsl_cnqn: String
            /// 비차익 매도 위탁 체결량
            let nabt_seln_entm_cnqn: String
            /// 비차익 매도 자기 체결량
            let nabt_seln_onsl_cnqn: String
            /// 비차익 매수2 위탁 체결량
            let nabt_shnu_entm_cnqn: String
            /// 비차익 매수2 자기 체결량
            let nabt_shnu_onsl_cnqn: String
            /// 차익 매도 위탁 체결 금액
            let arbt_seln_entm_cntg_amt: String
            /// 차익 매도 자기 체결 금액
            let arbt_seln_onsl_cntg_amt: String
            /// 차익 매수2 위탁 체결 금액
            let arbt_shnu_entm_cntg_amt: String
            /// 차익 매수2 자기 체결 금액
            let arbt_shnu_onsl_cntg_amt: String
            /// 비차익 매도 위탁 체결 금액
            let nabt_seln_entm_cntg_amt: String
            /// 비차익 매도 자기 체결 금액
            let nabt_seln_onsl_cntg_amt: String
            /// 비차익 매수2 위탁 체결 금액
            let nabt_shnu_entm_cntg_amt: String
            /// 비차익 매수2 자기 체결 금액
            let nabt_shnu_onsl_cntg_amt: String
            /// 차익 합계 매도 거래량
            let arbt_smtn_seln_vol: String
            /// 차익 합계 매도 거래량 비율
            let arbt_smtm_seln_vol_rate: String
            /// 차익 합계 매도 거래 대금
            let arbt_smtn_seln_tr_pbmn: String
            /// 차익 합계 매도 거래대금 비율
            let arbt_smtm_seln_tr_pbmn_rate: String
            /// 차익 합계 매수2 거래량
            let arbt_smtn_shnu_vol: String
            /// 차익 합계 매수 거래량 비율
            let arbt_smtm_shnu_vol_rate: String
            /// 차익 합계 매수2 거래 대금
            let arbt_smtn_shnu_tr_pbmn: String
            /// 차익 합계 매수 거래대금 비율
            let arbt_smtm_shnu_tr_pbmn_rate: String
            /// 차익 합계 순매수 수량
            let arbt_smtn_ntby_qty: String
            /// 차익 합계 순매수 수량 비율
            let arbt_smtm_ntby_qty_rate: String
            /// 차익 합계 순매수 거래 대금
            let arbt_smtn_ntby_tr_pbmn: String
            /// 차익 합계 순매수 거래대금 비율
            let arbt_smtm_ntby_tr_pbmn_rate: String
            /// 비차익 합계 매도 거래량
            let nabt_smtn_seln_vol: String
            /// 비차익 합계 매도 거래량 비율
            let nabt_smtm_seln_vol_rate: String
            /// 비차익 합계 매도 거래 대금
            let nabt_smtn_seln_tr_pbmn: String
            /// 비차익 합계 매도 거래대금 비율
            let nabt_smtm_seln_tr_pbmn_rate: String
            /// 비차익 합계 매수2 거래량
            let nabt_smtn_shnu_vol: String
            /// 비차익 합계 매수 거래량 비율
            let nabt_smtm_shnu_vol_rate: String
            /// 비차익 합계 매수2 거래 대금
            let nabt_smtn_shnu_tr_pbmn: String
            /// 비차익 합계 매수 거래대금 비율
            let nabt_smtm_shnu_tr_pbmn_rate: String
            /// 비차익 합계 순매수 수량
            let nabt_smtn_ntby_qty: String
            /// 비차익 합계 순매수 수량 비율
            let nabt_smtm_ntby_qty_rate: String
            /// 비차익 합계 순매수 거래 대금
            let nabt_smtn_ntby_tr_pbmn: String
            /// 비차익 합계 순매수 거래대금 비
            let nabt_smtm_ntby_tr_pbmn_rate: String
            /// 전체 위탁 매도 거래량
            let whol_entm_seln_vol: String
            /// 위탁 매도 거래량 비율
            let entm_seln_vol_rate: String
            /// 전체 위탁 매도 거래 대금
            let whol_entm_seln_tr_pbmn: String
            /// 위탁 매도 거래대금 비율
            let entm_seln_tr_pbmn_rate: String
            /// 전체 위탁 매수2 거래량
            let whol_entm_shnu_vol: String
            /// 위탁 매수 거래량 비율
            let entm_shnu_vol_rate: String
            /// 전체 위탁 매수2 거래 대금
            let whol_entm_shnu_tr_pbmn: String
            /// 위탁 매수 거래대금 비율
            let entm_shnu_tr_pbmn_rate: String
            /// 전체 위탁 순매수 수량
            let whol_entm_ntby_qt: String
            /// 위탁 순매수 수량 비율
            let entm_ntby_qty_rat: String
            /// 전체 위탁 순매수 거래 대금
            let whol_entm_ntby_tr_pbmn: String
            /// 위탁 순매수 금액 비율
            let entm_ntby_tr_pbmn_rate: String
            /// 전체 자기 매도 거래량
            let whol_onsl_seln_vol: String
            /// 자기 매도 거래량 비율
            let onsl_seln_vol_rate: String
            /// 전체 자기 매도 거래 대금
            let whol_onsl_seln_tr_pbmn: String
            /// 자기 매도 거래대금 비율
            let onsl_seln_tr_pbmn_rate: String
            /// 전체 자기 매수2 거래량
            let whol_onsl_shnu_vol: String
            /// 자기 매수 거래량 비율
            let onsl_shnu_vol_rate: String
            /// 전체 자기 매수2 거래 대금
            let whol_onsl_shnu_tr_pbmn: String
            /// 자기 매수 거래대금 비율
            let onsl_shnu_tr_pbmn_rate: String
            /// 전체 자기 순매수 수량
            let whol_onsl_ntby_qty: String
            /// 자기 순매수량 비율
            let onsl_ntby_qty_rate: String
            /// 전체 자기 순매수 거래 대금
            let whol_onsl_ntby_tr_pbmn: String
            /// 자기 순매수 대금 비율
            let onsl_ntby_tr_pbmn_rate: String
            /// 총 매도 수량
            let total_seln_qty: String
            /// 전체 매도 거래량 비율
            let whol_seln_vol_rate: String
            /// 총 매도 거래 대금
            let total_seln_tr_pbmn: String
            /// 전체 매도 거래대금 비율
            let whol_seln_tr_pbmn_rate: String
            /// 총 매수 수량
            let shnu_cntg_smtn: String
            /// 전체 매수 거래량 비율
            let whol_shun_vol_rate: String
            /// 총 매수2 거래 대금
            let total_shnu_tr_pbmn: String
            /// 전체 매수 거래대금 비율
            let whol_shun_tr_pbmn_rate: String
            /// 전체 순매수 수량
            let whol_ntby_qty: String
            /// 전체 합계 순매수 수량 비율
            let whol_smtm_ntby_qty_rate: String
            /// 전체 순매수 거래 대금
            let whol_ntby_tr_pbmn: String
            /// 전체 순매수 거래대금 비율
            let whol_ntby_tr_pbmn_rate: String
            /// 차익 위탁 순매수 수량
            let arbt_entm_ntby_qty: String
            /// 차익 위탁 순매수 거래 대금
            let arbt_entm_ntby_tr_pbmn: String
            /// 차익 자기 순매수 수량
            let arbt_onsl_ntby_qty: String
            /// 차익 자기 순매수 거래 대금
            let arbt_onsl_ntby_tr_pbmn: String
            /// 비차익 위탁 순매수 수량
            let nabt_entm_ntby_qty: String
            /// 비차익 위탁 순매수 거래 대금
            let nabt_entm_ntby_tr_pbmn: String
            /// 비차익 자기 순매수 수량
            let nabt_onsl_ntby_qty: String
            /// 비차익 자기 순매수 거래 대금
            let nabt_onsl_ntby_tr_pbmn: String
            /// 누적 거래량
            let acml_vol: String
            /// 누적 거래 대금
            let acml_tr_pbmn: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_실시간회원사_KRX : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0STMBC0"
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
            /// H0STMBC0
            let tr_id: String
            /// 종목코드
            /// 종목코드
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 유가증권단축종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let mksc_shrn_iscd: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 매도2회원사명1
            let seln2_mbcr_name1: String
            /// 매도2회원사명2
            let seln2_mbcr_name2: String
            /// 매도2회원사명3
            let seln2_mbcr_name3: String
            /// 매도2회원사명4
            let seln2_mbcr_name4: String
            /// 매도2회원사명5
            let seln2_mbcr_name5: String
            /// 매수회원사명1
            let byov_mbcr_name1: String
            /// 매수회원사명2
            let byov_mbcr_name2: String
            /// 매수회원사명3
            let byov_mbcr_name3: String
            /// 매수회원사명4
            let byov_mbcr_name4: String
            /// 매수회원사명5
            let byov_mbcr_name5: String
            /// 총매도수량1
            let total_seln_qty1: String
            /// 총매도수량2
            let total_seln_qty2: String
            /// 총매도수량3
            let total_seln_qty3: String
            /// 총매도수량4
            let total_seln_qty4: String
            /// 총매도수량5
            let total_seln_qty5: String
            /// 총매수2수량1
            let total_shnu_qty1: String
            /// 총매수2수량2
            let total_shnu_qty2: String
            /// 총매수2수량3
            let total_shnu_qty3: String
            /// 총매수2수량4
            let total_shnu_qty4: String
            /// 총매수2수량5
            let total_shnu_qty5: String
            /// 매도거래원구분1
            let seln_mbcr_glob_yn_1: String
            /// 매도거래원구분2
            let seln_mbcr_glob_yn_2: String
            /// 매도거래원구분3
            let seln_mbcr_glob_yn_3: String
            /// 매도거래원구분4
            let seln_mbcr_glob_yn_4: String
            /// 매도거래원구분5
            let seln_mbcr_glob_yn_5: String
            /// 매수거래원구분1
            let shnu_mbcr_glob_yn_1: String
            /// 매수거래원구분2
            let shnu_mbcr_glob_yn_2: String
            /// 매수거래원구분3
            let shnu_mbcr_glob_yn_3: String
            /// 매수거래원구분4
            let shnu_mbcr_glob_yn_4: String
            /// 매수거래원구분5
            let shnu_mbcr_glob_yn_5: String
            /// 매도거래원코드1
            let seln_mbcr_no1: String
            /// 매도거래원코드2
            let seln_mbcr_no2: String
            /// 매도거래원코드3
            let seln_mbcr_no3: String
            /// 매도거래원코드4
            let seln_mbcr_no4: String
            /// 매도거래원코드5
            let seln_mbcr_no5: String
            /// 매수거래원코드1
            let shnu_mbcr_no1: String
            /// 매수거래원코드2
            let shnu_mbcr_no2: String
            /// 매수거래원코드3
            let shnu_mbcr_no3: String
            /// 매수거래원코드4
            let shnu_mbcr_no4: String
            /// 매수거래원코드5
            let shnu_mbcr_no5: String
            /// 매도회원사비중1
            let seln_mbcr_rlim1: String
            /// 매도회원사비중2
            let seln_mbcr_rlim2: String
            /// 매도회원사비중3
            let seln_mbcr_rlim3: String
            /// 매도회원사비중4
            let seln_mbcr_rlim4: String
            /// 매도회원사비중5
            let seln_mbcr_rlim5: String
            /// 매수2회원사비중1
            let shnu_mbcr_rlim1: String
            /// 매수2회원사비중2
            let shnu_mbcr_rlim2: String
            /// 매수2회원사비중3
            let shnu_mbcr_rlim3: String
            /// 매수2회원사비중4
            let shnu_mbcr_rlim4: String
            /// 매수2회원사비중5
            let shnu_mbcr_rlim5: String
            /// 매도수량증감1
            let seln_qty_icdc1: String
            /// 매도수량증감2
            let seln_qty_icdc2: String
            /// 매도수량증감3
            let seln_qty_icdc3: String
            /// 매도수량증감4
            let seln_qty_icdc4: String
            /// 매도수량증감5
            let seln_qty_icdc5: String
            /// 매수2수량증감1
            let shnu_qty_icdc1: String
            /// 매수2수량증감2
            let shnu_qty_icdc2: String
            /// 매수2수량증감3
            let shnu_qty_icdc3: String
            /// 매수2수량증감4
            let shnu_qty_icdc4: String
            /// 매수2수량증감5
            let shnu_qty_icdc5: String
            /// 외국계총매도수량
            let glob_total_seln_qty: String
            /// 외국계총매수2수량
            let glob_total_shnu_qty: String
            /// 외국계총매도수량증감
            let glob_total_seln_qty_icdc: String
            /// 외국계총매수2수량증감
            let glob_total_shnu_qty_icdc: String
            /// 외국계순매수수량
            let glob_ntby_qty: String
            /// 외국계매도비중
            let glob_seln_rlim: String
            /// 외국계매수2비중
            let glob_shnu_rlim: String
            /// 매도2영문회원사명1
            let seln2_mbcr_eng_name1: String
            /// 매도2영문회원사명2
            let seln2_mbcr_eng_name2: String
            /// 매도2영문회원사명3
            let seln2_mbcr_eng_name3: String
            /// 매도2영문회원사명4
            let seln2_mbcr_eng_name4: String
            /// 매도2영문회원사명5
            let seln2_mbcr_eng_name5: String
            /// 매수영문회원사명1
            let byov_mbcr_eng_name1: String
            /// 매수영문회원사명2
            let byov_mbcr_eng_name2: String
            /// 매수영문회원사명3
            let byov_mbcr_eng_name3: String
            /// 매수영문회원사명4
            let byov_mbcr_eng_name4: String
            /// 매수영문회원사명5
            let byov_mbcr_eng_name5: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_실시간프로그램매매_KRX : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0STPGM0"
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
            /// H0STPGM0
            let tr_id: String
            /// 종목코드
            /// 종목코드
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 유가증권단축종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let mksc_shrn_iscd: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 주식체결시간
            let stck_cntg_hour: String
            /// 매도체결량
            let seln_cnqn: String
            /// 매도거래대금
            let seln_tr_pbmn: String
            /// 매수2체결량
            let shnu_cnqn: String
            /// 매수2거래대금
            let shnu_tr_pbmn: String
            /// 순매수체결량
            let ntby_cnqn: String
            /// 순매수거래대금
            let ntby_tr_pbmn: String
            /// 매도호가잔량
            let seln_rsqn: String
            /// 매수호가잔량
            let shnu_rsqn: String
            /// 전체순매수호가잔량
            let whol_ntby_qty: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_장운영정보_KRX : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0STMKO0"
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
            /// H0STMKO0
            let tr_id: String
            /// 종목코드
            /// 종목코드
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 유가증권단축종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let mksc_shrn_iscd: String
            /// 거래소구분코드
            let EXCH_CLS_CODE: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 거래정지여부
            let trht_yn: String
            /// 거래정지사유내용
            let tr_susp_reas_cntt: String
            /// 장운영구분코드
            /// 110  장전 동시호가 개시      112  장개시         121  장후 동시호가 개시      129  장마감         130  장개시전시간외개시      139  장개시전시간외종료      140  시간외 종가 매매 개시     146  장종료후시간외 체결지시     149  시간외 종가 매매 종료     150  시간외 단일가 매매 개시     156  시간외단일가 체결지시     159  시간외 단일가 매매 종료     164  시장임시정지        174  서킷브레이크 발동      175  서킷브레이크 해제      182  서킷브레이크 장중동시마감    184  서킷브레이크 개시      185  서킷브레이크 해제      387  사이드카 매도발동      388  사이드카 매도발동해제     397  사이드카 매수발동      398  사이드카 매수발동해제     ???  단일가개시        ???  서킷브레이크 단일가접수     F01  장개시 10초전       F06  장개시 1분전        F07  장개시 5분전        F08  장개시 10분전       F09  장개시 3분전        F11  장마감 10초전       F16  장마감 1분전        F17  장마감 5분전        F18  장마감 3분전        P01  장개시 10초전       P06  장개시 1분전        P07  장개시 5분전        P08  장개시 10분전       P09  장개시 30분전       P11  장마감 10초전       P16  장마감 1분전        P17  장마감 5분전        P18  장마감 3분전
            let mkop_cls_code: String
            /// 예상장운영구분코드
            /// 112 장전예상종료 121 장후예상시작 129 장후예상종료 311 장전예상시작
            let antc_mkop_cls_code: String
            /// 임의연장구분코드
            /// 1 시초동시 임의종료 지정 2 시초동시 임의종료 해제 3 마감동시 임의종료 지정 4 마감동시 임의종료 해제 5 시간외단일가임의종료 지정 6 시간외단일가임의종료 해제
            let mrkt_trtm_cls_code: String
            /// 동시호가배분처리구분코드
            /// divi_app_cls_code[0] 1: 배분개시 2: 배분해제 divi_app_cls_code[1] 1: 매수상한 2: 매수하한 3: 매도상한 4: 매도하한
            let divi_app_cls_code: String
            /// 종목상태구분코드
            /// 51 관리종목 지정 종목 52 시장경고 구분이 '투자위험'인 종목 53 시장경고 구분이 '투자경고'인 종목 54 시장경고 구분이 '투자주의'인 종목 55 당사 신용가능 종목 57 당사 증거금률이 100인 종목 58 거래정지 지정된 종목 59 단기과열종목으로 지정되거나 지정 연장된 종목 00 그 외 종목
            let iscd_stat_cls_code: String
            /// VI적용구분코드
            /// Y VI적용된 종목 N VI적용되지 않은 종목
            let vi_cls_code: String
            /// 시간외단일가VI적용구분코드
            /// Y 시간외단일가VI 적용된 종목 N 시간외단일가VI 적용되지 않은 종목
            let ovtm_vi_cls_code: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_실시간예상체결_KRX : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0STANC0"
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
            /// H0STANC0
            let tr_id: String
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
                    "tr_id",
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
                self.tr_id = headers["tr_id"] ?? ""
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
            /// 유가증권 단축 종목코드
            let MKSC_SHRN_ISCD: String
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
                case tr_id, tr_cont, gt_uid
                case content_type = "Content-Type"
            }
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct ELW_실시간체결가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0EWCNT0"
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
            /// H0EWCNT0
            let tr_id: String
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
                    "tr_id",
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
                self.tr_id = headers["tr_id"] ?? ""
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
            /// 유가증권 단축 종목코드
            let MKSC_SHRN_ISCD: String
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
                case tr_id, tr_cont, gt_uid
                case content_type = "Content-Type"
            }
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct ELW_실시간호가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0EWASP0"
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
            /// H0EWASP0
            let tr_id: String
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
                    "tr_id",
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
                self.tr_id = headers["tr_id"] ?? ""
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
            /// 유가증권 단축 종목코드
            /// ELW 종목코드(ex. 57JN53)
            let MKSC_SHRN_ISCD: String
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
                case tr_id, tr_cont, gt_uid
                case content_type = "Content-Type"
            }
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_시간외_실시간체결가_KRX : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0STOUP0"
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
            /// H0STOUP0
            let tr_id: String
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
                    "tr_id",
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
                self.tr_id = headers["tr_id"] ?? ""
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
            /// 유가증권 단축 종목코드
            /// ex. 005930
            let MKSC_SHRN_ISCD: String
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
                case tr_id, tr_cont, gt_uid
                case content_type = "Content-Type"
            }
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_시간외_실시간예상체결_KRX : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0STOAC0"
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
            /// H0STOAC0
            let tr_id: String
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
                    "tr_id",
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
                self.tr_id = headers["tr_id"] ?? ""
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
            /// 유가증권 단축 종목코드
            let MKSC_SHRN_ISCD: String
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
                case tr_id, tr_cont, gt_uid
                case content_type = "Content-Type"
            }
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_시간외_실시간호가_KRX : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0STOAA0"
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
            /// H0STOAA0
            let tr_id: String
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
                    "tr_id",
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
                self.tr_id = headers["tr_id"] ?? ""
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
            /// 유가증권 단축 종목코드
            let MKSC_SHRN_ISCD: String
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
                case tr_id, tr_cont, gt_uid
                case content_type = "Content-Type"
            }
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct ELW_실시간예상체결 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0EWANC0"
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
            /// H0EWANC0
            let tr_id: String
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
                    "tr_id",
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
                self.tr_id = headers["tr_id"] ?? ""
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
            /// 유가증권 단축 종목코드
            let MKSC_SHRN_ISCD: String
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
                case tr_id, tr_cont, gt_uid
                case content_type = "Content-Type"
            }
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내ETF_NAV추이 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0STNAV0"
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
            /// H0STNAV0
            let tr_id: String
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
                    "tr_id",
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
                self.tr_id = headers["tr_id"] ?? ""
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
            /// 유가증권 단축 종목코드
            /// 국내ETF 종목코드 입력(ex. 069500)
            let MKSC_SHRN_ISCD: String
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
                case tr_id, tr_cont, gt_uid
                case content_type = "Content-Type"
            }
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_실시간체결가_통합 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0UNCNT0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객타입
            /// B : 법인 P : 개인
            let custtype: String
            /// 거래타입
            /// 1 : 등록 2 : 해제
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
            /// '[실전/모의투자] H0UNCNT0 : 실시간 주식 체결가 통합'
            let TR_ID: String
            /// 구분값
            /// 종목코드 (ex 005930 삼성전자)
            let TR_KEY: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 유가증권 단축 종목코드
            let MKSC_SHRN_ISCD: String
            /// 주식 체결 시간
            let STCK_CNTG_HOUR: String
            /// 주식 현재가
            let STCK_PRPR: String
            /// 전일 대비 부호
            let PRDY_VRSS_SIGN: String
            /// 전일 대비
            let PRDY_VRSS: String
            /// 전일 대비율
            let PRDY_CTRT: String
            /// 가중 평균 주식 가격
            let WGHN_AVRG_STCK_PRC: String
            /// 주식 시가
            let STCK_OPRC: String
            /// 주식 최고가
            let STCK_HGPR: String
            /// 주식 최저가
            let STCK_LWPR: String
            /// 매도호가1
            let ASKP1: String
            /// 매수호가1
            let BIDP1: String
            /// 체결 거래량
            let CNTG_VOL: String
            /// 누적 거래량
            let ACML_VOL: String
            /// 누적 거래 대금
            let ACML_TR_PBMN: String
            /// 매도 체결 건수
            let SELN_CNTG_CSNU: String
            /// 매수 체결 건수
            let SHNU_CNTG_CSNU: String
            /// 순매수 체결 건수
            let NTBY_CNTG_CSNU: String
            /// 체결강도
            let CTTR: String
            /// 총 매도 수량
            let SELN_CNTG_SMTN: String
            /// 총 매수 수량
            let SHNU_CNTG_SMTN: String
            /// 체결구분
            let CNTG_CLS_CODE: String
            /// 매수비율
            let SHNU_RATE: String
            /// 전일 거래량 대비 등락율
            let PRDY_VOL_VRSS_ACML_VOL_RATE: String
            /// 시가 시간
            let OPRC_HOUR: String
            /// 시가대비구분
            let OPRC_VRSS_PRPR_SIGN: String
            /// 시가대비
            let OPRC_VRSS_PRPR: String
            /// 최고가 시간
            let HGPR_HOUR: String
            /// 고가대비구분
            let HGPR_VRSS_PRPR_SIGN: String
            /// 고가대비
            let HGPR_VRSS_PRPR: String
            /// 최저가 시간
            let LWPR_HOUR: String
            /// 저가대비구분
            let LWPR_VRSS_PRPR_SIGN: String
            /// 저가대비
            let LWPR_VRSS_PRPR: String
            /// 영업 일자
            let BSOP_DATE: String
            /// 신 장운영 구분 코드
            let NEW_MKOP_CLS_CODE: String
            /// 거래정지 여부
            let TRHT_YN: String
            /// 매도호가 잔량1
            let ASKP_RSQN1: String
            /// 매수호가 잔량1
            let BIDP_RSQN1: String
            /// 총 매도호가 잔량
            let TOTAL_ASKP_RSQN: String
            /// 총 매수호가 잔량
            let TOTAL_BIDP_RSQN: String
            /// 거래량 회전율
            let VOL_TNRT: String
            /// 전일 동시간 누적 거래량
            let PRDY_SMNS_HOUR_ACML_VOL: String
            /// 전일 동시간 누적 거래량 비율
            let PRDY_SMNS_HOUR_ACML_VOL_RATE: String
            /// 시간 구분 코드
            let HOUR_CLS_CODE: String
            /// 임의종료구분코드
            let MRKT_TRTM_CLS_CODE: String
            /// 정적VI발동기준가
            let VI_STND_PRC: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_실시간호가_통합 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0UNASP0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객타입
            /// 'B : 법인 P : 개인'
            let custtype: String
            /// 거래타입
            /// '1 : 등록 2 : 해제'
            let tr_type: String
            /// 컨텐츠타입
            /// '    utf-8'
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
                self.content_type = "'    utf-8'"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// '[실전/모의투자] H0UNASP0 : 실시간 주식 체결가 통합'
            let TR_ID: String
            /// 구분값
            /// 종목코드 (ex 005930 삼성전자)
            let TR_KEY: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 유가증권 단축 종목코드
            let MKSC_SHRN_ISCD: String
            /// 영업 시간
            let BSOP_HOUR: String
            /// 시간 구분 코드
            let HOUR_CLS_CODE: String
            /// 매도호가1
            let ASKP1: String
            /// 매도호가2
            let ASKP2: String
            /// 매도호가3
            let ASKP3: String
            /// 매도호가4
            let ASKP4: String
            /// 매도호가5
            let ASKP5: String
            /// 매도호가6
            let ASKP6: String
            /// 매도호가7
            let ASKP7: String
            /// 매도호가8
            let ASKP8: String
            /// 매도호가9
            let ASKP9: String
            /// 매도호가10
            let ASKP10: String
            /// 매수호가1
            let BIDP1: String
            /// 매수호가2
            let BIDP2: String
            /// 매수호가3
            let BIDP3: String
            /// 매수호가4
            let BIDP4: String
            /// 매수호가5
            let BIDP5: String
            /// 매수호가6
            let BIDP6: String
            /// 매수호가7
            let BIDP7: String
            /// 매수호가8
            let BIDP8: String
            /// 매수호가9
            let BIDP9: String
            /// 매수호가10
            let BIDP10: String
            /// 매도호가 잔량1
            let ASKP_RSQN1: String
            /// 매도호가 잔량2
            let ASKP_RSQN2: String
            /// 매도호가 잔량3
            let ASKP_RSQN3: String
            /// 매도호가 잔량4
            let ASKP_RSQN4: String
            /// 매도호가 잔량5
            let ASKP_RSQN5: String
            /// 매도호가 잔량6
            let ASKP_RSQN6: String
            /// 매도호가 잔량7
            let ASKP_RSQN7: String
            /// 매도호가 잔량8
            let ASKP_RSQN8: String
            /// 매도호가 잔량9
            let ASKP_RSQN9: String
            /// 매도호가 잔량10
            let ASKP_RSQN10: String
            /// 매수호가 잔량1
            let BIDP_RSQN1: String
            /// 매수호가 잔량2
            let BIDP_RSQN2: String
            /// 매수호가 잔량3
            let BIDP_RSQN3: String
            /// 매수호가 잔량4
            let BIDP_RSQN4: String
            /// 매수호가 잔량5
            let BIDP_RSQN5: String
            /// 매수호가 잔량6
            let BIDP_RSQN6: String
            /// 매수호가 잔량7
            let BIDP_RSQN7: String
            /// 매수호가 잔량8
            let BIDP_RSQN8: String
            /// 매수호가 잔량9
            let BIDP_RSQN9: String
            /// 매수호가 잔량10
            let BIDP_RSQN10: String
            /// 총 매도호가 잔량
            let TOTAL_ASKP_RSQN: String
            /// 총 매수호가 잔량
            let TOTAL_BIDP_RSQN: String
            /// 시간외 총 매도호가 잔량
            let OVTM_TOTAL_ASKP_RSQN: String
            /// 시간외 총 매수호가 잔량
            let OVTM_TOTAL_BIDP_RSQN: String
            /// 예상 체결가
            let ANTC_CNPR: String
            /// 예상 체결량
            let ANTC_CNQN: String
            /// 예상 거래량
            let ANTC_VOL: String
            /// 예상 체결 대비
            let ANTC_CNTG_VRSS: String
            /// 예상 체결 대비 부호
            let ANTC_CNTG_VRSS_SIGN: String
            /// 예상 체결 전일 대비율
            let ANTC_CNTG_PRDY_CTRT: String
            /// 누적 거래량
            let ACML_VOL: String
            /// 총 매도호가 잔량 증감
            let TOTAL_ASKP_RSQN_ICDC: String
            /// 총 매수호가 잔량 증감
            let TOTAL_BIDP_RSQN_ICDC: String
            /// 시간외 총 매도호가 증감
            let OVTM_TOTAL_ASKP_ICDC: String
            /// 시간외 총 매수호가 증감
            let OVTM_TOTAL_BIDP_ICDC: String
            /// 주식 매매 구분 코드
            let STCK_DEAL_CLS_CODE: String
            /// KRX 중간가
            let KMID_PRC: String
            /// KRX 중간가잔량합계수량
            let KMID_TOTAL_RSQN: String
            /// KRX 중간가 매수매도 구분
            let KMID_CLS_CODE: String
            /// NXT 중간가
            let NMID_PRC: String
            /// NXT 중간가잔량합계수량
            let NMID_TOTAL_RSQN: String
            /// NXT 중간가 매수매도 구분
            let NMID_CLS_CODE: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_실시간프로그램매매_통합 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0UNPGM0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객타입
            /// 'B : 법인 P : 개인'
            let custtype: String
            /// 거래타입
            /// '1 : 등록 2 : 해제'
            let tr_type: String
            /// 컨텐츠타입
            /// '    utf-8'
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
                self.content_type = "'    utf-8'"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// '[실전/모의투자] H0UNPGM0 : 실시간 주식종목프로그램매매 통합'
            let TR_ID: String
            /// 구분값
            /// 종목코드 (ex 005930 삼성전자)
            let TR_KEY: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 유가증권 단축 종목코드
            let MKSC_SHRN_ISCD: String
            /// 주식 체결 시간
            let STCK_CNTG_HOUR: String
            /// 매도 체결량
            let SELN_CNQN: String
            /// 매도 거래 대금
            let SELN_TR_PBMN: String
            /// 매수2 체결량
            let SHNU_CNQN: String
            /// 매수2 거래 대금
            let SHNU_TR_PBMN: String
            /// 순매수 체결량
            let NTBY_CNQN: String
            /// 순매수 거래 대금
            let NTBY_TR_PBMN: String
            /// 매도호가잔량
            let SELN_RSQN: String
            /// 매수호가잔량
            let SHNU_RSQN: String
            /// 전체순매수호가잔량
            let WHOL_NTBY_QTY: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_실시간체결가_NXT : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0NXCNT0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객타입
            /// 'B : 법인 P : 개인'
            let custtype: String
            /// 거래타입
            /// '1 : 등록 2 : 해제'
            let tr_type: String
            /// 컨텐츠타입
            /// '    utf-8'
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
                self.content_type = "'    utf-8'"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// '[실전/모의투자] H0NXCNT0 : 주식종목체결 (NXT)'
            let TR_ID: String
            /// 구분값
            /// 종목코드 (ex 005930 삼성전자)
            let TR_KEY: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 유가증권 단축 종목코드
            let MKSC_SHRN_ISCD: String
            /// 주식 체결 시간
            let STCK_CNTG_HOUR: String
            /// 주식 현재가
            let STCK_PRPR: String
            /// 전일 대비 부호
            let PRDY_VRSS_SIGN: String
            /// 전일 대비
            let PRDY_VRSS: String
            /// 전일 대비율
            let PRDY_CTRT: String
            /// 가중 평균 주식 가격
            let WGHN_AVRG_STCK_PRC: String
            /// 주식 시가
            let STCK_OPRC: String
            /// 주식 최고가
            let STCK_HGPR: String
            /// 주식 최저가
            let STCK_LWPR: String
            /// 매도호가1
            let ASKP1: String
            /// 매수호가1
            let BIDP1: String
            /// 체결 거래량
            let CNTG_VOL: String
            /// 누적 거래량
            let ACML_VOL: String
            /// 누적 거래 대금
            let ACML_TR_PBMN: String
            /// 매도 체결 건수
            let SELN_CNTG_CSNU: String
            /// 매수 체결 건수
            let SHNU_CNTG_CSNU: String
            /// 순매수 체결 건수
            let NTBY_CNTG_CSNU: String
            /// 체결강도
            let CTTR: String
            /// 총 매도 수량
            let SELN_CNTG_SMTN: String
            /// 총 매수 수량
            let SHNU_CNTG_SMTN: String
            /// 체결구분
            let CNTG_CLS_CODE: String
            /// 매수비율
            let SHNU_RATE: String
            /// 전일 거래량 대비 등락율
            let PRDY_VOL_VRSS_ACML_VOL_RATE: String
            /// 시가 시간
            let OPRC_HOUR: String
            /// 시가대비구분
            let OPRC_VRSS_PRPR_SIGN: String
            /// 시가대비
            let OPRC_VRSS_PRPR: String
            /// 최고가 시간
            let HGPR_HOUR: String
            /// 고가대비구분
            let HGPR_VRSS_PRPR_SIGN: String
            /// 고가대비
            let HGPR_VRSS_PRPR: String
            /// 최저가 시간
            let LWPR_HOUR: String
            /// 저가대비구분
            let LWPR_VRSS_PRPR_SIGN: String
            /// 저가대비
            let LWPR_VRSS_PRPR: String
            /// 영업 일자
            let BSOP_DATE: String
            /// 신 장운영 구분 코드
            let NEW_MKOP_CLS_CODE: String
            /// 거래정지 여부
            let TRHT_YN: String
            /// 매도호가 잔량1
            let ASKP_RSQN1: String
            /// 매수호가 잔량1
            let BIDP_RSQN1: String
            /// 총 매도호가 잔량
            let TOTAL_ASKP_RSQN: String
            /// 총 매수호가 잔량
            let TOTAL_BIDP_RSQN: String
            /// 거래량 회전율
            let VOL_TNRT: String
            /// 전일 동시간 누적 거래량
            let PRDY_SMNS_HOUR_ACML_VOL: String
            /// 전일 동시간 누적 거래량 비율
            let PRDY_SMNS_HOUR_ACML_VOL_RATE: String
            /// 시간 구분 코드
            let HOUR_CLS_CODE: String
            /// 임의종료구분코드
            let MRKT_TRTM_CLS_CODE: String
            /// 정적VI발동기준가
            let VI_STND_PRC: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_실시간호가_NXT : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0NXASP0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객타입
            /// 'B : 법인 P : 개인'
            let custtype: String
            /// 거래타입
            /// '1 : 등록 2 : 해제'
            let tr_type: String
            /// 컨텐츠타입
            /// '    utf-8'
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
                self.content_type = "'    utf-8'"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// '[실전/모의투자] H0NXASP0 : 실시간 주식 호가 (NXT)'
            let TR_ID: String
            /// 구분값
            /// 종목코드 (ex 005930 삼성전자)
            let TR_KEY: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 유가증권 단축 종목코드
            let MKSC_SHRN_ISCD: String
            /// 영업 시간
            let BSOP_HOUR: String
            /// 시간 구분 코드
            let HOUR_CLS_CODE: String
            /// 매도호가1
            let ASKP1: String
            /// 매도호가2
            let ASKP2: String
            /// 매도호가3
            let ASKP3: String
            /// 매도호가4
            let ASKP4: String
            /// 매도호가5
            let ASKP5: String
            /// 매도호가6
            let ASKP6: String
            /// 매도호가7
            let ASKP7: String
            /// 매도호가8
            let ASKP8: String
            /// 매도호가9
            let ASKP9: String
            /// 매도호가10
            let ASKP10: String
            /// 매수호가1
            let BIDP1: String
            /// 매수호가2
            let BIDP2: String
            /// 매수호가3
            let BIDP3: String
            /// 매수호가4
            let BIDP4: String
            /// 매수호가5
            let BIDP5: String
            /// 매수호가6
            let BIDP6: String
            /// 매수호가7
            let BIDP7: String
            /// 매수호가8
            let BIDP8: String
            /// 매수호가9
            let BIDP9: String
            /// 매수호가10
            let BIDP10: String
            /// 매도호가 잔량1
            let ASKP_RSQN1: String
            /// 매도호가 잔량2
            let ASKP_RSQN2: String
            /// 매도호가 잔량3
            let ASKP_RSQN3: String
            /// 매도호가 잔량4
            let ASKP_RSQN4: String
            /// 매도호가 잔량5
            let ASKP_RSQN5: String
            /// 매도호가 잔량6
            let ASKP_RSQN6: String
            /// 매도호가 잔량7
            let ASKP_RSQN7: String
            /// 매도호가 잔량8
            let ASKP_RSQN8: String
            /// 매도호가 잔량9
            let ASKP_RSQN9: String
            /// 매도호가 잔량10
            let ASKP_RSQN10: String
            /// 매수호가 잔량1
            let BIDP_RSQN1: String
            /// 매수호가 잔량2
            let BIDP_RSQN2: String
            /// 매수호가 잔량3
            let BIDP_RSQN3: String
            /// 매수호가 잔량4
            let BIDP_RSQN4: String
            /// 매수호가 잔량5
            let BIDP_RSQN5: String
            /// 매수호가 잔량6
            let BIDP_RSQN6: String
            /// 매수호가 잔량7
            let BIDP_RSQN7: String
            /// 매수호가 잔량8
            let BIDP_RSQN8: String
            /// 매수호가 잔량9
            let BIDP_RSQN9: String
            /// 매수호가 잔량10
            let BIDP_RSQN10: String
            /// 총 매도호가 잔량
            let TOTAL_ASKP_RSQN: String
            /// 총 매수호가 잔량
            let TOTAL_BIDP_RSQN: String
            /// 시간외 총 매도호가 잔량
            let OVTM_TOTAL_ASKP_RSQN: String
            /// 시간외 총 매수호가 잔량
            let OVTM_TOTAL_BIDP_RSQN: String
            /// 예상 체결가
            let ANTC_CNPR: String
            /// 예상 체결량
            let ANTC_CNQN: String
            /// 예상 거래량
            let ANTC_VOL: String
            /// 예상 체결 대비
            let ANTC_CNTG_VRSS: String
            /// 예상 체결 대비 부호
            let ANTC_CNTG_VRSS_SIGN: String
            /// 예상 체결 전일 대비율
            let ANTC_CNTG_PRDY_CTRT: String
            /// 누적 거래량
            let ACML_VOL: String
            /// 총 매도호가 잔량 증감
            let TOTAL_ASKP_RSQN_ICDC: String
            /// 총 매수호가 잔량 증감
            let TOTAL_BIDP_RSQN_ICDC: String
            /// 시간외 총 매도호가 증감
            let OVTM_TOTAL_ASKP_ICDC: String
            /// 시간외 총 매수호가 증감
            let OVTM_TOTAL_BIDP_ICDC: String
            /// 주식 매매 구분 코드
            let STCK_DEAL_CLS_CODE: String
            /// KRX 중간가
            let KMID_PRC: String
            /// KRX 중간가잔량합계수량
            let KMID_TOTAL_RSQN: String
            /// KRX 중간가 매수매도 구분
            let KMID_CLS_CODE: String
            /// NXT 중간가
            let NMID_PRC: String
            /// NXT 중간가잔량합계수량
            let NMID_TOTAL_RSQN: String
            /// NXT 중간가 매수매도 구분
            let NMID_CLS_CODE: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_실시간프로그램매매_NXT : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0NXPGM0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객타입
            /// 'B : 법인 P : 개인'
            let custtype: String
            /// 거래타입
            /// '1 : 등록 2 : 해제'
            let tr_type: String
            /// 컨텐츠타입
            /// '    utf-8'
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
                self.content_type = "'    utf-8'"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// '[실전/모의투자] H0NXPGM0 : 실시간 주식프로그램매매 (NXT)'
            let TR_ID: String
            /// 구분값
            /// 종목코드 (ex 005930 삼성전자)
            let TR_KEY: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 유가증권 단축 종목코드
            let MKSC_SHRN_ISCD: String
            /// 주식 체결 시간
            let STCK_CNTG_HOUR: String
            /// 매도 체결량
            let SELN_CNQN: String
            /// 매도 거래 대금
            let SELN_TR_PBMN: String
            /// 매수2 체결량
            let SHNU_CNQN: String
            /// 매수2 거래 대금
            let SHNU_TR_PBMN: String
            /// 순매수 체결량
            let NTBY_CNQN: String
            /// 순매수 거래 대금
            let NTBY_TR_PBMN: String
            /// 매도호가잔량
            let SELN_RSQN: String
            /// 매수호가잔량
            let SHNU_RSQN: String
            /// 전체순매수호가잔량
            let WHOL_NTBY_QTY: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_실시간회원사_통합 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0UNMBC0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객타입
            /// 'B : 법인 P : 개인'
            let custtype: String
            /// 거래타입
            /// '1 : 등록 2 : 해제'
            let tr_type: String
            /// 컨텐츠타입
            /// '    utf-8'
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
                self.content_type = "'    utf-8'"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// '[실전/모의투자] H0UNMBC0 : 국내주식 주식종목회원사 (통합)'
            let TR_ID: String
            /// 구분값
            /// 종목코드 (ex 005930 삼성전자)
            let TR_KEY: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 유가증권 단축 종목코드
            let MKSC_SHRN_ISCD: String
            /// 매도2 회원사명1
            let SELN2_MBCR_NAME1: String
            /// 매도2 회원사명2
            let SELN2_MBCR_NAME2: String
            /// 매도2 회원사명3
            let SELN2_MBCR_NAME3: String
            /// 매도2 회원사명4
            let SELN2_MBCR_NAME4: String
            /// 매도2 회원사명5
            let SELN2_MBCR_NAME5: String
            /// 매수 회원사명1
            let BYOV_MBCR_NAME1: String
            /// 매수 회원사명2
            let BYOV_MBCR_NAME2: String
            /// 매수 회원사명3
            let BYOV_MBCR_NAME3: String
            /// 매수 회원사명4
            let BYOV_MBCR_NAME4: String
            /// 매수 회원사명5
            let BYOV_MBCR_NAME5: String
            /// 총 매도 수량1
            let TOTAL_SELN_QTY1: String
            /// 총 매도 수량2
            let TOTAL_SELN_QTY2: String
            /// 총 매도 수량3
            let TOTAL_SELN_QTY3: String
            /// 총 매도 수량4
            let TOTAL_SELN_QTY4: String
            /// 총 매도 수량5
            let TOTAL_SELN_QTY5: String
            /// 총 매수2 수량1
            let TOTAL_SHNU_QTY1: String
            /// 총 매수2 수량2
            let TOTAL_SHNU_QTY2: String
            /// 총 매수2 수량3
            let TOTAL_SHNU_QTY3: String
            /// 총 매수2 수량4
            let TOTAL_SHNU_QTY4: String
            /// 총 매수2 수량5
            let TOTAL_SHNU_QTY5: String
            /// 매도거래원구분1
            let SELN_MBCR_GLOB_YN_1: String
            /// 매도거래원구분2
            let SELN_MBCR_GLOB_YN_2: String
            /// 매도거래원구분3
            let SELN_MBCR_GLOB_YN_3: String
            /// 매도거래원구분4
            let SELN_MBCR_GLOB_YN_4: String
            /// 매도거래원구분5
            let SELN_MBCR_GLOB_YN_5: String
            /// 매수거래원구분1
            let SHNU_MBCR_GLOB_YN_1: String
            /// 매수거래원구분2
            let SHNU_MBCR_GLOB_YN_2: String
            /// 매수거래원구분3
            let SHNU_MBCR_GLOB_YN_3: String
            /// 매수거래원구분4
            let SHNU_MBCR_GLOB_YN_4: String
            /// 매수거래원구분5
            let SHNU_MBCR_GLOB_YN_5: String
            /// 매도거래원코드1
            let SELN_MBCR_NO1: String
            /// 매도거래원코드2
            let SELN_MBCR_NO2: String
            /// 매도거래원코드3
            let SELN_MBCR_NO3: String
            /// 매도거래원코드4
            let SELN_MBCR_NO4: String
            /// 매도거래원코드5
            let SELN_MBCR_NO5: String
            /// 매수거래원코드1
            let SHNU_MBCR_NO1: String
            /// 매수거래원코드2
            let SHNU_MBCR_NO2: String
            /// 매수거래원코드3
            let SHNU_MBCR_NO3: String
            /// 매수거래원코드4
            let SHNU_MBCR_NO4: String
            /// 매수거래원코드5
            let SHNU_MBCR_NO5: String
            /// 매도 회원사 비중1
            let SELN_MBCR_RLIM1: String
            /// 매도 회원사 비중2
            let SELN_MBCR_RLIM2: String
            /// 매도 회원사 비중3
            let SELN_MBCR_RLIM3: String
            /// 매도 회원사 비중4
            let SELN_MBCR_RLIM4: String
            /// 매도 회원사 비중5
            let SELN_MBCR_RLIM5: String
            /// 매수2 회원사 비중1
            let SHNU_MBCR_RLIM1: String
            /// 매수2 회원사 비중2
            let SHNU_MBCR_RLIM2: String
            /// 매수2 회원사 비중3
            let SHNU_MBCR_RLIM3: String
            /// 매수2 회원사 비중4
            let SHNU_MBCR_RLIM4: String
            /// 매수2 회원사 비중5
            let SHNU_MBCR_RLIM5: String
            /// 매도 수량 증감1
            let SELN_QTY_ICDC1: String
            /// 매도 수량 증감2
            let SELN_QTY_ICDC2: String
            /// 매도 수량 증감3
            let SELN_QTY_ICDC3: String
            /// 매도 수량 증감4
            let SELN_QTY_ICDC4: String
            /// 매도 수량 증감5
            let SELN_QTY_ICDC5: String
            /// 매수2 수량 증감1
            let SHNU_QTY_ICDC1: String
            /// 매수2 수량 증감2
            let SHNU_QTY_ICDC2: String
            /// 매수2 수량 증감3
            let SHNU_QTY_ICDC3: String
            /// 매수2 수량 증감4
            let SHNU_QTY_ICDC4: String
            /// 매수2 수량 증감5
            let SHNU_QTY_ICDC5: String
            /// 외국계 총 매도 수량
            let GLOB_TOTAL_SELN_QTY: String
            /// 외국계 총 매수2 수량
            let GLOB_TOTAL_SHNU_QTY: String
            /// 외국계 총 매도 수량 증감
            let GLOB_TOTAL_SELN_QTY_ICDC: String
            /// 외국계 총 매수2 수량 증감
            let GLOB_TOTAL_SHNU_QTY_ICDC: String
            /// 외국계 순매수 수량
            let GLOB_NTBY_QTY: String
            /// 외국계 매도 비중
            let GLOB_SELN_RLIM: String
            /// 외국계 매수2 비중
            let GLOB_SHNU_RLIM: String
            /// 매도2 영문회원사명1
            let SELN2_MBCR_ENG_NAME1: String
            /// 매도2 영문회원사명2
            let SELN2_MBCR_ENG_NAME2: String
            /// 매도2 영문회원사명3
            let SELN2_MBCR_ENG_NAME3: String
            /// 매도2 영문회원사명4
            let SELN2_MBCR_ENG_NAME4: String
            /// 매도2 영문회원사명5
            let SELN2_MBCR_ENG_NAME5: String
            /// 매수 영문회원사명1
            let BYOV_MBCR_ENG_NAME1: String
            /// 매수 영문회원사명2
            let BYOV_MBCR_ENG_NAME2: String
            /// 매수 영문회원사명3
            let BYOV_MBCR_ENG_NAME3: String
            /// 매수 영문회원사명4
            let BYOV_MBCR_ENG_NAME4: String
            /// 매수 영문회원사명5
            let BYOV_MBCR_ENG_NAME5: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_실시간회원사_NXT : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0NXMBC0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객타입
            /// 'B : 법인 P : 개인'
            let custtype: String
            /// 거래타입
            /// '1 : 등록 2 : 해제'
            let tr_type: String
            /// 컨텐츠타입
            /// '    utf-8'
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
                self.content_type = "'    utf-8'"
            }
        }
        struct Body : Codable {
            /// 거래ID
            /// '[실전/모의투자] H0NXMBC0 : 국내주식 주식종목회원사 (NXT)'
            let TR_ID: String
            /// 구분값
            /// 종목코드 (ex 005930 삼성전자)
            let TR_KEY: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 유가증권 단축 종목코드
            let MKSC_SHRN_ISCD: String
            /// 매도2 회원사명1
            let SELN2_MBCR_NAME1: String
            /// 매도2 회원사명2
            let SELN2_MBCR_NAME2: String
            /// 매도2 회원사명3
            let SELN2_MBCR_NAME3: String
            /// 매도2 회원사명4
            let SELN2_MBCR_NAME4: String
            /// 매도2 회원사명5
            let SELN2_MBCR_NAME5: String
            /// 매수 회원사명1
            let BYOV_MBCR_NAME1: String
            /// 매수 회원사명2
            let BYOV_MBCR_NAME2: String
            /// 매수 회원사명3
            let BYOV_MBCR_NAME3: String
            /// 매수 회원사명4
            let BYOV_MBCR_NAME4: String
            /// 매수 회원사명5
            let BYOV_MBCR_NAME5: String
            /// 총 매도 수량1
            let TOTAL_SELN_QTY1: String
            /// 총 매도 수량2
            let TOTAL_SELN_QTY2: String
            /// 총 매도 수량3
            let TOTAL_SELN_QTY3: String
            /// 총 매도 수량4
            let TOTAL_SELN_QTY4: String
            /// 총 매도 수량5
            let TOTAL_SELN_QTY5: String
            /// 총 매수2 수량1
            let TOTAL_SHNU_QTY1: String
            /// 총 매수2 수량2
            let TOTAL_SHNU_QTY2: String
            /// 총 매수2 수량3
            let TOTAL_SHNU_QTY3: String
            /// 총 매수2 수량4
            let TOTAL_SHNU_QTY4: String
            /// 총 매수2 수량5
            let TOTAL_SHNU_QTY5: String
            /// 매도거래원구분1
            let SELN_MBCR_GLOB_YN_1: String
            /// 매도거래원구분2
            let SELN_MBCR_GLOB_YN_2: String
            /// 매도거래원구분3
            let SELN_MBCR_GLOB_YN_3: String
            /// 매도거래원구분4
            let SELN_MBCR_GLOB_YN_4: String
            /// 매도거래원구분5
            let SELN_MBCR_GLOB_YN_5: String
            /// 매수거래원구분1
            let SHNU_MBCR_GLOB_YN_1: String
            /// 매수거래원구분2
            let SHNU_MBCR_GLOB_YN_2: String
            /// 매수거래원구분3
            let SHNU_MBCR_GLOB_YN_3: String
            /// 매수거래원구분4
            let SHNU_MBCR_GLOB_YN_4: String
            /// 매수거래원구분5
            let SHNU_MBCR_GLOB_YN_5: String
            /// 매도거래원코드1
            let SELN_MBCR_NO1: String
            /// 매도거래원코드2
            let SELN_MBCR_NO2: String
            /// 매도거래원코드3
            let SELN_MBCR_NO3: String
            /// 매도거래원코드4
            let SELN_MBCR_NO4: String
            /// 매도거래원코드5
            let SELN_MBCR_NO5: String
            /// 매수거래원코드1
            let SHNU_MBCR_NO1: String
            /// 매수거래원코드2
            let SHNU_MBCR_NO2: String
            /// 매수거래원코드3
            let SHNU_MBCR_NO3: String
            /// 매수거래원코드4
            let SHNU_MBCR_NO4: String
            /// 매수거래원코드5
            let SHNU_MBCR_NO5: String
            /// 매도 회원사 비중1
            let SELN_MBCR_RLIM1: String
            /// 매도 회원사 비중2
            let SELN_MBCR_RLIM2: String
            /// 매도 회원사 비중3
            let SELN_MBCR_RLIM3: String
            /// 매도 회원사 비중4
            let SELN_MBCR_RLIM4: String
            /// 매도 회원사 비중5
            let SELN_MBCR_RLIM5: String
            /// 매수2 회원사 비중1
            let SHNU_MBCR_RLIM1: String
            /// 매수2 회원사 비중2
            let SHNU_MBCR_RLIM2: String
            /// 매수2 회원사 비중3
            let SHNU_MBCR_RLIM3: String
            /// 매수2 회원사 비중4
            let SHNU_MBCR_RLIM4: String
            /// 매수2 회원사 비중5
            let SHNU_MBCR_RLIM5: String
            /// 매도 수량 증감1
            let SELN_QTY_ICDC1: String
            /// 매도 수량 증감2
            let SELN_QTY_ICDC2: String
            /// 매도 수량 증감3
            let SELN_QTY_ICDC3: String
            /// 매도 수량 증감4
            let SELN_QTY_ICDC4: String
            /// 매도 수량 증감5
            let SELN_QTY_ICDC5: String
            /// 매수2 수량 증감1
            let SHNU_QTY_ICDC1: String
            /// 매수2 수량 증감2
            let SHNU_QTY_ICDC2: String
            /// 매수2 수량 증감3
            let SHNU_QTY_ICDC3: String
            /// 매수2 수량 증감4
            let SHNU_QTY_ICDC4: String
            /// 매수2 수량 증감5
            let SHNU_QTY_ICDC5: String
            /// 외국계 총 매도 수량
            let GLOB_TOTAL_SELN_QTY: String
            /// 외국계 총 매수2 수량
            let GLOB_TOTAL_SHNU_QTY: String
            /// 외국계 총 매도 수량 증감
            let GLOB_TOTAL_SELN_QTY_ICDC: String
            /// 외국계 총 매수2 수량 증감
            let GLOB_TOTAL_SHNU_QTY_ICDC: String
            /// 외국계 순매수 수량
            let GLOB_NTBY_QTY: String
            /// 외국계 매도 비중
            let GLOB_SELN_RLIM: String
            /// 외국계 매수2 비중
            let GLOB_SHNU_RLIM: String
            /// 매도2 영문회원사명1
            let SELN2_MBCR_ENG_NAME1: String
            /// 매도2 영문회원사명2
            let SELN2_MBCR_ENG_NAME2: String
            /// 매도2 영문회원사명3
            let SELN2_MBCR_ENG_NAME3: String
            /// 매도2 영문회원사명4
            let SELN2_MBCR_ENG_NAME4: String
            /// 매도2 영문회원사명5
            let SELN2_MBCR_ENG_NAME5: String
            /// 매수 영문회원사명1
            let BYOV_MBCR_ENG_NAME1: String
            /// 매수 영문회원사명2
            let BYOV_MBCR_ENG_NAME2: String
            /// 매수 영문회원사명3
            let BYOV_MBCR_ENG_NAME3: String
            /// 매수 영문회원사명4
            let BYOV_MBCR_ENG_NAME4: String
            /// 매수 영문회원사명5
            let BYOV_MBCR_ENG_NAME5: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_장운영정보_NXT : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0NXMKO0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객 타입
            /// B : 법인 P : 개인
            let custtype: String
            /// 거래타입
            /// 1 : 등록 2 : 해제
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
            /// '[실전/모의투자] H0NXMKO0 : 국내주식 장운영정보 (NXT)'
            let TR_ID: String
            /// 구분값
            /// 종목코드 (ex 005930 삼성전자)
            let TR_KEY: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 종목코드
            let MKSC_SHRN_ISCD: String
            /// 거래정지 여부
            let TRHT_YN: String
            /// 거래 정지 사유 내용
            let TR_SUSP_REAS_CNTT: String
            /// 장운영 구분 코드
            let MKOP_CLS_CODE: String
            /// 예상 장운영 구분 코드
            let ANTC_MKOP_CLS_CODE: String
            /// 임의연장구분코드
            let MRKT_TRTM_CLS_CODE: String
            /// 동시호가배분처리구분코드
            let DIVI_APP_CLS_CODE: String
            /// 종목상태구분코드
            let ISCD_STAT_CLS_CODE: String
            /// VI적용구분코드
            let VI_CLS_CODE: String
            /// 시간외단일가VI적용구분코드
            let OVTM_VI_CLS_CODE: String
            /// 거래소 구분코드
            let EXCH_CLS_CODE: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_실시간예상체결_NXT : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0NXANC0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객 타입
            /// B : 법인 P : 개인
            let custtype: String
            /// 거래타입
            /// 1 : 등록 2 : 해제
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
            /// '[실전/모의투자] H0NXANC0 : 국내주식 실시간예상체결 (NXT)'
            let TR_ID: String
            /// 구분값
            /// 종목코드 (ex 005930 삼성전자)
            let TR_KEY: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 유가증권단축종목코드
            let MKSC_SHRN_ISCD: String
            /// 주식체결시간
            let STCK_CNTG_HOUR: String
            /// 주식현재가
            let STCK_PRPR: String
            /// 전일대비구분
            let PRDY_VRSS_SIGN: String
            /// 전일대비
            let PRDY_VRSS: String
            /// 등락율
            let PRDY_CTRT: String
            /// 가중평균주식가격
            let WGHN_AVRG_STCK_PRC: String
            /// 시가
            let STCK_OPRC: String
            /// 고가
            let STCK_HGPR: String
            /// 저가
            let STCK_LWPR: String
            /// 매도호가
            let ASKP1: String
            /// 매수호가
            let BIDP1: String
            /// 거래량
            let CNTG_VOL: String
            /// 누적거래량
            let ACML_VOL: String
            /// 누적거래대금
            let ACML_TR_PBMN: String
            /// 매도체결건수
            let SELN_CNTG_CSNU: String
            /// 매수체결건수
            let SHNU_CNTG_CSNU: String
            /// 순매수체결건수
            let NTBY_CNTG_CSNU: String
            /// 체결강도
            let CTTR: String
            /// 총매도수량
            let SELN_CNTG_SMTN: String
            /// 총매수수량
            let SHNU_CNTG_SMTN: String
            /// 체결구분
            let CNTG_CLS_CODE: String
            /// 매수비율
            let SHNU_RATE: String
            /// 전일거래량대비등락율
            let PRDY_VOL_VRSS_ACML_VOL_RATE: String
            /// 시가시간
            let OPRC_HOUR: String
            /// 시가대비구분
            let OPRC_VRSS_PRPR_SIGN: String
            /// 시가대비
            let OPRC_VRSS_PRPR: String
            /// 최고가시간
            let HGPR_HOUR: String
            /// 고가대비구분
            let HGPR_VRSS_PRPR_SIGN: String
            /// 고가대비
            let HGPR_VRSS_PRPR: String
            /// 최저가시간
            let LWPR_HOUR: String
            /// 저가대비구분
            let LWPR_VRSS_PRPR_SIGN: String
            /// 저가대비
            let LWPR_VRSS_PRPR: String
            /// 영업일자
            let BSOP_DATE: String
            /// 신장운영구분코드
            let NEW_MKOP_CLS_CODE: String
            /// 거래정지여부
            let TRHT_YN: String
            /// 매도호가잔량1
            let ASKP_RSQN1: String
            /// 매수호가잔량1
            let BIDP_RSQN1: String
            /// 총매도호가잔량
            let TOTAL_ASKP_RSQN: String
            /// 총매수호가잔량
            let TOTAL_BIDP_RSQN: String
            /// 거래량회전율
            let VOL_TNRT: String
            /// 전일동시간누적거래량
            let PRDY_SMNS_HOUR_ACML_VOL: String
            /// 전일동시간누적거래량비율
            let PRDY_SMNS_HOUR_ACML_VOL_RATE: String
            /// 시간구분코드
            let HOUR_CLS_CODE: String
            /// 임의종료구분코드
            let MRKT_TRTM_CLS_CODE: String
            /// VI 상태값
            let VI_STND_PRC: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_장운영정보_통합 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0UNMKO0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객 타입
            /// B : 법인 P : 개인
            let custtype: String
            /// 거래타입
            /// 1 : 등록 2 : 해제
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
            /// '[실전/모의투자] H0UNMKO0 : 국내주식 장운영정보 (통합)'
            let TR_ID: String
            /// 구분값
            /// 종목코드 (ex 005930 삼성전자)
            let TR_KEY: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 거래정지 여부
            let TRHT_YN: String
            /// 거래 정지 사유 내용
            let TR_SUSP_REAS_CNTT: String
            /// 장운영 구분 코드
            let MKOP_CLS_CODE: String
            /// 예상 장운영 구분 코드
            let ANTC_MKOP_CLS_CODE: String
            /// 임의연장구분코드
            let MRKT_TRTM_CLS_CODE: String
            /// 동시호가배분처리구분코드
            let DIVI_APP_CLS_CODE: String
            /// 종목상태구분코드
            let ISCD_STAT_CLS_CODE: String
            /// VI적용구분코드
            let VI_CLS_CODE: String
            /// 시간외단일가VI적용구분코드
            let OVTM_VI_CLS_CODE: String
            /// 거래소 구분코드
            let EXCH_CLS_CODE: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 국내주식_실시간예상체결_통합 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0UNANC0"
        struct Header : Codable {
            /// 웹소켓 접속키
            /// 실시간 (웹소켓) 접속키 발급 API(/oauth2/Approval)를 사용하여 발급받은 웹소켓 접속키
            let approval_key: String
            /// 고객 타입
            /// B : 법인 P : 개인
            let custtype: String
            /// 거래타입
            /// 1 : 등록 2 : 해제
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
            /// '[실전/모의투자] H0UNANC0 : 국내주식 실시간예상체결 (통합)'
            let TR_ID: String
            /// 구분값
            /// 종목코드 (ex 005930 삼성전자)
            let TR_KEY: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 유가증권단축종목코드
            let MKSC_SHRN_ISCD: String
            /// 주식체결시간
            let STCK_CNTG_HOUR: String
            /// 주식현재가
            let STCK_PRPR: String
            /// 전일대비구분
            let PRDY_VRSS_SIGN: String
            /// 전일대비
            let PRDY_VRSS: String
            /// 등락율
            let PRDY_CTRT: String
            /// 가중평균주식가격
            let WGHN_AVRG_STCK_PRC: String
            /// 시가
            let STCK_OPRC: String
            /// 고가
            let STCK_HGPR: String
            /// 저가
            let STCK_LWPR: String
            /// 매도호가
            let ASKP1: String
            /// 매수호가
            let BIDP1: String
            /// 거래량
            let CNTG_VOL: String
            /// 누적거래량
            let ACML_VOL: String
            /// 누적거래대금
            let ACML_TR_PBMN: String
            /// 매도체결건수
            let SELN_CNTG_CSNU: String
            /// 매수체결건수
            let SHNU_CNTG_CSNU: String
            /// 순매수체결건수
            let NTBY_CNTG_CSNU: String
            /// 체결강도
            let CTTR: String
            /// 총매도수량
            let SELN_CNTG_SMTN: String
            /// 총매수수량
            let SHNU_CNTG_SMTN: String
            /// 체결구분
            let CNTG_CLS_CODE: String
            /// 매수비율
            let SHNU_RATE: String
            /// 전일거래량대비등락율
            let PRDY_VOL_VRSS_ACML_VOL_RATE: String
            /// 시가시간
            let OPRC_HOUR: String
            /// 시가대비구분
            let OPRC_VRSS_PRPR_SIGN: String
            /// 시가대비
            let OPRC_VRSS_PRPR: String
            /// 최고가시간
            let HGPR_HOUR: String
            /// 고가대비구분
            let HGPR_VRSS_PRPR_SIGN: String
            /// 고가대비
            let HGPR_VRSS_PRPR: String
            /// 최저가시간
            let LWPR_HOUR: String
            /// 저가대비구분
            let LWPR_VRSS_PRPR_SIGN: String
            /// 저가대비
            let LWPR_VRSS_PRPR: String
            /// 영업일자
            let BSOP_DATE: String
            /// 신장운영구분코드
            let NEW_MKOP_CLS_CODE: String
            /// 거래정지여부
            let TRHT_YN: String
            /// 매도호가잔량1
            let ASKP_RSQN1: String
            /// 매수호가잔량1
            let BIDP_RSQN1: String
            /// 총매도호가잔량
            let TOTAL_ASKP_RSQN: String
            /// 총매수호가잔량
            let TOTAL_BIDP_RSQN: String
            /// 거래량회전율
            let VOL_TNRT: String
            /// 전일동시간누적거래량
            let PRDY_SMNS_HOUR_ACML_VOL: String
            /// 전일동시간누적거래량비율
            let PRDY_SMNS_HOUR_ACML_VOL_RATE: String
            /// 시간구분코드
            let HOUR_CLS_CODE: String
            /// 임의종료구분코드
            let MRKT_TRTM_CLS_CODE: String
            /// VI 상태값
            let VI_STND_PRC: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }
}

