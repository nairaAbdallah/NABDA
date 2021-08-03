//
//  AuthenticationViewModel.swift
//  GraduationProj
//
//  Created by Naira Bassam on 31/03/2021.
//

import UIKit

protocol FormViewModel {
    func updateForm()
}

protocol AuthenticationViewModel {
    var formIsValid: Bool {get}
    var  shouldEnableButton: Bool {get}
    var buttonBackgroundColor:UIColor {get}
}

struct AddMedicinModel: AuthenticationViewModel {
    var name: String?
    var amount: String?
    var time: String?
    var duration: String?
    var AM: UIColor?
    var PM: UIColor?
    var S: UIColor?
    var S2: UIColor?
    var M: UIColor?
    var T: UIColor?
    var W: UIColor?
    var T2: UIColor?
    var F: UIColor?
    
    var formIsValid: Bool{
        return (name?.isEmpty == false
            && amount?.isEmpty == false
            && time?.isEmpty == false
            && duration?.isEmpty == false)
            && (AM?.isEqual(#colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)) == true
            || PM?.isEqual(#colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)) == true)
            && (S?.isEqual(#colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)) == true
            || S2?.isEqual(#colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)) == true
            || M?.isEqual(#colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)) == true
            || T?.isEqual(#colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)) == true
            || W?.isEqual(#colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)) == true
            || T2?.isEqual(#colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)) == true
            || F?.isEqual(#colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)) == true)
            
    }
    var  shouldEnableButton: Bool{
        return formIsValid
    }
    var buttonBackgroundColor:UIColor {
        let enable = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        let disable = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enable : disable
    }
}

struct AddNutritionModel: AuthenticationViewModel {
    
    var fruits: UIImage?
    var meat: UIImage?
    var coffeine: UIImage?
    var soup: UIImage?
    var vegetables: UIImage?
    var fish: UIImage?
    var juices: UIImage?
    var cigarettes: UIImage?
   
    var formIsValid: Bool{
        return  fruits?.isEqual(UIImage(named: "blue check-box-with-check-sign")) == true
            || meat?.isEqual(UIImage(named: "blue check-box-with-check-sign")) == true
            || coffeine?.isEqual(UIImage(named: "blue check-box-with-check-sign")) == true
            || soup?.isEqual(UIImage(named: "blue check-box-with-check-sign")) == true
            || vegetables?.isEqual(UIImage(named: "blue check-box-with-check-sign")) == true
            || fish?.isEqual(UIImage(named: "blue check-box-with-check-sign")) == true
            || juices?.isEqual(UIImage(named: "blue check-box-with-check-sign")) == true
            || cigarettes?.isEqual(UIImage(named: "blue check-box-with-check-sign")) == true
    }
    var  shouldEnableButton: Bool{
        return formIsValid
    }
    var buttonBackgroundColor:UIColor {
        let enable = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        let disable = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enable : disable
    }
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool{
        return email?.isEmpty == false
            && password?.isEmpty == false
    }
    var  shouldEnableButton: Bool{
        return formIsValid
    }
    var buttonBackgroundColor:UIColor {
        let enable = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        let disable = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enable : disable
    }
}

struct SignupViewModel: AuthenticationViewModel {
    var fullName: String?
    var idNumber: String?
    var email: String?
    var password: String?
    var confirmPassword: String?
    
    var formIsValid: Bool{
        return email?.isEmpty == false
            && password?.isEmpty == false
            && fullName?.isEmpty == false
            && idNumber?.isEmpty == false
            && confirmPassword?.isEmpty == false
    }
    var  shouldEnableButton: Bool{
        return formIsValid
    }
    var buttonBackgroundColor:UIColor {
        let enable = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        let disable = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enable : disable
    }
}

struct ForgetPasswordViewModel: AuthenticationViewModel {
    var email: String?
    
    var formIsValid: Bool{
        return email?.isEmpty == false
    }
    var  shouldEnableButton: Bool{
        return formIsValid
    }
    var buttonBackgroundColor:UIColor {
        let enable = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        let disable = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enable : disable
    }
}

struct VerificationViewModel: AuthenticationViewModel {
    
    var firstNumber: String?
    var secondNumber: String?
    var thirdNumber: String?
    var fourthNumber: String?
    
    var formIsValid: Bool{
        return firstNumber?.isEmpty == false
           && secondNumber?.isEmpty == false
           && thirdNumber?.isEmpty == false
           && fourthNumber?.isEmpty == false
    }
    var  shouldEnableButton: Bool{
        return formIsValid
    }
    var buttonBackgroundColor:UIColor {
        let enable = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        let disable = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enable : disable
    }
}
struct NewPasswordViewModel: AuthenticationViewModel {
    var password: String?
    var confirmPassword: String?
    
    var formIsValid: Bool{
        return password?.isEmpty == false
           && confirmPassword?.isEmpty == false
    }
    var  shouldEnableButton: Bool{
        return formIsValid
    }
    var buttonBackgroundColor:UIColor {
        let enable = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        let disable = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enable : disable
    }
}
struct ChangePasswordViewModel: AuthenticationViewModel {
    var oldPassword: String?
    var newPassword: String?
    var confirmPassword: String?
    
    var formIsValid: Bool{
        return newPassword?.isEmpty == false
           && confirmPassword?.isEmpty == false
           && oldPassword?.isEmpty == false
    }
    var  shouldEnableButton: Bool{
        return formIsValid
    }
    var buttonBackgroundColor:UIColor {
        let enable = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        let disable = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enable : disable
    }
}
