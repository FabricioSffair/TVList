//
//  File.swift
//  
//
//  Created by Fabrício Sperotto Sffair on 2022-05-24.
//

import Foundation
@testable import Client

final class MockURLSession: URLSessionRequester {
    
    var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    
    var responseData: Data!
    var response: URLResponse!
    var urlCalled: URL? = nil
    
    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        self.urlCalled = url
        return (responseData, response)
    }
}
