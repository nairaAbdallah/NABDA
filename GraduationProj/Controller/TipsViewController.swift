//
//  TipsViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 01/05/2021.
//

import UIKit

class TipsViewController: UIViewController {

    let image = ["foodImage", "excersisImage1", "takecareImage"]
    let titleTips = ["Food and Heart disease", "Exercise and Heart disease", "Take care of your heart"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    

   

}
extension TipsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "tipsCellIdentifier", for: indexPath) as! TipsTableViewCell
        cell.imageTips.image = UIImage(named: image[indexPath.row])
        cell.titleLabel.text = titleTips[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "firstTipsIdentifier", sender: self)
        }else if indexPath.row == 1 {
            performSegue(withIdentifier: "secondTipsIdentifier", sender: self)
        }else {
            performSegue(withIdentifier: "thirdTipsIdentifier", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }

}

