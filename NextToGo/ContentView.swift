//
//  ContentView.swift
//  NextToGo
//
//  Created by Admin on 23/03/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        RacingListView(viewModel: RacingListViewModel(getRacesUseCase: GetRacesUseCaseImpl(repo: RacingRepositoryImpl(service: NetworkService()))))
    }
}

#Preview {
    ContentView()
}
