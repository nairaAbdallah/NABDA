//
//  ShowingResultNoteViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 22/04/2021.
//

import UIKit
import Firebase

class ShowingResultNoteViewController: UIViewController {

    @IBOutlet weak var dateResult: UILabel!
    @IBOutlet weak var viewTextViewResult: UIView!
    @IBOutlet weak var textViewResult: UITextView!
    
    var number = 9
    let db = Firestore.firestore()
    var numOfBigCells = 0
    var resultTitleNote = ""
    var noteStructure: [NotesStructureCell] = []
    var notesWrittenShow = ""
    var notesWrittenDate = ""
    var showNotesStructure: [ShowNotesContentStructure] = []
    
    var desiredBodyValue: String!
    var desiredDateValue: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textViewResult.isEditable = false
        styleBig(viewTextViewResult)
        print(number)
        loadUserNotes()
        
        textViewResult.text = desiredBodyValue
        dateResult.text = desiredDateValue
        
    }
    
    func loadUserNotes(){
        db.collection("notesWritten")
            .order(by: "timeOfAddNote")
            .getDocuments { (querySnapshot, error) in
            if let e = error {
                print(e.localizedDescription)
                return
            }else{
                if let snapshotDocuments =  querySnapshot?.documents{
                   let numberOfCells = snapshotDocuments.count
                   self.numOfBigCells = numberOfCells
                    for doc in snapshotDocuments{
                        let emaiOfSenderNote = doc.data()["emailOfSender"] as! String
                        if let noteSender = Auth.auth().currentUser?.email {
                            if emaiOfSenderNote == noteSender {
                                self.resultTitleNote = doc.data()["noteTitle"] as! String
                                print(self.resultTitleNote)
                                let structureCell = NotesStructureCell(noteTitleContent: self.resultTitleNote)
                                self.noteStructure.append(structureCell)
                                
                                self.notesWrittenDate = doc.data()["dateOfAddNote"] as! String
                                self.notesWrittenShow = doc.data()["noteBody"] as! String
                                let showstructureNote = ShowNotesContentStructure(noteDateOfAdded: self.notesWrittenDate, noteContentTextView: self.notesWrittenShow)
                                self.showNotesStructure.append(showstructureNote)
                                                                                  
                            }
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
    func styleBig (_ component: UIView){
        component.layer.cornerRadius = component.frame.size.height / 25
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 25
        component.layer.shadowOpacity = 0.19
    }
}
