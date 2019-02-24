//
//  snapContentViewController.swift
//  SnapChat
//
//  Created by Faizan Khan on 24/02/19.
//  Copyright © 2019 Faizan Khan. All rights reserved.
//

import UIKit
import FirebaseStorage

class snapContentViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker : UIImagePickerController?
    var imageAdded = false
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBAction func nextButtonTapped(_ sender: Any) {
        var fileName = ""
        if let message = textField.text
        {
            if imageAdded && message != ""
            {
                let imagesFolder = Storage.storage().reference().child("images")
                    if let image = imageView.image
                    {
                        if let imageData = image.jpegData(compressionQuality: 0.1)
                        {
                            fileName = "\(NSUUID().uuidString).jpg"
                            imagesFolder.child(fileName).putData(imageData, metadata: nil) { (metadata, error) in
                                if let error = error
                                {
                                    self.presentAlertWhenError(alert: error.localizedDescription)
                                }
                                else
                                {
                                    //Segue to nect Voew Controller
                                    let finalURL = "https://firebasestorage.googleapis.com/v0/b/snapchat-4e551.appspot.com/o/images/\(fileName)"
                                    self.performSegue(withIdentifier: "selectPeople", sender: finalURL)
                                }
                            }
                        }
                    }
            }
            else
            {
                self.presentAlertWhenError(alert: "You must provide both image and message.")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let downloadURL = sender as? String
        {
            if let peopleViewController = segue.destination as? peopleTableViewController
            {
                peopleViewController.downloadURL = downloadURL
            }
        }
    }
    
    func presentAlertWhenError(alert: String) {
        let alertWindow = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertWindow.addAction(action)
        present(alertWindow, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        if imagePicker != nil
        {
            imagePicker?.sourceType = .camera
            present(imagePicker!, animated: true, completion: nil)
        }
    }
    @IBAction func pictureFromDocumentTapped(_ sender: Any) {
        if imagePicker != nil
        {
        imagePicker?.sourceType = .photoLibrary
        present(imagePicker!, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let newImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageView.image = newImage
            imageAdded = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
