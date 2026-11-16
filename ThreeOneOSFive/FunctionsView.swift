import SwiftUI

struct FunctionsView: View {
    @State private var selectedGame: GameType = .normal
    enum GameType { case normal, max }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.opacity(0.2).ignoresSafeArea()
                VStack(spacing: 18) {
                    HStack(spacing: 14) {
                        GameCard(title: "FF THƯỜNG", bundleId: "com.dts.freefireth", isSelected: selectedGame == .normal) { selectedGame = .normal }
                        GameCard(title: "FF MAX", bundleId: "com.dts.freefiremax", isSelected: selectedGame == .max) { selectedGame = .max }
                    }
                    .padding(.horizontal)
                    
                    Button(action: {}) {
                        Text("MỞ APP VÀ KÍCH HOẠT PATCH")
                            .font(.headline.bold()).foregroundColor(.white)
                            .frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(16)
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                .padding(.top, 20)
            }
            .navigationBarHidden(true)
        }
    }
}

struct GameCard: View {
    let title: String, bundleId: String, isSelected: Bool, action: () -> Void
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title).font(.headline.bold()).foregroundColor(.white)
                Text(bundleId).font(.system(size: 9)).foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading).padding()
            .background(Color.white.opacity(isSelected ? 0.2 : 0.08)).cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2))
        }
    }
}