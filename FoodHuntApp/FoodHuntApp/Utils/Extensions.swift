//
//  Extensions.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/02/23.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
