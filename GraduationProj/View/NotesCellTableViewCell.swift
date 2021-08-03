//
//  NotesCellTableViewCell.swift
//  GraduationProj
//
//  Created by Naira Bassam on 20/04/2021.
//

import UIKit

class NotesCellTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var noteTitle: UILabel!
        
  
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
