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
    
    func getSeries(at page: Int, containing searchString: String) async throws -> [Series] {
        pageCalled = page
        searchStringCalled = searchString
        return seriesToReturn!
    }
}
