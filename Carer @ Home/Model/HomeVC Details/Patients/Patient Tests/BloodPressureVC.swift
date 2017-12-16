//
//  BloodPressureVC.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/05.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit
import VerticalSteppedSlider
import ProgressHUD


class BloodPressureVC: UIViewController {
    
    @IBOutlet weak var systolicSlider: VSSlider!
    @IBOutlet weak var diastolicSlider: VSSlider!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var commentaryLabel: UILabel!
    
    var systolicBP : Float = 0
    var diastolicBP : Float = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        systolicBP = 120
        diastolicBP = 80
        systolicSlider.value = systolicBP
        diastolicSlider.value = diastolicBP
        bloodPressureResults()
        bpObservation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: IBActions
    
    @IBAction func sysSliderMoved(_ sender: VSSlider) {
        systolicBP = systolicSlider.value
        bloodPressureResults()
        bpObservation()
    }
    
    @IBAction func diaSliderMoved(_ sender: VSSlider) {
        diastolicBP = diastolicSlider.value
        bloodPressureResults()
        bpObservation()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Save", message: "Save Readings", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (saveAction) in
            ProgressHUD.showSuccess("Saved")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: BP Functions
    
    func bloodPressureResults() {
        resultsLabel.text = "\(Int(systolicBP)) / \(Int(diastolicBP))"
    }
    
    func bpObservation() {
        var check = 0
        var commentaryText = ""
        if (Int(systolicBP) > 140 && Int(diastolicBP) > 90) {
            check = 1 //High Blood Pressure
        }
        if (Int(systolicBP) > 120 && Int(systolicBP) <= 140) && (Int(diastolicBP) > 80 && Int(diastolicBP) <= 90) {
            check = 2 // Pre-High Blood Pressure
        }
        if (Int(systolicBP) > 90 && Int(systolicBP) <= 120) && (Int(diastolicBP) > 60 && Int(diastolicBP) <= 80) {
            check = 3 // Ideal Blood Pressure
        }
        if (Int(systolicBP) <= 90 && Int(diastolicBP) <= 60) {
            check = 4 //Low Blood Pressure
        }
        if (Int(systolicBP) > 90 && Int(systolicBP) <= 120) && (Int(diastolicBP) <= 60) {
            check = 5 // You may have low blood pressure
        }
        if (Int(systolicBP) > 140) && ( Int(diastolicBP) <= 80) {
            check = 6 // You may have high blood pressure
        }
        if (Int(diastolicBP) >= 90) && (Int(systolicBP) > 90 && Int(systolicBP) <= 120) {
            check = 7 // You may have high blood pressure
        }
        if Int(systolicBP) <= 90 && (Int(diastolicBP) > 60) {
            check = 8 // You may have low blood pressure
        }
        if (Int(diastolicBP) <= 60) && (Int(systolicBP) > 90 && Int(systolicBP) <= 120) {
            check = 9 // You may have low blood pressure
        }
        switch check {
        case 1:
            commentaryText = "High Blood Pressure"
            commentaryLabel.textColor = UIColor.red
        case 2:
            commentaryText = "Pre-High Blood Pressure"
            commentaryLabel.textColor = UIColor.magenta
        case 3:
            commentaryText = "Ideal Blood Pressure"
            commentaryLabel.textColor = UIColor.darkGray
        case 4:
            commentaryText = "Low Blood Pressure"
            commentaryLabel.textColor = UIColor.purple
        case 5:
            commentaryText = "Possible High Blood pressure"
            commentaryLabel.textColor = UIColor.orange
        case 6:
            commentaryText = "Possible High Blood pressure"
            commentaryLabel.textColor = UIColor.orange
        case 7:
            commentaryText = "Possible Low Blood pressure"
            commentaryLabel.textColor = UIColor.blue
        case 8:
            commentaryText = "Possible Low Blood pressure"
            commentaryLabel.textColor = UIColor.blue
        case 9:
            commentaryText = "Possible Low Blood pressure"
            commentaryLabel.textColor = UIColor.blue
        default:
            commentaryText = "Blood Pressure not ideal but OK"
            commentaryLabel.textColor = UIColor.brown
        }
        commentaryLabel.text = commentaryText
    }
}
