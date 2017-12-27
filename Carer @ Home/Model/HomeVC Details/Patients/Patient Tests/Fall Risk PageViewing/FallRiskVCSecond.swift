//
//  FallRiskVCSecond.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/16.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit

class FallRiskVCSecond: UIViewController {
    
    //MARK: IB Outlets
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreDescriptionLabel: UILabel!
    @IBOutlet weak var noHighFallRiskDrugButton: UIButton!
    @IBOutlet weak var oneHighFallRiskDrugButton: UIButton!
    @IBOutlet weak var twoOrMoreHighFallRiskDrugButton: UIButton!
    @IBOutlet weak var sedatedProcedureWithin24HoursButton: UIButton!
    @IBOutlet weak var noEquipmentPresentButton: UIButton!
    @IBOutlet weak var oneEquipmentPresentButton: UIButton!
    @IBOutlet weak var twoEquipmentPresentButton: UIButton!
    @IBOutlet weak var threeEquipmentPresentButton: UIButton!
    
    //MARK: Variances & Constants
    
    var age = 0
    var fallHistory = 0
    var bowel = 0
    var medication = 0
    var patientCareEquipment = 0
    var mobility = 0
    var cognition = 0
    
    var incontinence = 0 //Relates to Bowel
    var urgencyOrFrequency = 0 // Relates to Bowel
    
    var requiresAssistance = 0 // Relates to Mobility
    var unsteadyGait = 0 //Relates to Mobility
    var impairmentMobility = 0 //Relates to Mobility
    
    var alteredAwareness = 0 //Relates to Cognition
    var impulsive = 0 //Relates to Cognition
    var lackOfUnderstandingOfOnesLimitations = 0 // Relates to Cognition
    
    var scoresArray = [SaveFallRiskScores]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Scores.plist")
    
    var calcFR = CalculateFallRiskScores()
    var constants = Constants()
    
    //MARK: ViewDidLoad etc
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveScores()
        calculateScore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveScores()
        calculateScore()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        calculateScore()
        saveScores()
    }
    override func viewDidDisappear(_ animated: Bool) {
        saveScores()
        calculateScore()
    }
    
    // MARK: IB Actions
    
    @IBAction func noHighFallRiskDrugButtonTapped(_ sender: UIButton) {
        medication = 0
        scoresArray[constants.medicationIndex].score = medication
        saveScores()
        calculateScore()
        medicationButtonImages()
        noHighFallRiskDrugButton.setImage(constants.imageChecked, for: .normal)
    }
    
    @IBAction func oneHighFallRiskDrugButtonTapped(_ sender: UIButton) {
        medication = 3
        scoresArray[constants.medicationIndex].score = medication
        saveScores()
        calculateScore()
        medicationButtonImages()
        oneHighFallRiskDrugButton.setImage(constants.imageChecked, for: .normal)
    }
    
    @IBAction func twoOrMoreHighFallRiskDrugButtonTapped(_ sender: UIButton) {
        medication = 5
        scoresArray[constants.medicationIndex].score = medication
        saveScores()
        calculateScore()
        medicationButtonImages()
        twoOrMoreHighFallRiskDrugButton.setImage(constants.imageChecked, for: .normal)
    }
    
    @IBAction func sedatedProcedureWithin24HoursButtonTapped(_ sender: UIButton) {
        medication = 7
        scoresArray[constants.medicationIndex].score = medication
        saveScores()
        calculateScore()
        medicationButtonImages()
        sedatedProcedureWithin24HoursButton.setImage(constants.imageChecked, for: .normal)
    }
    
    @IBAction func noEquipmentPresentButtonTapped(_ sender: UIButton) {
        patientCareEquipment = 0
        scoresArray[constants.medicationIndex].score = medication
        saveScores()
        calculateScore()
        patientCareEquipmentButtonImages()
        noEquipmentPresentButton.setImage(constants.imageChecked, for: .normal)
    }
    
    @IBAction func oneEquipmentPresentButtonTapped(_ sender: UIButton) {
        patientCareEquipment = 1
        scoresArray[constants.patientCareEquipmentIndex].score = patientCareEquipment
        saveScores()
        calculateScore()
        patientCareEquipmentButtonImages()
        oneEquipmentPresentButton.setImage(constants.imageChecked, for: .normal)
    }
    
    @IBAction func twoEquipmentPresentButtonTapped(_ sender: UIButton) {
        patientCareEquipment = 2
        scoresArray[constants.patientCareEquipmentIndex].score = patientCareEquipment
        saveScores()
        calculateScore()
        patientCareEquipmentButtonImages()
        twoEquipmentPresentButton.setImage(constants.imageChecked, for: .normal)
    }
    
    @IBAction func threeEquipmentPresentButtonTapped(_ sender: UIButton) {
        patientCareEquipment = 3
        scoresArray[constants.patientCareEquipmentIndex].score = patientCareEquipment
        saveScores()
        calculateScore()
        patientCareEquipmentButtonImages()
        threeEquipmentPresentButton.setImage(constants.imageChecked, for: .normal)
    }
   
    //MARK: Functions
    
    func changeImage(sender: UIButton) {
        if sender.currentImage == constants.imageUnchecked {
            sender.setImage(constants.imageChecked, for: .normal)
        } else {
            sender.setImage(constants.imageUnchecked, for: .normal)
        }
    }
    
    func medicationButtonImages() {
        noHighFallRiskDrugButton.setImage(constants.imageUnchecked, for: .normal)
        oneHighFallRiskDrugButton.setImage(constants.imageUnchecked, for: .normal)
        twoOrMoreHighFallRiskDrugButton.setImage(constants.imageUnchecked, for: .normal)
        sedatedProcedureWithin24HoursButton.setImage(constants.imageUnchecked, for: .normal)
    }
    
    func patientCareEquipmentButtonImages() {
        noEquipmentPresentButton.setImage(constants.imageUnchecked, for: .normal)
        oneEquipmentPresentButton.setImage(constants.imageUnchecked, for: .normal)
        twoEquipmentPresentButton.setImage(constants.imageUnchecked, for: .normal)
        threeEquipmentPresentButton.setImage(constants.imageUnchecked, for: .normal)
    }
    
    func calculateScore() {
        let score = calcFR.calc(bowel: bowel, incontinence: incontinence, urgencyOrFrequency: urgencyOrFrequency, mobility: mobility, requiresAssistance: requiresAssistance, unsteadyGait: unsteadyGait, impairmentMobility: impairmentMobility, cognition: cognition, alteredAwareness: alteredAwareness, impulsive: impulsive, lackOfUnderstandingOfOnesLimitations: lackOfUnderstandingOfOnesLimitations, age: age, fallHistory: fallHistory, medication: medication, patientCareEquipment: patientCareEquipment)
        scoreLabel.text = "\(score)"
        if score < 6 {
            scoreDescriptionLabel.text = " Minor Fall Risk"
        } else if score >= 6 && score <= 13 {
            scoreDescriptionLabel.text = "Moderate Fall Risk"
        } else if score > 13 {
            scoreDescriptionLabel.text = "High Fall Risk"
        }
    }
    
    func saveScores() {
        
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(scoresArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item Array \(error)")
        }
    }
    
    func retrieveScores() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                scoresArray = try decoder.decode([SaveFallRiskScores].self, from: data)
            } catch {
                print("error decoding item array \(error) ")
            }
        }
    }
    
}
