//
//  CustomInputView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/03/01.
//

import SwiftUI

struct CustomInputView: View {
    
    @Binding var inputText: String
    
    var action: () -> Void
    
    var body: some View {
        VStack{
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
                .padding(.bottom, 8)
            
            HStack{
                TextField("コメント", text: $inputText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(minHeight: 30)
                
                Button(action: action){
                    Text("OK")
                        .bold()
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(.bottom, 8)
        .padding(.horizontal)
    }
}

