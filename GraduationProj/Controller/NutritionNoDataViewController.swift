//
//  NutritionNoDataViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 04/04/2021.
//

import UIKit
import Firebase

class NutritionNoDataViewController: UIViewController {

    @IBOutlet weak var thereIsNoDataLabel: UILabel!
    @IBOutlet weak var cloudNoData: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let addNutrition = AddNutritionViewController()
    var nutrionStruct: [String] = []
    var numOfBigCells = 0
    var resultStringDate = ""
    var nutritionStructure: [nutritionStructureCell] = []
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        style(addButton)
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
        db.collection("dataInNutritionCell")
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
                        let emaiOfSenderNutrition = doc.data()["emailOfNutritionSender"] as! String
                        if let nutritionSender = Auth.auth().currentUser?.email {
                            if emaiOfSenderNutrition == nutritionSender {
                                self.resultStringDate = doc.data()["dateOfAddedNutritions"] as! String
                                print(self.resultStringDate)
                                self.nutrionStruct = doc.data()["nutritionDataItself"] as! [String]
                                print(self.nutrionStruct)
                                let structureCell = nutritionStructureCell(dateAddNutrition: self.resultStringDate, dataAdded: self.nutrionStruct)
                                self.nutritionStructure.append(structureCell)
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

}
extension NutritionNoDataViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if nutritionStructure.count == 0 {
            tableView.isHidden = true
        }else {
            tableView.isHidden = false
        }
        return nutritionStructure.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! NutritionCellTableViewCell
        cell.dateLabel.text = nutritionStructure[indexPath.row].dateAddNutrition
        
        if nutritionStructure[indexPath.row].dataAdded.count == 8 {
            cell.fruitsLabel.text = nutritionStructure[indexPath.row].dataAdded[0]
            cell.meatLabel.text = nutritionStructure[indexPath.row].dataAdded[1]
            cell.coffeineLable.text = nutritionStructure[indexPath.row].dataAdded[2]
            cell.soupLabel.text = nutritionStructure[indexPath.row].dataAdded[3]
            cell.vegetablesLabel.text = nutritionStructure[indexPath.row].dataAdded[4]
            cell.fishLabel.text = nutritionStructure[indexPath.row].dataAdded[5]
            cell.juicesLabel.text = nutritionStructure[indexPath.row].dataAdded[6]
            cell.cigarettesLabel.text = nutritionStructure[indexPath.row].dataAdded[7]
        }else if nutritionStructure[indexPath.row].dataAdded.count == 7 {
            cell.fruitsLabel.text = nutritionStructure[indexPath.row].dataAdded[0]
            cell.meatLabel.text = nutritionStructure[indexPath.row].dataAdded[1]
            cell.coffeineLable.text = nutritionStructure[indexPath.row].dataAdded[2]
            cell.soupLabel.text = nutritionStructure[indexPath.row].dataAdded[3]
            cell.vegetablesLabel.text = nutritionStructure[indexPath.row].dataAdded[4]
            cell.fishLabel.text = nutritionStructure[indexPath.row].dataAdded[5]
            cell.juicesLabel.text = nutritionStructure[indexPath.row].dataAdded[6]
            cell.cigarettesPoInt.isHidden = true
        }else if nutritionStructure[indexPath.row].dataAdded.count == 6 {
            cell.fruitsLabel.text = nutritionStructure[indexPath.row].dataAdded[0]
            cell.meatLabel.text = nutritionStructure[indexPath.row].dataAdded[1]
            cell.coffeineLable.text = nutritionStructure[indexPath.row].dataAdded[2]
            cell.soupPoint.isHidden = true
            cell.vegetablesLabel.text = nutritionStructure[indexPath.row].dataAdded[3]
            cell.fishLabel.text = nutritionStructure[indexPath.row].dataAdded[4]
            cell.juicesLabel.text = nutritionStructure[indexPath.row].dataAdded[5]
            cell.cigarettesPoInt.isHidden = true
        }else if nutritionStructure[indexPath.row].dataAdded.count == 5 {
            cell.fruitsLabel.text = nutritionStructure[indexPath.row].dataAdded[0]
            cell.meatLabel.text = nutritionStructure[indexPath.row].dataAdded[1]
            cell.coffeineLable.text = nutritionStructure[indexPath.row].dataAdded[2]
            cell.vegetablesLabel.text = nutritionStructure[indexPath.row].dataAdded[3]
            cell.fishLabel.text = nutritionStructure[indexPath.row].dataAdded[4]
            cell.soupPoint.isHidden = true
            cell.juicesPoint.isHidden = true
            cell.cigarettesPoInt.isHidden = true
        }else if nutritionStructure[indexPath.row].dataAdded.count == 4 {
            cell.fruitsLabel.text = nutritionStructure[indexPath.row].dataAdded[0]
            cell.meatLabel.text = nutritionStructure[indexPath.row].dataAdded[1]
            cell.coffeinePoint.isHidden = true
            cell.soupPoint.isHidden = true
            cell.vegetablesLabel.text = nutritionStructure[indexPath.row].dataAdded[2]
            cell.fishLabel.text = nutritionStructure[indexPath.row].dataAdded[3]
            cell.juicesPoint.isHidden = true
            cell.cigarettesPoInt.isHidden = true
        }else if nutritionStructure[indexPath.row].dataAdded.count == 3 {
            cell.fruitsLabel.text = nutritionStructure[indexPath.row].dataAdded[0]
            cell.meatLabel.text = nutritionStructure[indexPath.row].dataAdded[1]
            cell.coffeineLable.text = nutritionStructure[indexPath.row].dataAdded[2]
            cell.soupPoint.isHidden = true
            cell.vegetablesPoint.isHidden = true
            cell.fishPoint.isHidden = true
            cell.juicesPoint.isHidden = true
            cell.cigarettesPoInt.isHidden = true
        }else if nutritionStructure[indexPath.row].dataAdded.count == 2 {
            cell.fruitsLabel.text = nutritionStructure[indexPath.row].dataAdded[0]
            cell.meatLabel.text = nutritionStructure[indexPath.row].dataAdded[1]
            cell.coffeinePoint.isHidden = true
            cell.soupPoint.isHidden = true
            cell.vegetablesPoint.isHidden = true
            cell.fishPoint.isHidden = true
            cell.juicesPoint.isHidden = true
            cell.cigarettesPoInt.isHidden = true
        }else if nutritionStructure[indexPath.row].dataAdded.count == 1 {
            cell.fruitsLabel.text = nutritionStructure[indexPath.row].dataAdded[0]
            cell.meatPoint.isHidden = true
            cell.coffeinePoint.isHidden = true
            cell.soupPoint.isHidden = true
            cell.vegetablesPoint.isHidden = true
            cell.fishPoint.isHidden = true
            cell.juicesPoint.isHidden = true
            cell.cigarettesPoInt.isHidden = true
        }else {
            cell.fruitsPoint.isHidden = true
            cell.meatPoint.isHidden = true
            cell.coffeinePoint.isHidden = true
            cell.soupPoint.isHidden = true
            cell.vegetablesPoint.isHidden = true
            cell.fishPoint.isHidden = true
            cell.juicesPoint.isHidden = true
            cell.cigarettesPoInt.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 186
    }

}

