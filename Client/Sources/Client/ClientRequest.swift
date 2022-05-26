//
//  ClientRequest.swift
//
//
//  Created by Fabrício Sperotto Sffair on 2022-05-23.
//

import Foundation

public typealias Headers = [String: String]
public typealias URLParameters = [String: String?]

public protocol ClientServicable {
    var clientRequester: ClientRequestable { get }
}

public protocol ClientRequestRepresentable {
    var url: String { get }
    var headers: [String: String]? { get }
    var body: Encodable? { get }
    var timeout: Float? { get }
    var httpMethod: HTTPMethod { get }
    var urlParameters: URLParameters { get }
    func buildURLRequest() -> URLRequest?
}

public struct ClientRequest: ClientRequestRepresentable {
    
    public let url: String
    public let headers: [String: String]?
    public let body: Encodable?
    public let timeout: Float?
    public let httpMethod: HTTPMethod
    public let urlParameters: URLParameters
    
    public init(url: String,
                headers: [String: String]?,
                body: Encodable?,
                timeout: Float?,
                httpMethod: HTTPMethod,
                urlParameters: URLParameters) {
        self.url = url
        self.headers = headers
        self.body = body
        self.timeout = timeout
        self.httpMethod = httpMethod
        self.urlParameters = urlParameters
    }
    
    public func buildURLRequest() -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        let urlWithParams = urlParameters.reduce(url, { result, dict in
            result.appending(dict.key, value: dict.value)
        })
        var urlRequest = URLRequest(url: urlWithParams)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        urlRequest.httpBody = body?.encode()
        return urlRequest
    }
    
    
}
