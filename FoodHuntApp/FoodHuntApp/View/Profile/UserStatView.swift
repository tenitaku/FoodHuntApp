//
//  UserStatView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/23.
//

import SwiftUI

struct UserStatView: View {
    
    let value: Int
    let title: String
    
    var body: some View {
        VStack{
            Text("\(value)")
                .font(.custom("Marker Felt", size: 25))
            Text(title)
                .font(.custom("Marker Felt", size: 18))
        }
        .frame(width: 80, alignment: .center)
    }
}

struct UserStatView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatView(value: 20, title: "Post")
    }
}
