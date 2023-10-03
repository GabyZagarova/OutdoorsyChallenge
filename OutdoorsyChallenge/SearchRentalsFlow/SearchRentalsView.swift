//
//  SearchRentalsView.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 3.10.23.
//

import SwiftUI
import Observation

struct SearchRentalsView: View {
    
    init(viewModel: SearchRentalsViewModel) {
        self.viewModel = viewModel
    }
    
    @Environment(\.currentTheme) private var currentTheme: UITheme
    @Bindable private var viewModel: SearchRentalsViewModel
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Spacer()
                .frame(height: currentTheme.spacing.large)
            
            inputView
            resultsListView
            
            Spacer()
        })
        .if(viewModel.isLoading) { view in
            view
                .overlay(content: {
                    if viewModel.isLoading {
                        LoadingView()
                    }
                })
        }
        .onAppear {
            Task {
                await viewModel.loadSearchResult()
            }
        }
    }
    
    @ViewBuilder
    private var inputView: some View {
        InputView(
            .init(
                placeholderText: Localisation.placeholderText,
                submitLabel: .search,
                onSubmitAction: {
                    Task {
                        await viewModel.loadSearchResult()
                    }
                }),
            text: $viewModel.searchInput
        )
        .padding([.leading, .trailing], currentTheme.spacing.large)
    }
    
    @ViewBuilder
    private var errorMessageView: some View {
        if viewModel.errorMessage != nil {
            GenericErrorView()
                .frame(maxWidth: .infinity, alignment: .center)
        } else {
            Spacer()
                .frame(height: currentTheme.spacing.large)
        }
    }
    
    @ViewBuilder
    private var resultsListView: some View {
        errorMessageView
        List(viewModel.rentals, id: \.id) { rental in
            RentalItemView(
                viewModel: .init(
                    imageURL: rental.imageURL,
                    title: rental.name,
                    description: rental.description
                )
            )
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .refreshable {
            Task {
                await viewModel.refresh()
            }
        }
    }
}

private enum Localisation {
    fileprivate static let placeholderText = "Enter filter key here"
}

#Preview {
    SearchRentalsView(
        viewModel: SearchRentalsViewModel(
            rentalsService: RentalsService(client: HTTPClient(urlSession: URLSession.shared))
        )
    )
}
