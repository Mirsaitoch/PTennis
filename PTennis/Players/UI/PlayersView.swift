import FirebaseCore
import FirebaseFirestore
import SwiftUI

struct PlayersView: View {
    @StateObject private var dataManager = DataManager()
    @StateObject var viewModel = PlayersViewModel()
    @Binding var showSignInView: Bool
    let authUser = try? AuthManager.shared.getAuthUser()
    @State private var showAddSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.paleGreen
                    .ignoresSafeArea()
                
                if viewModel.players.isEmpty {
                    ProgressView()
                        .navigationTitle("Top players")
                        .task {
                            try? await viewModel.getAllPlayers()
                        }
                    Spacer()
                    Text("id: \(authUser?.uid ?? "хуй тебе")")
                        .foregroundStyle(.black)
                    
                } else {
                    ScrollView {
                        VStack {
                            ForEach(Array(viewModel.players.enumerated()), id: \.element.id) { index, player in
                                PlayerCardView(num: String(index + 1), player: player)
                            }
                        }
                        .navigationTitle("Top players")
                        .task {
                            try? await viewModel.getAllPlayers()
                        }
                    }
                }
            }
        }
        .toolbar {
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation {
                        viewModel.sorted_in_reverse_order.toggle()
                    }
                    viewModel.sorted_in_reverse_order ? viewModel.sortedInReverse() : viewModel.sorted()
                    print(viewModel.sorted_in_reverse_order)
                } label: {
                    Image(systemName: viewModel.sorted_in_reverse_order ? "arrow.down.circle" : "arrow.up.circle")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showAddSheet.toggle()
                } label: {
                    Image(systemName: "person.badge.plus")
                }
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddPlayerView()
        }
    }
}

func addPlayer() async throws {
    let player = Player(id: "\(Int.random(in: 0...1000000000))",
                        name: "Mirsaitik",
                        surname: "Sabirzyanov",
                        rating: 10,
                        gender: "Female",
                        age: 20,
                        phone: "89872891527",
                        email: "erimoerim@oeitng.t")
    
    try await DataManager.shared.addPlayer(player: player)
}


#Preview {
    PlayersView(showSignInView: .constant(false))
}
