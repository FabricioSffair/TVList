//
//  Episode.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-25.
//

import Foundation

struct Episode: Decodable, Identifiable, Equatable {
    let id: Int
    let name: String
    let season: Int
    let number: Int?
    let type: String
    let airdate: Date
    let airtime: String?
    let runtime: Int
    let rating: Rating
    let image: SeriesImage?
    let summary: String
}
