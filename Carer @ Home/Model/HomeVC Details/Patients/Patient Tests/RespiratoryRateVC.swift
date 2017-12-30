//
//  RespiratoryRateVC.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/30.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit

class RespiratoryRateVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    // MARK: IB Outlets
    
    @IBOutlet weak var respiratoryRateLabel: UILabel!
    @IBOutlet weak var respiratoryRatePickerView: UIPickerView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
        // MARK: Variables & Constants
    
    var respiratoryArray: [Int] = []
    var clientAgeGroup = ""
    var dangerZone = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        respiratoryRatePickerView.delegate = self
        clientAgeGroup = "Adult"
        respiratoryArrayPopulate(clientAgeGroup: clientAgeGroup)
    }
    
    // MARK IB Actions
    
    @IBAction func ageButtonTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Age", message: "Patient Age group", preferredStyle: .actionSheet)
        
        let adultAction = UIAlertAction(title: "Adult", style: .default) { (adultAction) in
            self.clientAgeGroup = "Adult"
            self.respiratoryArrayPopulate(clientAgeGroup: self.clientAgeGroup)
        }
        let zeroToSixMonthsAction = UIAlertAction(title: " < 6 Mths", style: .default) { (zeroToSixMonthsAction) in
            self.clientAgeGroup = "zeroToSixMonths"
            self.respiratoryArrayPopulate(clientAgeGroup: self.clientAgeGroup)
        }
        let sixToTwelveMonthsAction = UIAlertAction(title: " 6 - 12 Mths", style: .default) { (sixToTwelveMonthsAction) in
            self.clientAgeGroup = "sixToTwelveMonths"
            self.respiratoryArrayPopulate(clientAgeGroup: self.clientAgeGroup)
        }
        let oneToFiveYrsAction = UIAlertAction(title: " 1 - 5 Yrs", style: .default) { (oneToFiveYrsAction) in
            self.clientAgeGroup = "oneToFiveYears"
            self.respiratoryArrayPopulate(clientAgeGroup: self.clientAgeGroup)
        }
        let fiveToTwelveYrsAction = UIAlertAction(title: " 5 - 12 yrs", style: .default) { (fiveToTwelveYrsAction) in
            self.clientAgeGroup = "fiveToTwelveYears"
            self.respiratoryArrayPopulate(clientAgeGroup: self.clientAgeGroup)
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
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return respiratoryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        respiratoryRateLabel.text = "\(respiratoryArray[row]) breaths/min"
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(respiratoryArray[row]) breaths/min"
    }
    
    //MARK: Functions
    
    func respiratoryArrayPopulate(clientAgeGroup: String) {
        respiratoryArray.removeAll()
        var medianBreathRate = 0
        switch clientAgeGroup {
        case "zeroToSixMonths":
            for i in 1...100 {
                respiratoryArray.append(i)
            }
            medianBreathRate = 45
            descriptionLabel.text = "0 - 6 Months Old"
        case "sixToTwelveMonths":
            for i in 1...60 {
                respiratoryArray.append(i)
            }
            medianBreathRate = 27
            descriptionLabel.text = "6 - 12 Months Old"
        case "oneToFiveYears":
            for i in 1...60 {
                respiratoryArray.append(i)
            }
            medianBreathRate = 25
            descriptionLabel.text = "1 - 5 Years Old"
        case "fiveToTwelveYears":
            for i in 1...60 {
                respiratoryArray.append(i)
            }
            medianBreathRate = 16
            descriptionLabel.text = "5 - 12 Years Old"
        default:
            for i in 1...60 {
                respiratoryArray.append(i)
            }
            medianBreathRate = 12
            descriptionLabel.text = "Adult Reading"
        }
        medianBreathRate -= 1
        respiratoryRatePickerView.selectRow(medianBreathRate, inComponent: 0, animated: true)
        respiratoryRateLabel.text = "\(respiratoryArray[medianBreathRate]) breaths/min"
    }
    
    func detectDanger(danger: Bool) {
        
        //    let zeroToSixMonths = "zeroToSixMonths"
        //    let sixToTwelveMonths = "sixToTwelveMonths"
        //    let oneToFiveYears = "oneToFiveYears"
        //    let fiveToTwelveYears = "fiveToTwelveYears"
        //    let adult = "Adult"
        
    }
    

}
