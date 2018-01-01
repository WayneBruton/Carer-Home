//
//  FallRiskVC.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/31.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit
import ProgressHUD

class FallRiskVC: UIViewController {
    
    //MARK: IB Outlets

    @IBOutlet weak var myScrollView: UIScrollView!
    //Single Select
    @IBOutlet weak var ageUnder60Button: UIButton! //0 points
    @IBOutlet weak var age60To69Button: UIButton! //1 Point
    @IBOutlet weak var age70To79Button: UIButton! //2 Points
    @IBOutlet weak var ageOver80Button: UIButton! //3 Points
    //Single Select
    @IBOutlet weak var fallsWithin6MonthsButton: UIButton! //5 Points
    //Multi Select
    @IBOutlet weak var bowelUrgencyButton: UIButton! //2 Points
    @IBOutlet weak var bowelIncontinenceButton: UIButton! //2 Points
    //Single Select
    @IBOutlet weak var careEquipmentNoneButton: UIButton!// 0 Points
    @IBOutlet weak var careEquipmentOneButton: UIButton! // 1 Point
    @IBOutlet weak var careEquipmentTwoButton: UIButton! // 2 Points
    @IBOutlet weak var careEquipmentThreeButton: UIButton! //3 Points
    //Single Select
    @IBOutlet weak var medicationNoRiskButton: UIButton! //0
    @IBOutlet weak var medicationOneRiskButton: UIButton! // 3 Points
    @IBOutlet weak var medicationTwoRiskButton: UIButton! // 5
    @IBOutlet weak var medicationSedatedProcedureButton: UIButton! //7
    //Multi - Select
    @IBOutlet weak var mobilityUnsteadyGaitButton: UIButton! // 2
    @IBOutlet weak var mobilityVisualAudioImpairmentButton: UIButton! // 2
    @IBOutlet weak var mobilityRequiresAssistanceButton: UIButton! //2
    //Multi-select
    @IBOutlet weak var cognitionAlteredAwarenessButton: UIButton! // 1
    @IBOutlet weak var cognitionUnderstandingLimitationsButton: UIButton! // 2
    @IBOutlet weak var cognitionImpulsiveButton: UIButton! // 4
    
    @IBOutlet weak var scoreButton: UIBarButtonItem!
    
    //MARK: Variables & Constants
    
    let imageUnchecked = UIImage(named: "checkbox-unchecked.png")
    let imageChecked = UIImage(named: "checkbox-checked.png")
    
    var age = 0
    var fallHistory = 0
    var bowelUrgencyOrFrequency = 0
    var bowelIncontinence = 0
    var equipment = 0
    var medication = 0
    var patientCareEquipment = 0
    var mobilityUnsteadyGait = 0
    var mobilityAudioVisualImpairment = 0
    var mobilityRequiresAssistance = 0
    var cognitionAlteredAwareness = 0
    var cognitionUnderstandingLimitations = 0
    var cognitionImpulsive = 0
    
    var fallRiskDescription = "Low Fall Risk"
    
    //MARK: ViewDidLoad Etc
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myScrollView.contentSize = CGSize(width: self.view.frame.width, height: 1677)

    }
    
    //MARK: IB Actions
    
    @IBAction func ageUnder60ButtonTapped(_ sender: UIButton) {
        setAgeButtonImages()
        sender.setImage(imageChecked, for: .normal)
        age = 0
        calculateScores()
    }
    
    @IBAction func age60To69ButtonTapped(_ sender: UIButton) {
        setAgeButtonImages()
        sender.setImage(imageChecked, for: .normal)
        age = 1
        calculateScores()
    }
    
    @IBAction func age70To79ButtonTapped(_ sender: UIButton) {
        setAgeButtonImages()
        sender.setImage(imageChecked, for: .normal)
        age = 2
        calculateScores()
    }
    
    @IBAction func ageOver80ButtonTapped(_ sender: UIButton) {
        setAgeButtonImages()
        sender.setImage(imageChecked, for: .normal)
        age = 3
        calculateScores()
    }
    
    @IBAction func fallsWithin6MonthsButtonTapped(_ sender: UIButton) {
        if sender.image(for: .normal) == imageUnchecked {
            sender.setImage(imageChecked, for: .normal)
            fallHistory = 5
        } else {
            sender.setImage(imageUnchecked, for: .normal)
            fallHistory = 0
        }
        calculateScores()
    }
    
    @IBAction func bowelUrgencyButtonTapped(_ sender: UIButton) {
        if sender.image(for: .normal) == imageUnchecked {
            sender.setImage(imageChecked, for: .normal)
            bowelUrgencyOrFrequency = 2
        } else {
            sender.setImage(imageUnchecked, for: .normal)
            bowelUrgencyOrFrequency = 0
        }
        calculateScores()
    }
    
    @IBAction func bowelIncontinenceButtonTapped(_ sender: UIButton) {
        if sender.image(for: .normal) == imageUnchecked {
            sender.setImage(imageChecked, for: .normal)
            bowelIncontinence = 2
        } else {
            sender.setImage(imageUnchecked, for: .normal)
            bowelIncontinence = 0
        }
        calculateScores()
    }
    
    @IBAction func careEquipmentNoneButtonTapped(_ sender: UIButton) {
        setCareEquipmentButtonImages()
        sender.setImage(imageChecked, for: .normal)
        equipment = 0
        calculateScores()
    }
    
    @IBAction func careEquipmentOneButtonTapped(_ sender: UIButton) {
        setCareEquipmentButtonImages()
        sender.setImage(imageChecked, for: .normal)
        equipment = 1
        calculateScores()
    }
    
    @IBAction func careEquipmentTwoButtonTapped(_ sender: UIButton) {
        setCareEquipmentButtonImages()
        sender.setImage(imageChecked, for: .normal)
        equipment = 2
        calculateScores()
    }
    
    @IBAction func careEquipmentThreeButtonTapped(_ sender: UIButton) {
        setCareEquipmentButtonImages()
        sender.setImage(imageChecked, for: .normal)
        equipment = 3
        calculateScores()
    }
    
    @IBAction func medicationNoRiskButtonTapped(_ sender: UIButton) {
        setMedicationButtonImage()
        sender.setImage(imageChecked, for: .normal)
        medication = 0
        calculateScores()
    }
    
    @IBAction func medicationOneRiskButtonTapped(_ sender: UIButton) {
        setMedicationButtonImage()
        sender.setImage(imageChecked, for: .normal)
        medication = 3
        calculateScores()
    }
    
    @IBAction func medicationTwoRiskButtonTapped(_ sender: UIButton) {
        setMedicationButtonImage()
        sender.setImage(imageChecked, for: .normal)
        medication = 5
        calculateScores()
    }
    
    @IBAction func medicationSedatedProcedureButtonTapped(_ sender: UIButton) {
        setMedicationButtonImage()
        sender.setImage(imageChecked, for: .normal)
        medication = 7
        calculateScores()
    }

    @IBAction func mobilityUnsteadyGaitButtonTapped(_ sender: UIButton) {
        if sender.image(for: .normal) == imageUnchecked {
            sender.setImage(imageChecked, for: .normal)
            mobilityUnsteadyGait = 2
        } else {
            sender.setImage(imageUnchecked, for: .normal)
            mobilityUnsteadyGait = 0
        }
        calculateScores()
    }
    
    @IBAction func mobilityVisualAudioImpairmentButtonTapped(_ sender: UIButton) {
        if sender.image(for: .normal) == imageUnchecked {
            sender.setImage(imageChecked, for: .normal)
            mobilityAudioVisualImpairment = 2
        } else {
            sender.setImage(imageUnchecked, for: .normal)
            mobilityAudioVisualImpairment = 0
        }
        calculateScores()
    }
    
    @IBAction func mobilityRequiresAssistanceButtonTapped(_ sender: UIButton) {
        if sender.image(for: .normal) == imageUnchecked {
            sender.setImage(imageChecked, for: .normal)
            mobilityRequiresAssistance = 2
        } else {
            sender.setImage(imageUnchecked, for: .normal)
            mobilityRequiresAssistance = 0
        }
        calculateScores()
    }
    //1
    @IBAction func cognitionAlteredAwarenessButtonTapped(_ sender: UIButton) {
        if sender.image(for: .normal) == imageUnchecked {
            sender.setImage(imageChecked, for: .normal)
            cognitionAlteredAwareness = 1
        } else {
            sender.setImage(imageUnchecked, for: .normal)
            cognitionAlteredAwareness = 0
        }
        calculateScores()
    }
    //2
    @IBAction func cognitionUnderstandingLimitationsButtonTapped(_ sender: UIButton) {
        if sender.image(for: .normal) == imageUnchecked {
            sender.setImage(imageChecked, for: .normal)
            cognitionUnderstandingLimitations = 2
        } else {
            sender.setImage(imageUnchecked, for: .normal)
            cognitionUnderstandingLimitations = 0
        }
        calculateScores()
    }
    //4
    @IBAction func cognitionImpulsiveButtonTapped(_ sender: UIButton) {
        if sender.image(for: .normal) == imageUnchecked {
            sender.setImage(imageChecked, for: .normal)
            cognitionImpulsive = 4
        } else {
            sender.setImage(imageUnchecked, for: .normal)
            cognitionImpulsive = 0
        }
        calculateScores()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        ProgressHUD.showSuccess("Saved !!")
    }
    
    @IBAction func scoreButtonTapped(_ sender: UIBarButtonItem) {
        calculateScores()
    }
    
    
    // MARK: Functions
    
    func setAgeButtonImages() {
        ageUnder60Button.setImage(imageUnchecked, for: .normal)
        age60To69Button.setImage(imageUnchecked, for: .normal)
        age70To79Button.setImage(imageUnchecked, for: .normal)
        ageOver80Button.setImage(imageUnchecked, for: .normal)
    }
    
    func setCareEquipmentButtonImages() {
        careEquipmentNoneButton.setImage(imageUnchecked, for: .normal)
        careEquipmentOneButton.setImage(imageUnchecked, for: .normal)
        careEquipmentTwoButton.setImage(imageUnchecked, for: .normal)
        careEquipmentThreeButton.setImage(imageUnchecked, for: .normal)
    }
    
    func setMedicationButtonImage() {
        medicationNoRiskButton.setImage(imageUnchecked, for: .normal)
        medicationOneRiskButton.setImage(imageUnchecked, for: .normal)
        medicationTwoRiskButton.setImage(imageUnchecked, for: .normal)
        medicationSedatedProcedureButton.setImage(imageUnchecked, for: .normal)
    }
    
    func calculateScores() {
         let score = age + fallHistory + bowelUrgencyOrFrequency + bowelIncontinence + equipment + medication + patientCareEquipment + mobilityUnsteadyGait + mobilityAudioVisualImpairment + mobilityRequiresAssistance + cognitionAlteredAwareness + cognitionUnderstandingLimitations + cognitionImpulsive
        if score < 6 {
            fallRiskDescription = " Minor Fall Risk"
        } else if score >= 6 && score <= 13 {
            fallRiskDescription = "Moderate Fall Risk"
        } else if score > 13 {
            fallRiskDescription = "High Fall Risk"
        }
        scoreButton.title = "\(fallRiskDescription) - \(score)"
    }

}
