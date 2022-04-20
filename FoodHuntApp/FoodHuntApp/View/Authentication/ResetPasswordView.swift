//
//  ResetPasswordView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/24.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var mode
    @Binding private var email: String
    
    init(email: Binding<String>) {
        self._email = email
    }
    
    
    var body: some View {
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
                
                //MARK: LOG IN
                Button {
                    viewModel.resetPassword(withEmail: email)
                } label: {
                    Text("パスワードリセットメールを送る")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width: 330, height: 50)
                        .background(Color("gradient2"))
                        .clipShape(Capsule())
                }
                
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
            .padding(.top, 60)
        }
        .onReceive(viewModel.$didSendRessetPasswordLink) { _ in
            self.mode.wrappedValue.dismiss()
        }
    }
}

