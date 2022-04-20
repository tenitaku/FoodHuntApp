//
//  ContentView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var selectedIndex = 0
    
    var body: some View {
        Group {
            //MARK: NO LOGIN
            if viewModel.userSession == nil {
                LoginView()
            } else {
            //MARK: YES LOGIN
                if let user =  viewModel.currentUser {
                    MainTabView(user: user, selectedIndex: $selectedIndex)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
