//
//  InputView.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 3.10.23.
//

import SwiftUI

private enum Constants {
    static let inputViewHeight = 50.0
    static let cornerRadius = 8.0
    static let borderWidth = 1.0
}

struct InputView: View {

    // TODO: Remove SubmitLabel - Create custom types - abstract model from SwiftUI
    struct ViewModel {
        let placeholderText: String
        let submitLabel: SubmitLabel
        let onSubmitAction: (() -> Void)?
    }
        
    init(_ viewModel: ViewModel, text: Binding<String>) {
        self.viewModel = viewModel
        _text = text
    }
    
    @Environment(\.currentTheme) private var currentTheme: UITheme
    @Binding fileprivate var text: String
    private let viewModel: ViewModel
    
    var body: some View {
        HStack {
            TextField(viewModel.placeholderText, text: $text)
                .onSubmit {
                    viewModel.onSubmitAction?()
                }
                .showClearButton($text)
                .submitLabel(viewModel.submitLabel)
                .foregroundColor(currentTheme.colors.text)
                .font(currentTheme.typography.description)
                .padding(
                    [.leading, .trailing],
                    currentTheme.spacing.small
                )
        }
        .frame(height: Constants.inputViewHeight)
        .overlay {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .stroke(currentTheme.colors.primary, lineWidth: Constants.borderWidth)
        }
    }
}

#Preview {
    VStack {
        InputView(
            .init(
                placeholderText: "Type your text here",
                submitLabel: .done,
                onSubmitAction: {
                    print("Input field return action")
                }),
            text: .constant("")
        )
        
        InputView(
            .init(
                placeholderText: "Type your text here",
                submitLabel: .done,
                onSubmitAction: {
                    print("Input field return action")
                }),
            text: .constant("Text")
        )
    }
}
