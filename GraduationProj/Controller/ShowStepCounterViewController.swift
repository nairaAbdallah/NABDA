//
//  ShowStepCounterViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 19/04/2021.
//

import UIKit
import Firebase

class ShowStepCounterViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableViewSteps: UITableView!
    
    var stepsStructure: [StepsStructureCell] = []
    let db = Firestore.firestore()
    let addNutrition = StepCounterViewController()
    var numOfBigCells = 0
    var resultStringDate = ""
    var resultStringCounter = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        style(addButton)
        tableViewSteps.dataSource = self
        tableViewSteps.delegate = self
        loadUserNutrition()
    }
    func style (_ component: UIButton){
        component.layer.cornerRadius = component.frame.size.height / 5
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 5
        component.layer.shadowOpacity = 0.19
    }
    func loadUserNutrition(){
        db.collection("numberOfSteps")
            .order(by: "timeOfAddNutritions")
            .getDocuments { (querySnapshot, error) in
            if let e = error {
                print(e.localizedDescription)
                return
            }else{
                if let snapshotDocuments =  querySnapshot?.documents{
                   let numberOfCells = snapshotDocuments.count
                   self.numOfBigCells = numberOfCells
                    for doc in snapshotDocuments{
                        let emaiOfSenderSteps = doc.data()["emailOfSender"] as! String
                        if let stepsSender = Auth.auth().currentUser?.email {
                            if emaiOfSenderSteps == stepsSender {
                                self.resultStringDate = doc.data()["dateOfStepCounter"] as! String
                                print(self.resultStringDate)
                                self.resultStringCounter = doc.data()["resultOfStepCounter"] as! String
                                print(self.resultStringCounter)
                                let structureCell = StepsStructureCell(dateOfSteps: self.resultStringDate, dataResult: self.resultStringCounter)
                                self.stepsStructure.append(structureCell)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableViewSteps.reloadData()
                    }
                }
            }
        }
    }

    

}
extension ShowStepCounterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if stepsStructure.count == 0 {
            tableView.isHidden = true
        }else {
            tableView.isHidden = false
        }
        return stepsStructure.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableStepCell", for: indexPath) as! StepsCellTableViewCell
        cell.dateOfDay.text = stepsStructure[indexPath.row].dateOfSteps
        cell.stepsResult.text = stepsStructure[indexPath.row].dataResult
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

}


