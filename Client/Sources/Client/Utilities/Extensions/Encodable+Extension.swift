//
//  Encodable+Extensio.swift
//  
//
//  Created by Fabrício Sperotto Sffair on 2022-05-23.
//

import Foundation

extension Encodable {
    public func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
