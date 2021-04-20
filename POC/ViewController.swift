//
//  ViewController.swift
//  POC
//
//  Created by Netra Technosys on 19/04/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var inputImage: UIImageView!
    @IBOutlet weak var outputImage: UIImageView!
    @IBOutlet weak var selectImageBtn: UIButton!
    @IBOutlet weak var removeBgBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.inputImage.image = UIImage(named: "image_1")
        // Do any additional setup after loading the view.
    }

    @IBAction func selectImageClicked(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.modalPresentationStyle = UIModalPresentationStyle.currentContext
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func removeBgClicked(_ sender: Any) {
        if let inputImg = self.inputImage.image {
            self.callsendImageAPI(image: inputImg)
        }
    }
    
    //MARK: - Api Calling
    func callsendImageAPI(/*param:[String: Any],*/image:UIImage) {

        let headers: HTTPHeaders
        headers = ["Content-type": "multipart/form-data",
                   "Content-Disposition" : "form-data",
                   "API-KEY" : "2ac2*****a4d4cc19ee11fd458dfe"]
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
//            for (key, value) in param {
//                multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
//            }
            
            guard let imgData = image.jpegData(compressionQuality: 1) else { return }
            multipartFormData.append(imgData, withName: "source_image_file", fileName: "image"+".jpeg", mimeType: "image/jpeg")
            
        },to: URL.init(string: "https://api.slazzer.com/v2.0/remove_image_background")!, usingThreshold: UInt64.init(),
          method: .post,
          headers: headers).response{ response in
            
            if (response.error == nil) {
                if let jsonData = response.data{
                    let image = UIImage(data: jsonData)
                    self.outputImage.image = image
                }
            }else{
                 print(response.error?.localizedDescription ?? "")
            }
        }
    }
    
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage:UIImage = info[.originalImage] as! UIImage
        self.inputImage.image = tempImage
        self.dismiss(animated: true, completion: nil)
    }

}

