//
//  NotificationCell.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/23.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    
    @State private var showPostImage = false
    
    @ObservedObject var viewModel: NotificationCellViewModel
    
    var isFollowed: Bool { return viewModel.notification.isFollowed ?? false }
    
    init(viewModel: NotificationCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack{

            KFImage(URL(string: viewModel.notification.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            VStack(alignment: .leading){
                HStack{
                    if let user = viewModel.notification.user {
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            Text(viewModel.notification.username)
                                .font(.custom("Marker Felt", size: 15))
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Text(viewModel.notification.type.notificationMessage)
                        .font(.system(size: 12, weight: .semibold))
                    
                }
                HStack{
                    Text(viewModel.timestampString + "前")
                        .foregroundColor(.primary)
                        .font(.system(size: 10, weight: .light))
                    Spacer()
                }
            }
            
            Spacer()
            
            if viewModel.notification.type != .follow {
                if let post = viewModel.notification.post {
                    NavigationLink {
                        ScrollView{
                            FeedCell(viewModel: FeedCellViewModel(post: post), isshowFeedCell: .constant(false))
                        }
                    } label: {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 35, height: 35)
                            .clipShape(Rectangle())
                            .cornerRadius(5)
                    }

                }
            } else {
                Button {
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                } label: {
                    Text(isFollowed ? "フォロー中" : "フォローする")
                        .font(.system(size: 12, weight: .semibold))
                        .frame(width: 90, height: 30)
                        .foregroundColor(isFollowed ? Color.primary : Color("antiprimary"))
                        .background(isFollowed ? Color("antiprimary") : Color.primary)
                        .cornerRadius(3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3).stroke(lineWidth: 1)
                                .foregroundColor(.secondary)
                        )
                }

            }
        }
        .padding(.horizontal, 8)
    }
}

