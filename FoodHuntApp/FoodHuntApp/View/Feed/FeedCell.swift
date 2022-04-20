//
//  FeedCell.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/23.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {

    @ObservedObject var viewModel: FeedCellViewModel
    
    @State var showComments: Bool = false
    @State var showActionSheet: Bool = false
    @State var showEditSheet: Bool = false
    
    @Environment(\.presentationMode) var mode
            
    @Binding var isshowFeedCell: Bool
    
    var didLike: Bool { return viewModel.post.didLike ?? false }
    
    init(viewModel: FeedCellViewModel, isshowFeedCell: Binding<Bool>) {
        self.viewModel = viewModel
        self._isshowFeedCell = isshowFeedCell
    }
    
    var body: some View {
        VStack(alignment: .leading){
            //MARK: USER INFO
            
            HStack{
                KFImage(URL(string: viewModel.post.ownerImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                
                Text(viewModel.post.OwnerUsername)
                    .font(.custom("Marker Felt", size: 25))
                
                Spacer()

                if case viewModel.post.ownerUid = AuthViewModel.shared.currentUser?.id {
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
                    }.actionSheet(isPresented: $showActionSheet) {
                        getActionSheetForReport()
                    }
                }
                
            }
            .padding(.bottom, -3)
            
            Text(viewModel.post.caption)
                .font(.system(size: 18, weight: .semibold))
                .padding(.bottom, -3)
            
            //MARK: POST IMAGE
            KFImage(URL(string: viewModel.post.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(maxWidth: UIScreen.main.bounds.width)
                .cornerRadius(10)
            
            //MARK: ACTION BUTTONS
            HStack(spacing: 30){
                
                HStack(spacing: 5){
                    Button {
                        didLike ? viewModel.unlike() : viewModel.like()
                    } label: {
                        Image(systemName: didLike ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundColor(didLike ? .red : .primary)
                    }
                    
                    Text(viewModel.likeString)
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.horizontal, 4)
                }
                
                Button {
                    showComments.toggle()
                } label: {
                    Image(systemName: "text.bubble")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.primary)
                }
                .sheet(isPresented: $showComments) {
                    CommentsView(post: viewModel.post)
                }
                
                Spacer()
                
                Text(viewModel.timestampString + "前")
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(.primary)
            }
            
            Rectangle()
                .foregroundColor(.secondary)
                .frame(height: 0.5)
                .frame(maxWidth: .infinity)
            
            Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal, 15)
        
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
                .destructive(Text("この投稿を報告する"), action: {
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
                    viewModel.uploadReportedPost(reason: "不適切である") { _ in
                        showActionSheet = false
                    }
                }),
                .destructive(Text("スパム目的である"), action: {
                    viewModel.uploadReportedPost(reason: "スパム目的である") { _ in
                        showActionSheet = false
                    }
                }),
                .destructive(Text("不快な気持ちになった"), action: {
                    viewModel.uploadReportedPost(reason: "不快な気持ちになった") { _ in
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
        return ActionSheet(
            title: Text("選択"),
            message: nil,
            buttons: [
                .destructive(Text("この投稿を削除する"),
                             action: {
                                 viewModel.deletePost()
                                 self.isshowFeedCell = false
                                 mode.wrappedValue.dismiss()
                             }),
                .cancel()
            ])
    }
    
    func reportPost(reason: String) {
        
    }
}
