//
//  ViewController.swift
//  instagramclone
//
//  Created by 福島匠 on 2022/03/06.
//

import UIKit
import AdSupport
import AppTrackingTransparency
import Photos

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 14, *) {
            switch ATTrackingManager.trackingAuthorizationStatus {
            case .authorized:
                print("Allow Tracking")
                print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
            case .denied:
                print("😭拒否")
            case .restricted:
                print("🥺制限")
            case .notDetermined:
                showRequestTrackingAuthorizationAlert()
            @unknown default:
                fatalError()
            }
        } else {// iOS14未満
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                print("Allow Tracking")
                print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
            } else {
                print("🥺制限")
            }
        }
    }

    ///Alert表示
    private func showRequestTrackingAuthorizationAlert() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                switch status {
                case .authorized:
                    print("🎉")
                    //IDFA取得
                    print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
                case .denied, .restricted, .notDetermined:
                    print("😭")
                @unknown default:
                    fatalError()
                }
            })
        }
    }
    
    private func libraryUsage() {
        if #available(iOS 14, *) {
            // 追加のみする場合の許可状態
            let addOnlyAuth = PHPhotoLibrary.authorizationStatus(for: .addOnly)
            
            switch addOnlyAuth {
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            case .authorized:
                print("authorized")
            case .limited:
                print("limited")
            @unknown default:
                print("default")
            }
            
            // 読み書きをする場合の許可状態
            let readWriteAuth = PHPhotoLibrary.authorizationStatus(for: .readWrite)

            switch readWriteAuth {
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            case .authorized:
                print("authorized")
            case .limited:
                print("limited")
            @unknown default:
                print("default")
            }
        } else {
            // iOS14未満
            let auth = PHPhotoLibrary.authorizationStatus()
            
            switch auth {
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            case .authorized:
                print("authorized")
            case .limited:
                print("limited")
            @unknown default:
                print("default")
            }

        }
    }
}
