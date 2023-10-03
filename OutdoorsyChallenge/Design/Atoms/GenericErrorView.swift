//
//  GenericErrorView.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 3.10.23.
//

import SwiftUI

struct GenericErrorView: View {

    init(message: String = "Something went wrong.") {
        self.message = message
    }
    
    @Environment(\.currentTheme) private var currentTheme: UITheme
    private var message: String

    var body: some View {
        VStack {
            Spacer()
                .frame(height: currentTheme.spacing.large)
            Text(message)
                .font(currentTheme.typography.title)
                .foregroundColor(currentTheme.colors.error)
            Spacer()
                .frame(height: currentTheme.spacing.large)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    GenericErrorView(message: .init())
}
