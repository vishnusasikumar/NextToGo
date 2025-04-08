import SwiftUI

@MainActor
class RacingRowViewModel: ObservableObject {
    @State var race: RaceSummary
    
    init(race: RaceSummary) {
        self.race = race
    }
    
    var timeString: String {
        race.advertisedStart.formattedDateStr
    }
}

