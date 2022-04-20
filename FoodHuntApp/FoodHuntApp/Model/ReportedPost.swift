//
//  Report.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/03/05.
//

import FirebaseFirestoreSwift
import Firebase

struct ReportedPost: Identifiable, Decodable {
    @DocumentID var id: String?
    let postId: String?
    let reason: String
    let timestamp: Timestamp
    let reportedUid: String
}
