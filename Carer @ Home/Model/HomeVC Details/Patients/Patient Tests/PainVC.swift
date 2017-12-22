//
//  PainVC.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/08.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit
import ProgressHUD
import SGauge
import MARoundButton


class PainVC: UIViewController {
    
    //Mark: Ib Outlets
    
    @IBOutlet weak var painScaleGuage: SGauge!
    @IBOutlet weak var painLabel: UILabel!
    @IBOutlet weak var increasePainButton: MARoundButton!
    @IBOutlet weak var decreasePainButton: MARoundButton!

    var painLevel = 0
    var sound = ClickSound()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showButton()
        processGauge()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARk: IbActions
    
    @IBAction func increasePainButtonPressed(_ sender: MARoundButton) {
        painLevel += 1
        showButton()
        processGauge()
        sound.playSound()
    }
    
    @IBAction func decreasePainButtonPressed(_ sender: MARoundButton) {
        painLevel -= 1
        showButton()
        processGauge()
        sound.playSound()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Save", message: "Save Pain Scale Readings", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (saveAction) in
            ProgressHUD.showSuccess("Saved")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showButton() {
        if painLevel <= 0 {
            decreasePainButton.isEnabled = false
            decreasePainButton.isHidden = true
            increasePainButton.isEnabled = true
            increasePainButton.isHidden = false
            painScaleGuage.value = 0
        } else if painLevel >= 10 {
            decreasePainButton.isEnabled = true
            decreasePainButton.isHidden = false
            increasePainButton.isEnabled = false
            increasePainButton.isHidden = true
            painScaleGuage.value = 10
        } else {
            decreasePainButton.isEnabled = true
            decreasePainButton.isHidden = false
            increasePainButton.isEnabled = true
            increasePainButton.isHidden = false
        }
    }
    
    func processGauge() {
        painScaleGuage.value = CGFloat(painLevel)
        switch painLevel {
        case 0:
            //painScaleGuage.arcColor = UIColor.blue
            painLabel.text = "No Pain - \(painLevel)"
            painLabel.textColor = UIColor.blue
        case 1:
            //painScaleGuage.arcColor = UIColor.
            painLabel.text = "Mild Pain - \(painLevel)"
            painLabel.textColor = UIColor.black
        case 2:
            //painScaleGuage.arcColor = UIColor(red: 0, green: 143, blue: 0, alpha: 0.5)
            painLabel.text = "Mild Pain - \(painLevel)"
            painLabel.textColor = UIColor.black
        case 3:
            //painScaleGuage.arcColor = UIColor(red: 255, green: 251, blue: 0, alpha: 1)
            painLabel.text = "Moderate Pain - \(painLevel)"
            painLabel.textColor = UIColor(red: 255, green: 251, blue: 0, alpha: 1)
        case 4:
            //painScaleGuage.arcColor = UIColor(red: 255, green: 251, blue: 0, alpha: 1)
            painLabel.text = "Moderate Pain - \(painLevel)"
            painLabel.textColor = UIColor(red: 255, green: 251, blue: 0, alpha: 1)
        case 5:
            //painScaleGuage.arcColor = UIColor.orange
            painLabel.text = "Severe Pain - \(painLevel)"
            painLabel.textColor = UIColor.orange
        case 6:
            //painScaleGuage.arcColor = UIColor.orange
            painLabel.text = "Severe Pain - \(painLevel)"
            painLabel.textColor = UIColor.orange
        case 7:
            //painScaleGuage.arcColor = UIColor.magenta
            painLabel.text = "Very Severe Pain - \(painLevel)"
            painLabel.textColor = UIColor.magenta
        case 8:
            //painScaleGuage.arcColor = UIColor.magenta
            painLabel.text = "Very Severe Pain - \(painLevel)"
            painLabel.textColor = UIColor.magenta
        case 9:
            //painScaleGuage.arcColor = UIColor.red
            painLabel.text = "Excruciating Pain - \(painLevel)"
            painLabel.textColor = UIColor.red
        default:
            //painScaleGuage.arcColor = UIColor.red
            painLabel.text = "Excruciating Pain - \(painLevel)"
            painLabel.textColor = UIColor.red
        }
    }
}
