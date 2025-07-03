//
//  해외주식_실시간시세.swift
//  KoreaInvestSwift
//
//  Created by kin on 4/12/25.
//

import FullyRESTful
public extension KISAPI {
    enum 해외주식_실시간시세 {}
}
public extension KISAPI.해외주식_실시간시세 {
    struct 해외주식_실시간지연체결가 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "제공 안함") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/HDFSCNT0"
        struct Header : Codable {
            /// 웹소켓 접속키
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
            /// HDFSCNT0
            var tr_id: String = "HDFSCNT0"
            /// D거래소명종목코드
            /// <미국 야간거래/아시아 주간거래 - 무료시세> D+시장구분(3자리)+종목코드 예) DNASAAPL : D+NAS(나스닥)+AAPL(애플) [시장구분] NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 , TSE : 도쿄, HKS : 홍콩, SHS : 상해, SZS : 심천 HSX : 호치민, HNX : 하노이 <미국 야간거래/아시아 주간거래 - 유료시세> ※ 유료시세 신청시에만 유료시세 수신가능 "포럼 > FAQ > 해외주식 유료시세 신청방법" 참고 R+시장구분(3자리)+종목코드 예) RNASAAPL : R+NAS(나스닥)+AAPL(애플) [시장구분] NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 , TSE : 도쿄, HKS : 홍콩, SHS : 상해, SZS : 심천 HSX : 호치민, HNX : 하노이 <미국 주간거래> R+시장구분(3자리)+종목코드 예) RBAQAAPL : R+BAQ(나스닥)+AAPL(애플) [시장구분] BAY : 뉴욕(주간), BAQ : 나스닥(주간). BAA : 아멕스(주간)
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 실시간종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let RSYM: String
            /// 종목코드
            let SYMB: String
            /// 수수점자리수
            let ZDIV: String
            /// 현지영업일자
            let TYMD: String
            /// 현지일자
            let XYMD: String
            /// 현지시간
            let XHMS: String
            /// 한국일자
            let KYMD: String
            /// 한국시간
            let KHMS: String
            /// 시가
            let OPEN: String
            /// 고가
            let HIGH: String
            /// 저가
            let LOW: String
            /// 현재가
            let LAST: String
            /// 대비구분
            let SIGN: String
            /// 전일대비
            let DIFF: String
            /// 등락율
            let RATE: String
            /// 매수호가
            let PBID: String
            /// 매도호가
            let PASK: String
            /// 매수잔량
            let VBID: String
            /// 매도잔량
            let VASK: String
            /// 체결량
            let EVOL: String
            /// 거래량
            let TVOL: String
            /// 거래대금
            let TAMT: String
            /// 매도체결량
            /// 매수호가가 매도주문 수량을 따라가서 체결된것을 표현하여 BIVL 이라는 표현을 사용
            let BIVL: String
            /// 매수체결량
            /// 매도호가가 매수주문 수량을 따라가서 체결된것을 표현하여 ASVL 이라는 표현을 사용
            let ASVL: String
            /// 체결강도
            let STRN: String
            /// 시장구분 1:장중,2:장전,3:장후
            let MTYP: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 해외주식_실시간지연호가_아시아 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "제공 안함") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/HDFSASP1"
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
            /// HDFSASP1
            var tr_id: String = "HDFSASP1"
            /// D거래소명종목코드
            /// <아시아국가 - 무료시세> D+시장구분(3자리)+종목코드 예) DHKS00003 : D+HKS(홍콩)+00003(홍콩중화가스) [시장구분] TSE : 도쿄, HKS : 홍콩, SHS : 상해, SZS : 심천 HSX : 호치민, HNX : 하노이 <아시아국가 - 유료시세> ※ 유료시세 신청시에만 유료시세 수신가능 "포럼 > FAQ > 해외주식 유료시세 신청방법" 참고 R+시장구분(3자리)+종목코드 예) RHKS00003 : R+HKS(홍콩)+00003(홍콩중화가스) [시장구분] TSE : 도쿄, HKS : 홍콩, SHS : 상해, SZS : 심천 HSX : 호치민, HNX : 하노이
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 실시간종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let RSYM: String
            /// 종목코드
            let SYMB: String
            /// 소수점자리수
            let ZDIV: String
            /// 현지일자
            let XYMD: String
            /// 현지시간
            let XHMS: String
            /// 한국일자
            let KYMD: String
            /// 한국시간
            let KHMS: String
            /// 매수총잔량
            let BVOL: String
            /// 매도총잔량
            let AVOL: String
            /// 매수총잔량대비
            let BDVL: String
            /// 매도총잔량대비
            let ADVL: String
            /// 매수호가1
            let PBID1: String
            /// 매도호가1
            let PASK1: String
            /// 매수잔량1
            let VBID1: String
            /// 매도잔량1
            let VASK1: String
            /// 매수잔량대비1
            let DBID1: String
            /// 매도잔량대비1
            let DASK1: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 해외주식_실시간체결통보 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "ws://ops.koreainvestment.com:31000") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/H0GSCNI0"
        struct Header : Codable {
            /// 웹소켓 접속키
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
            /// [실전투자] H0GSCNI0 : 실시간 해외주식 체결통보 [모의투자] H0GSCNI9 : 실시간 해외주식 체결통보
            var tr_id: String = KISManager.currentManager!.getValueForCurrentTargetServer(실전서버: "H0GSCNI0", 모의투자서버: "H0GSCNI9")
            /// HTSID
            /// HTSID
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 고객 ID
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let CUST_ID: String
            /// 계좌번호
            let ACNT_NO: String
            /// 주문번호
            let ODER_NO: String
            /// 원주문번호
            let OODER_NO: String
            /// 매도매수구분
            /// 01:매도 02:매수 03:전매도 04:환매수
            let SELN_BYOV_CLS: String
            /// 정정구분
            /// 0:정상 1:정정 2:취소
            let RCTF_CLS: String
            /// 주문종류2
            /// 1:시장가 2:지정자 6:단주시장가 7:단주지정가 A:MOO B:LOO C:MOC D:LOC
            let ODER_KIND2: String
            /// 주식 단축 종목코드
            let STCK_SHRN_ISCD: String
            /// 체결수량
            /// - 주문통보의 경우 해당 위치에 주문수량이 출력 - 체결통보인 경우 해당 위치에 체결수량이 출력
            let CNTG_QTY: String
            /// 체결단가
            /// ※ 주문통보 시에는 주문단가가, 체결통보 시에는 체결단가가 수신 됩니다. ※ 체결단가의 경우, 국가에 따라 소수점 생략 위치가 상이합니다. 미국 4 일본 1 중국 3 홍콩 3 베트남 0 EX) 미국 AAPL(현재가 : 148.0100)의 경우 001480100으로 체결단가가 오는데, 4번째 자리에 소수점을 찍어 148.01로 해석하시면 됩니다.
            let CNTG_UNPR: String
            /// 주식 체결 시간
            /// 특정 거래소의 체결시간 데이터는 수신되지 않습니다. 체결시간 데이터가 필요할 경우, 체결통보 데이터 수신 시 타임스탬프를 찍는 것으로 대체하시길 바랍니다.
            let STCK_CNTG_HOUR: String
            /// 거부여부
            /// 0:정상 1:거부
            let RFUS_YN: String
            /// 체결여부
            /// 1:주문,정정,취소,거부 2:체결
            let CNTG_YN: String
            /// 접수여부
            /// 1:주문접수 2:확인 3:취소(FOK/IOC)
            let ACPT_YN: String
            /// 지점번호
            let BRNC_NO: String
            /// 주문 수량
            /// - 주문통보인 경우 해당 위치 미출력 (주문통보의 주문수량은 CNTG_QTY 위치에 출력) - 체결통보인 경우 해당 위치에 주문수량이 출력
            let ODER_QTY: String
            /// 계좌명
            let ACNT_NAME: String
            /// 체결종목명
            let CNTG_ISNM: String
            /// 해외종목구분
            /// 4:홍콩(HKD) 5:상해B(USD) 6:NASDAQ 7:NYSE 8:AMEX 9:OTCB C:홍콩(CNY) A:상해A(CNY) B:심천B(HKD) D:도쿄 E:하노이 F:호치민
            let ODER_COND: String
            /// 담보유형코드
            /// 10:현금 15:해외주식담보대출
            let DEBT_GB: String
            /// 담보대출일자
            /// 대출일(YYYYMMDD)
            let DEBT_DATE: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }

    struct 해외주식_실시간호가_미국 : KISWebSocketITEM {
        var initialMessage: Send
        public var server: ServerInfo = .init(domain: KISManager.currentManager?.targetServer.getValue(실전서버: "ws://ops.koreainvestment.com:21000", 모의투자서버: "모의투자 미지원") ?? "", defaultHeader: [:])
        public var path: String = "/tryitout/HDFSASP0"
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
            /// HDFSASP0
            var tr_id: String = "HDFSASP0"
            /// R거래소명종목코드
            /// <미국 야간거래 - 무료시세> D+시장구분(3자리)+종목코드 예) DNASAAPL : D+NAS(나스닥)+AAPL(애플) [시장구분] NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 <미국 야간거래 - 유료시세> ※ 유료시세 신청시에만 유료시세 수신가능 "포럼 > FAQ > 해외주식 유료시세 신청방법" 참고 R+시장구분(3자리)+종목코드 예) RNASAAPL : D+NAS(나스닥)+AAPL(애플) [시장구분] NYS : 뉴욕, NAS : 나스닥, AMS : 아멕스 <미국 주간거래> R+시장구분(3자리)+종목코드 예) RBAQAAPL : R+BAQ(나스닥)+AAPL(애플) [시장구분] BAY : 뉴욕(주간), BAQ : 나스닥(주간). BAA : 아멕스(주간)
            let tr_key: String
        }
        struct Init_Msg: Codable {
            let header: Header
            let body: Body
        }
        struct Receive_Msg : Codable {
            /// 실시간종목코드
            /// '각 항목사이에는 구분자로 ^ 사용, 모든 데이터타입은 String으로 변환되어 push 처리됨'
            let rsym: String
            let bstp_cls_code: BSTP_CLS_CODE
        }
        struct BSTP_CLS_CODE : Codable {
            /// 종목코드
            let symb: String
            /// 소숫점자리수
            let zdiv: String
            /// 현지일자
            let xymd: String
            /// 현지시간
            let xhms: String
            /// 한국일자
            let kymd: String
            /// 한국시간
            let khms: String
            /// 매수총잔량
            let bvol: String
            /// 매도총잔량
            let avol: String
            /// 매수총잔량대비
            let bdvl: String
            /// 매도총잔량대비
            let advl: String
            /// 매수호가1
            let pbid1: String
            /// 매도호가1
            let pask1: String
            /// 매수잔량1
            let vbid1: String
            /// 매도잔량1
            let vask1: String
            /// 매수잔량대비1
            let dbid1: String
            /// 매도잔량대비1
            let dask1: String
            /// 매수호가2
            let pbid2: String
            /// 매도호가2
            let pask2: String
            /// 매수잔량2
            let vbid2: String
            /// 매도잔량2
            let vask2: String
            /// 매수잔량대비2
            let dbid2: String
            /// 매도잔량대비2
            let dask2: String
            /// 매수호가3
            let pbid3: String
            /// 매도호가3
            let pask3: String
            /// 매수잔량3
            let vbid3: String
            /// 매도잔량3
            let vask3: String
            /// 매수잔량대비3
            let dbid3: String
            /// 매도잔량대비3
            let dask3: String
            /// 매수호가4
            let pbid4: String
            /// 매도호가4
            let pask4: String
            /// 매수잔량4
            let vbid4: String
            /// 매도잔량4
            let vask4: String
            /// 매수잔량대비4
            let dbid4: String
            /// 매도잔량대비4
            let dask4: String
            /// 매수호가5
            let pbid5: String
            /// 매도호가5
            let pask5: String
            /// 매수잔량5
            let vbid5: String
            /// 매도잔량5
            let vask5: String
            /// 매수잔량대비5
            let dbid5: String
            /// 매도잔량대비5
            let dask5: String
            /// 매수호가6
            let pbid6: String
            /// 매도호가6
            let pask6: String
            /// 매수잔량6
            let vbid6: String
            /// 매도잔량6
            let vask6: String
            /// 매수잔량대비6
            let dbid6: String
            /// 매도잔량대비6
            let dask6: String
            /// 매수호가7
            let pbid7: String
            /// 매도호가7
            let pask7: String
            /// 매수잔량7
            let vbid7: String
            /// 매도잔량7
            let vask7: String
            /// 매수잔량대비7
            let dbid7: String
            /// 매도잔량대비7
            let dask7: String
            /// 매수호가8
            let pbid8: String
            /// 매도호가8
            let pask8: String
            /// 매수잔량8
            let vbid8: String
            /// 매도잔량8
            let vask8: String
            /// 매수잔량대비8
            let dbid8: String
            /// 매도잔량대비8
            let dask8: String
            /// 매수호가9
            let pbid9: String
            /// 매도호가9
            let pask9: String
            /// 매수잔량9
            let vbid9: String
            /// 매도잔량9
            let vask9: String
            /// 매수잔량대비9
            let dbid9: String
            /// 매도잔량대비9
            let dask9: String
            /// 매수호가10
            let pbid10: String
            /// 매도호가10
            let pask10: String
            /// 매수잔량10
            let vbid10: String
            /// 매도잔량10
            let vask10: String
            /// 매수잔량대비10
            let dbid10: String
            /// 매도잔량대비10
            let dask10: String
        }
        var send = Init_Msg.self
        var receive = Receive_Msg.self
    }
}
