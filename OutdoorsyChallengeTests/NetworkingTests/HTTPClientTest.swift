//
//  HTTPClientTest.swift
//  OutdoorsyChallengeTests
//
//  Created by Gabriela Bakalova on 2.10.23.
//

import XCTest
@testable import OutdoorsyChallenge

final class HTTPClientTest: XCTestCase {

    private var urlSession: URLSessionMock!
    private var httpClient: HTTPClient!
    
    override func setUp() {
        super.setUp()
        urlSession = .init()
        httpClient = .init(urlSession: urlSession)
    }

   // TODO: Add more test for the failure scenarios
    
    func testSendRequestURLEndpoint() async throws {
        var endpoint = EndpointMock()
        endpoint.host = "test.com"
        endpoint.path = "/test"
        endpoint.queryItems = [.init(name: "param1", value: "value1"), .init(name: "param2", value: "value2")]

        urlSession.dataTaskHandler = { request, delegate in
            let url = request.url
            XCTAssertEqual(request.httpMethod, "GET")
            XCTAssertEqual(url?.scheme, "https")
            XCTAssertEqual(url?.host, "test.com")
            XCTAssertEqual(url?.path, "/test")
            XCTAssertEqual(url?.query, "param1=value1&param2=value2")
            XCTAssertNil(delegate)
            return (Data(), HTTPURLResponse())
        }
        
        do {
            _ = try await httpClient.sendRequest(endpoint: endpoint, responseModelType: ResponseMock.self)
        } catch let error as NetworkingError {
            XCTAssertEqual(error, NetworkingError.generic)
        }
        
        XCTAssertEqual(urlSession.dataTaskCallCount, 1)
    }
}

struct ResponseMock: Decodable {
    let property: String
}

fileprivate struct EndpointMock: Endpoint {
    var host: String = "test.com"
    var path: String = "/test"
    var method: RequestMethod = .get
    var queryItems: [URLQueryItem]? = [.init(name: "param1", value: "value1"), .init(name: "param2", value: "value2")]
}
