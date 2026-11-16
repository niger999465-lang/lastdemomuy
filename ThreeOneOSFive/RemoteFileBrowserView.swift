import SwiftUI

struct RemoteFileBrowserView: View {
    @State private var fileList: [String] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.opacity(0.2).ignoresSafeArea()
                List(fileList, id: \.self) { file in
                    HStack {
                        Image(systemName: "doc.fill").foregroundColor(.blue)
                        Text(file).foregroundColor(.white)
                        Spacer()
                    }
                    .listRowBackground(Color.white.opacity(0.08))
                }
                .scrollContentBackground(.hidden)
                .onAppear(perform: fetchFilesFromServer)
            }
            .navigationBarHidden(true)
        }
    }
    
    func fetchFilesFromServer() {
        guard let url = URL(string: "https://your-python-tunnel.loca.lt/api/files") else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let files = json["files"] as? [String] {
                DispatchQueue.main.async {
                    self.fileList = files
                }
            }
        }.resume()
    }
}