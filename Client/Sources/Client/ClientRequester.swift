//
//  ClientRequester.swift
//  
//
//  Created by Fabrício Sperotto Sffair on 2022-05-23.
//

import Foundation

public protocol ClientRequestable {
    
    var requestTimeOut: Int { get }
    func request<T>(_ req: ClientRequestRepresentable) async throws -> T where T: Decodable
}

protocol URLSessionRequester {
    var configuration: URLSessionConfiguration { get }
    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession : URLSessionRequester { }

public class ClientRequester: ClientRequestable {
    
    public init() { }
    
    var session: URLSessionRequester = URLSession.shared
    public var requestTimeOut: Int = 5
    
    public func request<T>(_ req: ClientRequestRepresentable) async throws -> T where T: Decodable {
        
        if let timeout = req.timeout {
            session.configuration.timeoutIntervalForRequest = TimeInterval(timeout)
        }
        
        guard let url = req.buildURLRequest()?.url else {
            throw ClientRequestError.badURL
        }
        
        do {
            let (data, response) = try await session.data(from: url, delegate: nil)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.iso8601Short)
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            throw error
        }
    }
}

