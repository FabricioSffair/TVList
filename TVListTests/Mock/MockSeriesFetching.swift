//
//  MockSeriesFetching.swift
//  TVListTests
//
//  Created by Fabrício Sperotto Sffair on 2022-05-24.
//

import Foundation
@testable import TVList

final class MockSeriesFetching: SeriesFetching {
    
    var pageCalled: Int?
    var searchStringCalled: String?
    var seriesToReturn: [Series]?
    
    func getSeries(at page: Int) async throws -> [Series] {
        pageCalled = page
        return seriesToReturn!
    }
    
    func searchSeries(containing searchString: String) async throws -> [SearchResult] {
        searchStringCalled = searchString
        return [.init(score: 0.965, series: seriesToReturn!.first)]!
    }
}
