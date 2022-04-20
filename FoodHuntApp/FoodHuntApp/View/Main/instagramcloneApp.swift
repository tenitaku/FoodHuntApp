//
//  instagramcloneApp.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/22.
//

import SwiftUI
import Firebase
import GoogleMobileAds


@main
struct instagramcloneApp: App {
    
    init() {
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}
