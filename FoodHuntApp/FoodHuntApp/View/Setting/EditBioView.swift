//
//  EditBioView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/03/05.
//
import SwiftUI

struct EditBioView: View {
    @State private var bioText: String
    @ObservedObject private var viewModel: EditBioViewModel
    @Binding var user: User
    @Environment(\.presentationMode) var mode
    
    init(user: Binding<User>) {
        self._user = user
        self.viewModel = EditBioViewModel(user: self._user.wrappedValue)
        self._bioText = State(initialValue: _user.wrappedValue.bio ?? "")
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { mode.wrappedValue.dismiss() }, label: {
                    Text("キャンセル")
                        .foregroundColor(.primary)
                })
                
                Spacer()
                
                Button(action: { viewModel.saveUserBio(bioText) }, label: {
                    Text("保存する")
                        .bold()
                        .foregroundColor(.primary)
                    
                })
            }.padding()
            
            TextArea(text: $bioText, placeholder: "ここにプロフィール文を入力して下さい")
                .frame(width: 370, height: 200)
                .padding()
            
            Spacer()
        }
        .onReceive(viewModel.$uploadComplete, perform: { completed in
            if completed {
                self.mode.wrappedValue.dismiss()
                self.user.bio = viewModel.user.bio
            }
        })
    }
}
