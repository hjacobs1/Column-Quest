//
//  ViewController.swift
//  Column Quest Alpha
//
//  Created by Henry Jacobs on 11/1/17.
//  Copyright © 2017 Henry Jacobs. All rights reserved.
//

import UIKit

// library that makes working with images easier and less verbose
import EasyImagy

// library with a matrix data type used to carry out matrix operations
import MathSwift
import MobileCoreServices
import QuartzCore
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var cameraButtonView = UIButton()
    let imagePicker = UIImagePickerController()
    var imageTaken = UIImage()
    var imagePicked = UIImageView()
    
    // creates and instance of the Math class, which processes the internal library of images so that the app is prepared
    // to make comparisons between the internal library and whatever image the user selects when the app is launched.
    var doMath = Math()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create the button that will open the camera
        var cameraButtonView = UIButton(frame: CGRect(x: 0.0, y: 467, width: self.view.frame.width, height: 100.0))
        cameraButtonView.setTitle("Open Camera", for: .normal)
        cameraButtonView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        cameraButtonView.addTarget(self, action: #selector(openCameraButton(sender:)), for: .touchUpInside)
        self.view.addSubview(cameraButtonView)
        
        // create the button that will open the photo library
        var libButtonView = UIButton(frame: CGRect(x: 0.0, y: 567, width: self.view.frame.width, height: 100.0))
        libButtonView.setTitle("Open Photo Library", for: .normal)
        libButtonView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        libButtonView.addTarget(self, action: #selector(openPhotoLibraryButton(sender:)), for: .touchUpInside)
        self.view.addSubview(libButtonView)
        
        // set the size of the imagePicked variable which will later be given an image to to display
        imagePicked = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 450))
        imagePicked.contentMode = .scaleAspectFit
        view.addSubview(imagePicked)
        checkPermission()
    }
    
    // function that calls a method from the Math class comparing the selected image with the library of images then creates the 
    // views for displaying the result of the comparision.
    func convert(){
        var img: UIImage = imagePicked.image! /* gets the image from the imagePicked variable and saves it to a UIImage var*/
        var image = Image<RGBA>(uiImage: img)! /* converts the selected image to a datatype from EasyImagy library 
                                                    that will be easier to manipulate */
        var result = doMath.mathCall(inp: image) /* calls a method from the instance of the Math class that compresses the image,
                                                    converts it to grayscale, and compares it to the library of images. This method 
                                                    then calls another method that determines which type of column the slected 
                                                    image is. Finally, it returns a text that says the type.*/
        // creating display to show the result of the comparison.
        var labelView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        labelView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        var label = UILabel(frame: CGRect(x: 0, y: 10, width: self.view.frame.width, height: 50))
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.textAlignment = .center
        label.text = result
        
        labelView.addSubview(label)
        self.view.addSubview(labelView)
    }
    
    // requests permission to access the camera and the camer roll from the user
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
            print("User does not have access to photo album.")
        case .denied:
            print("User has denied the permission.")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        checkPermission()
    }
    
    
    // function that is called by tapping the open camera button. This opens the camera from within the app
    // and creates an intance of the image picker class, which will allow the picture taken by the camera to be manipulated
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

    // function that is called by tapping the open photo library button. This opens the library from within the app
    // and creates an intance of the image picker class, which will allow the picture selected to be manipulated
    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

  // function for the image picker controller that calls the convert method on the image selected either from the library
  // or by taking a photo with the camera
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        print("image")
        imagePicked.image = image
        dismiss(animated:true, completion: nil)
        convert() /* calls convert method to process the image slected by the UIImagePickerController */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     }
}



