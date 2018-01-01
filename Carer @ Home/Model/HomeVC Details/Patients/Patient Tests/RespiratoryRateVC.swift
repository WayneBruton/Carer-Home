//
//  RespiratoryRateVC.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/30.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit
import ProgressHUD

class RespiratoryRateVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    // MARK: IB Outlets
    
    @IBOutlet weak var respiratoryRateLabel: UILabel!
    @IBOutlet weak var respiratoryRatePickerView: UIPickerView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
        // MARK: Variables & Constants
    
    var respiratoryArray: [String] = []
    var clientAgeGroup = ""
    var dangerZone = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        respiratoryRatePickerView.delegate = self
        clientAgeGroup = "Adult"
        respiratoryArrayPopulate(clientAgeGroup: clientAgeGroup)
        detectDanger()
    }
    
    // MARK IB Actions
    
    @IBAction func ageButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Age", message: "Patient Age group", preferredStyle: .actionSheet)
        
        let adultAction = UIAlertAction(title: "Adult", style: .default) { (adultAction) in
            self.clientAgeGroup = "Adult"
            self.respiratoryArrayPopulate(clientAgeGroup: self.clientAgeGroup)
            self.detectDanger()
        }
        let zeroToSixMonthsAction = UIAlertAction(title: " < 6 Mths", style: .default) { (zeroToSixMonthsAction) in
            self.clientAgeGroup = "zeroToSixMonths"
            self.respiratoryArrayPopulate(clientAgeGroup: self.clientAgeGroup)
            self.detectDanger()
        }
        let sixToTwelveMonthsAction = UIAlertAction(title: " 6 - 12 Mths", style: .default) { (sixToTwelveMonthsAction) in
            self.clientAgeGroup = "sixToTwelveMonths"
            self.respiratoryArrayPopulate(clientAgeGroup: self.clientAgeGroup)
            self.detectDanger()
        }
        let oneToFiveYrsAction = UIAlertAction(title: " 1 - 5 Yrs", style: .default) { (oneToFiveYrsAction) in
            self.clientAgeGroup = "oneToFiveYears"
            self.respiratoryArrayPopulate(clientAgeGroup: self.clientAgeGroup)
            self.detectDanger()
        }
        let fiveToTwelveYrsAction = UIAlertAction(title: " 5 - 12 yrs", style: .default) { (fiveToTwelveYrsAction) in
            self.clientAgeGroup = "fiveToTwelveYears"
            self.respiratoryArrayPopulate(clientAgeGroup: self.clientAgeGroup)
            self.detectDanger()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(adultAction)
        alert.addAction(zeroToSixMonthsAction)
        alert.addAction(sixToTwelveMonthsAction)
        alert.addAction(oneToFiveYrsAction)
        alert.addAction(fiveToTwelveYrsAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        ProgressHUD.showSuccess("Coming soon!!")
    }
    
    
    //MARK: PickerView Datasource & Delegates
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return respiratoryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        respiratoryRateLabel.text = "\(respiratoryArray[row])"
        detectDanger()
        print(respiratoryArray[row])
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(respiratoryArray[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel!
        if view == nil { //if no label there yet
            pickerLabel = UILabel()
            //color the label's background
            let hue = CGFloat(row)/CGFloat(respiratoryArray.count)
            pickerLabel?.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0
            )}
        let titleData = "\(respiratoryArray[row])"
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 26.0)!,NSAttributedStringKey.foregroundColor:UIColor.black])
            pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .center
        return pickerLabel!
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 36.0
        }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200
    }
    
    func pickerView(_ pickerView: UIPickerView, heightForComponent component: Int) -> CGFloat {
        return 200
    }
    
    
    //MARK: Functions
    
    func respiratoryArrayPopulate(clientAgeGroup: String) {
        respiratoryArray.removeAll()
        var medianBreathRate = 0
        switch clientAgeGroup {
        case "zeroToSixMonths":
            for i in 1...100 {
                let data = "\(i) breaths / min"
                respiratoryArray.append(data)
            }
            medianBreathRate = 45
            descriptionLabel.text = "0 - 6 Months Old"
        case "sixToTwelveMonths":
            for i in 1...60 {
                let data = "\(i) breaths / min"
                respiratoryArray.append(data)
            }
            medianBreathRate = 27
            descriptionLabel.text = "6 - 12 Months Old"
        case "oneToFiveYears":
            for i in 1...60 {
                let data = "\(i) breaths / min"
                respiratoryArray.append(data)
            }
            medianBreathRate = 25
            descriptionLabel.text = "1 - 5 Years Old"
        case "fiveToTwelveYears":
            for i in 1...60 {
                let data = "\(i) breaths / min"
                respiratoryArray.append(data)
            }
            medianBreathRate = 16
            descriptionLabel.text = "5 - 12 Years Old"
        default:
            for i in 1...60 {
                let data = "\(i) breaths / min"
                respiratoryArray.append(data)
            }
            medianBreathRate = 12
            descriptionLabel.text = "Adult Reading"
        }
        medianBreathRate -= 1
        respiratoryRatePickerView.selectRow(medianBreathRate, inComponent: 0, animated: true)
        respiratoryRateLabel.text = "\(respiratoryArray[medianBreathRate])"
    }
    
    func detectDanger() {
        let respiratoryRate = respiratoryArray.index(of: respiratoryRateLabel.text!)
        
        switch clientAgeGroup {
        case "zeroToSixMonths":
            if respiratoryRate! < (30 - 1) || respiratoryRate! > (60 + 1) {
                respiratoryRateLabel.backgroundColor = UIColor.orange
            } else {
                respiratoryRateLabel.backgroundColor = UIColor.green
            }
        case "sixToTwelveMonths":
            if respiratoryRate! < (24 - 1) || respiratoryRate! > (30 + 1) {
                respiratoryRateLabel.backgroundColor = UIColor.orange
            } else {
                respiratoryRateLabel.backgroundColor = UIColor.green
            }
        case "oneToFiveYears":
            if respiratoryRate! < (20 - 1) || respiratoryRate! > (30 + 1) {
                respiratoryRateLabel.backgroundColor = UIColor.orange
            } else {
                respiratoryRateLabel.backgroundColor = UIColor.green
            }
        case "fiveToTwelveYears":
            if respiratoryRate! < (12 - 1) || respiratoryRate! > (20 + 1) {
                respiratoryRateLabel.backgroundColor = UIColor.orange
            } else {
                respiratoryRateLabel.backgroundColor = UIColor.green
            }
        default:
            if respiratoryRate! < (12 - 3) || respiratoryRate! > (12 + 3) {
                respiratoryRateLabel.backgroundColor = UIColor.orange
            } else {
                respiratoryRateLabel.backgroundColor = UIColor.green
            }
        }
    }
    
    
    

}
