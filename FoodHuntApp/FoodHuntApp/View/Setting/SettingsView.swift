//
//  SettingsView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/03/05.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: ProfileViewModel
    @State var showEditBio = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            //MARK: FROFILE EDIT
            GroupBox {
                
                Button {
                    showEditBio.toggle()
                } label: {
                    SettingsRowView(leftIcon: "text.quote", text: "プロフィール文", color: .orange)
                }
                .sheet(isPresented: $showEditBio) {
                    EditBioView(user: $viewModel.user)
                }
                
                SettingsRowView(leftIcon: "person.crop.circle.badge.exclamationmark", text: "画像とユーザー名の変更機能は\n実装まで少々お待ち下さい", color: .orange)
                
                //                    NavigationLink {
                //                        SettingsEditImageView(title: "プロフィール画像", description: "プロフィール画像を変更できます。", selectedImage: UIImage(named: "food1")!)
                //                    } label: {
                //                        SettingsRowView(leftIcon: "photo", text: "プロフィール画像", color: .purple)
                //                    }
                
                Button {
                    AuthViewModel.shared.signout()
                } label: {
                    SettingsRowView(leftIcon: "figure.walk", text: "ログアウト", color: Color("gradient2"))
                }
                //                    .alert(isPresented: $showSignOutError) {
                //                        return Alert(title: Text("Error signing out"))
                //                    }
                
            } label: {
                SettingsLabelView(labelText: "プロフィール設定", labelImage: "person.fill")
            }
            .padding()
            
            //MARK: APP EDIT
            GroupBox {
                Button {
                    openCustomURL(urlString: "https://appcreator2323.wixsite.com/foodhunt")
                } label: {
                    SettingsRowView(leftIcon: "folder.fill", text: "ウェブサイト", color: .yellow)
                }
                
                Button {
                    openCustomURL(urlString: "https://appcreator2323.wixsite.com/foodhunt/privacypolicy")
                } label: {
                    SettingsRowView(leftIcon: "folder.fill", text: "プライバシー・ポリシー", color: .yellow)
                }
                
                Button {
                    openCustomURL(urlString: "https://appcreator2323.wixsite.com/foodhunt/termsofservice")
                } label: {
                    SettingsRowView(leftIcon: "folder.fill", text: "利用規約", color: .yellow)
                }
                
            } label: {
                SettingsLabelView(labelText: "FoodHuntについて", labelImage: "apps.iphone")
            }.padding()
        }
        
    }
    
    //MARK: FUNCTIONS
    func openCustomURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

