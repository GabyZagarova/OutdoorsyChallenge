//
//  RentalsServiceMock.swift
//  OutdoorsyChallengeTests
//
//  Created by Gabriela Bakalova on 3.10.23.
//

import XCTest
@testable import OutdoorsyChallenge

final class RentalsServiceMock: RentalsServiceProtocol {
    
    var fetchRentalsHandler: (([String], UInt, UInt) throws -> [Rental])?
    private(set) var fetchRentalsCallCount = 0
    func fetchRentals(filterKeywords: [String], pageLimit: UInt, pageOffset: UInt) async throws -> [Rental] {
        fetchRentalsCallCount += 1
        return try fetchRentalsHandler?(filterKeywords, pageLimit, pageOffset) ?? []
    }
}
