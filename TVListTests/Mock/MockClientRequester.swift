//
//  MockClientRequester.swift
//  TVListTests
//
//  Created by Fabrício Sperotto Sffair on 2022-05-24.
//

import Foundation
import Client

@testable import TVList

final class MockClientRequester: ClientRequestable {
    
    var requestTimeOut: Int = 0
    var urlCalled: String?
    var response: [Series]?
    
    func request<T>(_ req: ClientRequestRepresentable) async throws -> T where T : Decodable {
        urlCalled = req.url
        return response as! T
    }
}
