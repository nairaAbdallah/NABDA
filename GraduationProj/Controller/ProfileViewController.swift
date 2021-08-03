//
//  ProfileViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 28/03/2021.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ProfileViewController: UIViewController {

    let storage = Storage.storage().reference().child("profileImages")
    let db = Firestore.firestore()
    let vc = UIImagePickerController()
    var name = ""
    var age = ""
    var hight = ""
    var weight = ""
    var bloodType = ""
    var phoneNumber = ""
    var urlString = ""
    var urlImage = ""
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var hightText: UITextField!
    @IBOutlet weak var weghtText: UITextField!
    @IBOutlet weak var bloodTypeText: UITextField!
    @IBOutlet weak var phoneNumberText: UITextField!
    
    @IBAction func addPhotoAction(_ sender: UIButton) {
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        present(vc, animated: true)
       
    }    
    @IBOutlet weak var nameButton: UIButton!
    @IBAction func nameButtonAction(_ sender: UIButton) {
        nameText.isEnabled = true
        ageText.isEnabled = false
        hightText.isEnabled = false
        weghtText.isEnabled = false
        bloodTypeText.isEnabled = false
        phoneNumberText.isEnabled = false
        
       
    }
    @IBOutlet weak var ageButton: UIButton!
    @IBAction func ageButtonAction(_ sender: UIButton) {
        ageText.isEnabled = true
        nameText.isEnabled = false
        hightText.isEnabled = false
        weghtText.isEnabled = false
        bloodTypeText.isEnabled = false
        phoneNumberText.isEnabled = false
    }
    @IBOutlet weak var hightButton: UIButton!
    @IBAction func hightButtonAction(_ sender: UIButton) {
        hightText.isEnabled = true
        nameText.isEnabled = false
        ageText.isEnabled = false
        weghtText.isEnabled = false
        bloodTypeText.isEnabled = false
        phoneNumberText.isEnabled = false
    }
    @IBOutlet weak var weightButton: UIButton!
    @IBAction func weightButtonAction(_ sender: UIButton) {
        weghtText.isEnabled = true
        nameText.isEnabled = false
        ageText.isEnabled = false
        hightText.isEnabled = false
        bloodTypeText.isEnabled = false
        phoneNumberText.isEnabled = false
    }
    @IBOutlet weak var bloodTypeButton: UIButton!
    @IBAction func bloodTypeAction(_ sender: UIButton) {
        bloodTypeText.isEnabled = true
        nameText.isEnabled = false
        ageText.isEnabled = false
        hightText.isEnabled = false
        weghtText.isEnabled = false
        phoneNumberText.isEnabled = false
    }
    @IBOutlet weak var phoneNumberButton: UIButton!
    @IBAction func phoneNumberAction(_ sender: UIButton) {
        phoneNumberText.isEnabled = true
        nameText.isEnabled = false
        ageText.isEnabled = false
        hightText.isEnabled = false
        weghtText.isEnabled = false
        bloodTypeText.isEnabled = false
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        retrieve()
        profilePhoto.layer.cornerRadius = profilePhoto.frame.size.height / 2
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.size.height / 2
        nameText.isEnabled = false
        ageText.isEnabled = false
        hightText.isEnabled = false
        weghtText.isEnabled = false
        bloodTypeText.isEnabled = false
        phoneNumberText.isEnabled = false
        nameText.delegate = self
        ageText.delegate = self
        hightText.delegate = self
        weghtText.delegate = self
        bloodTypeText.delegate = self
        phoneNumberText.delegate = self
        vc.delegate = self
    }
    func saveProfileData() {
        if let profileSender = Auth.auth().currentUser?.email {
            if (nameText.text != "") && (ageText.text != "") && (hightText.text != "") && (weghtText.text != "") && (bloodTypeText.text != "") && (phoneNumberText.text != "") && (profilePhoto.image != nil) {
                if let name = nameText.text, let age = ageText.text, let hight = hightText.text, let weight = weghtText.text, let bloodType = bloodTypeText.text, let phoneNumber = phoneNumberText.text{
                    db.collection("dataOfProfile").addDocument(data: [ "Sender": profileSender,  "profileImage": urlString,"Name": name, "Age": age, "Hight": hight, "Weight": weight, "BloodType": bloodType, "PhoneNumber": phoneNumber, "timeOfAddData": Date().timeIntervalSince1970]) { (error) in
                        if let e = error {
                            self.showMessage(withTitle: "Error", message: e.localizedDescription)
                            return
                        }else{
                            print("successed saves data in firestore")
                            self.nameText.isEnabled = false
                            self.ageText.isEnabled = false
                            self.hightText.isEnabled = false
                            self.weghtText.isEnabled = false
                            self.bloodTypeText.isEnabled = false
                            self.phoneNumberText.isEnabled = false
                        }
                    }
                }
            }
        }
    }
    func showMessage(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func retrieve() {
        db.collection("dataOfProfile")
            .order(by: "timeOfAddData")
            .getDocuments { (querySnapshot, error) in
            if let e = error {
                print(e.localizedDescription)
                return
            }else{
                if let snapshotDocuments =  querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let emaiOfSender = doc.data()["Sender"] as! String
                        if let profileSender = Auth.auth().currentUser?.email {
                            if profileSender == emaiOfSender {
                                self.name = doc.data()["Name"] as! String
                                self.age = doc.data()["Age"] as! String
                                self.hight = doc.data()["Hight"] as! String
                                self.weight = doc.data()["Weight"] as! String
                                self.bloodType = doc.data()["BloodType"] as! String
                                self.phoneNumber = doc.data()["PhoneNumber"] as! String
                                self.urlImage = doc.data()["profileImage"] as! String
                                guard let url = URL(string: self.urlImage) else {
                                    return
                                }
                                let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                                    guard let data = data, error == nil else {
                                        return
                                    }
                                    DispatchQueue.main.async {
                                        let image = UIImage(data: data)
                                        self.profilePhoto.image = image
                                    }
                                }
                                task.resume()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.nameText.text = self.name
                        self.ageText.text = self.age
                        self.hightText.text = self.hight
                        self.weghtText.text = self.weight
                        self.bloodTypeText.text = self.bloodType
                        self.phoneNumberText.text = self.phoneNumber
                    }
                }
            }
         }
    }
}
extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else{
            textField.placeholder = "Typr something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let profileSender = Auth.auth().currentUser?.email {
            self.db.collection("dataOfProfile")
                .whereField("Sender", isEqualTo: profileSender)
                .limit(to: 1)
                .getDocuments() { (querySnapshot, error) in
                    
                    if let e = error {
                        print(e)
                    } else {
                        if let doc = querySnapshot?.documents, !doc.isEmpty {
                            if let profileSender = Auth.auth().currentUser?.email {
                                if (self.nameText.text != "") && (self.ageText.text != "") && (self.hightText.text != "") && (self.weghtText.text != "") && (self.bloodTypeText.text != "") && (self.phoneNumberText.text != "") && (self.profilePhoto.image != nil) {
                                    if let name = self.nameText.text, let age = self.ageText.text, let hight = self.hightText.text, let weight = self.weghtText.text, let bloodType = self.bloodTypeText.text, let phoneNumber = self.phoneNumberText.text{
                                        self.db.collection("dataOfProfile")
                                            .whereField("Sender", isEqualTo: profileSender)
                                            .getDocuments() { (querySnapshot, error) in
                                                if let e = error {
                                                    print(e)
                                                } else {
                                                    let document = querySnapshot!.documents.first
                                                    document?.reference.updateData([
                                                        "Name": name, "Age": age, "Hight": hight, "Weight": weight, "BloodType": bloodType, "PhoneNumber": phoneNumber
                                                    ])
                                                    print("success update new data")
                                                }}
                                    }
                                }
                            }
                        } else {
                            self.saveProfileData()
                            print("save")
                        }
                    }
                    
                }
        }
        
        
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profilePhoto.image = image
            guard let imageData = image.pngData() else {
                return
            }
            let imageId = NSUUID().uuidString
            storage.child("\(imageId).png").putData(imageData, metadata: nil) { (_, error) in
                guard error == nil else {
                    print("Faild to upload")
                    return
                }
                self.storage.child("\(imageId).png").downloadURL { (url, error) in
                    guard let url = url, error == nil else {
                        return
                    }
                    self.urlString = url.absoluteString                   
                    
                    
                    if let profileSender = Auth.auth().currentUser?.email {
                        if (self.nameText.text != "") && (self.ageText.text != "") && (self.hightText.text != "") && (self.weghtText.text != "") && (self.bloodTypeText.text != "") && (self.phoneNumberText.text != "") && (self.profilePhoto.image != nil) {
                            
                            self.db.collection("dataOfProfile")
                                .whereField("Sender", isEqualTo: profileSender)
                                .getDocuments() { (querySnapshot, error) in
                                    if let e = error {
                                        print(e)
                                    } else {
                                        let document = querySnapshot!.documents.first
                                        document?.reference.updateData([
                                            "profileImage": self.urlString
                                        ])
                                        print("success update new image")
                                    }
                            }
                        }
                    }
                }
            }
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
