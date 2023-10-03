//
//  RentalsService.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 2.10.23.
//

import Foundation

protocol RentalsServiceProtocol {
    func fetchRentals(filterKeywords: [String], pageLimit: UInt, pageOffset: UInt) async throws -> (rentals: [Rental], totalCount: UInt)
}
    
final class RentalsService: RentalsServiceProtocol {
    let client: HTTPClientProtocol
    init(client: HTTPClientProtocol) {
        self.client = client
    }
 
    func fetchRentals(filterKeywords: [String], pageLimit: UInt, pageOffset: UInt = 0) async throws -> (rentals: [Rental], totalCount: UInt) {
        let response = try await client.sendRequest(
            endpoint: RentalsEndpoint(filterKeywords: filterKeywords, pageLimit: pageLimit, pageOffset: pageOffset),
            responseModelType: RentalsResponseRootDTO.self
        )
        
        return (response.rentals.map { Rental(rentalDTO: $0) }, response.totalCount)
    }
}
