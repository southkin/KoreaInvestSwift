//
//  EncodableExtension.swift
//  KoreaInvestSwift
//
//  Created by kin on 3/24/25.
//

import Foundation

extension Encodable {
    var header: [String: String]? {
        guard let data = self.data else { return nil }
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            return jsonObject as? [String: String]
        } catch {
            print("Failed to convert Encodable to header: \(error)")
            return nil
        }
    }
    var dict: [String: Any]? {
        guard let data = self.data else { return nil }
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            return jsonObject as? [String: Any]
        } catch {
            print("Failed to convert Encodable to dictionary: \(error)")
            return nil
        }
    }
    
    var allProperties: [(String, Encodable?)] {
        var result = [(String, Encodable?)]()
        let mirror = Mirror(reflecting: self)
        guard let style = mirror.displayStyle, style == .struct || style == .class else {
            return []
        }
        for (property, value) in mirror.children {
            if let p = property {
                result.append((p, value as? Encodable))
            }
        }
        return result
    }
    
    var JSONString: String? {
        guard let data = self.data else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    var data: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    func dataWithThrows() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
