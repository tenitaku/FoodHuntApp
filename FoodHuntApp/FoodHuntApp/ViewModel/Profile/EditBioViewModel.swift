//
//  EditProfileViewModel.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/03/05.
//

import SwiftUI

class EditBioViewModel: ObservableObject {
    var user: User
    @Published var uploadComplete = false
    
    init(user: User) {
        self.user = user
    }
    
    func saveUserBio(_ bio: String) {
        guard let uid = user.id else { return }
        
        COLLECTION_USERS.document(uid).updateData(["bio": bio]) { _ in
            self.user.bio = bio
            self.uploadComplete = true
        }
    }
}
