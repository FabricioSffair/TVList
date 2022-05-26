//
//  ClientServiceTests.swift
//  TVListTests
//
//  Created by Fabrício Sperotto Sffair on 2022-05-24.
//

import Client
import XCTest

@testable import TVList

class ClientServiceTests: XCTestCase, MockProvider {

    private var sut: ClientService!
    private var mockClientRequester: MockClientRequester!
    
    override func setUp() {
        mockClientRequester = MockClientRequester()
        sut = ClientService(clientRequester: mockClientRequester)
    }
    
    override func tearDown() {
        mockClientRequester = nil
        sut = nil
    }
    
    func testGetSeries() {
        let getSeriesExpectation = expectation(description: "Get series async call returned")
        let mockedSeries = mockedSeries()
        mockClientRequester.response = mockedSeries
        let endpoint = Endpoint.getSeries(0)
        let expectedURL = endpoint.createClientRequest().url
        Task {
            do {
                let series = try await sut.getSeries(at: 0)
                XCTAssertEqual(series, mockedSeries)
                XCTAssertEqual(expectedURL, mockClientRequester.urlCalled)
                getSeriesExpectation.fulfill()
            } catch {
                XCTFail("Failed to call get series!")
            }
        }
        wait(for: [getSeriesExpectation], timeout: 2.0)
    }

}
