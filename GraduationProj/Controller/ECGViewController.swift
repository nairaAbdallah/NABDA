//
//  ECGViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 29/04/2021.
//

import UIKit
import  Firebase

class ECGViewController: UIViewController {
    
    var name = ""
    let db = Firestore.firestore()
    var urlImage = ""
    
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var viewW: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        retrieve()
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        imageButton.layer.cornerRadius = imageButton.frame.size.height / 2
        styleView(viewW)
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
                                        self.profileImage.image = image
                                    }
                                }
                                task.resume()
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.nameText.text = self.name
                    }
                }
            }
         }
    }
    func styleView(_ component: UIView){
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 2)
        component.layer.shadowRadius = component.frame.size.height
        component.layer.shadowOpacity = 0.19
    }

}
