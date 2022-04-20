//
//  CommentCell.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/03/01.
//

import SwiftUI
import Kingfisher

struct CommentCell: View {
    
    @ObservedObject var viewModel: CommentCellViewModel
    
    @State var showActionSheet: Bool = false
    @State var showEditSheet: Bool = false
    
    var body: some View {
        HStack{
            KFImage(URL(string: viewModel.comment.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
            Text(viewModel.comment.username + " ")
                .font(.custom("Marker Felt", size: 16)) +
            Text(viewModel.comment.commentText)
                .font(.system(size: 14, weight: .regular))
            
            Spacer()
            
            Text("\(viewModel.comment.timestampString ?? "")" + "前")
                .foregroundColor(.primary)
                .font(.system(size: 12))
            
            if case viewModel.comment.uid = AuthViewModel.shared.currentUser?.id {
                Button {
                    showEditSheet.toggle()
                } label: {
                    Image(systemName: "minus.square")
                        .foregroundColor(.primary)
                }
                .actionSheet(isPresented: $showEditSheet) {
                    getActionSheetForDelete()
                }
            } else {
                Button {
                    showActionSheet.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.primary)
                }
                .actionSheet(isPresented: $showActionSheet) {
                    getActionSheetForReport()
                }
                
            }
        }
        .padding(.horizontal)
    }
    
    @State var actionSheetType: PostActionSheetOption = .general
    
    enum PostActionSheetOption {
        case general
        case reporting
    }
    
    func getActionSheetForReport() -> ActionSheet {
        switch self.actionSheetType {
        case .general:
            return ActionSheet(title: Text("選択"), message: nil, buttons: [
                .destructive(Text("このコメントを報告する"), action: {
                    self.actionSheetType = .reporting
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.showActionSheet.toggle()
                    }
                }),
                .cancel()
            ])
        case .reporting:
            return ActionSheet(title: Text("報告する理由を教えて下さい"), message: nil, buttons: [
                .destructive(Text("不適切である"), action: {
                    viewModel.uploadReportedComment(reason: "不適切である") { _ in
                        showActionSheet = false
                    }
                }),
                .destructive(Text("スパム目的である"), action: {
                    viewModel.uploadReportedComment(reason: "スパム目的である") { _ in
                        showActionSheet = false
                    }
                }),
                .destructive(Text("不快な気持ちになった"), action: {
                    viewModel.uploadReportedComment(reason: "不快な気持ちになった") { _ in
                        showActionSheet = false
                    }
                }),
                .cancel({
                    self.actionSheetType = .general
                })
            ])
        }
        
    }
    
    func getActionSheetForDelete() -> ActionSheet {
        return ActionSheet(title: Text("選択"), message: nil, buttons: [
            .destructive(Text("このコメントを削除する"), action: {
                viewModel.deleteComment()
            }),
            .cancel()
        ])
    }
}
