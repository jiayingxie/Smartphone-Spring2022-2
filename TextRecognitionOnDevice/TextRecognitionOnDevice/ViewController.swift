//
//  ViewController.swift
//  TextRecognitionOnDevice
//
//  Created by Jiaying Xie on 4/17/22.
//

import UIKit
import MLKit
import MLKitVision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var lblImage: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func analyzeTextAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Identify Image", message: "Select Image fromn Library or take a picture", preferredStyle: .alert)
                
                let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
                    if UIImagePickerController.isSourceTypeAvailable(.camera){
                        let imagePicker = UIImagePickerController()
                        imagePicker.delegate = self
                        imagePicker.sourceType = UIImagePickerController.SourceType.camera
                        imagePicker.allowsEditing = false
                        self.present(imagePicker, animated: true, completion: nil)
                    }
                }
                
                let libraryAction = UIAlertAction(title: "Photo Library", style: .default) { action in
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                        
                        let imagePicker = UIImagePickerController()
                        imagePicker.delegate = self
                        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                        imagePicker.allowsEditing = false
                        self.present(imagePicker, animated: true, completion: nil)
                    }
                    
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                    print("Cancel")
                }
                
                alertController.addAction(cameraAction)
                alertController.addAction(libraryAction)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        imgView.image = image
        picker.dismiss(animated: true, completion: nil)
        analyzeText()
    }
    
    
    func analyzeText() {
        let textRecognizer = TextRecognizer.textRecognizer()
        let image = VisionImage(image: imgView.image!)
        let visionImage = VisionImage(image: imgView.image!)
        visionImage.orientation = imgView.image!.imageOrientation
        
        textRecognizer.process(image) { result, error in
            if error != nil {
                self.lblImage.text = error?.localizedDescription
                return
            }
            
            let resultText = result?.text
//            print(resultText)
            self.lblImage.text = resultText
        }
    }
    
}

