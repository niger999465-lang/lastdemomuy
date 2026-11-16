import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.black, Color.purple.opacity(0.2), Color.black], 
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            TabView {
                HomeView()
                    .tabItem { Label("Trang chủ", systemImage: "house.fill") }
                
                FunctionsView()
                    .tabItem { Label("Chức năng", systemImage: "cube.box.fill") }
                
                RemoteFileBrowserView()
                    .tabItem { Label("Quản lý File", systemImage: "folder.fill") }
                
                SettingsView()
                    .tabItem { Label("Cài đặt", systemImage: "gearshape.fill") }
            }
            .accentColor(.blue)
        }
        .preferredColorScheme(.dark)
    }
}