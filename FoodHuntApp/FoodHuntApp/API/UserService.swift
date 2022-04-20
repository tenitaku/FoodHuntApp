//
//  UserService.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/26.
//

import Firebase

typealias FirestoreCompletion = ((Error?) -> Void)?

struct UserService {
    
    //MARK: FOLLOW
    static func follow(uid: String, completion: ((Error?) -> Void)?) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { _ in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
        }
    }
    
    //MARK: BLOCK
    static func block(uid: String, completion: ((Error?) -> Void)?) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_BLOCKING.document(currentUid).collection("user-blocking").document(uid).setData([:]) { _ in
            COLLECTION_BLOCKERS.document(uid).collection("user-blockers").document(currentUid).setData([:], completion: completion)
        }
    }
    
    //MARK: UNFOLLOW
    static func unfollow(uid: String, completion: ((Error?) -> Void)?) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { _ in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
    }
    
    //MARK: UNBLOCK
    static func unblock(uid: String, completion: ((Error?) -> Void)?) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_BLOCKING.document(currentUid).collection("user-blocking").document(uid).delete { _ in
            COLLECTION_BLOCKERS.document(uid).collection("user-blockers").document(currentUid).delete(completion: completion)
        }
    }
    
    //MARK: CHECK IS FOLLOWED
    static func chechIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { snapshot, _ in
            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
    }
    
    //MARK: CHECK IS FOLLOWED
    static func chechIfUserIsBlocked(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        COLLECTION_BLOCKING.document(currentUid).collection("user-blocking").document(uid).getDocument { snapshot, _ in
            guard let isBlocked = snapshot?.exists else { return }
            completion(isBlocked)
        }
    }
    
    //MARK: FETCH USER
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            completion(user)
        }
    }
}
