//
//  RacingListViewModel.swift
//  NextToGo
//
//  Created by Admin on 23/03/2025.
//

import SwiftUI

@MainActor
class RacingListViewModel: ObservableObject {
    
    enum ViewState {
        case idle
        case loading
        case failed
        case loaded
        case refresh
    }
    
    enum ViewID {
        case mainList
        case filterButton
    }
    
    @Published var races: [RaceSummary] = []
    @Published private(set) var state = ViewState.idle
    @Published var filter = FilterCategory.all
    private var pageCount = 1
    private let getRacesUseCase: GetRacesUseCase
    private var numberOfRetries = 3

    init(getRacesUseCase: GetRacesUseCase) {
        self.getRacesUseCase = getRacesUseCase
    }
    
    func getNextRaces() async {
        state = .loading
        Task {
            let array = await getRacesUseCase.getRaces(with: pageCount)
            if array.count < 5 {
                if pageCount >= 10 {
                    resetCounts()
                    self.state = .failed
                } else {
                    await fetchNext(array)
                }
            } else {
                self.races = array.sorted{ $0.advertisedStart.formattedDate < $1.advertisedStart.formattedDate }
                self.state = .loaded
            }
        }
    }
    
    func refresh() async {
        resetCounts()
        await getNextRaces()
    }
    
    var filteredRaces: [RaceSummary] {
        self.races.filter { race in
            (filter == .all || filter.categoryID == race.categoryID)
        }
    }
    
    var title: String {
        filter == .all ? "Next To Go" : filter.rawValue
    }
    
    private func fetchNext(_ array: [RaceSummary]) async {
        if numberOfRetries > 0 {
            if array.count < 5 {
                pageCount += 1
            } else {
                numberOfRetries -= 1
            }
            await getNextRaces()
        } else {
            resetCounts()
            self.state = .failed
        }
    }
    
    private func resetCounts() {
        self.pageCount = 1
        self.numberOfRetries = 3
    }
}

