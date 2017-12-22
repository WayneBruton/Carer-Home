//
//  FluidIntakeVC.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/05.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit
import ProgressHUD
import MARoundButton
import SGauge

class FluidIntakeVC: UIViewController {
    
    @IBOutlet weak var fluidMeter: SGauge!
   // @IBOutlet weak var fluidMeter: UICircularProgressRingView!
    @IBOutlet weak var litreLabel: UILabel!
    @IBOutlet weak var moreButton: MARoundButton!
    @IBOutlet weak var lessButton: MARoundButton!
    
    var valueMeter = 0
    var sound = ClickSound()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fluidMeter.value = CGFloat(valueMeter)
        valuesChanged()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fluidMeter.value = CGFloat(valueMeter)
        litreLabel.text = "\(Int(fluidMeter.value)) ml"
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: IB Actions
    
    @IBAction func moreButtonPressed(_ sender: MARoundButton) {
        valueMeter += 250
        valuesChanged()
        sound.playSound()
    }
    
    @IBAction func lessButtonPressed(_ sender: MARoundButton) {
        valueMeter -= 250
        valuesChanged()
        sound.playSound()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Save", message: "Save Fluid Readings", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (saveAction) in
            ProgressHUD.showSuccess("Saved")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Values changed Method
    
    func valuesChanged() {
        if valueMeter <= 0 {
            lessButton.isEnabled = false
            lessButton.isHidden = true
        } else {
            lessButton.isEnabled = true
            lessButton.isHidden = false
        }
        if valueMeter >= 5000 {
            moreButton.isEnabled = false
            moreButton.isHidden = true
        } else {
            moreButton.isEnabled = true
            moreButton.isHidden = false
        }
        let valueLabel = Int(valueMeter)
        litreLabel.text = "\(valueLabel) ml"
        fluidMeter.value = CGFloat(valueMeter)
    }
    
}
