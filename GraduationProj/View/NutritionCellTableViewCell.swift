//
//  NutritionCellTableViewCell.swift
//  GraduationProj
//
//  Created by Naira Bassam on 18/04/2021.
//

import UIKit

class NutritionCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var nutritionImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var fruitsLabel: UILabel!
    @IBOutlet weak var meatLabel: UILabel!
    @IBOutlet weak var coffeineLable: UILabel!
    @IBOutlet weak var soupLabel: UILabel!
    @IBOutlet weak var vegetablesLabel: UILabel!
    @IBOutlet weak var fishLabel: UILabel!
    @IBOutlet weak var juicesLabel: UILabel!
    @IBOutlet weak var cigarettesLabel: UILabel!
    @IBOutlet weak var fruitsPoint: UIImageView!
    @IBOutlet weak var meatPoint: UIImageView!
    @IBOutlet weak var coffeinePoint: UIImageView!
    @IBOutlet weak var soupPoint: UIImageView!
    @IBOutlet weak var vegetablesPoint: UIImageView!
    @IBOutlet weak var fishPoint: UIImageView!
    @IBOutlet weak var juicesPoint: UIImageView!
    @IBOutlet weak var cigarettesPoInt: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style(viewCell)
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
