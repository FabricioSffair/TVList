//
//  TVListTests.swift
//  TVListTests
//
//  Created by Fabrício Sperotto Sffair on 2022-05-20.
//

import Combine
import XCTest

@testable import TVList

class SeriesRepositoryTests: XCTestCase, MockProvider {

    var sut: SeriesRepository!
    var seriesFetching: MockSeriesFetching!
    var subscribers: Set<AnyCancellable> = []

    override func setUp() {
        seriesFetching = MockSeriesFetching()
        sut = SeriesRepository(remote: seriesFetching, localDatabase: FakeProvider())
    }
    
    override func tearDown() {
        sut = nil
        seriesFetching = nil
        subscribers = []
    }
    
    func testCallGetSeries() throws {
        let getStringsExpectation = expectation(description: "Received series from getSeries publisher expectation")
        let pageCall = 4
        let searchString = "Test"
        let mockedSeries = mockedSeries()
        seriesFetching.seriesToReturn = mockedSeries
        sut.seriesPublisher.sink { series in
            XCTAssertEqual(series, mockedSeries)
            XCTAssertEqual(self.seriesFetching.pageCalled, pageCall)
            getStringsExpectation.fulfill()
        }
        .store(in: &subscribers)
        
        sut.getSeries(at: pageCall)
        wait(for: [getStringsExpectation], timeout: 2.0)
    }
}
