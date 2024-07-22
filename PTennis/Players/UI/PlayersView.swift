import FirebaseCore
import FirebaseFirestore
import SwiftUI

struct PlayersView: View {
    @StateObject private var dataManager = DataManager()
    @StateObject var viewModel = PlayersViewModel()
    let authUser = try? AuthManager.shared.getAuthUser()
    @State private var showAddSheet = false
    
    init() {
     UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
     UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
   }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bcolor
                    .ignoresSafeArea()
                
                if viewModel.players.isEmpty {
                    if viewModel.isLoading {
                        ProgressView()
                            .navigationTitle("Top players")
                            .task {
                                try? await viewModel.getAllPlayers()
                            }
                    } else {
                        Text("There are no added players yet")
                            .foregroundStyle(.white)
                            .font(.system(size: 42, design: .rounded))
                    }
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(Array(viewModel.players.enumerated()), id: \.element.id) { index, player in
                                PlayerCardView(num: String(index + 1), player: player)
                            }
                        }
                        .navigationTitle("Top players")
                        .navigationBarTitleTextColor(.white)
                        .task {
                            try? await viewModel.getAllPlayers()
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
                    if authUser?.email != "" {
                        Button {
                            showAddSheet.toggle()
                        } label: {
                            Image(systemName: "person.badge.plus")
                        }
                    }
                }
            }

        }
        .sheet(isPresented: $showAddSheet) {
            AddPlayerView()
        }
    }
}

#Preview {
    PlayersView()
}
