//
//  Series.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-24.
//

import Foundation

struct Series: Decodable, Identifiable, Equatable {
    
    let id: Int
    let url: String?
    let name: String
    let type: String
    let language: String
    let genres: [String]
    let status: String?
    let runtime: Int?
    let averageRunTime: Int?
    let premiered: Date?
    let ended: Date?
    let schedule: Schedule
    let rating: Rating
    let weight: Int
    let network: Network?
    let image: SeriesImage?
    let summary: String?
    
    struct Schedule: Decodable, Equatable {
        
        let time: String
        let days: [String]
        
        func toString() -> String {
            days.joined(separator: ", ") + " @ " + time 
        }
    }
    
    struct Rating: Decodable, Equatable {
        
        let average: Double?
    }
    
    struct Network: Decodable, Equatable {
        
        struct Country: Decodable, Equatable {
            let name: String
            let code: String
            let timezone: String?
        }
        
        let id: Int
        let name: String?
        let country: Country
        let officialSite: String?
    }
    
    struct SeriesImage: Decodable, Equatable {
        
        let medium: String
        let original: String?
    }
}


struct SearchResult: Decodable {
    let score: Double
    let show: Series
}
