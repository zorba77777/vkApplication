//
//  ImagePickerViewController.swift
//  vkApplication
//
//  Created by Timur Sasin on 26/04/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//


import UIKit
import AVKit
import MobileCoreServices
import Photos
import VK_ios_sdk

class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var publishButton: UIButton!
    var uploadUrl: String = ""
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkPermission()
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            print("User do not have access to photo album.")
        case .denied:
            print("User has denied the permission.")
        }
    }

    @IBAction func selectExistingPictureOrVideo(_ sender: UIButton) {
        pickMediaFromSource(UIImagePickerControllerSourceType.photoLibrary)
    }
    
    @IBAction func publishImageInVk(_ sender: UIButton) {
        self.publishButton.isEnabled = false
        
        guard let idString = VKSdk.accessToken().userId else {
            print("Something went wrong with VKSdk")
            return
        }
        
        guard let userId = Int(idString) else { return }
        
        let uploadRequest: VKRequest = VKApi.uploadWallPhotoRequest(self.image, parameters: VKImageParameters.jpegImage(withQuality: 1), userId: userId, groupId: 0)
        uploadRequest.execute(resultBlock: {
            data in
            guard let response = data else { return }
            guard let array = response.json as? NSArray else { return }
            guard let dictionary = array[0] as? NSDictionary else { return }
            guard let owner_id = dictionary["owner_id"] as? Int else { return }
            guard let id = dictionary["id"] as? Int else { return }
            let photoAttachString = "photo" + String(owner_id) + "_" + String(id)
            
            let postPhotoRequest: VKRequest = VKApi.wall().post([
                    "message":"",
                    VK_API_ATTACHMENTS: photoAttachString
                ])

            postPhotoRequest.execute(resultBlock: { (response) in
                print(response as Any)
            }, errorBlock: { (error) in
                print(error as Any)
            })
            
        }, errorBlock: {
            error in print(error as Any)
        })
    }
    
    func pickMediaFromSource(_ sourceType:UIImagePickerControllerSourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) == false {
            print("Unsupperted source type - savedPhotosAlbum")
            return
        }
        
        let controller = UIImagePickerController()
        controller.sourceType = .savedPhotosAlbum
        controller.mediaTypes = [kUTTypeImage as String]
        controller.allowsEditing = false
        controller.delegate = self
        
        present(controller, animated: true, completion: nil)
        

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let mediaType = info[UIImagePickerControllerMediaType] as? String else {
            print("Not found media type")
            return
        }
        
        if mediaType == kUTTypeImage as String {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.imageView.image = image
                self.image = image
                self.publishButton.isEnabled = true
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
    }
}


