//
//  SecondTipsViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 02/05/2021.
//

import UIKit

class SecondTipsViewController: UIViewController {

    @IBOutlet weak var viewTips: UIView!
    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.isEditable = false
        textTitle.isEnabled = false
        stylee(viewTitle)
        style(viewTips)
    }
    

    func stylee (_ component: UIView){
        component.layer.cornerRadius = component.frame.size.height / 3
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 3
        component.layer.shadowOpacity = 0.19
    }
    
    func style (_ component: UIView){
        component.layer.cornerRadius = component.frame.size.height / 33
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 33
        component.layer.shadowOpacity = 0.19
    }

}
