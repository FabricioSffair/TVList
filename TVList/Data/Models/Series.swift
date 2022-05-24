//
//  Series.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-24.
//

import Foundation

struct Series: Decodable, Identifiable {
    
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
    let image: SeriesImage
    let summary: String?
    
    struct Schedule: Decodable {
        
        let time: String
        let days: [String]
    }
    
    struct Rating: Decodable {
        
        let average: Double?
    }
    
    struct Network: Decodable {
        
        struct Country: Decodable {
            let name: String
            let code: String
            let timezone: String?
        }
        
        let id: Int
        let name: String?
        let country: Country
        let officialSite: String?
    }
    
    struct SeriesImage: Decodable {
        
        let medium: String?
        let original: String?
    }
}
