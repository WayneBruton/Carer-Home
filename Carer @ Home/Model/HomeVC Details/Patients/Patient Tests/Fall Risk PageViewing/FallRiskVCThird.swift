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
        if sender.currentImage == imageChecked {
            mobility = 0
        } else {
            mobility = 0
        }
        scoresArray[mobilityIndex].score = mobility
        saveScores()
        calculateScore()
    }
    
    @IBAction func mobilityRequiresAssistanceButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == imageChecked {
            requiresAssistance = 2
        } else {
            requiresAssistance = 0
        }
        scoresArray[requiresAssistanceIndex].score = requiresAssistance
        saveScores()
        calculateScore()
    }
    
    @IBAction func mobityUnsteadyGaitButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == imageChecked {
            unsteadyGait = 2
        } else {
            unsteadyGait = 0
        }
        scoresArray[unsteadyGaitIndex].score = unsteadyGait
        saveScores()
        calculateScore()
    }
    
    @IBAction func mobityVisualAudioButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == imageChecked {
            impairmentMobility = 2
        } else {
            impairmentMobility = 0
        }
        scoresArray[impairmentMobilityIndex].score = impairmentMobility
        saveScores()
        calculateScore()
    }
    
    @IBAction func cognitionNoIssuesButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == imageChecked {
            cognitionAlteredAwarenessButton.setImage(image, for: .normal)
            cognitionImpulsiveButton.setImage(image, for: .normal)
            cognitionImpulsiveButton.setImage(image, for: .normal)
            cognitionAwarenessPhysicalOrCognitiveAbilitiesButton.setImage(image, for: .normal)
            impulsive = 0
            alteredAwareness = 0
            lackOfUnderstandingOfOnesLimitations = 0
            cognition = 0
        } else {
            cognition = 0
        }
        scoresArray[impulsiveIndex].score = impulsive
        saveScores()
        calculateScore()
    }
    
    @IBAction func cognitionAlteredAwarenessButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == imageChecked {
            alteredAwareness = 1
        } else {
            alteredAwareness = 0
        }
        scoresArray[alteredAwarenessIndex].score = alteredAwareness
        saveScores()
        calculateScore()
    }
    
    @IBAction func cognitionImpulsiveButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == imageChecked {
            impulsive = 2
        } else {
            impulsive = 0
        }
        scoresArray[impulsiveIndex].score = impulsive
        saveScores()
        calculateScore()
    }
    
    @IBAction func cognitionAwarenessPhysicalOrCognitiveAbilitiesButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == imageChecked {
            lackOfUnderstandingOfOnesLimitations = 4
        } else {
            lackOfUnderstandingOfOnesLimitations = 0
        }
        scoresArray[lackOfUnderstandingOfOnesLimitationsIndex].score = lackOfUnderstandingOfOnesLimitations
        saveScores()
        calculateScore()
    }
    
    // MARk: Functions
    
    func changeImage(sender: UIButton) {
        if sender.currentImage == image {
            sender.setImage(imageChecked, for: .normal)
        } else {
            sender.setImage(image, for: .normal)
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
