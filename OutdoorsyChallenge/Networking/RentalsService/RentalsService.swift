//
//  RentalsService.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 2.10.23.
//

import Foundation

protocol RentalsServiceProtocol {
    func fetchRentals(filterKeywords: [String], pageLimit: UInt, pageOffset: UInt) async throws -> [Rental]
}
    
final class RentalsService: RentalsServiceProtocol {
    let client: HTTPClientProtocol
    
    init(client: HTTPClientProtocol) {
        self.client = client
    }
 
    func fetchRentals(filterKeywords: [String], pageLimit: UInt, pageOffset: UInt = 0) async throws -> [Rental] {
        let response = try await client.sendRequest(
            endpoint: RentalsEndpoint(filterKeywords: filterKeywords, pageLimit: pageLimit, pageOffset: pageOffset),
            responseModelType: RentalsResponseRootDTO.self
        )
        
        return response.data.map { Rental(rentalDTO: $0) }
    }
}
