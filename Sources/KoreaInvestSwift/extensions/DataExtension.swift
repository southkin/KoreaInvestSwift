//
//  DataExtension.swift
//  KoreaInvestSwift
//
//  Created by kin on 3/24/25.
//

import Foundation
public extension Data {
    func makeObj<T:Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
    func makeObj<T:Decodable>(type:T.Type) -> T? {
        return makeObj()
    }
    var dict:[String:Any]? {
        return try? JSONSerialization.jsonObject(with: self) as? [String:Any]
    }
    func string(encoding:String.Encoding = .utf8) -> String {
        return String(data: self, encoding: encoding) ?? ""
    }
}
