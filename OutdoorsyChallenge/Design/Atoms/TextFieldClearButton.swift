//
//  TextFieldClearButton.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 3.10.23.
//

import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var fieldText: String

    func body(content: Content) -> some View {
        content
            .overlay {
                if !fieldText.isEmpty {
                    HStack {
                        Spacer()
                        Button {
                            fieldText = ""
                        } label: {
                            Image(systemName: "multiply.circle.fill")
                        }
                        .foregroundColor(.secondary)
                        .padding(.trailing, 4)
                    }
                }
            }
    }
}

extension View {
    func showClearButton(_ text: Binding<String>) -> some View {
        self.modifier(TextFieldClearButton(fieldText: text))
    }
}

#Preview {
    VStack {
        TextField("", text: .constant(""))
            .showClearButton(.constant(""))
        TextField("", text: .constant("test"))
            .showClearButton(.constant("test"))
        TextField("", text: .constant("double test"))
            .showClearButton(.constant("double test"))
    }
}
