import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.opacity(0.2).ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 16) {
                        Text("iHax").font(.system(size: 32, weight: .bold)).foregroundColor(.white)
                        Text("FF THƯỜNG // FF MAX").font(.caption).tracking(2).foregroundColor(.gray)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            HStack { Label("Model", systemImage: "iphone").foregroundColor(.white); Spacer(); Text("iPhone").foregroundColor(.gray) }
                            Divider().background(Color.white.opacity(0.2))
                            HStack { Label("Trạng thái", systemImage: "checkmark.shield").foregroundColor(.white); Spacer(); Text("Đã kích hoạt bản quyền").foregroundColor(.green).bold() }
                        }
                        .padding().background(Color.white.opacity(0.12)).cornerRadius(18)
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }
}