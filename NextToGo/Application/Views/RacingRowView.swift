import SwiftUI

struct RacingRowView: View {
    @ObservedObject var viewModel: RacingRowViewModel
    
    init(race: RaceSummary) {
        self.viewModel = RacingRowViewModel(race: race)
    }
    
    var body: some View {
        HStack {
            Text("#\(viewModel.race.raceNumber)")
                .bold()
                .foregroundStyle(.primary)
            VStack(alignment: .leading) {
                Text(viewModel.race.raceName)
                    .fontWeight(.semibold)
                    .font(.caption)
                Text(viewModel.timeString)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    let race = MockService.sampleSummaries
    return Group {
        RacingRowView(race: race[0])
        RacingRowView(race: race[1])
    }
}
    
