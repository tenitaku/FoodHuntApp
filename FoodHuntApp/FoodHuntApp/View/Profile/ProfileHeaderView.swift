//
//  ProfileHeaderView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/23.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    
    //FOR USER MODEL AND VIEWMODEL
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 6){
            
            Text(viewModel.user.username)
                .font(.custom("Marker Felt", size: 30))
                .padding(.leading, 8)
            
            HStack(alignment: .center,spacing: 30){
                NavigationLink {
                    UserListView(viewModel: SearchViewModel(config: .followers(viewModel.user.id ?? "")), searchText: .constant(""))
                        .navigationBarTitle("\(viewModel.user.username)のFollowers")
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    UserStatView(value: viewModel.user.stats?.followers ?? 0, title: "Followers")
                }
                
//                if let stats = viewModel.user.stats {
//                    UserStatView(value: viewModel.user.stats?.posts ?? 0, title: "Post")
//                }
                
                KFImage(URL(string: viewModel.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90)
                    .clipShape(Circle())
                
                NavigationLink {
                    UserListView(viewModel: SearchViewModel(config: .following(viewModel.user.id ?? "")), searchText: .constant(""))
                        .navigationBarTitle("\(viewModel.user.username)のFollowing")
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    UserStatView(value: viewModel.user.stats?.following ?? 0, title: "Following")
                }
            }
            .padding(.horizontal, 8)
            
            if let bio = viewModel.user.bio {
                Text(bio)
                    .font(.system(size: 15, weight: .medium))
                    .padding(.leading, 8)
            }
            
            ProfileActionButton(viewModel: viewModel)
            
        }
    }
}

