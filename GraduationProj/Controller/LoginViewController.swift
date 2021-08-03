//
//  LoginViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 16/03/2021.
//

import UIKit
import Firebase
import CoreBluetooth

class LoginViewController: UIViewController {

    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
      
    var manger: CBCentralManager!
    var viewModel = LoginViewModel()
    
    @objc func textDidChange(_ sender: UITextField) {
        if sender == emailText {
            viewModel.email = sender.text
        }else {
            viewModel.password = sender.text
        }
        updateForm()
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        if let email = emailText.text, let password = passwordText.text{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error{
                    self?.showMessage(withTitle: "Error", message: e.localizedDescription)
                    return
                }else{
                    if self?.manger.state == .poweredOn {
                        self?.performSegue(withIdentifier: "logInToConnect", sender: self)
                    }else{
                        self?.performSegue(withIdentifier: "logInToNotConnect", sender: self)
                    }
                }
            }
        }
    }
               
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
        logInButton.isEnabled = false
        logInButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1).withAlphaComponent(0.5)
        buttonStyle(logInButton)
        style(viewEmail)
        style(viewPassword)
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
        passwordText.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    func showMessage(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
extension LoginViewController: FormViewModel{
    func updateForm() {
        logInButton.isEnabled = viewModel.shouldEnableButton
        logInButton.backgroundColor = viewModel.buttonBackgroundColor
    }
}
extension LoginViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
       print("state updated")
    }
}
