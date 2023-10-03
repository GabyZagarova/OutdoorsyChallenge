//
//  SearchRentalsViewModel.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 3.10.23.
//

import SwiftUI
import Observation

@Observable
class SearchRentalsViewModel {

    // Input
    // TODO: Listen to changes and execute fetch request on every space entered by the user
    var searchInput: String = ""
    
    // Output
    var rentals: [Rental] = []
    
    // State
    // TODO: Empty state could be implemented
    var errorMessage: String? = nil
    var isLoading: Bool = false

    // MARK: - Privet
    private let rentalsService: RentalsServiceProtocol
    private let pageLimit: UInt = 16
    private var pageOffset: UInt = 0
    
    init(rentalsService: RentalsServiceProtocol) {
        self.rentalsService = rentalsService
    }
    
    func refresh() async {
        pageOffset = 0
        isLoading = false
        await loadSearchResult(onRefresh: true)
    }
    
    func loadSearchResult(onRefresh: Bool = false) async {
        isLoading = onRefresh ? false : true
        errorMessage = nil
        do {
            rentals = try await rentalsService.fetchRentals(
                filterKeywords: searchInput.toWords(),
                pageLimit: pageLimit,
                pageOffset: pageOffset
            )
            // TODO: Cash images for scroll back
        } catch {
            // TODO: We can improve error handling here
            errorMessage = "Something else went wrong."
        }
        isLoading = false
    }
}
