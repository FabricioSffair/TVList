//
//  MockProvider.swift
//  TVListTests
//
//  Created by Fabrício Sperotto Sffair on 2022-05-24.
//

import Foundation

@testable import TVList
import XCTest

protocol MockProvider {
    func mockedSeries() -> [Series]
}
extension MockProvider {
    func mockedSeries() -> [Series] {
        [
            .init(
                id: 1,
                url: "",
                name: "test",
                type: "Test",
                language: "test",
                genres: [],
                status: "Ended",
                runtime: 60,
                averageRunTime: 55,
                premiered: Date.distantPast,
                ended: Date(),
                schedule: .init(time: "22:00", days: ["Monday"]),
                rating: .init(average: 6.5),
                weight: 5,
                network: nil,
                image: SeriesImage.init(medium: "", original: nil),
                summary: "Test summary"
            ),
            .init(
                id: 2,
                url: "",
                name: "test2",
                type: "Test2",
                language: "test2",
                genres: [],
                status: "Running",
                runtime: 60,
                averageRunTime: 55,
                premiered: Date.distantPast,
                ended: Date(),
                schedule: .init(time: "23:00", days: ["Friday"]),
                rating: .init(average: 5.5),
                weight: 8,
                network: nil,
                image: SeriesImage.init(medium: "", original: nil),
                summary: "Test summary 2"
            ),
        ]
    }
    
    func mockedEpisodes() -> [Episode] {
        [
            .init(
                id: 1,
                name: "test1",
                season: 1,
                number: 1,
                type: "Ended",
                airdate: Date(),
                airtime: "",
                runtime: 60,
                rating: Rating.init(average: 6.5),
                image: nil,
                summary: "Testing"
            ),
            .init(
                id: 2,
                name: "test2",
                season: 1,
                number: 2,
                type: "Ended",
                airdate: Date(),
                airtime: "",
                runtime: 60,
                rating: Rating.init(average: 6.5),
                image: nil,
                summary: "Testing2"
            )
        ]
    }
}
