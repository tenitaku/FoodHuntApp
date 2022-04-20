//
//  UserListView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/23.
//

import SwiftUI

struct UserListView: View {
    
    //MARK: FOR FETCH USER
    @ObservedObject var viewModel: SearchViewModel
    
    //MARK: FOR IF ELSE
    @Binding var searchText: String
    var users: [User] {
        return searchText.isEmpty ? viewModel.users : viewModel.filterUsers(searchText)
    }
    
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(users) { user in
                    NavigationLink {
                        LazyView(ProfileView(user: user))
                    } label: {
                        UserCell(user: user)
                    }
                    .foregroundColor(.primary)
                }
            }
        }
    }
    
}

//struct RefreshableModifier: ViewModifier {
//    let action: @Sendable () async -> Void
//
//    func body(content: Content) -> some View {
//        List {
//            HStack { // HStack + Spacerで中央揃え
//                Spacer()
//                content
//                Spacer()
//            }
//            .listRowSeparator(.hidden) // 罫線非表示
//            .listRowInsets(EdgeInsets()) // Insetsを0に
//        }
//        .refreshable(action: action)
//        .listStyle(PlainListStyle()) // ListStyleの変更
//    }
//}
//
//extension ScrollView {
//    func refreshable(action: @escaping @Sendable () async -> Void) -> some View {
//        modifier(RefreshableModifier(action: action))
//    }
//}

