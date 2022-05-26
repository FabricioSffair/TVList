//
//  Enums.swift
//  
//
//  Created by Fabrício Sperotto Sffair on 2022-05-23.
//

import Foundation

public enum ClientRequestError: Error {
    case badURL
    case apiError(_ error: String)
    case invalidJSON(_ error: String)
    case unauthorized(_ error: String)
    case badRequest(_ error: String)
    case serverError(_ error: String)
    case noResponse(_ error: String)
    case unableToParseData(_ error: String)
    case unknown(_ error: String)
}

public enum HTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

extension ClientRequestError: Equatable {} 
