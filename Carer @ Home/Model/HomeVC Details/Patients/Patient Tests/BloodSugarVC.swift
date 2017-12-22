//
//  BloodSugarVC.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/09.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit
import ProgressHUD
import SGauge
import GMStepper


class BloodSugarVC: UIViewController {
    
    // MARK: IB Outlets - Constants & Variances
    
    @IBOutlet weak var sugarGauge: SGauge!
    @IBOutlet weak var mmolPerLitreLabel: UILabel!
    @IBOutlet weak var HbAc1Label: UILabel!
    @IBOutlet weak var HbAc1PercentLabel: UILabel!
    @IBOutlet weak var mgPerdlLabel: UILabel!
    @IBOutlet weak var sugarStepper: GMStepper!
    
    // MARK: Variables & Constants
    
    var mmolPerLitre = 0.0
    var mgPerDl = 0.0
    var HbAc1 = 0.0
    var molPerLireRatio = 0.18015588
    var mmolPerMol = 0.0
    var timer = Timer()
    var sound = ClickSound()
    
    // MARK:  ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mmolPerLitre = 7.8
        calcSugar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: IB Actions
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Save", message: "Save Blood Glucose Readings", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (saveAction) in
            ProgressHUD.showSuccess("Saved")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sugarStepperPressed(_ sender: GMStepper) {
       mmolPerLitre = sugarStepper.value
        sugarStepper.value = round(mmolPerLitre * 10) / 10
        calcSugar()
    }
    
    // MARK: Methods
    
    func calcSugar() {
        
        if CGFloat(mmolPerLitre) >= sugarGauge.maxValue {
            mmolPerLitre = Double(sugarGauge.maxValue)
        }
        if CGFloat(mmolPerLitre) <= sugarGauge.minValue {
            mmolPerLitre = Double(sugarGauge.minValue)
        }
        mmolPerLitre = round(mmolPerLitre * 10) / 10
        mgPerDl = round(mmolPerLitre * 18)
        mmolPerMol = round(mmolPerLitre / molPerLireRatio)
        HbAc1 = round(((mmolPerMol / 10.929) + 2.15) * 10) / 10
        mmolPerLitreLabel.text = "\(mmolPerLitre) mmol/l"
        mgPerdlLabel.text = "\(mgPerDl) mg/dl"
        HbAc1Label.text = " HbAc1 \(mmolPerMol) mmol/mol"
        HbAc1PercentLabel.text = "HbAc1 - \(HbAc1) %"
        sugarGauge.value = CGFloat(mmolPerLitre)
    }
    
    @objc func increaseLevel() {
        mmolPerLitre += 0.1
        calcSugar()
        sound.playSound()
    }
    
    @objc func decreaseLevel() {
        mmolPerLitre -= 0.1
        calcSugar()
        sound.playSound()
    }
}
