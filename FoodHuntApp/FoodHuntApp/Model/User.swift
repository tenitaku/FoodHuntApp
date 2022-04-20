//
//  User.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/24.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    let username: String
    let email: String
    let profileImageUrl: String
//    let fullname: String
    var bio: String?
    @DocumentID var id: String?
    var isFollowed: Bool? = false
    var isBlocked: Bool? = false
//    var bio: String?
    
    var stats: UserStats?
    
    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.uid == id}
}

struct UserStats: Decodable {
    var following: Int
    var posts: Int
    var followers: Int
}
