//
//  CommentsCellViewModel.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/03/05.
//

import SwiftUI
import Firebase

class CommentCellViewModel: ObservableObject {
    
    @Published var comment: Comment
    init(comment: Comment) {
        self.comment = comment
    }
    
    func uploadReportedComment(reason: String, completion: FirestoreCompletion) {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let commentId = comment.id else { return }
        
        let data = [
            "reason" : reason,
            "timestamp" : Timestamp(date: Date()),
            "reportedUid" : uid,
            "commentId" : commentId,
            "commnettext": comment.commentText
        ] as [String : Any]
        
        COLLECTION_REPORTEDCOMMENTS.addDocument(data: data, completion: completion)
    }
    
    func deleteComment() {
        guard let commentId = comment.id else { return }
        guard let postId = comment.postId else { return }
        COLLECTION_POSTS.document(postId).collection("post-comments").document(commentId).delete()
    }
}
