//
//  FallRiskVCThird.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/16.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit

class FallRiskVCThird: UIViewController {
    
    // MARK: IB Outlets
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreDescriptionLabel: UILabel!
    @IBOutlet weak var mobilityNoIssuesButton: UIButton!
    @IBOutlet weak var mobilityRequiresAssistanceButton: UIButton!
    @IBOutlet weak var mobityUnsteadyGaitButton: UIButton!
    @IBOutlet weak var mobityVisualAudioButton: UIButton!
    @IBOutlet weak var cognitionNoIssuesButton: UIButton!
    @IBOutlet weak var cognitionAlteredAwarenessButton: UIButton!
    @IBOutlet weak var cognitionImpulsiveButton: UIButton!
    @IBOutlet weak var cognitionAwarenessPhysicalOrCognitiveAbilitiesButton: UIButton!
    
    // MARK: Variances and Constants
    
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
    
    
    // MARK: ViewDidLoad etc
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveScores()
        calculateScore()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveScores()
        calculateScore()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        retrieveScores()
        calculateScore()
    }
    
    // MARK: IB Actions
    
    @IBAction func mobilityNoIssuesButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == constants.imageChecked {
            mobility = 0
        } else {
            mobility = 0
        }
        scoresArray[constants.mobilityIndex].score = mobility
        saveScores()
        calculateScore()
    }
    
    @IBAction func mobilityRequiresAssistanceButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == constants.imageChecked {
            requiresAssistance = 2
        } else {
            requiresAssistance = 0
        }
        scoresArray[constants.requiresAssistanceIndex].score = requiresAssistance
        saveScores()
        calculateScore()
    }
    
    @IBAction func mobityUnsteadyGaitButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == constants.imageChecked {
            unsteadyGait = 2
        } else {
            unsteadyGait = 0
        }
        scoresArray[constants.unsteadyGaitIndex].score = unsteadyGait
        saveScores()
        calculateScore()
    }
    
    @IBAction func mobityVisualAudioButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == constants.imageChecked {
            impairmentMobility = 2
        } else {
            impairmentMobility = 0
        }
        scoresArray[constants.impairmentMobilityIndex].score = impairmentMobility
        saveScores()
        calculateScore()
    }
    
    @IBAction func cognitionNoIssuesButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == constants.imageChecked {
            cognitionAlteredAwarenessButton.setImage(constants.imageUnchecked, for: .normal)
            cognitionImpulsiveButton.setImage(constants.imageUnchecked, for: .normal)
            cognitionImpulsiveButton.setImage(constants.imageUnchecked, for: .normal)
            cognitionAwarenessPhysicalOrCognitiveAbilitiesButton.setImage(constants.imageUnchecked, for: .normal)
            impulsive = 0
            alteredAwareness = 0
            lackOfUnderstandingOfOnesLimitations = 0
            cognition = 0
        } else {
            cognition = 0
        }
        scoresArray[constants.impulsiveIndex].score = impulsive
        saveScores()
        calculateScore()
    }
    
    @IBAction func cognitionAlteredAwarenessButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == constants.imageChecked {
            alteredAwareness = 1
        } else {
            alteredAwareness = 0
        }
        scoresArray[constants.alteredAwarenessIndex].score = alteredAwareness
        saveScores()
        calculateScore()
    }
    
    @IBAction func cognitionImpulsiveButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == constants.imageChecked {
            impulsive = 2
        } else {
            impulsive = 0
        }
        scoresArray[constants.impulsiveIndex].score = impulsive
        saveScores()
        calculateScore()
    }
    
    @IBAction func cognitionAwarenessPhysicalOrCognitiveAbilitiesButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == constants.imageChecked {
            lackOfUnderstandingOfOnesLimitations = 4
        } else {
            lackOfUnderstandingOfOnesLimitations = 0
        }
        scoresArray[constants.lackOfUnderstandingOfOnesLimitationsIndex].score = lackOfUnderstandingOfOnesLimitations
        saveScores()
        calculateScore()
    }
    
    // MARk: Functions
    
    func changeImage(sender: UIButton) {
        if sender.currentImage == constants.imageUnchecked {
            sender.setImage(constants.imageChecked, for: .normal)
        } else {
            sender.setImage(constants.imageUnchecked, for: .normal)
        }
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
