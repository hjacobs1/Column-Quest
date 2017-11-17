//
//  ViewController.swift
//  Column Quest Alpha
//
//  Created by Henry Jacobs on 11/1/17.
//  Copyright © 2017 Henry Jacobs. All rights reserved.
//

import UIKit
import EasyImagy
import MathSwift
import MobileCoreServices
import QuartzCore
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var cameraButtonView = UIButton()
    let imagePicker = UIImagePickerController()
    var imageTaken = UIImage()
    var imagePicked = UIImageView()
    
    var doMath = Math()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cameraButtonView = UIButton(frame: CGRect(x: 0.0, y: 467, width: self.view.frame.width, height: 100.0))
        cameraButtonView.setTitle("Open Camera", for: .normal)
        cameraButtonView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        cameraButtonView.addTarget(self, action: #selector(openCameraButton(sender:)), for: .touchUpInside)
        self.view.addSubview(cameraButtonView)
        
        var libButtonView = UIButton(frame: CGRect(x: 0.0, y: 567, width: self.view.frame.width, height: 100.0))
        libButtonView.setTitle("Open Photo Library", for: .normal)
        libButtonView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        libButtonView.addTarget(self, action: #selector(openPhotoLibraryButton(sender:)), for: .touchUpInside)
        self.view.addSubview(libButtonView)
        
         imagePicked = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 450))
        imagePicked.contentMode = .scaleAspectFit
        view.addSubview(imagePicked)
        checkPermission()
    }
    func convert(){
        var img: UIImage = imagePicked.image!
        var image = Image<RGBA>(uiImage: img)!
        var result = doMath.mathCall(inp: image)
        var labelView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        labelView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        var label = UILabel(frame: CGRect(x: 0, y: 10, width: self.view.frame.width, height: 50))
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.textAlignment = .center
        label.text = result
        
        labelView.addSubview(label)
        self.view.addSubview(labelView)
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
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        checkPermission()
    }
    
    
    
    @IBAction func openCameraButton(sender: AnyObject) {
         print("button tapped")
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
  
        }
        
    }

    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }


  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        print("image")
        imagePicked.image = image
        dismiss(animated:true, completion: nil)
        convert()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     }
}



