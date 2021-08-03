//
//  UserAlreadyLoginViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 01/04/2021.
//

import UIKit
import CoreBluetooth
import Firebase

class UserAlreadyLoginViewController: UIViewController {

    @IBOutlet weak var nabdaLabel: UILabel!
    @IBOutlet weak var careLabel: UILabel!
    
    var manger: CBCentralManager!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manger = CBCentralManager()
        manger.delegate = self
        
        nabdaLabel?.text = ""
        careLabel?.text = ""
        var nabdaIndex = 0.0
        var careIndex = 0.0
        let careText = "Because we care"
        let nabdaText = "Nabda"
        for letter in nabdaText {
            Timer.scheduledTimer(withTimeInterval: 0.4 * nabdaIndex, repeats: false) { (timer) in
                self.nabdaLabel.text?.append(letter)
            }
            nabdaIndex += 1
        }
       Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
            for letter in careText {
                Timer.scheduledTimer(withTimeInterval: 0.2 * careIndex, repeats: false) { (timer) in
                    self.careLabel.text?.append(letter)
                }
                careIndex += 1
            }
        
        }
        Timer.scheduledTimer(withTimeInterval: 5.5, repeats: false) { (timer) in
            if self.manger.state == .poweredOn {
            self.performSegue(withIdentifier: "userAlreadyLoginConnected", sender: self)
        }else{
            self.performSegue(withIdentifier: "userAlreadyLoginNot", sender: self)
        }
           
        }
    }
}
extension UserAlreadyLoginViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
       print("state updated")
    }
}

