//
//  PulseVC.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/06.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit
import ProgressHUD
import GMStepper
import RoundedSwitch

class PulseVC: UIViewController {
    
    @IBOutlet weak var restingActiveSwitch: Switch!
    @IBOutlet weak var pulseStepper: GMStepper!
    @IBOutlet weak var ageStepper: UIStepper!
    
    var age = 45
    
    override func viewDidLoad() {
        super.viewDidLoad()
        age = 45
        typeOfPulse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: IB Actions
    
    @IBAction func restingActiveSwitchPressed(_ sender: Switch) {
        typeOfPulse()
    }
    
    @IBAction func ageStepperPressed(_ sender: UIStepper) {
        age = Int(ageStepper.value)
        typeOfPulse()
    }
    
    @IBAction func saveButonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Save", message: "Save Pulse Readings", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (saveAction) in
            ProgressHUD.showSuccess("Saved")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Pulse Method
    
    func typeOfPulse() {
        if restingActiveSwitch.rightSelected == true {
            if age <= 40 {
                let maxHeartRate = Double(220 - age)
                let A = Double(maxHeartRate * 0.5)
                let B = Double(maxHeartRate * 0.85)
                var targetHeartRate = (A + B)/2
                targetHeartRate = round(targetHeartRate)
                pulseStepper.minimumValue = 60
                pulseStepper.maximumValue = 220
                pulseStepper.value = targetHeartRate
            } else {
                let maxHeartRate = Double(220 - (Double(age) * 0.75))
                let A = Double(maxHeartRate * 0.5)
                let B = Double(maxHeartRate * 0.85)
                var targetHeartRate = (A + B)/2
                targetHeartRate = round(targetHeartRate)
                pulseStepper.minimumValue = 60
                pulseStepper.maximumValue = 220
                pulseStepper.value = targetHeartRate
            }
        } else {
            pulseStepper.minimumValue = 25
            pulseStepper.maximumValue = 150
            pulseStepper.value = 80
        }
    }
}
