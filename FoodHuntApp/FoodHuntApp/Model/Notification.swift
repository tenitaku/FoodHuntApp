//
//  Notification.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/03/03.
//

import FirebaseFirestoreSwift
import Firebase

struct Notification: Identifiable, Decodable {
    @DocumentID var id: String?
    let postId: String?
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let type: NotificationType
    let uid: String
    
    var isFollowed: Bool? = false
    var post: Post?
    var user: User?
}

enum NotificationType: Int, Decodable {
    case like
    case comment
    case follow
    
    var notificationMessage: String {
        switch self {
        case .like: return "があなたの投稿にいいねしました"
        case .comment: return "があなたの投稿にコメントしました"
        case .follow: return "があなたをフォローしました"
        }
    }
}
