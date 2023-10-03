//
//  RentalsEndpointTest.swift
//  OutdoorsyChallengeTests
//
//  Created by Gabriela Bakalova on 2.10.23.
//

import XCTest
@testable import OutdoorsyChallenge

final class RentalsEndpointTest: XCTestCase {
    
    func testEndpointGenerationNoOffset() {
        let rentalsEndpoint = RentalsEndpoint(filterKeywords: ["trailer", "camper"], pageLimit: 8)
        XCTAssertEqual(rentalsEndpoint.scheme, "https")
        XCTAssertEqual(rentalsEndpoint.host, "search.outdoorsy.com")
        XCTAssertEqual(rentalsEndpoint.path, "/rentals")
        XCTAssertEqual(rentalsEndpoint.queryItems, [URLQueryItem.init(name: "filter[keywords]", value: "trailer camper"),
                                                    URLQueryItem.init(name: "page[limit]", value: "8"),
                                                    URLQueryItem.init(name: "page[offset]", value: "0")
                                                   ])
    }
    
    func testEndpointGeneration() {
        let rentalsEndpoint = RentalsEndpoint(filterKeywords: ["trailer", "camper"], pageLimit: 8, pageOffset: 16)
        XCTAssertEqual(rentalsEndpoint.scheme, "https")
        XCTAssertEqual(rentalsEndpoint.host, "search.outdoorsy.com")
        XCTAssertEqual(rentalsEndpoint.path, "/rentals")
        XCTAssertEqual(rentalsEndpoint.queryItems, [URLQueryItem.init(name: "filter[keywords]", value: "trailer camper"),
                                                    URLQueryItem.init(name: "page[limit]", value: "8"),
                                                    URLQueryItem.init(name: "page[offset]", value: "16")
                                                   ])
    }
}
