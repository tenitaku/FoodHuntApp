//
//  ProfileView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/23.
//

import SwiftUI
import GoogleMobileAds

struct ProfileView: View {
    
    //MARK: USER MODEL
    let user: User
    
    //MARK: FOR VIEW MODEL
    @ObservedObject var viewModel: ProfileViewModel
    
    var isFollowed: Bool { return viewModel.user.isFollowed ?? false }
    var isBlocked: Bool { return viewModel.user.isBlocked ?? false }
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView{
                VStack(spacing: 12){
                    ProfileHeaderView(viewModel: viewModel)
                    if viewModel.user.isCurrentUser {
                        PostGridView(config: .profile(user.id ?? ""))
                    } else {
                        if isFollowed == true && isBlocked == false {
                            PostGridView(config: .profile(user.id ?? ""))
                        }
                    }
                }
                .padding(.top, 4)
            }
            .navigationBarTitle("\(user.username)：\(viewModel.user.stats?.posts ?? 0)投稿")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                viewModel.chechIfUserIsFollowed()
                viewModel.chechIfUserIsBlocked()
                viewModel.fetchUserStats()
                viewModel.fetchUserPosts(forUid: user.id ?? "")
            }, label: {
                Text("Refresh")
            }))
//            .navigationBarItems(leading:
//                HStack(spacing: 0){
//                    Image(systemName: "p.square")
//                    Image(systemName: "r.circle.fill")
//                    Image(systemName: "o.square")
//                    Image(systemName: "f.circle.fill")
//                    Image(systemName: "i.square")
//                    Image(systemName: "l.circle.fill")
//                    Image(systemName: "e.square")
//            })
            
            GADBannerForProfileViewController()
                .frame(width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height)
        }
    }
}

