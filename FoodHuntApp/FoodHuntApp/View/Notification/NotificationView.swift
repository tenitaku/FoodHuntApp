//
//  NotificationView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/23.
//

import SwiftUI
import GoogleMobileAds

struct NotificationView: View {
    
    @ObservedObject var viewModel = NotificationViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView{
                LazyVStack(spacing: 15){
                    ForEach(viewModel.notifications) { notification in
                        NotificationCell(viewModel: NotificationCellViewModel(notification: notification))
                    }
                }
                .padding(.top)
//                .refreshable {
//                    NotificationView(viewModel: NotificationViewModel())
//                }
            }
            .navigationBarTitle("通知一覧")
            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarItems(leading: Button(action: {
//
//            }, label: {
//                HStack(spacing: 0){
//                    Image(systemName: "l.square")
//                    Image(systemName: "e.circle.fill")
//                    Image(systemName: "t.square")
//                    Image(systemName: "t.circle.fill")
//                    Image(systemName: "e.square")
//                    Image(systemName: "r.circle.fill")
//                }
//            }))
            .navigationBarItems(trailing: Button(action: {
                viewModel.refresh()
            }, label: {
                Text("Refresh")
            }))
            
            GADBannerForNotificationViewController()
                .frame(width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height)
        }
        
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
