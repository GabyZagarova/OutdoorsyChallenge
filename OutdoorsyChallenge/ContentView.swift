//
//  ContentView.swift
//  OutdoorsyChallenge
//
//  Created by Gabriela Bakalova on 2.10.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear{
            #warning("Work in progres")
            Task {
                let HTTPClient = HTTPClient(urlSession: URLSession.shared)
                let rentalsService = RentalsService(client: HTTPClient)
                let result = try await rentalsService.fetchRentals(filterKeywords: ["trailer", "camper"], pageLimit: 8)
                print(result)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
