//
//  TapMapView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/03/09.
//

import SwiftUI
import MapKit

struct TapMapView: View {
    
    @StateObject private var mapviewModel = MapViewModel()
    
    @Environment(\.presentationMode) var mode
    
    @Binding private var hokui: Double
    @Binding private var toukei: Double
    
    init(hokui: Binding<Double>, toukei: Binding<Double>) {
        self._hokui = hokui
        self._toukei = toukei
    }
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
            LocationSelecterView() { location in
                hokui = location.latitude
                toukei = location.longitude
            }
            
            VStack{
                VStack(alignment: .leading) {
                    Text("北緯: \(hokui)")
                    Text("東経: \(toukei)")
                }
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .semibold))
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.orange)
                .cornerRadius(5)
                .padding(.top, 50)
                
                Spacer()
                
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Text("OK")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .padding()
                        .frame(width: 200, height: 30)
                        .background(Color.orange)
                        .clipShape(Capsule())
                }
                .padding(.bottom, 50)
            }

        }
        .edgesIgnoringSafeArea(.top)
    }
}

