//
//  HTTPClientMock.swift
//  OutdoorsyChallengeTests
//
//  Created by Gabriela Bakalova on 3.10.23.
//

import XCTest
@testable import OutdoorsyChallenge

final class HTTPClientMock: HTTPClientProtocol {
    
    private(set) var sendRequestCallCount = 0
    var sendRequestHandler: ((Endpoint, Any.Type?) throws -> Any.Type)?
    func sendRequest<T>(endpoint: Endpoint, responseModelType: T.Type) async throws -> T where T : Decodable {
        sendRequestCallCount += 1
        return try sendRequestHandler?(endpoint, responseModelType) as! T
    }
}
