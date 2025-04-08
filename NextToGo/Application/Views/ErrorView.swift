import SwiftUI

struct ErrorView: View {
    @ObservedObject var listViewModel: RacingListViewModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .overlay {
                VStack {
                    Text("Sorry something went wrong, Please try again later")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Button("Reload Users") {
                        Task {
                            await listViewModel.refresh()
                        }
                    }
                    .buttonStyle(.bordered)
                }
                
            }
    }
}

#Preview {
    let viewModel = RacingListViewModel(getRacesUseCase: GetRacesUseCaseImpl(repo: RacingRepositoryImpl(service: MockService())))
    ErrorView(listViewModel: viewModel)
}
