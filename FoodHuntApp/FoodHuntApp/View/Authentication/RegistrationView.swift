//
//  RegistrationView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/24.
//

import SwiftUI
import AppTrackingTransparency
import Photos

struct RegistrationView: View {
    //MARK: FOR IMAGE
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    @State var imagePickerPresented = false
    
    //MARK: FOR REGISTER
    @State private var email = ""
    @State private var username = ""
//    @State private var fullname = ""
    @State private var password = ""
    @Environment(\.presentationMode) var mode
    
    //MARK: VIEW MODEL
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack{
            //MARK: BACK COLOR
            LinearGradient(gradient: Gradient(colors: [Color("gradient2"),Color("gradient1")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            
            VStack(spacing: 15){
                
                //MARK: IMAGE = NIL
                if let image = image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .padding(.top, 30)
                        .padding(.bottom, 10)
                } else {
                //MARK: IMAGE = IMAGE
                    Button {
                        imagePickerPresented.toggle()
                        PHPhotoLibrary.requestAuthorization(for: .addOnly) { (addOnlyAuth) in
                            switch addOnlyAuth {
                            case .notDetermined:
                                print("notDetermined")
                            case .restricted:
                                print("restricted")
                            case .denied:
                                print("denied")
                            case .authorized:
                                // 全ての写真へのアクセスを許可
                                print("authorized")
                            case .limited:
                                // 写真を選択
                                print("limited")
                            @unknown default:
                                print("default")
                            }
                        }
                    } label: {
                        VStack{
                            Image(systemName: "photo.on.rectangle.angled")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .foregroundColor(.white)
                            
                            Text("プロフィール画像を選択(変更不可)")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 10)
                    }
                    .sheet(isPresented: $imagePickerPresented) {
                        loadImage()
                    } content: {
                        ImagePicker(image: $selectedImage)
                    }
                }
                                
                //MARK: EMAIL FIELD
                CustomTextField(text: $email, placeholder: Text("メールアドレス"), imageNamge: "envelope")
                    .padding()
                    .background(Color(.init(white: 1, alpha: 0.15)))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                
                //MARK: USER NAME
                CustomTextField(text: $username, placeholder: Text("ユーザー名(英語がおすすめ。変更不可。)"), imageNamge: "person")
                    .padding()
                    .background(Color(.init(white: 1, alpha: 0.15)))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                
                //MARK: FULL NAME
//                CustomTextField(text: $fullname, placeholder: Text("アカウント名"), imageNamge: "person")
//                    .padding()
//                    .background(Color(.init(white: 1, alpha: 0.15)))
//                    .cornerRadius(10)
//                    .foregroundColor(.white)
                
                //MARK: PASSWORD
                CustomSecureField(text: $password, placeholder: Text("パスワード(6字以上の英数字)"))
                    .padding()
                    .background(Color(.init(white: 1, alpha: 0.15)))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                
                HStack(spacing: 20){
                    Button {
                        openCustomURL(urlString: "https://appcreator2323.wixsite.com/foodhunt/termsofservice")
                    } label: {
                        Text("利用規約")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .semibold))
                    }
                    
                    Button {
                        openCustomURL(urlString: "https://appcreator2323.wixsite.com/foodhunt/privacypolicy")
                    } label: {
                        Text("プライバシーポリシー")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .semibold))
                    }
                }
                
                
                
                
                //MARK: REGISTER BUTTON
                Button {
                    viewModel.register(withEmail: email, password: password, image: selectedImage, username: username)
                    ATTrackingManager.requestTrackingAuthorization(completionHandler: {_ in})
                } label: {
                    Text("アカウント登録")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width: 330, height: 50)
                        .background(Color("gradient2"))
                        .clipShape(Capsule())
                }
                .padding(.top)
                
                //MARK: GO TO LOGIN
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    HStack{
                        Text("既にアカウントをお持ちの方→")
                            .font(.system(size: 14, weight: .semibold))
                        Text("ログイン")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .padding(.top)
                }
                
                Spacer()
            }
            .padding(.horizontal, 40)
        }
    }
    
    func openCustomURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

//MARK: EXTENSION UPLOAD
extension RegistrationView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
