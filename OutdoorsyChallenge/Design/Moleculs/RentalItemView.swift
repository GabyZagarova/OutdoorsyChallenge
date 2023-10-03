//
//  RentalItemView.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 3.10.23.
//

import SwiftUI

struct RentalItemView: View {
    
    struct ViewModel {
        var imageURL: URL?
        var title: String
        var description: String
    }

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    @Environment(\.currentTheme) private var currentTheme: UITheme
    private let viewModel: ViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            RentalAsyncImageView(imageURL: viewModel.imageURL)
            
            Spacer()
                .frame(width: currentTheme.spacing.small)
            
            TitleSubtitleView(
                title: viewModel.title,
                description: viewModel.description
            )
            
            Spacer()
                .frame(width: currentTheme.spacing.small)
        }
    }
}

#Preview {
    VStack {
        RentalItemView(viewModel: .init(
            title: "Caravan rental very very very very very very very title",
            description: "Caravan rental description"
        ))
        
        RentalItemView(viewModel: .init(
            title: "Caravan rental title",
            description: "Caravan rental very very very very very very ver very very ver very very ver very ver very ver very ver long description"
        ))
    }
}
