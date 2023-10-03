//
//  TitleSubtitleView.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 3.10.23.
//

import SwiftUI

struct TitleSubtitleView: View {

    var title: String
    var description: String
    
    @Environment(\.currentTheme) private var currentTheme: UITheme

    var body: some View {
        VStack(alignment: .leading, content: {
            Text(title)
                .foregroundStyle(currentTheme.colors.text)
                .font(currentTheme.typography.title)
                .lineLimit(1)
                .truncationMode(.middle)

            Text(description)
                .foregroundStyle(currentTheme.colors.text)
                .font(currentTheme.typography.description)
                .lineLimit(2)
                .truncationMode(.middle)
        })
    }
}

#Preview {
    TitleSubtitleView(
        title: "Title",
        description: "Description"
    )
}
