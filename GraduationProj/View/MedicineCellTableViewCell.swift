//
//  MedicineCellTableViewCell.swift
//  GraduationProj
//
//  Created by Naira Bassam on 24/04/2021.
//

import UIKit

class MedicineCellTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var viewAmount: UIView!
    @IBOutlet weak var viewTime: UIView!    
    @IBOutlet weak var viewDuration: UIView!
    @IBOutlet weak var imageMedicine: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var sButton: UIButton!
    @IBOutlet weak var s2Button: UIButton!
    @IBOutlet weak var mButton: UIButton!
    @IBOutlet weak var tButton: UIButton!
    @IBOutlet weak var wButton: UIButton!
    @IBOutlet weak var t2Button: UIButton!
    @IBOutlet weak var fButton: UIButton!
    @IBOutlet weak var amButton: UIButton!
    @IBOutlet weak var pmButton: UIButton!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var medicineName: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var duration: UILabel!
            
    override func awakeFromNib() {
        super.awakeFromNib()
        style(viewCell)
        style(viewName)
        style(viewAmount)
        style(viewTime)
        style(viewDuration)
        style(viewImage)
        style(sButton)
        style(s2Button)
        style(mButton)
        style(tButton)
        style(wButton)
        style(t2Button)
        style(fButton)
        style(amButton)
        style(pmButton)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func style (_ component: UIView){
        component.layer.cornerRadius = component.frame.size.height / 7
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 7
        component.layer.shadowOpacity = 0.19
    }
    
    func style (_ component: UIButton){
        component.layer.cornerRadius = component.frame.size.height / 2
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 2
        component.layer.shadowOpacity = 0.19
    }
    
}
