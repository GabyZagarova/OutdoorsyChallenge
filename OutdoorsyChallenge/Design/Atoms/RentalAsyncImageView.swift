//
//  RentalAsyncImageView.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 3.10.23.
//

import SwiftUI

private enum Constants {
    static let imageViewWidth = 100.0
    static let imageViewHeight = 80.0
    static let cornerRadius = 10.0
}

// TODO: View Modifier for image view style
// TODO: Do one more level of abstraction - placeholder image should be generic or injected
// TODO: Additional image processing because some images are not in the best same aspect ration
// TODO: Image caching for better performance

struct RentalAsyncImageView: View {
    let imageURL: URL?

    private let placeholderImage = Image("rental-placeholder")

    var body: some View {
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .frame(
                    width: Constants.imageViewWidth,
                    height: Constants.imageViewHeight
                )
                .cornerRadius(Constants.cornerRadius)
                .scaledToFit()
        } placeholder: {
            placeholderImageView
        }
    }
        
    @ViewBuilder
    private var placeholderImageView: some View {
        placeholderImage   
            .resizable()
            .frame(
                width: Constants.imageViewWidth,
                height: Constants.imageViewHeight
            )
            .cornerRadius(Constants.cornerRadius)
            .scaledToFit()
    }
}

#Preview {
    RentalAsyncImageView(imageURL: nil)
}
