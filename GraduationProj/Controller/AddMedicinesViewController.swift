//
//  AddMedicinesViewController.swift
//  GraduationProj
//
//  Created by Naira Bassam on 07/04/2021.
//

import UIKit
import Firebase
import UserNotifications

class AddMedicinesViewController: UIViewController {

    var imageArray = [UIImage(named: "drugs"), UIImage(named: "syrup"), UIImage(named: "syringe"), UIImage(named: "ointment"), UIImage(named: "asthma"), UIImage(named: "urethral")]
    var nameOfImage = ["drugs","syrup","syringe","ointment","asthma","urethral"]
    let medicineCell = MedicineCollectionViewCell()
    var barButtonclick = 1
    var amButtonclick = 1
    var pmButtonclick = 1
    var sButtonclick = 1
    var ssButtonclick = 1
    var mButtonclick = 1
    var tButtonclick = 1
    var wButtonclick = 1
    var ttButtonclick = 1
    var fButtonclick = 1
    var indexPathRow: Int?
    var amPM: [String] = []
    var day: [String] = []
    let db = Firestore.firestore()
    var viewModel = AddMedicinModel()
    let center = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    
    @objc func textWillChange(_ sender: UITextField){
        if sender == medicineNameText {
            viewModel.name = sender.text
        }else if sender == amountText {
            viewModel.amount = sender.text
        }else if sender == timeText {
            viewModel.time = sender.text
        }else {
            viewModel.duration = sender.text
        }
        updateForm()
    }
    @objc func textDidChange(_ sender: UIButton) {
        if sender == AMButton {
            viewModel.AM = sender.backgroundColor
        }else if sender == PMButton {
            viewModel.PM = sender.backgroundColor
        }else if sender == SButton {
            viewModel.S = sender.backgroundColor
        }else if sender == S2Button {
            viewModel.S2 = sender.backgroundColor
        }else if sender == MButton {
            viewModel.M = sender.backgroundColor
        }else if sender == TButton {
            viewModel.T = sender.backgroundColor
        }else if sender == WButton {
            viewModel.W = sender.backgroundColor
        }else if sender == T2Button {
            viewModel.T2 = sender.backgroundColor
        } else {
            viewModel.F = sender.backgroundColor
        }
        updateForm()
    }
    
    @IBOutlet weak var medicineNameText: UITextField!
    @IBOutlet weak var amountText: UITextField!
    @IBOutlet weak var timeText: UITextField!
    @IBOutlet weak var durationText: UITextField!
    
    @IBOutlet weak var medicinCollectionView: UICollectionView!
    @IBOutlet weak var viewAmount: UIView!
    @IBOutlet weak var viewMedicienName: UIView!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var SButton: UIButton!
    @IBOutlet weak var S2Button: UIButton!
    @IBOutlet weak var MButton: UIButton!
    @IBOutlet weak var TButton: UIButton!
    @IBOutlet weak var WButton: UIButton!
    @IBOutlet weak var T2Button: UIButton!
    @IBOutlet weak var FButton: UIButton!
    @IBOutlet weak var viewDuration: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var AMButton: UIButton!
    @IBOutlet weak var PMButton: UIButton!
    @IBOutlet weak var notificationBarButton: UIBarButtonItem!
    @IBOutlet weak var minuts: UITextField!
    
    
    @IBAction func notificationButtonAction(_ sender: UIBarButtonItem) {
        if (barButtonclick % 2) != 0 {
            notificationBarButton.image = UIImage(named: "notification-1")
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                
            }
        }else {
            notificationBarButton.image = UIImage(named: "ringing")
        }
        barButtonclick += 1
    }
    
    @IBAction func amButtonAction(_ sender: UIButton) {
        if (amButtonclick % 2) != 0 {
            AMButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }else {
            AMButton.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        }
        amButtonclick += 1
    }
    
    @IBAction func pmButtonAction(_ sender: UIButton) {
        if (pmButtonclick % 2) != 0 {
            PMButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }else {
            PMButton.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        }
        pmButtonclick += 1
    }
    
    @IBAction func sButtonAction(_ sender: UIButton) {
        if (sButtonclick % 2) != 0 {
            SButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }else {
            SButton.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        }
        sButtonclick += 1
    }
    
    @IBAction func ssButtonAtion(_ sender: UIButton) {
        if (ssButtonclick % 2) != 0 {
            S2Button.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }else {
            S2Button.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        }
        ssButtonclick += 1
    }
    
    @IBAction func mButtonAction(_ sender: UIButton) {
        if (mButtonclick % 2) != 0 {
            MButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }else {
            MButton.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        }
        mButtonclick += 1
    }
    
    @IBAction func tButtonAction(_ sender: UIButton) {
        if (tButtonclick % 2) != 0 {
            TButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }else {
            TButton.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        }
        tButtonclick += 1
    }
 
    @IBAction func wButtonAction(_ sender: UIButton) {
        if (wButtonclick % 2) != 0 {
            WButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }else {
            WButton.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        }
        wButtonclick += 1
    }
    
    @IBAction func ttButtonAction(_ sender: UIButton) {
        if (ttButtonclick % 2) != 0 {
            T2Button.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }else {
            T2Button.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        }
        ttButtonclick += 1
    }
    
    @IBAction func fButtonAction(_ sender: UIButton) {
        if (fButtonclick % 2) != 0 {
            FButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
        }else {
            FButton.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        }
        fButtonclick += 1
    }
       
    @IBAction func addMedicineAction(_ sender: UIButton) {
        saveMedicine()
        content.title = "Remember"
        content.body = "It's time to take \(medicineNameText.text!)"
        content.sound = UNNotificationSound.default
        if let minute = minuts.text, let hour = timeText.text {
            var dateInfo = DateComponents()
            var dateInfoo = DateComponents()
            var dateInfo3 = DateComponents()
            var dateInfo4 = DateComponents()
            var dateInfo5 = DateComponents()
            var dateInfo6 = DateComponents()
            var dateInfo7 = DateComponents()
            var dateInfo8 = DateComponents()
            var dateInfo9 = DateComponents()
            var dateInfo10 = DateComponents()
            var dateInfo11 = DateComponents()
            var dateInfo12 = DateComponents()
            var dateInfo13 = DateComponents()
            var dateInfo14 = DateComponents()
            if AMButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
                if SButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
                    dateInfo.weekday = 7
                    dateInfo.hour = Int(hour)
                    dateInfo.minute = Int(minute)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
                    let uuid = UUID().uuidString
                    let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
                    center.add(request) { (error) in
                        if let e = error {
                                print(e.localizedDescription)
                            }
                    }
                }
                if S2Button.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
                    dateInfo3.weekday = 1
                    dateInfo3.hour = Int(hour)
                    dateInfo3.minute = Int(minute)
                    let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateInfo3, repeats: true)
                    let uuid2 = UUID().uuidString
                    let request2 = UNNotificationRequest(identifier: uuid2, content: content, trigger: trigger2)
                    center.add(request2) { (error) in
                        if let e = error {
                                print(e.localizedDescription)
                            }
                    }
                }
                if MButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
                    dateInfo4.weekday = 2
                    dateInfo4.hour = Int(hour)
                    dateInfo4.minute = Int(minute)
                    let trigger3 = UNCalendarNotificationTrigger(dateMatching: dateInfo4, repeats: true)
                    let uuid3 = UUID().uuidString
                    let request3 = UNNotificationRequest(identifier: uuid3, content: content, trigger: trigger3)
                    center.add(request3) { (error) in
                        if let e = error {
                                print(e.localizedDescription)
                            }
                    }
                }
                if TButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
                    dateInfo5.weekday = 3
                    dateInfo5.hour = Int(hour)
                    dateInfo5.minute = Int(minute)
                    let trigger4 = UNCalendarNotificationTrigger(dateMatching: dateInfo5, repeats: true)
                    let uuid4 = UUID().uuidString
                    let request4 = UNNotificationRequest(identifier: uuid4, content: content, trigger: trigger4)
                    center.add(request4) { (error) in
                        if let e = error {
                                print(e.localizedDescription)
                            }
                    }
                }
                if WButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
                    dateInfo6.weekday = 4
                    dateInfo6.hour = Int(hour)
                    dateInfo6.minute = Int(minute)
                    let trigger5 = UNCalendarNotificationTrigger(dateMatching: dateInfo6, repeats: true)
                    let uuid5 = UUID().uuidString
                    let request5 = UNNotificationRequest(identifier: uuid5, content: content, trigger: trigger5)
                    center.add(request5) { (error) in
                        if let e = error {
                                print(e.localizedDescription)
                            }
                    }
                }
                if T2Button.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
                    dateInfo7.weekday = 5
                    dateInfo7.hour = Int(hour)
                    dateInfo7.minute = Int(minute)
                    let trigger6 = UNCalendarNotificationTrigger(dateMatching: dateInfo7, repeats: true)
                    let uuid6 = UUID().uuidString
                    let request6 = UNNotificationRequest(identifier: uuid6, content: content, trigger: trigger6)
                    center.add(request6) { (error) in
                        if let e = error {
                                print(e.localizedDescription)
                            }
                    }
                }
                if FButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
                    dateInfo8.weekday = 6
                    dateInfo8.hour = Int(hour)
                    dateInfo8.minute = Int(minute)
                    let trigger7 = UNCalendarNotificationTrigger(dateMatching: dateInfo8, repeats: true)
                    let uuid7 = UUID().uuidString
                    let request7 = UNNotificationRequest(identifier: uuid7, content: content, trigger: trigger7)
                    center.add(request7) { (error) in
                        if let e = error {
                                print(e.localizedDescription)
                            }
                    }
                }
               
            }
            if PMButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
                if SButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
                    
                    if let intHour = Int(hour) {
                        let pmHour = intHour + 12
                        dateInfoo.hour = pmHour
                        dateInfoo.minute = Int(minute)
                        dateInfoo.weekday = 7
                        let triggerr = UNCalendarNotificationTrigger(dateMatching: dateInfoo, repeats: true)
                        let uuidd = UUID().uuidString
                        let requestt = UNNotificationRequest(identifier: uuidd, content: content, trigger: triggerr)
                        center.add(requestt) { (error) in
                            if let e = error {
                                    print(e.localizedDescription)
                                }
                        }
                    }
                }
                if S2Button.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
                    
                    if let intHour = Int(hour) {
                        let pmHour = intHour + 12
                        dateInfo9.hour = pmHour
                        dateInfo9.minute = Int(minute)
                        dateInfo9.weekday = 1
                        let triggerr8 = UNCalendarNotificationTrigger(dateMatching: dateInfo9, repeats: true)
                        let uuidd8 = UUID().uuidString
                        let requestt8 = UNNotificationRequest(identifier: uuidd8, content: content, trigger: triggerr8)
                        center.add(requestt8) { (error) in
                            if let e = error {
                                    print(e.localizedDescription)
                                }
                        }
                    }
                }
                if MButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
                    
                    if let intHour = Int(hour) {
                        let pmHour = intHour + 12
                        dateInfo10.hour = pmHour
                        dateInfo10.minute = Int(minute)
                        dateInfo10.weekday = 2
                        let triggerr9 = UNCalendarNotificationTrigger(dateMatching: dateInfo10, repeats: true)
                        let uuidd9 = UUID().uuidString
                        let requestt9 = UNNotificationRequest(identifier: uuidd9, content: content, trigger: triggerr9)
                        center.add(requestt9) { (error) in
                            if let e = error {
                                    print(e.localizedDescription)
                                }
                        }
                    }
                }
                if TButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
                    
                    if let intHour = Int(hour) {
                        let pmHour = intHour + 12
                        dateInfo11.hour = pmHour
                        dateInfo11.minute = Int(minute)
                        dateInfo11.weekday = 3
                        let triggerr0 = UNCalendarNotificationTrigger(dateMatching: dateInfo11, repeats: true)
                        let uuidd0 = UUID().uuidString
                        let requestt0 = UNNotificationRequest(identifier: uuidd0, content: content, trigger: triggerr0)
                        center.add(requestt0) { (error) in
                            if let e = error {
                                    print(e.localizedDescription)
                                }
                        }
                    }
                }
                if WButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
                    
                    if let intHour = Int(hour) {
                        let pmHour = intHour + 12
                        dateInfo12.hour = pmHour
                        dateInfo12.minute = Int(minute)
                        dateInfo12.weekday = 4
                        let triggerr11 = UNCalendarNotificationTrigger(dateMatching: dateInfo12, repeats: true)
                        let uuidd11 = UUID().uuidString
                        let requestt11 = UNNotificationRequest(identifier: uuidd11, content: content, trigger: triggerr11)
                        center.add(requestt11) { (error) in
                            if let e = error {
                                    print(e.localizedDescription)
                                }
                        }
                    }
                }
                if T2Button.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
                    
                    if let intHour = Int(hour) {
                        let pmHour = intHour + 12
                        dateInfo13.hour = pmHour
                        dateInfo13.minute = Int(minute)
                        dateInfo13.weekday = 5
                        let triggerr22 = UNCalendarNotificationTrigger(dateMatching: dateInfo13, repeats: true)
                        let uuidd22 = UUID().uuidString
                        let requestt22 = UNNotificationRequest(identifier: uuidd22, content: content, trigger: triggerr22)
                        center.add(requestt22) { (error) in
                            if let e = error {
                                    print(e.localizedDescription)
                                }
                        }
                    }
                }
                if FButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
                    
                    if let intHour = Int(hour) {
                        let pmHour = intHour + 12
                        dateInfo14.hour = pmHour
                        dateInfo14.minute = Int(minute)
                        dateInfo14.weekday = 6
                        let triggerr33 = UNCalendarNotificationTrigger(dateMatching: dateInfo14, repeats: true)
                        let uuidd33 = UUID().uuidString
                        let requestt33 = UNNotificationRequest(identifier: uuidd33, content: content, trigger: triggerr33)
                        center.add(requestt33) { (error) in
                            if let e = error {
                                    print(e.localizedDescription)
                                }
                        }
                    }
                }
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        medicinCollectionView.delegate = self
        medicinCollectionView.dataSource = self
        medicinCollectionView.isMultipleTouchEnabled = false
       
        addButton.isEnabled = false
        addButton.backgroundColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1).withAlphaComponent(0.5)
        configurNotificationObservers()
        style(viewMedicienName)
        style(viewAmount)
        style(viewTime)
        style(SButton)
        style(S2Button)
        style(MButton)
        style(TButton)
        style(WButton)
        style(T2Button)
        style(FButton)
        style(viewDuration)
        stylee(addButton)
        style(AMButton)
        style(PMButton)
    }
    
    func configurNotificationObservers() {
        medicineNameText.addTarget(self, action: #selector(textWillChange), for: .editingChanged)
        amountText.addTarget(self, action: #selector(textWillChange), for: .editingChanged)
        timeText.addTarget(self, action: #selector(textWillChange), for: .editingChanged)
        durationText.addTarget(self, action: #selector(textWillChange), for: .editingChanged)
        AMButton.addTarget(self, action: #selector(textDidChange), for: .touchUpInside)
        PMButton.addTarget(self, action: #selector(textDidChange), for: .touchUpInside)
        SButton.addTarget(self, action: #selector(textDidChange), for: .touchUpInside)
        S2Button.addTarget(self, action: #selector(textDidChange), for: .touchUpInside)
        MButton.addTarget(self, action: #selector(textDidChange), for: .touchUpInside)
        TButton.addTarget(self, action: #selector(textDidChange), for: .touchUpInside)
        WButton.addTarget(self, action: #selector(textDidChange), for: .touchUpInside)
        T2Button.addTarget(self, action: #selector(textDidChange), for: .touchUpInside)
        FButton.addTarget(self, action: #selector(textDidChange), for: .touchUpInside)
       
    }
    @IBAction func test(_ sender: UITextField) {
        
        
    }
    func style (_ component: UIView){
        component.layer.cornerRadius = component.frame.size.height / 5
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 5
        component.layer.shadowOpacity = 0.19
    }
    func style (_ component: UIButton){
        component.layer.cornerRadius = component.frame.size.height / 2
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 2
        component.layer.shadowOpacity = 0.19
    }
   
    func stylee (_ component: UIButton){
        component.layer.cornerRadius = component.frame.size.height / 5
        component.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        component.layer.shadowOffset = CGSize(width: 0, height: 1.7)
        component.layer.shadowRadius = component.frame.size.height / 5
        component.layer.shadowOpacity = 0.19
    }
    func showMessage(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func calculateDate() ->String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        let nameOfMonth = formatter.string(from: date)

        let formatterDay = Calendar.current
        let components = formatterDay.dateComponents([.day], from: date)
        let nameOfDay = components.day
        let totalDate = "\(nameOfDay!) \(nameOfMonth)"
        return totalDate
    }
    func saveMedicine() {
        if AMButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
            amPM.append("AM")
        }else{
            amPM.append("notAM")
        }
        if PMButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
            amPM.append("PM")
        }else{
            amPM.append("notPM")
        }
        if SButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
            day.append("S")
        }else{
            day.append("notS")
        }
        if S2Button.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
            day.append("S")
        }else{
            day.append("notS")
        }
        if MButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
            day.append("M")
        }else{
            day.append("notM")
        }
        if TButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
            day.append("T")
        }else{
            day.append("notT")
        }
        if WButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
            day.append("W")
        }else{
            day.append("notW")
        }
        if T2Button.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
            day.append("T")
        }else{
            day.append("notT")
        }
        if FButton.backgroundColor == #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1) {
            day.append("F")
        }else{
            day.append("notF")
        }
        let resultCalculateDate = calculateDate()
        if let medicineName = medicineNameText.text, let amount = amountText.text, let time = timeText.text, let minuts = minuts.text, let duration = durationText.text, let index = indexPathRow{
    
            if let medicineSender = Auth.auth().currentUser?.email {
                db.collection("medicineAdded").addDocument(data: ["dateOfAddMedicine": resultCalculateDate, "medicineName": medicineName, "imageType": nameOfImage[index], "amount": amount, "emailOfSender": medicineSender, "time": time, "minuts": minuts, "amORpm": amPM, "days": day, "duration": duration, "timeOfAddMedicine": Date().timeIntervalSince1970]) { (error) in
                    if let e = error {
                        self.showMessage(withTitle: "Error", message: e.localizedDescription)
                        return
                    }else{
                        print("successed saves data in firestore")
                    }
                }
            }
        }
    }
}

extension AddMedicinesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResuableCollectionViewCell", for: indexPath) as! MedicineCollectionViewCell
        cell.imageTypeMedicin.image = imageArray[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        indexPathRow = nil
        if let selectedCell:UICollectionViewCell = collectionView.cellForItem(at: indexPath as IndexPath) as? MedicineCollectionViewCell {
            selectedCell.contentView.layer.borderColor = #colorLiteral(red: 0, green: 0.3720028996, blue: 0.5692689419, alpha: 1)
            selectedCell.contentView.layer.borderWidth = 3
            selectedCell.contentView.layer.cornerRadius = selectedCell.contentView.frame.size.height / 5
        }
        indexPathRow = indexPath.row

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let selectedCell:UICollectionViewCell = collectionView.cellForItem(at: indexPath as IndexPath) as? MedicineCollectionViewCell {
            selectedCell.contentView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
           

        }
    }
    
}
extension AddMedicinesViewController: FormViewModel{
    func updateForm() {
        addButton.isEnabled = viewModel.shouldEnableButton
        addButton.backgroundColor = viewModel.buttonBackgroundColor
    }
}
