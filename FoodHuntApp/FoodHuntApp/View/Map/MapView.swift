//
//  MapView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/03/03.
//

import SwiftUI
import MapKit
import Kingfisher
import GoogleMobileAds

struct MapView: View {
    
    @StateObject private var mapviewModel = MapViewModel()
    
    @State private var isshowFeedCell = false
    
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            Map(coordinateRegion: $mapviewModel.region,
                showsUserLocation: true,
                annotationItems: viewModel.posts) { post in
                
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: post.latitude, longitude: post.longitude)) {

                    Button {
                        isshowFeedCell = true
                    } label: {
                        ZStack(alignment: .top){
                            Image(systemName: "mappin")
                                .foregroundColor(.orange)
                                .font(.system(size: 54))
                            ZStack{
                                Circle()
                                    .foregroundColor(.orange)
                                    .frame(width: 40, height: 40)
                                KFImage(URL(string: post.imageUrl))
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    .sheet(isPresented: $isshowFeedCell) {
                        ScrollView{
                            FeedCell(viewModel: FeedCellViewModel(post: post), isshowFeedCell: $isshowFeedCell)
                        }
                    }
                }
            }
            .accentColor(.blue)
            .navigationBarTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                    
            }, label: {
                HStack(spacing: 0){
                    Image(systemName: "f.square")
                    Image(systemName: "o.circle.fill")
                    Image(systemName: "o.square")
                    Image(systemName: "d.circle.fill")
                    Image(systemName: "h.square")
                    Image(systemName: "u.circle.fill")
                    Image(systemName: "n.square")
                    Image(systemName: "t.circle.fill")
                }
            }))
            .navigationBarItems(trailing: Button(action: {
                viewModel.fetchPostsFromFollowedUsers()
            }, label: {
                Text("Refresh")
            }))
            .accentColor(.primary)
            .onAppear(perform: {
                viewModel.fetchPostsFromFollowedUsers()
                mapviewModel.checkIfLocationServicesIsEnabled()
            })
            .edgesIgnoringSafeArea(.top)
            
            GADBannerForHomeViewController()
                .frame(width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height)
                .padding(.bottom, 30)
        }
        
    }
}
