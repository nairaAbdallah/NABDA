//
//  SettingViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 28/03/2021.
//

import UIKit
import Firebase
import CoreBluetooth

class SettingViewController: UIViewController {

    fileprivate let application = UIApplication.shared
    var manger:CBCentralManager!
    
    @IBOutlet weak var logOut: UIButton!
    @IBOutlet weak var connectDevice: UISwitch!
        
    @IBAction func logOutAction(_ sender: UIButton) {
        do {
        try Auth.auth().signOut()
            performSegue(withIdentifier: "logOutIdent", sender: self)
        } catch let signOutError as NSError {
           print ("Error signing out: %@", signOutError)
        }
    }

    @IBAction func switchAction(_ sender: UISwitch) {
        if connectDevice.isOn == true {
            if let settingURL = URL(string: UIApplication.openSettingsURLString) {
                application.open(settingURL, options: [:]) { _ in
                    self.performSegue(withIdentifier: "reloadIdentifer", sender: self)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manger = CBCentralManager()
        manger.delegate = self
        
        testState()
    }
    func testState()
    {
        if manger?.state == .poweredOn {
            connectDevice.setOn(true, animated: true)
            print(".poweredOn")
        }else{
            connectDevice.setOn(false, animated: true)
            print(".poweredOff")
        }
    }
    
}
extension SettingViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
       print("state updated")
        
    }
}


