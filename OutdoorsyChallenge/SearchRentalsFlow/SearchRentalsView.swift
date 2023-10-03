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
    @FocusState private var fieldIsFocused: Bool
    private var shouldScrollToTop: Bool = false
    
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
        .safeAreaInset(edge: .bottom) {
            Text(viewModel.totalCountDisplayString)
                .font(currentTheme.typography.description)
                .foregroundStyle(currentTheme.colors.primary)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .onAppear {
            Task {
                await viewModel.initialLoad()
            }
        }
        .onTapGesture {
            fieldIsFocused = false
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
                        await viewModel.loadForSearchKey()
                        fieldIsFocused = false
                    }
                }),
            text: $viewModel.searchInput
        )
        .focused($fieldIsFocused)
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
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(Array(viewModel.rentals.enumerated()), id: \.1.id) { (index, rental) in
                    RentalItemView(
                        viewModel: .init(
                            imageURL: rental.imageURL,
                            title: rental.name,
                            description: rental.description
                        )
                    )
                    .onAppear {
                        viewModel.requestMoreItemsIfNeeded(index: index)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .padding([.leading, .trailing])
    }
}

private enum Localisation {
    fileprivate static let placeholderText = "Enter filter key words here"
}

#Preview {
    SearchRentalsView(
        viewModel: SearchRentalsViewModel(
            rentalsService: RentalsService(client: HTTPClient(urlSession: URLSession.shared))
        )
    )
}
