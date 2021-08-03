//
//  TipsTableViewCell.swift
//  GraduationProj
//
//  Created by Naira Bassam on 02/05/2021.
//

import UIKit

class TipsTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageTips: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style(viewCell)
        style(viewImage)
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
    
}
