//
//  SignUpViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 17/03/2021.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreBluetooth

class SignUpViewController: UIViewController {
    
    var manger:CBCentralManager!
    
    @IBOutlet weak var confirmPassView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailTextView: UIView!
    @IBOutlet weak var iDNumberView: UIView!
    @IBOutlet weak var fullNameView: UIView!
    @IBOutlet weak var CreateButton: UIButton!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var iDNumber: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    
    @IBAction func creatAccountButton(_ sender: Any) {
        
        if(confirmPass.text == password.text){
            if iDNumber.text?.count == 14{
                if let email = emailText.text, let password = password.text, let fullname = fullName.text, let idNumber = iDNumber.text{
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let e = error{
                            self.showMessage(withTitle: "Error", message: e.localizedDescription)
                            return
                        }else{
                            if self.manger.state == .poweredOn {
                                self.performSegue(withIdentifier: "signUpToConnect", sender: self)
                            }else{
                                self.performSegue(withIdentifier: "signUpToNotConnect", sender: self)
                            }
                            guard let uid = authResult?.user.uid else { return }
                            let values = ["email": email, "fullName": fullname, "idNumber": idNumber, "password": password]
                            
                            Database.database().reference().child("users").child(uid).updateChildValues(values) { (error, ref) in
                                if let e = error{
                                    self.showMessage(withTitle: "Error", message: e.localizedDescription)
                                    return
                                }
                            }
                        }
                    }
                }
            }else{
                self.showMessage(withTitle: "Error", message: "Id Number must be equal 14 digits")
                return
            }
        }else{
            self.showMessage(withTitle: "Error", message: "Confirm password not correct")
            return
        }
    }
    
    var viewModel = SignupViewModel()
    @objc func textDidChange(_ sender: UITextField) {
        if sender == emailText {
            viewModel.email = sender.text
        }else if sender == password {
            viewModel.password = sender.text
        }else if sender == fullName {
            viewModel.fullName = sender.text
        }else if sender == iDNumber {
            viewModel.idNumber = sender.text
        }else {
            viewModel.confirmPassword = sender.text
        }
        updateForm()
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
        CreateButton.isEnabled = false
        CreateButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1).withAlphaComponent(0.5)
        manger = CBCentralManager()
        manger.delegate = self
        
        CreateButton.isEnabled = false
        buttonStyle(CreateButton)
        style(fullNameView)
        style(iDNumberView)
        style(emailTextView)
        style(passwordView)
        style(confirmPassView)
        
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
        password.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullName.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        iDNumber.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        confirmPass.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    func showMessage(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


extension SignUpViewController: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
       print("state updated")
    }
}
extension SignUpViewController: FormViewModel{
    func updateForm() {
        CreateButton.isEnabled = viewModel.shouldEnableButton
        CreateButton.backgroundColor = viewModel.buttonBackgroundColor
    }
}

