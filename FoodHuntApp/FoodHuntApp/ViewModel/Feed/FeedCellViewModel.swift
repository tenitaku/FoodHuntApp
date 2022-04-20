//
//  FeedCellViewModel.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/28.
//

import SwiftUI
import Firebase

class FeedCellViewModel: ObservableObject {
    @Published var post: Post
    @Published var posts = [Post]()
    
    //@Published var reportedPost = [ReportedPost]()
    
    init(post: Post) {
        self.post = post
        checkIfUserLikedPost()
    }
    
    var likeString: String {
        let label = post.likes == 1 ? "like" : "likes"
        return "\(post.likes) \(label)"
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: post.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    //MARK: LIKE FUNC
    func like() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_POSTS.document(post.id ?? "").collection("post-likes").document(uid).setData([:]) { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(postId).setData([:]) { _ in
                
                COLLECTION_POSTS.document(postId).updateData(["likes" : self.post.likes + 1])
                
                NotificationViewModel.uploadNotification(toUid: self.post.ownerUid, type: .like, post: self.post)
                
                
                self.post.didLike = true
                self.post.likes += 1
            }
        }
    }
    
    //MARK: UNLIKE FUNC
    func unlike() {
        guard post.likes > 0 else { return }
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid).delete { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(postId).delete { _ in
                COLLECTION_POSTS.document(postId).updateData(["likes" : self.post.likes - 1])
                self.post.didLike = false
                self.post.likes -= 1
            }
        }
    }
    
    //MARK: CHECK IF FUNC
    func checkIfUserLikedPost() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_USERS.document(uid).collection("user-likes").document(postId).getDocument { snapshot, _ in
            guard let didLike = snapshot?.exists else { return }
            self.post.didLike = didLike
        }
    }
    
//    func uploadReportedPost(reason: String, postId: String) {
//        let data: [String: Any] = [
//
//        ]
//        COLLECTION_REPORTS.addDocument(data: T##[String : Any], completion: T##((Error?) -> Void)?##((Error?) -> Void)?##(Error?) -> Void)
//    }
    
    func uploadReportedPost(reason: String, completion: FirestoreCompletion) {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        let data = [
            "reason" : reason,
            "timestamp" : Timestamp(date: Date()),
            "reportedUid" : uid,
            "postId" : postId
        ] as [String : Any]
        
        COLLECTION_REPORTEDPOSTS.addDocument(data: data, completion: completion)
        
    }
    
    func deletePost() {
        guard let postId = post.id else { return }
        COLLECTION_POSTS.document(postId).delete { _ in
        }
        self.fetchPostsFromFollowedUsers()
    }
    
    func fetchPostsFromFollowedUsers() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).collection("user-feed").getDocuments { snapshot, _ in
            guard let postIDs = snapshot?.documents.map({ $0.documentID }) else { return }
            
            //postIdから情報を得る
            postIDs.forEach { id in
                COLLECTION_POSTS.document(id).getDocument { snapshot, _ in
                    guard let post = try? snapshot?.data(as: Post.self) else { return }
                    self.posts.append(post)
                }
            }

            guard let documents = snapshot?.documents else { return }
            self.posts = documents.compactMap({ try? $0.data(as: Post.self) })
        }
    }
    
//    func unlike() {
//        guard post.likes > 0 else { return }
//        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
//        guard let postId = post.id else { return }
//
//        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid).delete { _ in
//            COLLECTION_USERS.document(uid).collection("user-likes").document(postId).delete { _ in
//                COLLECTION_POSTS.document(postId).updateData(["likes" : self.post.likes - 1])
//                self.post.didLike = false
//                self.post.likes -= 1
//            }
//        }
//    }
    
//    func fetchFeedUser() {
//        COLLECTION_USERS.document(post.id ?? "").getDocument { snapshot, _ in
//            self.post.user = try? snapshot?.data(as: User.self)
//        }
//    }
}
