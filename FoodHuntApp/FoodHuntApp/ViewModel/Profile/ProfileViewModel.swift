//
//  ProfileViewModel.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/26.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var user: User
    
    @Published var posts = [Post]()
    
    init(user: User) {
        self.user = user
        chechIfUserIsFollowed()
        chechIfUserIsBlocked()
        fetchUserStats()
    }
    
    func follow() {
        guard let uid = user.id else { return }
        UserService.follow(uid: uid) { _ in
            NotificationViewModel.uploadNotification(toUid: uid, type: .follow)
            self.user.isFollowed = true
        }
    }
    
    func block() {
        guard let uid = user.id else { return }
        UserService.block(uid: uid) { _ in
            self.user.isBlocked = true
        }
    }
    
    
    func unfollow() {
        guard let uid = user.id else { return }
        UserService.unfollow(uid: uid) { _ in
            self.user.isFollowed = false
        }
    }
    
    func unblock() {
        guard let uid = user.id else { return }
        UserService.unblock(uid: uid) { _ in
            self.user.isBlocked = false
        }
    }
    
    func chechIfUserIsFollowed() {
        guard !user.isCurrentUser else { return }

        guard let uid = user.id else { return }
        UserService.chechIfUserIsFollowed(uid: uid) { isFollowed in
            self.user.isFollowed = isFollowed
        }
    }
    
    func chechIfUserIsBlocked() {
        guard !user.isCurrentUser else { return }

        guard let uid = user.id else { return }
        UserService.chechIfUserIsBlocked(uid: uid) { isBlocked in
            self.user.isBlocked = isBlocked
        }
    }
    
    
    func fetchUserStats() {
        guard let uid = user.id else { return }
        
        COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, _ in
            guard let following = snapshot?.documents.count else { return }
            
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, _ in
                guard let followers = snapshot?.documents.count else { return }
                
                COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, _ in
                    guard let posts = snapshot?.documents.count else { return }
                    
                    self.user.stats = UserStats(following: following, posts: posts, followers: followers)
                }
            }
        }
    }
    
    func fetchUserPosts(forUid uid: String) {
        COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.compactMap({ try? $0.data(as: Post.self) })
            self.posts = posts.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
        }
    }
}
