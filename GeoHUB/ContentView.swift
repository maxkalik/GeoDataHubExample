//
//  ContentView.swift
//  GeoHUB
//
//  Created by Maksim Kalik on 17/02/2022.
//

import SwiftUI
import Combine

struct ContentView: View {

    @StateObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Type address", text: $viewModel.text)
                .padding(.horizontal)
                .padding(.top)
                .font(.title)
                .onReceive(
                    viewModel.$text.debounce(for: .seconds(1), scheduler: DispatchQueue.main)
                ) {
                    guard $0.isEmpty == false else { return }
                    viewModel.searchAddress($0)
                }
            List(self.viewModel.predictableValues, id: \.self) { value in
                Text(value)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
