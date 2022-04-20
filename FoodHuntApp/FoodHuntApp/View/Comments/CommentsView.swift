//
//  CommentsView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/03/01.
//

import SwiftUI

struct CommentsView: View {
    
    @State var commentText = ""
    @ObservedObject var viewModel: CommentViewModel
    
    init(post: Post) {
        self.viewModel = CommentViewModel(post: post)
    }
    
    var body: some View {
        VStack{
            //MARK: COMMENT CELL
            ScrollView{
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.comments) { comment in
                        CommentCell(viewModel: CommentCellViewModel(comment: comment))
                    }
                }
                .padding(.top, 20)
            }
            
            //MARK: INPUT VIEW
            CustomInputView(inputText: $commentText, action: uploadComment)
        }
    }
    
    func uploadComment() {
        viewModel.uploadComment(commentText: commentText)
        commentText = ""
    }
}


