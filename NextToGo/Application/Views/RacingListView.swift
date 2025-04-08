//
//  RacingListView.swift
//  NextToGo
//
//  Created by Admin on 23/03/2025.
//

import SwiftUI

struct RacingListView: View {
    
    @ObservedObject var viewModel: RacingListViewModel
    @StateObject var publishedDate: PublishedDate = .init(date: Date.now)
    @State private var selectedRace: RaceSummary?
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .refresh, .loading:
                ActivityIndicator()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.orange)
            case .failed:
                ErrorView(listViewModel: viewModel)
            case .idle, .loaded:
                NavigationStack {
                    VStack {
                        List(selection: $selectedRace) {
                            ForEach(viewModel.filteredRaces) { race in
                                RacingRowView(race: race)
                                .tag(race.raceName)
                            }
                        }
                        .animation(.default, value: viewModel.filteredRaces)
                        .navigationTitle(viewModel.title)
                        .accessibilityLabel(Text("List of races"))
                        .accessibilityHint(Text("Show a list of races based on the order of start"))
                        .accessibilityIdentifier(RacingListViewModel.ViewID.mainList.rawValue)
                    }
                    .toolbar {
                        ToolbarItem {
                            Menu {
                                Picker("Category", selection: $viewModel.filter) {
                                    ForEach(FilterCategory.allCases) { category in
                                        Text(category.rawValue).tag(category)
                                    }
                                }
                                .pickerStyle(.inline)
                                
                            } label: {
                                Label("Filter", systemImage: "slider.horizontal.3")
                            }
                            .accessibility(addTraits: [.isHeader, .playsSound])
                            .accessibilityLabel(Text("List of categories"))
                            .accessibilityHint(Text("Show a list of categories to filter the main list with"))
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.getNextRaces()
            }
        }
    }
}

#Preview {
    RacingListView(viewModel: RacingListViewModel(getRacesUseCase: GetRacesUseCaseImpl(repo: RacingRepositoryImpl(service: NetworkService())))) // This should be replaced with a proper DI
}
