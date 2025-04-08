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
            case .loading:
                ActivityIndicator()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.orange)
            case .failed:
                ErrorView(listViewModel: viewModel)
            case .loaded:
                NavigationStack {
                    List(selection: $selectedRace) {
                        ForEach(viewModel.filteredRaces) { race in
                            RacingRowView(race: race)
                            .tag(race.raceName)
                        }
                    }
                    .animation(.default, value: viewModel.filteredRaces)
                    .navigationTitle(viewModel.title)
    //                .accessibilityLabel(Text("List of races"), comment: "Accessibility Label for main list")
    //                .accessibilityHint(Text("Show a list of races based on the order of start"), comment: "Accessibility hint for main list")
    //                .accessibilityIdentifier(RacingListViewModel.ViewID.mainList)
                    .toolbar {
                        ToolbarItem {
                            Menu {
                                Picker("Category", selection: viewModel.$filter) {
                                    ForEach(FilterCategory.allCases) { category in
                                        Text(category.rawValue).tag(category)
                                    }
                                }
                                .pickerStyle(.inline)
                                
                            } label: {
                                Label("Filter", systemImage: "slider.horizontal.3")
                            }
    //                        .accessibility(addTraits: [.isHeader, .playsSound])
    //                        .accessibilityLabel(Text("List of categories"), comment: "Accessibility hint for filters")
    //                        .accessibilityHint(Text("Show a list of categories to filter the main list with"), comment: "Accessibility hint for filters")
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
