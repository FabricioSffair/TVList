//
//  Env.swift
//  
//
//  Created by Fabrício Sperotto Sffair on 2022-05-23.
//

import Foundation

public enum Env: String, CaseIterable {
    case local
    case dev
    case prod
    
    var baseUrl: String {
        return "https://api.tvmaze.com"
    }
}
