//
//  CameraViewController.swift
//  Insipid Instagram
//
//  Created by jeremy on 2/17/19.
//  Copyright © 2019 Jeremy Chang. All rights reserved.
//

import UIKit
import AlamofireImage
import Firebase
import FirebaseStorage

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var db: Firestore!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var commentField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
    }
    

    @IBAction func onSubmitButton(_ sender: Any) {
        let image = imageView.image!.pngData()
        let caption = commentField.text!
        
        let storage = Storage.storage()
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        let user = Auth.auth().currentUser!
        let imagesRef = storageRef.child(user.uid + "/" + Date().description)
        
        imagesRef.putData(Data(image!), metadata: nil) { (metadata, error) in
            imagesRef.downloadURL{ (url, error) in
                guard let downloadUrl = url?.absoluteString else { print("error"); return }
                self.db.collection("posts").addDocument(data: [
                    "url" : downloadUrl,
                    "userId" : Auth.auth().currentUser!.uid,
                    "caption" : caption
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: " + user.uid + "/" + Date().description + ")")
                        self.tabBarController?.selectedIndex = 0
                    }
                }
            }
        }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
