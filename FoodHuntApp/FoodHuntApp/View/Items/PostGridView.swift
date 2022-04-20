//
//  PostGridView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/23.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    
    private let items = [GridItem(), GridItem(), GridItem()]
    private let gridwidth = UIScreen.main.bounds.width / 3
    @State var showFeedCell: Bool = false
    
    @State var navigationViewIsActive: Bool = false


    //MARK: FOR VIEWMODEL
    let config: PostGridConfiguration
    @ObservedObject var viewModel: PostGridViewModel
    
    //MARK: INIT
    init(config: PostGridConfiguration) {
        self.config = config
        self.viewModel = PostGridViewModel(config: config)
    }
    
    var body: some View {
        LazyVGrid(columns: items, spacing: 3) {
            ForEach(viewModel.posts) { post in
                NavigationLink {
                    ScrollView{
                        FeedCell(viewModel: FeedCellViewModel(post: post), isshowFeedCell: .constant(false))
                            .navigationBarTitle("\(post.OwnerUsername)の投稿")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                } label: {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: gridwidth, height: gridwidth)
                        .clipped()
                }
            }
        }
    }
}

