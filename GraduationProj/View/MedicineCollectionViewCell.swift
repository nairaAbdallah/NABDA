//
//  MedicineCollectionViewCell.swift
//  GraduationProj
//
//  Created by Naira Bassam on 23/04/2021.
//

import UIKit

class MedicineCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageTypeMedicin: UIImageView!
    @IBOutlet weak var viewImageType: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stylee(imageTypeMedicin)
//        stylee()
    }
    
    func stylee (_ component: UIImageView){
        component.layer.cornerRadius = component.frame.size.height / 5
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 5
        component.layer.shadowOpacity = 0.19
    }
    func stylee (){
        viewImageType.layer.borderWidth = 2
        viewImageType.layer.borderColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        viewImageType.layer.cornerRadius = viewImageType.frame.size.height / 5
    }
    
}
