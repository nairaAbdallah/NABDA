//
//  MedicinesNoDataViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 07/04/2021.
//

import UIKit
import Firebase

class MedicinesNoDataViewController: UIViewController {

    let db = Firestore.firestore()
    let addMedicine = AddMedicinesViewController()
    var medicineAmount = ""
    var medicineTime = ""
    var medicineMinute = ""
    var medicineDate = ""
    var medicineAMPM: [String] = []
    var medicineDays: [String] = []
    var medicineDuration = ""
    var medicineImage = ""
    var numOfBigCells = 0
    var resultStringName = ""
    var medicineStructure: [MedicineStructureCell] = []
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        style(addButton)
        loadUserMedicine()
    }
    func loadUserMedicine(){
        db.collection("medicineAdded")
            .order(by: "timeOfAddMedicine")
            .getDocuments { (querySnapshot, error) in
            if let e = error {
                print(e.localizedDescription)
                return
            }else{
                if let snapshotDocuments =  querySnapshot?.documents{
                   let numberOfCells = snapshotDocuments.count
                   self.numOfBigCells = numberOfCells
                    for doc in snapshotDocuments{
                        let emaiOfSenderMedicine = doc.data()["emailOfSender"] as! String
                        if let medicineSender = Auth.auth().currentUser?.email {
                            if emaiOfSenderMedicine == medicineSender {
                                self.resultStringName = doc.data()["medicineName"] as! String
                                print(self.resultStringName)
                                self.medicineAmount = doc.data()["amount"] as! String
                                print(self.medicineAmount)
                                self.medicineTime = doc.data()["time"] as! String
                                print(self.medicineTime)
                                self.medicineMinute = doc.data()["minuts"] as! String
                                print(self.medicineMinute)
                                self.medicineDuration = doc.data()["duration"] as! String
                                print(self.medicineDuration)
                                self.medicineImage = doc.data()["imageType"] as! String
                                print(self.medicineImage)
                                self.medicineAMPM = doc.data()["amORpm"] as! [String]
                                print(self.medicineAMPM)
                                self.medicineDays = doc.data()["days"] as! [String]
                                print(self.medicineDays)
                                self.medicineDate = doc.data()["dateOfAddMedicine"] as! String
                                print(self.medicineDate)
                                let structureCell = MedicineStructureCell(name: self.resultStringName, amount: self.medicineAmount, time: self.medicineTime, minute: self.medicineMinute, duration: self.medicineDuration, selectedAMPM: self.medicineAMPM, selectedDays: self.medicineDays, medicineImage: self.medicineImage, date: self.medicineDate)
                                self.medicineStructure.append(structureCell)
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
    
}

extension MedicinesNoDataViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if medicineStructure.count == 0 {
            tableView.isHidden = true
        }else {
            tableView.isHidden = false
        }
        return medicineStructure.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineReusableCell", for: indexPath) as! MedicineCellTableViewCell
        cell.date.text = medicineStructure[indexPath.row].date
        cell.medicineName.text = medicineStructure[indexPath.row].name
        cell.amount.text = medicineStructure[indexPath.row].amount
        cell.time.text = ("\(medicineStructure[indexPath.row].time) : \(medicineStructure[indexPath.row].minute)")
        cell.duration.text = medicineStructure[indexPath.row].duration
        if medicineStructure[indexPath.row].selectedAMPM[0] == "AM" {
            cell.amButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }
        if medicineStructure[indexPath.row].selectedAMPM[1] == "PM" {
            cell.pmButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }
        if medicineStructure[indexPath.row].selectedDays[0] == "S" {
            cell.sButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }
        if medicineStructure[indexPath.row].selectedDays[1] == "S" {
            cell.s2Button.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }
        if medicineStructure[indexPath.row].selectedDays[2] == "M" {
            cell.mButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }
        if medicineStructure[indexPath.row].selectedDays[3] == "T" {
            cell.tButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }
        if medicineStructure[indexPath.row].selectedDays[4] == "W" {
            cell.wButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }
        if medicineStructure[indexPath.row].selectedDays[5] == "T" {
            cell.t2Button.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }
        if medicineStructure[indexPath.row].selectedDays[6] == "F" {
            cell.fButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }
        cell.imageMedicine.image = UIImage(named: medicineStructure[indexPath.row].medicineImage)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 186
    }

}


