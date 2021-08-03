//
//  NotesAddedViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 20/04/2021.
//

import UIKit
import Firebase

class NotesAddedViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let noteAdded = ShowingResultNoteViewController()
    
    var numOfSelectedCell = 0
    var numOfCell: [Int] = []
    var noteStructure: [NotesStructureCell] = []
    let db = Firestore.firestore()
    let addNote = WriteNotesViewController()
    var numOfBigCells = 0
    var resultTitleNote = ""
    var showNotesStructure: [ShowNotesContentStructure] = []
    var notesWrittenShow = ""
    var notesWrittenDate = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        style(addButton)
        loadUserNotes()
       
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
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func style (_ component: UIButton){
        component.layer.cornerRadius = component.frame.size.height / 5
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 5
        component.layer.shadowOpacity = 0.19
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ShowingResultNoteViewController {
            let vc = segue.destination as? ShowingResultNoteViewController
            vc?.number = numOfCell[0]
            vc?.desiredBodyValue = showNotesStructure[numOfCell[0]].noteContentTextView
            vc?.desiredDateValue = showNotesStructure[numOfCell[0]].noteDateOfAdded
        }
    }
    

}
extension NotesAddedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if noteStructure.count == 0 {
            tableView.isHidden = true
        }else {
            tableView.isHidden = false
        }
        return noteStructure.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableNotesCell", for: indexPath) as! NotesCellTableViewCell
        cell.noteTitle.text = noteStructure[indexPath.row].noteTitleContent
       
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        numOfCell = []
        numOfCell.append(indexPath.row)
        noteAdded.number = indexPath.row
        performSegue(withIdentifier: "selectedCellIdentifier", sender: self)
              
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
