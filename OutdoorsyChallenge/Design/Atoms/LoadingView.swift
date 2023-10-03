//
//  LoadingView.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 3.10.23.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        VStack {
            ProgressView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    LoadingView()
}
