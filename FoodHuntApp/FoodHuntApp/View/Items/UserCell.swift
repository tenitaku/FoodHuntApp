//
//  UserCell.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/23.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    
    //MARK: FOR FETCH USER
    let user: User
        
    var body: some View {
        HStack{
            //MARK: IMAGE
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
            
            //MARK: USERNAME
            Text(user.username)
                .font(.custom("Marker Felt", size: 20))
            
            
            Spacer()
        }
        .padding(.horizontal, 8)
    }
}
