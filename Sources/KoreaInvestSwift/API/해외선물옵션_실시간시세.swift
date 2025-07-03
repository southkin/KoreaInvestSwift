//
//  Untitled.swift
//  KoreaInvestSwift
//
//  Created by kin on 4/12/25.
//

import FullyRESTful
public extension KISAPI {
    enum 해외선물옵션_실시간시세 {}
}
public extension KISAPI.해외선물옵션_실시간시세 {
    struct 해외선물옵션_실시간체결가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/HDFFF020"
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
            /// HDFFF020
            var tr_id: String = "HDFFF020"
            /// 종목코드
            /// 종목코드 ※ CME, SGX 실시간시세 유료시세 신청 필수 "포럼 > FAQ > 해외선물옵션 API 유료시세 신청방법(CME, SGX 거래소)"
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let series_cd: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 영업일자
            let bsns_date: String
            /// 장개시일자
            let mrkt_open_date: String
            /// 장개시시각
            let mrkt_open_time: String
            /// 장종료일자
            let mrkt_close_date: String
            /// 장종료시각
            let mrkt_close_time: String
            /// 전일종가
            /// 전일종가, 체결가격, 전일대비가, 시가, 고가, 저가 ※ ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고
            let prev_price: String
            /// 수신일자
            let recv_date: String
            /// 수신시각
            /// 수신시각(recv_time) = 실제 체결시각
            let recv_time: String
            /// 본장_전산장구분
            let active_flag: String
            /// 체결가격
            let last_price: String
            /// 체결수량
            let last_qntt: String
            /// 전일대비가
            let prev_diff_price: String
            /// 등락률
            let prev_diff_rate: String
            /// 시가
            let open_price: String
            /// 고가
            let high_price: String
            /// 저가
            let low_price: String
            /// 누적거래량
            let vol: String
            /// 전일대비부호
            let prev_sign: String
            /// 체결구분
            /// 2:매수체결 5:매도체결
            let quotsign: String
            /// 수신시각2 만분의일초
            let recv_time2: String
            /// 전일정산가
            let psttl_price: String
            /// 전일정산가대비
            let psttl_sign: String
            /// 전일정산가대비가격
            let psttl_diff_price: String
            /// 전일정산가대비율
            let psttl_diff_rate: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 해외선물옵션_실시간호가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/HDFFF010"
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
            /// HDFFF010
            var tr_id: String = "HDFFF010"
            /// 종목코드
            /// 종목코드 ※ CME, SGX 실시간시세 유료시세 신청 필수 "포럼 > FAQ > 해외선물옵션 API 유료시세 신청방법(CME, SGX 거래소)"
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let series_cd: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 수신일자
            let recv_date: String
            /// 수신시각
            let recv_time: String
            /// 전일종가
            /// 전일종가, 매수1호가~매도5호가 ※ ffcode.mst(해외선물종목마스터 파일)의 sCalcDesz(계산 소수점) 값 참고
            let prev_price: String
            /// 매수1수량
            let bid_qntt_1: String
            /// 매수1번호
            let bid_num_1: String
            /// 매수1호가
            let bid_price_1: String
            /// 매도1수량
            let ask_qntt_1: String
            /// 매도1번호
            let ask_num_1: String
            /// 매도1호가
            let ask_price_1: String
            /// 매수2수량
            let bid_qntt_2: String
            /// 매수2번호
            let bid_num_2: String
            /// 매수2호가
            let bid_price_2: String
            /// 매도2수량
            let ask_qntt_2: String
            /// 매도2번호
            let ask_num_2: String
            /// 매도2호가
            let ask_price_2: String
            /// 매수3수량
            let bid_qntt_3: String
            /// 매수3번호
            let bid_num_3: String
            /// 매수3호가
            let bid_price_3: String
            /// 매도3수량
            let ask_qntt_3: String
            /// 매도3번호
            let ask_num_3: String
            /// 매도3호가
            let ask_price_3: String
            /// 매수4수량
            let bid_qntt_4: String
            /// 매수4번호
            let bid_num_4: String
            /// 매수4호가
            let bid_price_4: String
            /// 매도4수량
            let ask_qntt_4: String
            /// 매도4번호
            let ask_num_4: String
            /// 매도4호가
            let ask_price_4: String
            /// 매수5수량
            let bid_qntt_5: String
            /// 매수5번호
            let bid_num_5: String
            /// 매수5호가
            let bid_price_5: String
            /// 매도5수량
            let ask_qntt_5: String
            /// 매도5번호
            let ask_num_5: String
            /// 매도5호가
            let ask_price_5: String
            /// 전일정산가
            let sttl_price: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 해외선물옵션_실시간주문내역통보 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/HDFFF1C0"
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
            /// HDFFF1C0
            var tr_id: String = "HDFFF1C0"
            /// HTSID
            /// HTSID
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 유저ID
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let user_id: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 계좌번호
            let acct_no: String
            /// 주문일자
            let ord_dt: String
            /// 주문번호
            let odno: String
            /// 원주문일자
            let orgn_ord_dt: String
            /// 원주문번호
            let orgn_odno: String
            /// 종목명
            let series: String
            /// 정정취소구분코드
            /// 해당없음 : 00 , 정정 : 01 , 취소 : 02
            let rvse_cncl_dvsn_cd: String
            /// 매도매수구분코드
            /// 01 : 매도, 02 : 매수
            let sll_buy_dvsn_cd: String
            /// 복합주문구분코드
            /// 0 (hedge청산만 이용)
            let cplx_ord_dvsn_cd: String
            /// 가격구분코드
            /// 1:Limit, 2:Market, 3:Stop(Stop가격시 시장가)
            let prce_tp: String
            /// FM거래소접수구분코드
            /// 01:접수전, 02:응답, 03:거부
            let fm_excg_rcit_dvsn_cd: String
            /// 주문수량
            let ord_qty: String
            /// FMLIMIT가격
            let fm_lmt_pric: String
            /// FMSTOP주문가격
            let fm_stop_ord_pric: String
            /// 총체결수량
            let tot_ccld_qty: String
            /// 총체결단가
            let tot_ccld_uv: String
            /// 잔량
            let ord_remq: String
            /// FM주문그룹일자
            /// 주문일자(ORD_DT)와 동일
            let fm_ord_grp_dt: String
            /// 주문그룹번호
            let ord_grp_stno: String
            /// 주문상세일시
            let ord_dtl_dtime: String
            /// 조작상세일시
            let oprt_dtl_dtime: String
            /// 주문자
            let work_empl: String
            /// 통화코드
            let crcy_cd: String
            /// 청산여부(Y/N)
            let lqd_yn: String
            /// 청산LIMIT가격
            let lqd_lmt_pric: String
            /// 청산STOP가격
            let lqd_stop_pric: String
            /// 체결조건코드
            let trd_cond: String
            /// 기간주문유효상세일시
            let term_ord_vald_dtime: String
            /// 계좌청산유형구분코드
            let spec_tp: String
            /// 행사예약주문여부
            let ecis_rsvn_ord_yn: String
            /// 선물옵션종목구분코드
            let fuop_item_dvsn_cd: String
            /// 자동주문 전략구분
            let auto_ord_dvsn_cd: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 해외선물옵션_실시간체결내역통보 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/HDFFF2C0"
        struct Header : Codable {
            /// 웹소켓 접속키
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
            /// HDFFF2C0
            var tr_id: String = "HDFFF2C0"
            /// HTSID
            /// HTSID
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 유저ID
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let user_id: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 계좌번호
            let acct_no: String
            /// 주문일자
            let ord_dt: String
            /// 주문번호
            let odno: String
            /// 원주문일자
            let orgn_ord_dt: String
            /// 원주문번호
            let orgn_odno: String
            /// 종목명
            let series: String
            /// 정정취소구분코드
            /// 해당없음 : 00 , 정정 : 01 , 취소 : 02
            let rvse_cncl_dvsn_cd: String
            /// 매도매수구분코드
            /// 01 : 매도, 02 : 매수
            let sll_buy_dvsn_cd: String
            /// 복합주문구분코드
            /// 0 (hedge청산만 이용)
            let cplx_ord_dvsn_cd: String
            /// 가격구분코드
            let prce_tp: String
            /// FM거래소접수구분코드
            let fm_excg_rcit_dvsn_cd: String
            /// 주문수량
            let ord_qty: String
            /// FMLIMIT가격
            let fm_lmt_pric: String
            /// FMSTOP주문가격
            let fm_stop_ord_pric: String
            /// 총체결수량
            /// 동일한 주문건에 대한 누적된 체결수량 (하나의 주문건에 여러건의 체결내역 발생)
            let tot_ccld_qty: String
            /// 총체결단가
            let tot_ccld_uv: String
            /// 잔량
            let ord_remq: String
            /// FM주문그룹일자
            let fm_ord_grp_dt: String
            /// 주문그룹번호
            let ord_grp_stno: String
            /// 주문상세일시
            let ord_dtl_dtime: String
            /// 조작상세일시
            let oprt_dtl_dtime: String
            /// 주문자
            let work_empl: String
            /// 체결일자
            let ccld_dt: String
            /// 체결번호
            let ccno: String
            /// API 체결번호
            let api_ccno: String
            /// 체결수량
            /// 매 체결 단위 체결수량임 (여러건 체결내역 누적 체결수량인 총체결수량과 다름)
            let ccld_qty: String
            /// FM체결가격
            let fm_ccld_pric: String
            /// 통화코드
            let crcy_cd: String
            /// 위탁수수료
            let trst_fee: String
            /// 주문매체온라인여부
            let ord_mdia_online_yn: String
            /// FM체결금액
            let fm_ccld_amt: String
            /// 선물옵션종목구분코드
            let fuop_item_dvsn_cd: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }
}
