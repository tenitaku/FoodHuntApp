//
//  CommentViewModel.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/03/01.
//

import SwiftUI
import Firebase

class CommentViewModel: ObservableObject {
    
    private let post: Post
    
    @Published var comments = [Comment]()
    
    init(post: Post) {
        self.post = post
        fetchComments()
    }
    
    //MARK: UPLOAD COMMENT
    func uploadComment(commentText: String) {
        
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let postId = post.id else { return }
        
        let data: [String: Any] = [
            "username": user.username,
            "profileImageUrl": user.profileImageUrl,
            "uid": user.id ?? "",
            "timestamp": Timestamp(date: Date()),
            "postOwnerUid": post.ownerUid,
            "commentText" : commentText,
            "postId": postId
        ]
        
        COLLECTION_POSTS.document(postId).collection("post-comments").addDocument(data: data) { error in
            if let error = error {
                print("error \(error.localizedDescription)")
                return 
            }
            
            NotificationViewModel.uploadNotification(toUid: self.post.ownerUid, type: .comment, post: self.post)
            
        }
    
    }
    
    //MARK: FETCH COMMNET
    func fetchComments() {
        
        guard let postId = post.id else { return }
        let query = COLLECTION_POSTS.document(postId).collection("post-comments").order(by: "timestamp", descending: false)
        
        query.addSnapshotListener { snapshot, _ in
            guard let addedDocs = snapshot?.documentChanges.filter({ $0.type == .added}) else { return }
            self.comments.append(contentsOf: addedDocs.compactMap({ try? $0.document.data(as: Comment.self)}))
        }
    }
}
