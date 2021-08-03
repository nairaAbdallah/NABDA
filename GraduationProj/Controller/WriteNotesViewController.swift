//
//  WriteNotesViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 20/04/2021.
//

import UIKit
import Firebase


class WriteNotesViewController: UIViewController {

   
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var viewTextView: UIView!
    @IBOutlet weak var viewTextField: UIView!
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteBody: UITextView!
    
    var titleOfNote = ""
    var noteContent = ""
    let db = Firestore.firestore()

    @objc private func buttonTouched() {
        
        let noteTitleBody = noteTitle.text
        if noteTitleBody != nil {
            titleOfNote = noteTitleBody!
        }
        let noteBodyItself = noteBody.text
        if noteBodyItself != nil {
            noteContent = noteBodyItself!
        }
        performSegue(withIdentifier: "addNoteIdentifier", sender: self)
        saveNotes()
        print("Done")
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.buttonTouched))
        navigationItem.rightBarButtonItem = buttonItem
        styleBig(viewTextView)
        style(viewTextField)
        dateLabel.text = calculateDate()
        
    }
    

    func style (_ component: UIView){
        component.layer.cornerRadius = component.frame.size.height / 5
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 5
        component.layer.shadowOpacity = 0.19
    }
    func styleBig (_ component: UIView){
        component.layer.cornerRadius = component.frame.size.height / 25
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 25
        component.layer.shadowOpacity = 0.19
    }
    func showMessage(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func calculateDate() ->String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        let nameOfMonth = formatter.string(from: date)

        let formatterDay = Calendar.current
        let components = formatterDay.dateComponents([.day], from: date)
        let nameOfDay = components.day
        let totalDate = "\(nameOfDay!) \(nameOfMonth)"
        return totalDate
    }
    func saveNotes() {
        let resultCalculateDate = calculateDate()
        print(resultCalculateDate)
        if let noteSender = Auth.auth().currentUser?.email {
            db.collection("notesWritten").addDocument(data: ["dateOfAddNote": resultCalculateDate, "noteTitle": titleOfNote, "noteBody": noteContent, "emailOfSender": noteSender, "timeOfAddNote": Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    self.showMessage(withTitle: "Error", message: e.localizedDescription)
                    return
                }else{
                    print("successed saves data in firestore")
                }
            }
        }
    }
}
