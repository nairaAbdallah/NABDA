//
//  AddNutritionViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 04/04/2021.
//

import UIKit
import Firebase

class AddNutritionViewController: UIViewController{

    @IBOutlet weak var cigaretter: UILabel!
    @IBOutlet weak var juice: UILabel!
    @IBOutlet weak var fish: UILabel!
    @IBOutlet weak var vegetable: UILabel!
    @IBOutlet weak var soup: UILabel!
    @IBOutlet weak var coffeine: UILabel!
    @IBOutlet weak var meat: UILabel!
    @IBOutlet weak var fruits: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var checkbox1: UIButton!
    @IBOutlet weak var checkbox2: UIButton!
    @IBOutlet weak var checkbox3: UIButton!
    @IBOutlet weak var checkbox4: UIButton!
    @IBOutlet weak var checkbox5: UIButton!
    @IBOutlet weak var checkbox6: UIButton!
    @IBOutlet weak var checkbox7: UIButton!
    @IBOutlet weak var checkbox8: UIButton!
    let db = Firestore.firestore()
    var totalBlueCheckBox = 0
    var click1 = 1
    var addedNutritions: [String] = []
    
    var viewModel = AddNutritionModel()
    @objc func textDidChange(_ sender: UIButton) {
        if sender == checkbox1 {
            viewModel.fruits = sender.currentImage
        }else if sender == checkbox2 {
            viewModel.meat = sender.currentImage
        }else if sender == checkbox3 {
            viewModel.coffeine = sender.currentImage
        }else if sender == checkbox4 {
            viewModel.soup = sender.currentImage
        }else if sender == checkbox5 {
            viewModel.vegetables = sender.currentImage
        }else if sender == checkbox6 {
            viewModel.fish = sender.currentImage
        }else if sender == checkbox7 {
            viewModel.juices = sender.currentImage
        }else {
            viewModel.cigarettes = sender.currentImage
        }
        updateForm()
    }
    
    @IBAction func checkBox1(_ sender: UIButton) {
        if (click1 % 2) != 0 {
            checkbox1.setImage(UIImage(named: "blue check-box-with-check-sign"), for: .normal)
        }else {
            checkbox1.setImage(UIImage(named: "gray check-box-with-check-sign"), for: .normal)
        }
        click1 += 1
    }
    var click2 = 1
    @IBAction func checkBox2(_ sender: UIButton) {
        if (click2 % 2) != 0 {
            checkbox2.setImage(UIImage(named: "blue check-box-with-check-sign"), for: .normal)
        }else {
            checkbox2.setImage(UIImage(named: "gray check-box-with-check-sign"), for: .normal)
        }
        click2 += 1
    }
    var click3 = 1
    @IBAction func checkBox3(_ sender: UIButton) {
        if (click3 % 2) != 0 {
            checkbox3.setImage(UIImage(named: "blue check-box-with-check-sign"), for: .normal)
        }else {
            checkbox3.setImage(UIImage(named: "gray check-box-with-check-sign"), for: .normal)
        }
        click3 += 1
    }
    var click4 = 1
    @IBAction func checkBox4(_ sender: UIButton) {
        if (click4 % 2) != 0 {
            checkbox4.setImage(UIImage(named: "blue check-box-with-check-sign"), for: .normal)
        }else {
            checkbox4.setImage(UIImage(named: "gray check-box-with-check-sign"), for: .normal)
        }
        click4 += 1
    }
    var click5 = 1
    @IBAction func checkBox5(_ sender: UIButton) {
        if (click5 % 2) != 0 {
            checkbox5.setImage(UIImage(named: "blue check-box-with-check-sign"), for: .normal)
        }else {
            checkbox5.setImage(UIImage(named: "gray check-box-with-check-sign"), for: .normal)
        }
        click5 += 1
    }
    var click6 = 1
    @IBAction func checkBox6(_ sender: UIButton) {
        if (click6 % 2) != 0 {
            checkbox6.setImage(UIImage(named: "blue check-box-with-check-sign"), for: .normal)
        }else {
            checkbox6.setImage(UIImage(named: "gray check-box-with-check-sign"), for: .normal)
        }
        click6 += 1
    }
    var click7 = 1
    @IBAction func checkBox7(_ sender: UIButton) {
        if (click7 % 2) != 0 {
            checkbox7.setImage(UIImage(named: "blue check-box-with-check-sign"), for: .normal)
        }else {
            checkbox7.setImage(UIImage(named: "gray check-box-with-check-sign"), for: .normal)
        }
        click7 += 1
    }
    var click8 = 1
    @IBAction func checkBox8(_ sender: UIButton) {
        if (click8 % 2) != 0 {
            checkbox8.setImage(UIImage(named: "blue check-box-with-check-sign"), for: .normal)
        }else {
            checkbox8.setImage(UIImage(named: "gray check-box-with-check-sign"), for: .normal)
        }
        click8 += 1
    }

    @IBAction func addButton(_ sender: UIButton) {
    
        if checkbox1.imageView?.image == UIImage(named: "blue check-box-with-check-sign") {
            totalBlueCheckBox += 1
            addedNutritions.append(fruits.text!)
        }
        if checkbox2.imageView?.image == UIImage(named: "blue check-box-with-check-sign") {
            totalBlueCheckBox += 1
            addedNutritions.append(meat.text!)
        }
        if checkbox3.imageView?.image == UIImage(named: "blue check-box-with-check-sign") {
            totalBlueCheckBox += 1
            addedNutritions.append(coffeine.text!)
        }
        if checkbox4.imageView?.image == UIImage(named: "blue check-box-with-check-sign") {
            totalBlueCheckBox += 1
            addedNutritions.append(soup.text!)
        }
        if checkbox5.imageView?.image == UIImage(named: "blue check-box-with-check-sign") {
            totalBlueCheckBox += 1
            addedNutritions.append(vegetable.text!)
        }
        if checkbox6.imageView?.image == UIImage(named: "blue check-box-with-check-sign") {
            totalBlueCheckBox += 1
            addedNutritions.append(fish.text!)
        }
        if checkbox7.imageView?.image == UIImage(named: "blue check-box-with-check-sign") {
            totalBlueCheckBox += 1
            addedNutritions.append(juice.text!)
        }
        if checkbox8.imageView?.image == UIImage(named: "blue check-box-with-check-sign") {
            totalBlueCheckBox += 1
            addedNutritions.append(cigaretter.text!)
        }
        print(addedNutritions)
        let resultCalculateDate = calculateDate()
        print(resultCalculateDate)
        
        if let nutritionSender = Auth.auth().currentUser?.email {
            db.collection("dataInNutritionCell").addDocument(data: ["dateOfAddedNutritions": resultCalculateDate, "nutritionDataItself": addedNutritions, "emailOfNutritionSender": nutritionSender, "timeOfAddNutritions": Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    self.showMessage(withTitle: "Error", message: e.localizedDescription)
                    return
                }else{
                    print("successed saves data in firestore")
                }
            }
        }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style(addButton)
        addButton.isEnabled = false
        addButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1).withAlphaComponent(0.5)
        configurNotificationObservers()
    }
    
    func configurNotificationObservers() {
        checkbox1.addTarget(self, action: #selector(textDidChange), for: .touchUpInside)
        checkbox2.addTarget(self, action: #selector(textDidChange), for: .touchUpInside)
        checkbox3.addTarget(self, action: #selector(textDidChange), for: .touchUpInside)
        checkbox4.addTarget(self, action: #selector(textDidChange), for: .touchUpInside)
        checkbox5.addTarget(self, action: #selector(textDidChange), for: .touchUpInside)
        checkbox6.addTarget(self, action: #selector(textDidChange), for: .touchUpInside)
        checkbox7.addTarget(self, action: #selector(textDidChange), for: .touchUpInside)
        checkbox8.addTarget(self, action: #selector(textDidChange), for: .touchUpInside)
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
    
    func style (_ component: UIButton){
        component.layer.cornerRadius = component.frame.size.height / 5
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 5
        component.layer.shadowOpacity = 0.19
    }
}
extension AddNutritionViewController: FormViewModel{
    func updateForm() {
        addButton.isEnabled = viewModel.shouldEnableButton
        addButton.backgroundColor = viewModel.buttonBackgroundColor
    }
}
