import SwiftUI

struct KeyVerificationView: View {
    @Binding var isUnlocked: Bool
    @State private var inputKey: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                    Text("XÁC THỰC BẢN QUYỀN")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                    Text("Hệ thống quản lý Key - Python Server")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                VStack(spacing: 16) {
                    TextField("Nhập Key...", text: $inputKey)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .autocapitalization(.allCharacters)
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage).font(.caption).foregroundColor(.red)
                    }
                    
                    Button(action: verifyKey) {
                        HStack {
                            if isLoading {
                                ProgressView().tint(.white)
                            } else {
                                Text("KÍCH HOẠT").font(.headline.bold())
                            }
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                    }
                    .disabled(inputKey.isEmpty || isLoading)
                }
                .padding(.horizontal, 30)
            }
        }
    }
    
    func verifyKey() {
        isLoading = true
        errorMessage = ""
        
        let deviceID = UIDevice.current.identifierForVendor?.uuidString ?? "ios_device"
        let parameters: [String: Any] = ["key": inputKey, "device_id": deviceID]
        
        // Thay link này bằng URL ngrok hoặc Cloudflare Tunnel trỏ tới script Python máy nhà
        guard let url = URL(string: "https://your-python-tunnel.loca.lt/api/verify_key") else {
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                isLoading = false
                guard let data = data, error == nil else {
                    errorMessage = "Không thể kết nối đến Python Server tại máy nhà!"
                    return
                }
                
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let success = json["success"] as? Bool, success {
                    UserDefaults.standard.set(true, forKey: "isKeyUnlocked")
                    isUnlocked = true
                } else {
                    errorMessage = "Key không hợp lệ hoặc đã bị khóa!"
                }
            }
        }.resume()
    }
}