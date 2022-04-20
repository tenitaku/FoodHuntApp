//
//  FeedViewModel.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/28.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    func fetchPosts() {
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.posts = documents.compactMap({ try? $0.data(as: Post.self) })
        }
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
}
