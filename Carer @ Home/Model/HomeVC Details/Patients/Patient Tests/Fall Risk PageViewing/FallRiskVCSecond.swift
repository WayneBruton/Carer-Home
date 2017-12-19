//
//  FallRiskVCSecond.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/16.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit

class FallRiskVCSecond: UIViewController {
    


    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreDescriptionLabel: UILabel!
    
    
    var age = 0
    var fallHistory = 0
    var bowel = 0
    var medication = 0
    var patientCareEquipment = 0
    var mobility = 0
    var cognition = 0
    
    var incontinence = 0 //Relates to Bowel
    var urgencyOrFrequency = 0 // Relates to Bowel
    
    var unsteadyGait = 0 //Relates to Mobility
    var impairmentMobility = 0 //Relates to Mobility
    
    var alteredAwareness = 0 //Relates to Cognition
    var impulsive = 0 //Relates to Cognition
    var lackOfUnderstandingOfOnesLimitations = 0 // Relates to Cognition
    
    let userDefaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveScores()
        calculateScore()
        
        
      
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        retrieveScores()
//        calculateScore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveScores()
        calculateScore()
    }
    
    func saveScores() {
        userDefaults.set(age, forKey: "age")
        userDefaults.set(fallHistory, forKey: "fallHistory")
        userDefaults.set(medication, forKey: "medication")
        userDefaults.set(patientCareEquipment, forKey: "patientCareEquipment")
        userDefaults.set(incontinence, forKey: "incontinence")
        userDefaults.set(urgencyOrFrequency, forKey: "urgencyOrFrequency")
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
        bowel = incontinence + urgencyOrFrequency
        mobility = unsteadyGait + impairmentMobility
        cognition = alteredAwareness + impulsive + lackOfUnderstandingOfOnesLimitations
        let score = age + fallHistory + bowel + medication + patientCareEquipment + mobility + cognition
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
