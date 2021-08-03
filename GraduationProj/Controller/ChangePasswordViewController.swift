//
//  ChangePasswordViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 28/03/2021.
//

import UIKit
import Firebase
import FirebaseDatabase

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var newPasswordView: UIView!
    @IBOutlet weak var oldPasswordView: UIView!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var changeButton: UIButton!
    @IBAction func changePasswordAction(_ sender: UIButton) {
        fetchUser()
    }
    let signUp = SignUpViewController()
    var viewModel = ChangePasswordViewModel()
    
    @objc func textDidChange(_ sender: UITextField) {
        if sender == oldPassword {
            viewModel.oldPassword = sender.text
        }else if sender == newPassword {
            viewModel.newPassword = sender.text
        }else {
            viewModel.confirmPassword = sender.text
        }
        updateForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeButton.isEnabled = false
        changeButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1).withAlphaComponent(0.5)
        style(oldPasswordView)
        style(newPasswordView)
        style(confirmPasswordView)
        buttonStyle(changeButton)
        configurNotificationObservers()
    }
    func style (_ component: UIView){
        component.layer.cornerRadius = component.frame.size.height / 4
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 4
        component.layer.shadowOpacity = 0.25
    }
    func buttonStyle (_ component: UIButton){
        component.layer.cornerRadius = component.frame.size.height / 4
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 4
        component.layer.shadowOpacity = 0.25
    }
    
    func configurNotificationObservers() {
        oldPassword.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        newPassword.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        confirmPassword.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    func fetchUser() {
       guard let uid = Auth.auth().currentUser?.uid else { return }
       Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
           let uid = snapshot.key
           guard let dictionary = snapshot.value as? [String: String] else { return }
           let user = User(uid: uid, dictionary: dictionary)
           guard let new = self.newPassword.text else { return }
           var currentPassword = user.password
           let currentEmail = user.email          
           if self.oldPassword.text == currentPassword {
             if(self.confirmPassword.text == new) {
                //test
                let values = ["email": user.email, "fullName": user.fullName, "idNumber": user.idNumber, "password": new]
                Database.database().reference().child("users").child(uid).setValue(values)
                //test
                let user = Auth.auth().currentUser
                let credential: AuthCredential = EmailAuthProvider.credential(withEmail: currentEmail, password: currentPassword)
               user?.reauthenticate(with: credential) { (authResult, error) in
                    if let e = error {
                      self.showMessage(withTitle: "Error", message: e.localizedDescription)
                      return
                    } else {
                      Auth.auth().currentUser?.updatePassword(to: new) { (error) in
                          if let e = error{
                              self.showMessage(withTitle: "Error", message: e.localizedDescription)
                             return
                        }else {
                          currentPassword = new
                             self.performSegue(withIdentifier: "changePasswordIdentifier", sender: self)
                         }
                     }
                  }
                }
             }else{
                self.showMessage(withTitle: "Error", message: "Confirm password not correct")
                return
            }
        }else{
            self.showMessage(withTitle: "Error", message: "Old password not correct")
            return
        }
   }
}
    
    func showMessage(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension ChangePasswordViewController: FormViewModel{
    func updateForm() {
        changeButton.isEnabled = viewModel.shouldEnableButton
        changeButton.backgroundColor = viewModel.buttonBackgroundColor
    }
}
