//
//  ExtensionBaseViewController.swift
//  FirebaseLesson1
//
//  Created by Noishiki Tatsunori on 2020/02/17.
//  Copyright © 2020 Noishiki Tatsunori. All rights reserved.
//

import UIKit
import PGFramework
import Photos
import AVFoundation

extension UIViewController: UITabBarControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    func checkCameraAuth(allowed: @escaping () -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        let status2 = PHPhotoLibrary.authorizationStatus()
        if status == AVAuthorizationStatus.authorized && status2 == .authorized {
            // アクセス許可あり
            allowed()
        } else if status == AVAuthorizationStatus.restricted || status2 == .restricted {
            // ユーザー自身にカメラへのアクセスが許可されていない
            self.alertToSetting(title: "カメラもしくは写真へのアクセスが許可されていません", message: "設定画面へ移行しますか？")
        } else if status == AVAuthorizationStatus.notDetermined || status2 == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: {result in
                PHPhotoLibrary.requestAuthorization({ (status) in
                    if result && (status == .authorized) {
                        allowed()
                    } else {
                        return
                    }
                })
            })
        }else if status == AVAuthorizationStatus.denied || status2 == .denied {
            self.alertToSetting(title: "カメラもしくは写真へのアクセスが許可されていません", message: "設定画面へ移行しますか？")
        }else{
            print("error")
        }
    }
    
    func moviewPicker(deleteAction: @escaping (UIAlertAction) -> Void) {
        checkCameraAuth {
            let alert: UIAlertController = UIAlertController(title: "", message: "選択してください", preferredStyle: .actionSheet)
            let galleryAction: UIAlertAction = UIAlertAction(title: "アルバムから選択", style: .default, handler:{
                (action: UIAlertAction!) -> Void in
                let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                    let libraryPicker = UIImagePickerController()
                    libraryPicker.sourceType = sourceType
                    libraryPicker.mediaTypes = ["public.movie"]
                    libraryPicker.delegate = self
                    self.present(libraryPicker, animated: true, completion: nil)
                }
            })
            let deleteAction = UIAlertAction(title: "動画を削除", style: .default, handler: deleteAction)
            let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (_) in })
            alert.addAction(galleryAction)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func useCamera(isDeletable: Bool?=nil, deleteAction:((UIAlertAction) -> Void)?=nil) {
        self.checkCameraAuth {
            DispatchQueue.main.async {
                self.activeCamera(isDeletable: isDeletable, deleteAction: deleteAction)
            }
        }
    }
    
    func activeCamera(isDeletable: Bool?=nil, deleteAction:((UIAlertAction) -> Void)?=nil){
        let alert: UIAlertController = UIAlertController(title: "", message: "選択してください", preferredStyle: .actionSheet)
        let cameraAction: UIAlertAction = UIAlertAction(title: "カメラで撮影", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
            let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.camera
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                let cameraPicker = UIImagePickerController()
                cameraPicker.sourceType = sourceType
                cameraPicker.delegate = self
                self.present(cameraPicker, animated: true, completion: nil)
            }
        })
        let galleryAction: UIAlertAction = UIAlertAction(title: "アルバムから選択", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
            let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                let libraryPicker = UIImagePickerController()
                libraryPicker.sourceType = sourceType
                libraryPicker.delegate = self
                self.present(libraryPicker, animated: true, completion: nil)
                
            }
        })
        
        let deleteAction = UIAlertAction(title: "写真を削除", style: .default, handler: deleteAction)
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        alert.addAction(cancelAction)
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        if isDeletable == true {
            alert.addAction(deleteAction)
        }
        present(alert, animated: true, completion: nil)
    }
    
    func alert(message: String) {
        if message != "" {
            let vc = UIAlertController(title: message, message: nil, preferredStyle: UIAlertController.Style.alert)
            vc.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(vc, animated: true, completion: nil)
        }else {
            return
        }
    }
    
    func alert(message: String, choiceHandler: @escaping ((UIAlertAction) -> Void)) {
        if message != "" {
            let vc = UIAlertController(title: message, message: nil, preferredStyle: UIAlertController.Style.alert)
            vc.addAction(UIAlertAction(title: "OK", style: .default, handler: choiceHandler))
            present(vc, animated: true, completion: nil)
        }else {
            return
        }
    }
    
    func alert(title: String?, message: String? = nil, choice: String? = nil, choiceStyle: Int? = nil, tintColor: UIColor? = nil, choiceHandler: @escaping () -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        ac.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        if let choice = choice {
            ac.addAction(UIAlertAction(title: choice, style: .default, handler: { action in
                choiceHandler()
            } ))
        }
        ac.view.tintColor = tintColor
        present(ac, animated: true, completion: nil)
    }
    
    func alertToSetting(title: String, message: String) {
        if message != "" {
            let vc = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            vc.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }))
            vc.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(vc, animated: true, completion: nil)
        }else {
            return
        }
    }
    
    func callActionSheet(titles: [String], choiceHandler: [() -> Void]) {
        var actions = [UIAlertAction]()
        for i in 0 ..< titles.count {
            let action = UIAlertAction(title: titles[i], style: .default) { action in
                let handler = choiceHandler[i]
                handler()
            }
            actions.append(action)
        }
        let alert: UIAlertController = UIAlertController(title: "", message: "選択してください", preferredStyle: .actionSheet)
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        alert.addAction(cancelAction)
        actions.forEach { (action) in
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}


