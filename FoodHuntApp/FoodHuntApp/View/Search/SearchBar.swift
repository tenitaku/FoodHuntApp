//
//  SearchBar.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/23.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack{
            TextField("検索...", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                alignment: .leading)
                            .padding(.leading, 8)
                    })
                .onTapGesture {
                    isEditing = true
                }
            
            if isEditing {
                Button {
                    isEditing = false
                    text = ""
                    UIApplication.shared.endEditing()
                } label: {
                    Text("キャンセル")
                }
                .foregroundColor(.primary)
                .padding(.trailing, 8)
                .transition(.move(edge: .trailing))
                .animation(.default, value: isEditing)

            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("テキスト"), isEditing: .constant(true))
    }
}
