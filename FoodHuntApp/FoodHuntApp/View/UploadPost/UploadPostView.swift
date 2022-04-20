//
//  UploadProfileView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/23.
//

import SwiftUI
import Photos

struct UploadPostView: View {
    
    @State private var selectedImage: UIImage?
    @State var postImage: Image?
    @State var captionText = ""
    @State private var hokui: Double = 0
    @State private var toukei: Double = 0
    @State var latitude = ""
    @State var longitude = ""
    @State var imagePickerPresented = false
    @Binding var tabIndex: Int
    
    //MARK: FOR VIEWMODEL
    @ObservedObject var viewModel = UploadPostViewModel()
    
    var body: some View {
        VStack{
            //MARK: NO POST IMAGE
            if postImage == nil {
                Button(action: {
                    imagePickerPresented.toggle()
                    PHPhotoLibrary.requestAuthorization(for: .addOnly) { (addOnlyAuth) in
                        switch addOnlyAuth {
                        case .notDetermined:
                            print("notDetermined")
                        case .restricted:
                            print("restricted")
                        case .denied:
                            print("denied")
                        case .authorized:
                            // 全ての写真へのアクセスを許可
                            print("authorized")
                        case .limited:
                            // 写真を選択
                            print("limited")
                        @unknown default:
                            print("default")
                        }
                    }
                }, label: {
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 180)
                        .foregroundColor(.primary)
                        .padding(.top, 50)
                }).sheet(isPresented: $imagePickerPresented) {
                    loadImage()
                } content: {
                    ImagePicker(image: $selectedImage)
                }
                
                
                //MARK: YES POST IMAGE
            } else if let image = postImage {
                VStack(alignment: .center) {
                    Button {
                        UIApplication.shared.endEditing()
                    } label: {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: UIScreen.main.bounds.width)
                            .padding(.bottom, 10)
                    }
                    
                    //                    TextField("文章を記入", text: $captionText)
                    //                        .padding(.horizontal, 8)
                    //                        .padding(.bottom, 10)
                    
                    NavigationLink {
                        TapMapView(hokui: $hokui, toukei: $toukei)
                            .navigationBarHidden(true)
                    } label: {
                        Text("地図上で位置を選択する")
                            .foregroundColor(.primary)
                    }

                    
                    HStack{
//                        TextArea(text: $latitude, placeholder: "北緯 (例：32.81075)")
//                            .frame(height: 50)
                        Text("北緯：\(hokui)")
                            .foregroundColor(.primary)
                            .font(.system(size: 15, weight: .semibold))
                        Text("東経：\(toukei)")
                            .foregroundColor(.primary)
                            .font(.system(size: 15, weight: .semibold))

//
//                        TextArea(text: $longitude, placeholder: "東経 (例：130.72106)")
//                            .frame(height: 50)
                    }
                    
                    TextArea(text: $captionText, placeholder: "テキストを入力")
                        .frame(height: 200)
                    
                    HStack(spacing: 20) {
                        Button {
                            if let image = selectedImage {
                                viewModel.uploadPost(caption: captionText, latitude: hokui, longitude: toukei, image: image) { _ in
                                    captionText = ""
                                    latitude = ""
                                    longitude = ""
                                    postImage = nil
                                    tabIndex = 0
                                }
                            }
                        } label: {
                            Text("投稿する")
                                .foregroundColor(Color("antiprimary"))
                                .font(.system(size: 16, weight: .semibold))
                                .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 30)
                                .background(Color.primary)
                                .cornerRadius(5)
                                .padding(.bottom)
                        }
                        
                        Button {
                            captionText = ""
                            postImage = nil
                            latitude = ""
                            longitude = ""
                        } label: {
                            Text("キャンセル")
                                .foregroundColor(Color("antiprimary"))
                                .font(.system(size: 16, weight: .semibold))
                                .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 30)
                                .background(Color.primary)
                                .cornerRadius(5)
                                .padding(.bottom)
                        }
                    }
                }
            }
            
            Spacer()
        }
        .navigationBarTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: Button(action: {
            
        }, label: {
            HStack(spacing: 0){
                Image(systemName: "n.square")
                Image(systemName: "e.circle.fill")
                Image(systemName: "w.square")
                Image(systemName: "p.circle.fill")
                Image(systemName: "o.square")
                Image(systemName: "s.circle.fill")
                Image(systemName: "t.square")
            }
        }))
        
    }
}

//MARK: EXTENSION UPLOAD
extension UploadPostView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        postImage = Image(uiImage: selectedImage)
    }
}
