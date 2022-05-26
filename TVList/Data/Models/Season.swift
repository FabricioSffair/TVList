//
//  Season.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-25.
//

import Foundation

struct Season: Identifiable {
    let id: Int
    var episodes: [Episode]
}
