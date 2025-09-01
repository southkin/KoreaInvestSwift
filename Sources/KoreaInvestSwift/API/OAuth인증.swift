//
//  OAuth인증.swift
//  KoreaInvestSwift
//
//  Created by kin on 3/24/25.
//

import Foundation
import FullyRESTful

public extension KISAPI {
    enum OAuth인증 {
        
    }
}

public extension KISAPI.OAuth인증 {
    ///실시간 (웹소켓) 접속키 발급[실시간-000]
    ///실시간 (웹소켓) 접속키 발급받으실 수 있는 API 입니다.
    ///웹소켓 이용 시 해당 키를 appkey와 appsecret 대신 헤더에 넣어 API를 호출합니다.
    ///접속키의 유효기간은 24시간이지만, 접속키는 세션 연결 시 초기 1회만 사용하기 때문에 접속키 인증 후에는 세션종료되지 않는 이상 접속키 신규 발급받지 않으셔도 365일 내내 웹소켓 데이터 수신하실 수 있습니다.
    struct Approval : APIITEM {
        public struct Request : Codable {
            ///권한부여타입
            let grant_type:String
            ///앱키
            ///한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appkey:String
            ///시크릿키
            ///한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
            ///* 주의 : appsecret와 secretkey는 동일하오니 착오없으시기 바랍니다. (용어가 다른점 양해 부탁드립니다.)
            let secretkey:String
            init() {
                self.grant_type = "client_credentials"
                self.appkey = KISManager.currentManager?.baseHeader["appkey"] ?? ""
                self.secretkey = KISManager.currentManager?.baseHeader["appsecret"] ?? ""
            }
        }
        public struct Response : Codable {
            ///웹소켓 접속키
            ///웹소켓 이용 시 발급받은 웹소켓 접속키를 appkey와 appsecret 대신 헤더에 넣어 API 호출합니다.
            let approval_key:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/oauth2/Approval"
        public var customHeader: [String : String]?
        init() throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
            ])
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
        }
    }
    
    ///Hashkey
    ///해쉬키(Hashkey)는 보안을 위한 요소로 사용자가 보낸 요청 값을 중간에 탈취하여 변조하지 못하도록 하는데 사용됩니다.
    ///해쉬키를 사용하면 POST로 보내는 요청(주로 주문/정정/취소 API 해당)의 body 값을 사전에 암호화시킬 수 있습니다.
    ///해쉬키는 비필수값으로 사용하지 않아도 POST API 호출은 가능합니다.
    struct hashkey : APIITEM {
        public struct Request : Codable {
            ///요청값
            ///POST로 보낼 body값
            ///ex)
            ///datas = {
            ///"CANO": '00000000',
            ///"ACNT_PRDT_CD": "01",
            ///"OVRS_EXCG_CD": "SHAA"
            ///}
            let JsonBody:String
        }
        public struct Response : Codable {
            ///요청값
            ///요청한 JsonBody
//            let JsonBody:[String:Any]
            ///해쉬키
            ///[POST API 대상] Client가 요청하는 Request Body를 hashkey api로 생성한 Hash값
            ///* API문서 > hashkey 참조
            let HASH:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/uapi/hashkey"
        public var customHeader: [String : String]?
        init() throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
                "appkey",
                "appsecret"
            ])
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
        }
    }
    
    struct tokenP : APIITEM {
        ///접근토큰발급(P)[인증-001]
        ///본인 계좌에 필요한 인증 절차로, 인증을 통해 접근 토큰을 부여받아 오픈API 활용이 가능합니다.
        ///1. 접근토큰(access_token)의 유효기간은 24시간 이며(1일 1회발급 원칙)
        ///   갱신발급주기는 6시간 입니다.(6시간 이내는 기존 발급키로 응답)
        ///2. 접근토큰발급(/oauth2/tokenP) 시 접근토큰값(access_token)과 함께 수신되는
        ///   접근토큰 유효기간(acess_token_token_expired)을 이용해 접근토큰을 관리하실 수 있습니다.
        ///[참고]
        ///'23.4.28 이후 지나치게 잦은 토큰 발급 요청건을 제어 하기 위해 신규 접근토큰발급 이후 일정시간 이내에 재호출 시에는 직전 토큰값을 리턴하게 되었습니다. 일정시간 이후 접근토큰발급 API 호출 시에는 신규 토큰값을 리턴합니다.
        ///접근토큰발급 API 호출 및 코드 작성하실 때 해당 사항을 참고하시길 바랍니다.
        ///※ 참고 : 포럼 > 공지사항 >  [수정] [중요] 접근 토큰 발급 변경 안내
        public struct Request : Codable {
            ///권한부여
            ///client_credentials
            let grant_type:String
            ///앱키
            ///한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appkey:String
            ///앱시크릿키
            ///한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
            let appsecret:String
        }
        public struct Response : Codable {
            ///접근토큰
            ///OAuth 토큰이 필요한 API 경우 발급한 Access token
            ///- 일반개인고객/일반법인고객
            ///. Access token 유효기간 1일
            ///.. 일정시간(6시간) 이내에 재호출 시에는 직전 토큰값을 리턴
            ///. OAuth 2.0의 Client Credentials Grant 절차를 준용
            ///- 제휴법인
            ///. Access token 유효기간 3개월
            ///. Refresh token 유효기간 1년
            ///. OAuth 2.0의 Authorization Code Grant 절차를 준용
            ///ex) "eyJ0eXUxMiJ9.eyJz…..................................."
            let access_token:String
            ///접근토큰유형
            ///접근토큰유형 : "Bearer"
            ///※ API 호출 시, 접근토큰유형 "Bearer" 입력. ex) "Bearer eyJ...."
            let token_type:String
            ///접근토큰유효기간
            ///유효기간(초)
            ///ex) 7776000
            let expires_in:Int
            ///접근토큰 유효기간(일시표시)
            ///유효기간(년:월:일 시:분:초)
            ///ex) "2022-08-30 08:10:10"
            let access_token_token_expired:String
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/oauth2/tokenP"
        public var customHeader: [String : String]?
        init() throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
            ])
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
        }
    }
    ///접근토큰폐기(P)[인증-002]
    ///부여받은 접큰토큰을 더 이상 활용하지 않을 때 사용합니다.
    struct revokeP : APIITEM {
        public struct Request : Codable {
            ///고객 앱Key
            ///한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
            let appkey:String
            ///고객 앱Secret
            ///한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
            let appsecret:String
            ///접근토큰
            ///OAuth 토큰이 필요한 API 경우 발급한 Access token
            ///일반고객(Access token 유효기간 1일, OAuth 2.0의 Client Credentials Grant 절차를 준용)
            ///법인(Access token 유효기간 3개월, Refresh token 유효기간 1년, OAuth 2.0의 Authorization Code Grant 절차를 준용)
            let token:String
        }
        public struct Response : Codable {
            ///응답코드
            ///HTTP 응답코드
            let code:String?
            ///응답메세지
            ///응답메세지
            let message:String?
        }
        public let requestModel = Request.self
        public let responseModel = Response.self
        public var method:HTTPMethod = .POST
        public let server: ServerInfo
        public let path = "/oauth2/revokeP"
        public var customHeader: [String : String]?
        init() throws {
            self.server = try KISManager.currentManager!.getCurrentServer()
            self.customHeader = KISManager.currentManager!.headerPick(names: [
            ])
            self.customHeader?["Content-Type"] = "application/json; charset=utf-8"
        }
    }
}


