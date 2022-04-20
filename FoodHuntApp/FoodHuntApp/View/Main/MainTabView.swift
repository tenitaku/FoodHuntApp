//
//  MainTabView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/23.
//

import SwiftUI

struct MainTabView: View {
    
    //MARK: USER MODEL
    let user: User
    
    @Binding var selectedIndex: Int
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            NavigationView{
                MapView()
            }
            .onTapGesture {
                selectedIndex = 0
            }
            .tabItem {
                Text("ホーム")
                Image(systemName: "house")
            }
            .tag(0)
            
            NavigationView{
                SearchView()
            }
            .onTapGesture {
                selectedIndex = 1
            }
            .tabItem {
                Text("アカウント検索")
                Image(systemName: "magnifyingglass")
            }
            .tag(1)
            
            NavigationView{
                UploadPostView(tabIndex: $selectedIndex)
            }
            .onTapGesture {
                selectedIndex = 2
            }
            .tabItem {
                Text("新規投稿")
                Image(systemName: "plus.square")
            }
            .tag(2)
            
            NavigationView{
                NotificationView()
            }
            .onTapGesture {
                selectedIndex = 3
            }
            .tabItem {
                Text("お便り")
                Image(systemName: "heart")
            }
            .tag(3)
            
            NavigationView{
                ProfileView(user: user)
            }
            .onTapGesture {
                selectedIndex = 4
            }
            .tabItem {
                Text("プロフィール")
                Image(systemName: "person")
            }
            .tag(4)
        }
        .accentColor(.primary)
    }
}

