// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import FullyRESTful

import Combine

public enum TargetServer {
    case 실전서버
    case 모의투자서버
    public var server:ServerInfo {
        switch self {
        case .모의투자서버:
            return .init(domain: "https://openapivts.koreainvestment.com:29443", defaultHeader: ["Content-Type": "application/json; utf-8"])
        case .실전서버:
            return .init(domain: "https://openapi.koreainvestment.com:9443", defaultHeader: ["Content-Type": "application/json; utf-8"])
            
        }
    }
    public var websocketServer:ServerInfo {
        switch self {
        case .모의투자서버:
            return .init(domain: "ws://ops.koreainvestment.com:21000", defaultHeader: ["Content-Type": "application/json; utf-8"])
        case .실전서버:
            return .init(domain: "ws://ops.koreainvestment.com:31000", defaultHeader: ["Content-Type": "application/json; utf-8"])
            
        }
    }
    public func getValue<T>(실전서버:T, 모의투자서버:T) -> T {
        switch self {
        case .모의투자서버:
            return 모의투자서버
        case .실전서버:
            return 실전서버
        }
    }
}

public class KISManager {
    public struct InitInfo : Codable {
        ///계좌번호
        ///한국투자증권에서 생성된 계좌번호(00000000-00 형식)
        var account_id:String
        ///앱키
        ///한국투자증권 홈페이지에서 발급받은 appkey (절대 노출되지 않도록 주의해주세요.)
        var CANO:String
        var ACNT_PRDT_CD:String
        var appkey:String
        ///앱시크릿키
        ///한국투자증권 홈페이지에서 발급받은 appsecret (절대 노출되지 않도록 주의해주세요.)
        var appsecret:String
        ///고객식별키
        ///[법인 필수] 제휴사 회원 관리를 위한 고객식별키
        var personalseckey:String?
        ///고객타입
        ///B : 법인
        ///P : 개인
        var custtype:String?
        ///일련번호
        ///[법인 필수] 001
        var seq_no:String?
        ///맥주소
        ///법인고객 혹은 개인고객의 Mac address 값
        var mac_address:String?
        ///핸드폰번호
        ///[법인 필수] 제휴사APP을 사용하는 경우 사용자(회원) 핸드폰번호
        ///ex) 01011112222 (하이픈 등 구분값 제거)
        var phone_number:String?
        ///접속 단말 공인 IP
        ///[법인 필수] 사용자(회원)의 IP Address
        var ip_addr:String?
        public init(account_id: String, appkey: String, appsecret: String, personalseckey: String? = nil, custtype: String? = nil, seq_no: String? = nil, mac_address: String? = nil, phone_number: String? = nil, ip_addr: String? = nil) {
            self.account_id = account_id
            self.CANO = account_id.components(separatedBy: "-")[0]
            self.ACNT_PRDT_CD = account_id.components(separatedBy: "-")[1]
            self.appkey = appkey
            self.appsecret = appsecret
            self.personalseckey = personalseckey
            self.custtype = custtype
            self.seq_no = seq_no
            self.mac_address = mac_address
            self.phone_number = phone_number
            self.ip_addr = ip_addr
        }
    }
    nonisolated(unsafe) static var currentManager: KISManager?
    let targetServer:TargetServer
    let baseHeader: [String: String]
    var accessToken:AccessToken?
    var websocketAccessToken:AccessToken?
    @discardableResult
    public init(
        targetServer:TargetServer,
        initInfo:InitInfo
    ) throws {
        self.targetServer = targetServer
        self.baseHeader = initInfo.header ?? [:]
        self.accessToken = UserDefaults.standard.string(forKey: "accessToken")?.makeObj()
//        guard let _ = KISManager.currentManager else {
            KISManager.currentManager = self
//            return
//        }
//        print("KISManager 는 하나의 인스턴스만 사용하여야 합니다.")
//        throw NSError(domain: "KISManager", code: -1, userInfo: nil)
    }
    public func getCurrentServer() throws -> ServerInfo {
        return targetServer.server
    }
    public func getValueForCurrentTargetServer<VALUE>(실전서버:VALUE, 모의투자서버:VALUE) -> VALUE {
        targetServer.getValue(실전서버: 실전서버, 모의투자서버: 모의투자서버) ?? 모의투자서버
    }
    func headerPick(names:[String]) -> [String: String] {
        var newList:[String: String] = [:]
        let header = baseHeader
        names.forEach {
            newList[$0] = header[$0]
        }
        
        return newList
    }
    struct AccessToken : Codable {
        let token:String
        let rawToken:String
        let tokenType:String
        let expiresAt:Date
        var isExpired: Bool {
                Date() >= expiresAt
            }
    }
    func getAccessToken() async -> AccessToken? {
        guard
            let appkey = baseHeader["appkey"],
            let appsecret = baseHeader["appsecret"]
        else {
            return nil
        }
        if let accessToken = accessToken, !accessToken.isExpired {
            return accessToken
        }
        let result = try? await KISAPI.OAuth인증.tokenP().request(param: .init(grant_type: "client_credentials", appkey: appkey, appsecret: appsecret))?.model
        guard let result else {
            return nil
        }
        accessToken = .init(
            token: "\(result.token_type) \(result.access_token)",
            rawToken: result.access_token,
            tokenType: result.token_type,
            expiresAt: Date().addingTimeInterval(TimeInterval(result.expires_in)))
        UserDefaults.standard.set(accessToken?.JSONString, forKey: "accessToken")
        return accessToken
    }
    func getWebsocketAccessToken() async -> AccessToken? {
        guard
              let _ = baseHeader["appkey"],
              let _ = baseHeader["appsecret"]
        else {
            return nil
        }
        if let accessToken = websocketAccessToken, !accessToken.isExpired {
            return accessToken
        }
        let result = try? await KISAPI.OAuth인증.Approval().request(param: .init())?.model
        guard let result else {
            return nil
        }
        websocketAccessToken = .init(
            token: result.approval_key,
            rawToken: result.approval_key,
            tokenType: "",
            expiresAt: Date().addingTimeInterval(60*60*23))
        return websocketAccessToken
    }
    public func getCANO() -> String {
        let info = headerPick(names: ["CANO"])
        return info["CANO"] ?? ""
    }
    public func ACNT_PRDT_CD() -> String {
        let info = headerPick(names: ["ACNT_PRDT_CD"])
        return info["ACNT_PRDT_CD"] ?? ""
    }
}


public enum KISAPI{}
public protocol NeedHash {}
public extension APIITEM {
    func getHashHeaderIfNeeded(param: RequestModel) async -> String {
        if let _ = self as? NeedHash {
            let result = try? await KISAPI.OAuth인증.hashkey().request(param: .init(JsonBody: param.JSONString ?? ""))
            return result?.model?.HASH ?? ""
        }
        return ""
    }
}
public protocol Pagingable {
    var hasNext: Bool { get set }
    var reqItem: any Codable { get set }
}
public extension APIITEM {
    mutating func run(param:RequestModel) async throws -> ResponseModel? {
        if var header = customHeader {
            header.removeValue(forKey: "tr_cont")
            header["hashkey"] = await getHashHeaderIfNeeded(param: param)
            customHeader = header
        }
        let result = try await request(param: param)
        guard let response = result?.rawResponse,
              let obj:ResponseModel = result?.model
        else {
            throw NSError(domain: "KISManager", code: 0, userInfo: nil)
        }
        if var pagingable = self as? Pagingable {
            pagingable.hasNext = response.allHeaderFields["tr_cont"] as? String == "M"
            pagingable.reqItem = param as! Codable
        }
        return obj
    }
    mutating func next() async throws -> ResponseModel? {
        if var pagingable = self as? Pagingable {
            guard pagingable.hasNext else {
                return nil
            }
            guard let reqParam = pagingable.reqItem as? RequestModel else {
                print("리퀘스트 정보가 없습니다")
                throw NSError(domain: "KISManager", code: 0, userInfo: nil)
            }
            if var header = customHeader {
                header["tr_cont"] = "N"
                header["hashkey"] = await getHashHeaderIfNeeded(param: reqParam)
                self.customHeader = header
            }
            let result = try await request(param: reqParam)
            guard let response = result?.rawResponse,
                  let obj:ResponseModel = result?.model
            else {
                print("뭐라그래야해? 암튼 실패")
                throw NSError(domain: "KISManager", code: 0, userInfo: nil)
            }
            pagingable.hasNext = response.allHeaderFields["tr_cont"] as? String == "M"
            return obj
        }
        return nil
    }
}

protocol KISWebSocketITEM: WebSocketITEM {
    associatedtype Send: Codable
    associatedtype Receive: Codable
    
    var initialMessage: Send { get }
    var decoder: JSONDecoder { get }
    var send:Send.Type { get }
    var receive:Receive.Type { get }
}

extension KISWebSocketITEM {
    var decoder: JSONDecoder { JSONDecoder() }

    func listen() -> AnyPublisher<Receive, Error> {
        // WebSocketITEM.listen() 기반 publisher 구독
        self.listen()
            .decode(Receive.self)
            .eraseToAnyPublisher()
    }

    func connectAndSendInitialMessage() async throws {
        _ = try await self.send(.codable(initialMessage))
    }
}
public extension Publisher where Output == WebSocketReceiveMessageModel, Failure == Never {
    func decode<T: Decodable>(_ type: T.Type) -> AnyPublisher<T, Error> {
        self
            .tryMap { message in
                switch message {
                case .text(let text):
                    guard let data = text.data(using: .utf8) else {
                        throw URLError(.cannotDecodeRawData)
                    }
                    return try JSONDecoder().decode(T.self, from: data)
                case .binary(let data):
                    return try JSONDecoder().decode(T.self, from: data)
                }
            }
            .eraseToAnyPublisher()
        
    }
}



