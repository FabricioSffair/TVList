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
    case getEpisodes(Int)
    
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
        case .getEpisodes(let seriesId):
            return "/shows/\(seriesId)/episodes"
        }
    }
    
    private var parameters: URLParameters {
        switch self {
        case .getSeries(let page):
            return ["page": String(page)]
        case .searchSeries(let search):
            return ["q": search]
        case .getEpisodes:
            return [:]
        }
    }
    
    private var httpMethod: HTTPMethod {
        switch self {
        case .getSeries, .searchSeries, .getEpisodes:
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
