//
//  TestLogInViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 02/04/2021.
//

import UIKit
import Firebase

class TestLogInViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        authenticateUser()
    }
    
    func authenticateUser() {
            if Auth.auth().currentUser?.uid == nil {
                performSegue(withIdentifier: "ifUserNotLogedIn", sender: self)
                print("user not logged in")
            }else {
                performSegue(withIdentifier: "ifUserLoggedin", sender: self)
                print("user logged in")
            }
        }

}
