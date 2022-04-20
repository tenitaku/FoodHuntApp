//
//  ProfileActionButton.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/23.
//

import SwiftUI

struct ProfileActionButton: View {
    
    //MARK: FOR VIEW MODEL
    @ObservedObject var viewModel: ProfileViewModel
    
    var isFollowed: Bool { return viewModel.user.isFollowed ?? false }
    var isBlocked: Bool { return viewModel.user.isBlocked ?? false }
    
    var body: some View {
        if viewModel.user.isCurrentUser {
            //MARK: EDTI PROFILE
            NavigationLink {
                SettingsView(viewModel: ProfileViewModel(user: viewModel.user))
            } label: {
                Text("設定")
                    .font(.system(size: 14, weight: .semibold))
                    .frame(maxWidth: UIScreen.main.bounds.width - 16)
                    .frame(height: 30)
                    .foregroundColor(.primary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3).stroke(lineWidth: 1)
                            .foregroundColor(.secondary)
                    )
            }
            
        } else {
            //MARK: FOLLOW BUTTON
            HStack{
                Button {
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                } label: {
                    Text(isFollowed ? "フォロー中" : "フォローする")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(maxWidth: UIScreen.main.bounds.width / 2 - 16)
                        .frame(height: 30)
                        .foregroundColor(isFollowed ? Color.primary : Color("antiprimary"))
                        .background(isFollowed ? Color("antiprimary") : Color.primary)
                        .cornerRadius(3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3).stroke(lineWidth: 1)
                                .foregroundColor(.secondary)
                        )
                }
                
                Button {
                    isBlocked ? viewModel.unblock() : viewModel.block()
                } label: {
                    Text(isBlocked ? "ブロック解除" : "ブロックする")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(maxWidth: UIScreen.main.bounds.width / 2 - 16)
                        .frame(height: 30)
                        .foregroundColor(isBlocked ? Color.primary : Color("antiprimary"))
                        .background(isBlocked ? Color("antiprimary") : Color.primary)
                        .cornerRadius(3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3).stroke(lineWidth: 1)
                                .foregroundColor(.secondary)
                        )
                }
            }
        }
    }
}

