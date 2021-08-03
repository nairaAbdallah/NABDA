//
//  ActivitiesViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 24/03/2021.
//

import UIKit
import Firebase
import FirebaseDatabase

class ActivitiesViewController: UIViewController {

    var name = ""
    let db = Firestore.firestore()
    var urlImage = ""
    
    @IBOutlet weak var bButtonImage: UIButton!
    @IBOutlet weak var vViewImage: UIImageView!
    @IBOutlet weak var nutritionCell: UIView!
    @IBOutlet weak var medicinesCells: UIView!
    @IBOutlet weak var Exercise: UIView!
    @IBOutlet weak var notesCell: UIView!
    @IBOutlet weak var viewW: UIView!
    @IBOutlet weak var nameText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieve()
        bButtonImage.layer.cornerRadius = bButtonImage.frame.size.height / 2
        vViewImage.layer.cornerRadius = vViewImage.frame.size.height / 2
        
        style(nutritionCell)
        style(medicinesCells)
        style(Exercise)
        style(notesCell)
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
                                        self.vViewImage.image = image
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
    func style (_ component: UIView){
        component.layer.cornerRadius = component.frame.size.height / 5
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 5
        component.layer.shadowOpacity = 0.19
    }

    func styleView(_ component: UIView){
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 2)
        component.layer.shadowRadius = component.frame.size.height
        component.layer.shadowOpacity = 0.19
    }

}
