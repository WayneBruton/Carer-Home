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
    
    let ageIndex = 0
    let fallHistoryIndex = 1
    let bowelIndex = 2
    let medicationIndex = 3
    let patientCareEquipmentIndex = 4
    let mobilityIndex = 5
    let cognitionIndex = 6
    let incontinenceIndex = 7
    let urgencyOrFrequencyIndex = 8
    let requiresAssistanceIndex = 9
    let unsteadyGaitIndex = 10
    let impairmentMobilityIndex = 11
    let alteredAwarenessIndex = 12
    let impulsiveIndex = 13
    let lackOfUnderstandingOfOnesLimitationsIndex = 14
    
    let image = UIImage(named: "checkbox-unchecked.png")
    let imageChecked = UIImage(named: "checkbox-checked.png")
    
    var calcFR = CalculateFallRiskScores()
    
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
        scoresArray[medicationIndex].score = medication
        saveScores()
        calculateScore()
        medicationButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        noHighFallRiskDrugButton.setImage(image, for: .normal)
    }
    
    @IBAction func oneHighFallRiskDrugButtonTapped(_ sender: UIButton) {
        medication = 3
        scoresArray[medicationIndex].score = medication
        saveScores()
        calculateScore()
        medicationButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        oneHighFallRiskDrugButton.setImage(image, for: .normal)
    }
    
    @IBAction func twoOrMoreHighFallRiskDrugButtonTapped(_ sender: UIButton) {
        medication = 5
        scoresArray[medicationIndex].score = medication
        saveScores()
        calculateScore()
        medicationButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        twoOrMoreHighFallRiskDrugButton.setImage(image, for: .normal)
    }
    
    @IBAction func sedatedProcedureWithin24HoursButtonTapped(_ sender: UIButton) {
        medication = 7
        scoresArray[medicationIndex].score = medication
        saveScores()
        calculateScore()
        medicationButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        sedatedProcedureWithin24HoursButton.setImage(image, for: .normal)
    }
    
    @IBAction func noEquipmentPresentButtonTapped(_ sender: UIButton) {
        patientCareEquipment = 0
        scoresArray[medicationIndex].score = medication
        saveScores()
        calculateScore()
        patientCareEquipmentButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        noEquipmentPresentButton.setImage(image, for: .normal)
    }
    
    @IBAction func oneEquipmentPresentButtonTapped(_ sender: UIButton) {
        patientCareEquipment = 1
        scoresArray[patientCareEquipmentIndex].score = patientCareEquipment
        saveScores()
        calculateScore()
        patientCareEquipmentButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        oneEquipmentPresentButton.setImage(image, for: .normal)
    }
    
    @IBAction func twoEquipmentPresentButtonTapped(_ sender: UIButton) {
        patientCareEquipment = 2
        scoresArray[patientCareEquipmentIndex].score = patientCareEquipment
        saveScores()
        calculateScore()
        patientCareEquipmentButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        twoEquipmentPresentButton.setImage(image, for: .normal)
    }
    
    @IBAction func threeEquipmentPresentButtonTapped(_ sender: UIButton) {
        patientCareEquipment = 3
        scoresArray[patientCareEquipmentIndex].score = patientCareEquipment
        saveScores()
        calculateScore()
        patientCareEquipmentButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        threeEquipmentPresentButton.setImage(image, for: .normal)
    }
   
    //MARK: Functions
    
    func changeImage(sender: UIButton) {
        if sender.currentImage == image {
            sender.setImage(imageChecked, for: .normal)
        } else {
            sender.setImage(image, for: .normal)
        }
    }
    
    func medicationButtonImages() {
        let image = UIImage(named: "checkbox-unchecked.png")
        noHighFallRiskDrugButton.setImage(image, for: .normal)
        oneHighFallRiskDrugButton.setImage(image, for: .normal)
        twoOrMoreHighFallRiskDrugButton.setImage(image, for: .normal)
        sedatedProcedureWithin24HoursButton.setImage(image, for: .normal)
    }
    
    func patientCareEquipmentButtonImages() {
        let image = UIImage(named: "checkbox-unchecked.png")
        noEquipmentPresentButton.setImage(image, for: .normal)
        oneEquipmentPresentButton.setImage(image, for: .normal)
        twoEquipmentPresentButton.setImage(image, for: .normal)
        threeEquipmentPresentButton.setImage(image, for: .normal)
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
