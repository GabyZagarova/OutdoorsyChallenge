//
//  SearchRentalsViewModelTests.swift
//  OutdoorsyChallengeTests
//
//  Created by Gabriela Bakalova on 3.10.23.
//

import XCTest
@testable import OutdoorsyChallenge

final class SearchRentalsViewModelTests: XCTestCase {
    private var rentalsService: RentalsServiceMock!
    private var sut: SearchRentalsViewModel!

    override func setUp() {
        super.setUp()
        
        rentalsService = RentalsServiceMock()
        sut = SearchRentalsViewModel(rentalsService: rentalsService)
    }
    
    func testOnAppearNoResults() async {
        mockDependencyResult(result: [], error: false)
        await sut.initialLoad()

        XCTAssertEqual(sut.searchInput, "")
        
        XCTAssertEqual(sut.rentals.count, 0)
        XCTAssertEqual(sut.totalCountDisplayString, "0/0")
        XCTAssertEqual(sut.isLoading, false)
        XCTAssertEqual(sut.errorMessage, nil)
    }
    
    func testOnAppearWithResults() async {
        mockDependencyResult(result: [Rental.randomRental(), 
                                      Rental.randomRental(),
                                      Rental.randomRental()],
                             error: false)
        await sut.initialLoad()

        XCTAssertEqual(sut.searchInput, "")
        
        XCTAssertEqual(sut.rentals.count, 3)
        XCTAssertEqual(sut.totalCountDisplayString, "3/3")
        XCTAssertEqual(sut.isLoading, false)
        XCTAssertEqual(sut.errorMessage, nil)
    }
    
    func testOnAppearWithError() async {
        mockDependencyResult(result: [], error: true)
        await sut.initialLoad()

        XCTAssertEqual(sut.searchInput, "")

        XCTAssertEqual(sut.rentals.count, 0)
        XCTAssertEqual(sut.totalCountDisplayString, "")
        XCTAssertEqual(sut.isLoading, false)
        XCTAssertEqual(sut.errorMessage, "Something else went wrong.")
    }
    
    func testSearchKeys() async {
        let searchKeys = "Search key"

        rentalsService.fetchRentalsHandler = { searchKeys, pageLimit, pageOffset in
            XCTAssertEqual(searchKeys.count, 2)
            XCTAssertEqual(searchKeys[0], "Search")
            XCTAssertEqual(searchKeys[1], "key")

            return ([Rental.randomRental(),
                    Rental.randomRental(),
                    Rental.randomRental()], 3)
        }
        
        sut.searchInput = searchKeys
        
        await sut.initialLoad()
        
        XCTAssertEqual(sut.searchInput, "Search key")

        XCTAssertEqual(sut.rentals.count, 3)
        XCTAssertEqual(sut.totalCountDisplayString, "3/3")
        XCTAssertEqual(sut.isLoading, false)
        XCTAssertEqual(sut.errorMessage, nil)
    }
}

private extension SearchRentalsViewModelTests {
    private func mockDependencyResult(result: [Rental], error: Bool) {
        let expectedError = NetworkingError.generic
        
        rentalsService.fetchRentalsHandler = { searchKeys, pageLimit, pageOffset in
            guard !error else {
                throw expectedError
            }
        
            return (rentals: result, totalCount: UInt(result.count))
        }
    }
}

private extension Rental {
    static func randomRental() -> Rental {
        return .init(
            id: String.randomString(length: 10),
            name: String.randomString(length: 10),
            description: String.randomString(length: 25),
            displayVehicleType: "Type",
            imageURL: URL(string: "URL String"),
            unavailable: false)
    }
}
