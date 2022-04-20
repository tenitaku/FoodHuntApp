//
//  SearchView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/23.
//

import SwiftUI
import GoogleMobileAds

struct SearchView: View {
    //MARK: FOR VIEW
    @State var searchText = ""
    @State var inSearchMode = false
    
    //MARK: FOR VIEWMODEL
    @ObservedObject var viewModel = SearchViewModel(config: .search)
    
    var body: some View {
        ZStack(alignment: .bottom){
            ScrollView{
                //MARK: SEARCH BAR
                SearchBar(text: $searchText, isEditing: $inSearchMode)
                    .padding(.horizontal, 8)
                    .padding(.bottom)
                //MARK: GRID OR LIST
                ZStack{
                    if inSearchMode {
                        UserListView(viewModel: viewModel, searchText: $searchText)
                    } else {
                        //                    PostGridView(config: .explore)
                        FeedView(viewModel: FeedViewModel())
                            .padding(.bottom, 30)
                    }
                }
            }
            .navigationBarTitle("アカウント検索")
            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarItems(leading:
//                                    HStack(spacing: 0){
//                Image(systemName: "s.square")
//                Image(systemName: "e.circle.fill")
//                Image(systemName: "a.square")
//                Image(systemName: "r.circle.fill")
//                Image(systemName: "c.square")
//                Image(systemName: "h.circle.fill")
//            }
//            )
            
            
            GADBannerForSearchViewController()
                .frame(width: kGADAdSizeBanner.size.width, height: kGADAdSizeBanner.size.height)
        }
    }
}



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
