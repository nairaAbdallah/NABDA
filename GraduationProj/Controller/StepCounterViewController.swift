//
//  StepCounterViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 09/04/2021.
//

import UIKit
import CoreMotion
import Firebase

class StepCounterViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stepCounter: UILabel!
    @IBOutlet weak var stepCounterView: UIView!
    
    var click = 1
    var resultOfStepsInTheDay = ""
    let db = Firestore.firestore()
    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    
    @IBAction func buttonStart(_ sender: UIButton) {
        
        if (click % 2) != 0 {
            startButton.setImage(UIImage(named: "pause"), for: .normal)
            permeterState()
            permeterCount()
        }else {
            startButton.setImage(UIImage(named: "play-button"), for: .normal)
            if let stepsValue = stepCounter.text{
                resultOfStepsInTheDay = stepsValue
            }   
            saveStepCounter()
            performSegue(withIdentifier: "ResultStepCounter", sender: self)
        }
        click += 1
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style(stepCounterView)
       
    }
       
    func permeterState() {
        if CMMotionActivityManager.isActivityAvailable() {
            self.activityManager.startActivityUpdates(to: OperationQueue.main) { (data) in
                DispatchQueue.main.async {
                   if let activity = data {
                    if activity.running == true {
                        print("Running")
                    }else if activity.walking == true{
                        print("Walking")
                    }else if activity.automotive == true{
                        print("Automotive")
                    }
                    }
                }
            }
        }
    }
    func permeterCount() {
        if CMPedometer.isStepCountingAvailable() {
            self.pedometer.startUpdates(from: Date()) { (data, error) in
                if error == nil {
                    if let response = data {
                        DispatchQueue.main.async {
                            self.stepCounter.text = "Steps = \(response.numberOfSteps)"
                            print("Steps = \(response.numberOfSteps)")
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
    func style (_ component: UIView){
        
        component.layer.cornerRadius = component.frame.size.height / 4
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 4
        component.layer.shadowOpacity = 0.25
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
    func saveStepCounter() {
        let resultCalculateDate = calculateDate()
        print(resultCalculateDate)
        if let stepCounterSender = Auth.auth().currentUser?.email {
            db.collection("numberOfSteps").addDocument(data: ["dateOfStepCounter": resultCalculateDate, "resultOfStepCounter": resultOfStepsInTheDay, "emailOfSender": stepCounterSender, "timeOfAddNutritions": Date().timeIntervalSince1970]) { (error) in
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
