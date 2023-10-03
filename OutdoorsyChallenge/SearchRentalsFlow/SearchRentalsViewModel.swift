//
//  SearchRentalsViewModel.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 3.10.23.
//

import SwiftUI
import Observation

// TODO: We can improve error handling here
// TODO: Listen to changes and execute fetch request on every space entered by the user
// TODO: Empty, loading, error state could be implemented for the entire scene
// TODO: Prefetch for data and images
// TODO: Cache images for better scroll performance

@Observable
class SearchRentalsViewModel {
    
    // Input
    @ObservationIgnored
    var searchInput: String = ""
    
    // Output
    var rentals: [Rental] = []
    var totalCountDisplayString: String = ""
    
    // State
    var errorMessage: String? = nil
    var isLoading: Bool = false
    
    // MARK: - Dependency
    private let rentalsService: RentalsServiceProtocol
    
    // MARK: - Privet
    private let scrollThreshold: UInt = 2
    private let pageLimit: UInt = 16
    private var pageOffset: UInt = 0
    private(set) var totalCount: UInt = 0 {
        didSet {
            let rentalsCount = rentals.count
            let totalCount = totalCount
            totalCountDisplayString = "\(rentalsCount)/\(totalCount)"
        }
    }
    
    init(rentalsService: RentalsServiceProtocol) {
        self.rentalsService = rentalsService
    }

    func initialLoad() async {
        await loadResults()
    }
    
    func loadForSearchKey() async {
        rentals = []
        pageOffset = 0
        await loadResults()
    }
    
    func requestMoreItemsIfNeeded(index: Int) {
        guard rentals.count != 0,
              totalCount != 0 else {
            return
        }
                
        if scrollThresholdMeet(loadedItemsCount: rentals.count, index: index) &&
            moreItemsRemaining(loadedItemsCount: rentals.count, totalItemsCount: Int(totalCount)) {
            // Request next page by updating the offset
            pageOffset += pageLimit
            Task {
                await loadResults()
            }
        }
    }
    
    private func loadResults() async {
        isLoading = rentals.isEmpty ? true : false
        errorMessage = nil
        do {
            let result = try await rentalsService.fetchRentals(
                filterKeywords: searchInput.toWords(),
                pageLimit: pageLimit,
                pageOffset: pageOffset
            )
            rentals += result.rentals
            totalCount = result.totalCount
        } catch {
            errorMessage = Localisation.errorMessage
            totalCountDisplayString = ""
        }
        isLoading = false
    }
    
    private func scrollThresholdMeet(loadedItemsCount: Int, index: Int) -> Bool {
        return (loadedItemsCount - index) == scrollThreshold
    }
    
    private func moreItemsRemaining(loadedItemsCount: Int, totalItemsCount: Int) -> Bool {
        return loadedItemsCount < totalItemsCount
    }
}

private enum Localisation {
    static let errorMessage = "Something else went wrong."
}
