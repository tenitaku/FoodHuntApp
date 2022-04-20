//
//  LoginView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/24.
//

import SwiftUI
import AppTrackingTransparency

struct LoginView: View {
    
    //MARK: FOR FIELD
    @State private var email = ""
    @State private var password = ""
    
    //MARK: VIEW MODEL
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView{
            ZStack {
                //MARK: BACKGROUND COLOR
                LinearGradient(gradient: Gradient(colors: [Color("gradient2"),Color("gradient1")]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                //MARK: LOGO
                VStack(spacing: 15){
                    Text("Food Hunt")
                        .font(.custom("Marker Felt", size: 60))
                        .foregroundColor(Color.white)
                    
                    
                    //MARK: EMAIL FIELD
                    CustomTextField(text: $email, placeholder: Text("メールアドレス"), imageNamge: "envelope")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    //MARK: PASSWORD FIELD
                    CustomSecureField(text: $password, placeholder: Text("パスワード"))
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    //MARK: FORGOT PASSWORD
                    HStack{
                        Spacer()
                        
                        NavigationLink {
                            ResetPasswordView(email: $email)
                                .navigationBarHidden(true)
                        } label: {
                            Text("パスワードを忘れた方")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                        }

                    }
                    .padding(.bottom)
                    
                    //MARK: LOG IN
                    Button {
                        viewModel.login(withEmail: email, password: password)
                        ATTrackingManager.requestTrackingAuthorization(completionHandler: {_ in})
                    } label: {
                        Text("ログイン")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(width: 330, height: 50)
                            .background(Color("gradient2"))
                            .clipShape(Capsule())
                    }
                    
                    //MARK: GOTO SIGN UP
                    NavigationLink {
                        RegistrationView()
                            .navigationBarHidden(true)
                    } label: {
                        HStack{
                            Text("アカウントをお持ちでない方→")
                                .font(.system(size: 14, weight: .semibold))
                            Text("アカウント登録")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .padding(.top)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 40)
                .padding(.top, -40)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
