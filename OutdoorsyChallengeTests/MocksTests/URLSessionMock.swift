//
//  URLSessionMock.swift
//  OutdoorsyChallengeTests
//
//  Created by Gabriela Bakalova on 3.10.23.
//

import XCTest
@testable import OutdoorsyChallenge

final class URLSessionMock: URLSessionProtocol {
    
    private(set) var dataTaskCallCount: Int = 0
    var dataTaskHandler: ((URLRequest, URLSessionTaskDelegate?) throws -> (Data, URLResponse))?
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        dataTaskCallCount += 1
        return try dataTaskHandler?(request, delegate) ?? (Data(), URLResponse())
    }
}
