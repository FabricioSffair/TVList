//
//  Endpoint.swift
//  
//
//  Created by Fabrício Sperotto Sffair on 2022-05-23.
//

import Foundation

public enum Endpoint {
    
    case getSeries(Int)
    case searchSeries(String)
    
    var timeout: Float { 3 }
    
    var env: Env {
        return .prod
    }
    
    private var path: String {
        switch self {
        case .getSeries:
            return "/shows"
        case .searchSeries:
            return "/search/shows"
        }
    }
    
    private var parameters: URLParameters {
        switch self {
        case .getSeries(let page):
            return ["page": String(page)]
        case .searchSeries(let search):
            return ["q": search]
        }
    }
    
    private var httpMethod: HTTPMethod {
        switch self {
        case .getSeries, .searchSeries:
            return .GET
        }
    }
    
    private var requestBody: Encodable? {
        return nil
    }
    
    private var headers: Headers {
        return ["Content-Type": "application/json"]
    }
    
    public func createClientRequest() -> ClientRequest {
        return ClientRequest(
            url: env.baseUrl + path,
            headers: headers,
            body: requestBody,
            timeout: timeout,
            httpMethod: httpMethod,
            urlParameters: parameters
        )
    }
}
