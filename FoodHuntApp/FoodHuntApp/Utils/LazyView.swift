//
//  LazyView.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/03/04.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
