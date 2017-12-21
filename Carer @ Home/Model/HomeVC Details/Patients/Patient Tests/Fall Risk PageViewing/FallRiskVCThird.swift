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
    
    let userDefaults = UserDefaults.standard
    let image = UIImage(named: "checkbox-unchecked.png")
    let imageChecked = UIImage(named: "checkbox-checked.png")
    
    var calcFR = CalculateFallRiskScores()
    
    
    //var changeImage : ChangeButtonImage!
    
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
        saveScores()
        calculateScore()
    }
    
    @IBAction func cognitionNoIssuesButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == imageChecked {
            cognition = 0
        } else {
            cognition = 0
        }
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

    func saveScores() {
        userDefaults.set(age, forKey: "age")
        userDefaults.set(fallHistory, forKey: "fallHistory")
        userDefaults.set(medication, forKey: "medication")
        userDefaults.set(patientCareEquipment, forKey: "patientCareEquipment")
        userDefaults.set(incontinence, forKey: "incontinence")
        userDefaults.set(urgencyOrFrequency, forKey: "urgencyOrFrequency")
        userDefaults.set(requiresAssistance, forKey: "requiresAssistance")//*****
        userDefaults.set(unsteadyGait, forKey: "unsteadyGait")
        userDefaults.set(impairmentMobility, forKey: "impairmentMobility")
        userDefaults.set(alteredAwareness, forKey: "alteredAwareness")
        userDefaults.set(impulsive, forKey: "impulsive")
        userDefaults.set(lackOfUnderstandingOfOnesLimitations, forKey: "lackOfUnderstandingOfOnesLimitations")
    }
    func retrieveScores() {
        if userDefaults.integer(forKey: "age") != 0 {
            age = userDefaults.integer(forKey: "age")
        }
        if userDefaults.integer(forKey: "fallHistory") != 0 {
            fallHistory = userDefaults.integer(forKey: "fallHistory")
        }
        if userDefaults.integer(forKey: "medication") != 0 {
            medication = userDefaults.integer(forKey: "medication")
        }
        if userDefaults.integer(forKey: "patientCareEquipment") != 0 {
            patientCareEquipment = userDefaults.integer(forKey: "patientCareEquipment")
        }
        if userDefaults.integer(forKey: "incontinence") != 0 {
            incontinence = userDefaults.integer(forKey: "incontinence")
        }
        if userDefaults.integer(forKey: "urgencyOrFrequency") != 0 {
            urgencyOrFrequency = userDefaults.integer(forKey: "urgencyOrFrequency")
        }
        if userDefaults.integer(forKey: "requiresAssistance") != 0 {
            requiresAssistance = userDefaults.integer(forKey: "requiresAssistance")
        }
        
        if userDefaults.integer(forKey: "unsteadyGait") != 0 {
            unsteadyGait = userDefaults.integer(forKey: "unsteadyGait")
        }
        if userDefaults.integer(forKey: "impairmentMobility") != 0 {
            impairmentMobility = userDefaults.integer(forKey: "impairmentMobility")
        }
        if userDefaults.integer(forKey: "alteredAwareness") != 0 {
            alteredAwareness = userDefaults.integer(forKey: "alteredAwareness")
        }
        if userDefaults.integer(forKey: "impulsive") != 0 {
            impulsive = userDefaults.integer(forKey: "impulsive")
        }
        if userDefaults.integer(forKey: "lackOfUnderstandingOfOnesLimitations") != 0 {
            lackOfUnderstandingOfOnesLimitations = userDefaults.integer(forKey: "lackOfUnderstandingOfOnesLimitations")
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


}
