//
//  FeedView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/23.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(viewModel.posts) { post in
                    FeedCell(viewModel: FeedCellViewModel(post: post), isshowFeedCell: .constant(false))
                }
            }
            .padding(.top, -10)
        }
        .navigationBarItems(trailing: Button(action: {
            viewModel.fetchPostsFromFollowedUsers()
        }, label: {
            Text("Refresh")
        }))
    }
}



struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
