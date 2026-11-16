import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.opacity(0.2).ignoresSafeArea()
                Form {
                    Section(header: Text("Hệ thống")) {
                        Button("Đăng xuất / Nhập lại Key") {
                            UserDefaults.standard.set(false, forKey: "isKeyUnlocked")
                            exit(0)
                        }.foregroundColor(.red)
                    }
                    .listRowBackground(Color.white.opacity(0.1))
                }
                .scrollContentBackground(.hidden)
            }
            .navigationBarHidden(true)
        }
    }
}