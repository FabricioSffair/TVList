import XCTest
@testable import Client

final class ClientRequesterTests: XCTestCase {
    
    var sut: ClientRequester!
    var mockSession: MockURLSession!
    
    override func setUp() {
        sut = ClientRequester()
        mockSession = MockURLSession()
        sut.session = mockSession
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        mockSession = nil
    }
    
    func testRequestWithValidURL() {
        let urlRequest = Endpoint.getSeries(0).createClientRequest()
        mockSession.response = URLResponse(url: urlRequest.buildURLRequest()!.url!, mimeType: "", expectedContentLength: 100, textEncodingName: "")
        let mockedData = MockedData.shared
        mockSession.responseData = try! JSONEncoder().encode(mockedData)
        Task {
            do {
                let response: MockedData = try await sut.request(urlRequest)
                XCTAssertEqual(response, mockedData)
            } catch {
                XCTFail("Test request failed with error: \(error)")
            }
            
        }
    }
    
    func testRequestWithInvalidURL() {
        let urlRequest = ClientRequest(url: "", headers: nil, body: nil, timeout: nil, httpMethod: .GET, urlParameters: [:])
        let mockedData = MockedData.shared
        mockSession.responseData = try! JSONEncoder().encode(mockedData)
        Task {
            do {
                let _: MockedData = try await sut.request(urlRequest)
                XCTFail("Test sending invalid url didn't throw error")
            } catch {
                XCTAssertEqual(error as! ClientRequestError, ClientRequestError.badURL)
            }
        }
    }
}


struct MockedData: Codable, Equatable {
    let id: Int
    let name: String
    
    static let shared: MockedData = .init(id: 1, name: "Test")
}
