//
//  Post.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/28.
//

import FirebaseFirestoreSwift
import Firebase
import MapKit

struct Post: Identifiable, Decodable {
    
    @DocumentID var id: String?
    let ownerUid: String
    let OwnerUsername: String
    let caption: String
    let latitude: Double
    let longitude: Double
    var likes: Int
    let imageUrl: String
    let timestamp: Timestamp
    let ownerImageUrl: String
    //let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    
    //var user: User?
    var didLike: Bool? = false
}
