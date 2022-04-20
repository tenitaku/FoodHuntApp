//
//  UploadPostViewModel.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/27.
//

import SwiftUI
import Firebase

class UploadPostViewModel: ObservableObject {
    
    func uploadPost(caption: String, latitude: Double, longitude: Double, image: UIImage, completion: FirestoreCompletion) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        ImageUploader.uploadImage(image: image, type: .post) { imageUrl in
            let data = [
                "caption" : caption,
                "latitude" : latitude,
                "longitude" : longitude,
                "timestamp" : Timestamp(date: Date()),
                "likes" : 0,
                "imageUrl" : imageUrl,
                "ownerUid" : user.id ?? "",
                "ownerImageUrl" : user.profileImageUrl,
                "OwnerUsername" : user.username
            ] as [String : Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
}
