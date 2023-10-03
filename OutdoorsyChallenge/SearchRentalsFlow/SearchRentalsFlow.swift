//
//  SearchRentalsFlow.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 3.10.23.
//

import SwiftUI

struct SearchRentalsFlow: View {

    var body: some View {
        NavigationStack {
            root
        }
    }
    
    @ViewBuilder
    private var root: some View {
        SearchRentalsView(
            viewModel: SearchRentalsViewModel(
                rentalsService: RentalsService(client: HTTPClient(urlSession: URLSession.shared))
            )
        )
        .navigationTitle(Localisation.rentalSearchTitle)
    }
}

private enum Localisation {
    static let rentalSearchTitle = "Keyword Search"
}

#Preview {
    SearchRentalsFlow()
}
