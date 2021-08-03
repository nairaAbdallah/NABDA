//
//  ForgetViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 17/03/2021.
//

import UIKit
import Firebase
import FirebaseDatabase
import MessageUI

class ForgetViewController: UIViewController {

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var emailTextView: UIView!
    
    @IBAction func forgetPasswordButton(_ sender: UIButton) {
        if let email = emailText.text {
            restPassword(forEmail: email)
            self.showMessage(withTitle: "Done", message: "Rest password link sent, please check your email")
        }        
    }
    
    var viewModel = ForgetPasswordViewModel()
    
    @objc func textDidChange(_ sender: UITextField) {
        if sender == emailText {
            viewModel.email = sender.text
        }
        updateForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.isEnabled = false
        confirmButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1).withAlphaComponent(0.5)
        buttonStyle(confirmButton)
        style(emailTextView)
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
        emailText.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    func restPassword(forEmail email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let e = error{
                self.showMessage(withTitle: "Error", message: e.localizedDescription)
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
extension ForgetViewController: FormViewModel{
    func updateForm() {
        confirmButton.isEnabled = viewModel.shouldEnableButton
        confirmButton.backgroundColor = viewModel.buttonBackgroundColor
    }
}
