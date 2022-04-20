//
//  AuthViewModel.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

class AuthViewModel: ObservableObject {

    @Published var userSession: FirebaseAuth.User?
    
    //MARK: FOR FETCH USER
    @Published var currentUser: User?
    
    @Published var didSendRessetPasswordLink = false
    
    static let shared = AuthViewModel()
    
    //MARK: INIT
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    //MARK: LOGIN
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("loginFailed: \(error.localizedDescription)")
                return
            }
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    //MARK: REGISTER
    func register(withEmail email: String, password: String, image: UIImage?, username: String) {
        guard let image = image else { return }
        
        ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let user = result?.user else { return }
                print("登録成功")
                
                let data = [
                    "email": email,
                    "username": username,
//                    "fullname": fullname,
                    "profileImageUrl": imageUrl,
                    "uid": user.uid
                ]
                
                COLLECTION_USERS.document(user.uid).setData(data) { err in
                    if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("ユーザー情報を登録しました")
                        }
                    self.userSession = user
                    self.fetchUser()
                }
            }
        }
    }
    
    //MARK: SIGNOUT
    func signout() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    //MARK: FETCH USER
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            self.currentUser = user
        }
    }
    
    //MARK: RESET PASSWORD
    func resetPassword(withEmail email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            self.didSendRessetPasswordLink = true
        }
    }
}
