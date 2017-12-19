//
//  FallRiskVCFirst.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/16.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit
import ProgressHUD

class FallRiskVCFirst: UIViewController  {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var ageLess60Button: UIButton!
    @IBOutlet weak var age60To69Button: UIButton!
    @IBOutlet weak var age70To79Button: UIButton!
    @IBOutlet weak var age80AndMoreButton: UIButton!
    @IBOutlet weak var fallHistoryButton: UIButton!
    @IBOutlet weak var scoreDescriptionLabel: UILabel!
    @IBOutlet weak var incontinenceButton: UIButton!
    @IBOutlet weak var UrgencyOrFrequencyButton: UIButton!
    
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
        saveScores()
        calculateScore()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        retrieveScores()
        calculateScore()
    }
 
    @IBAction func ageLess60ButtonTapped(_ sender: UIButton) {
        age = 0
        ageButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        ageLess60Button.setImage(image, for: .normal)
        saveScores()
        calculateScore()
    }
    
    @IBAction func age60To69ButtonTapped(_ sender: UIButton) {
        age = 1
        ageButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
         age60To69Button.setImage(image, for: .normal)
        saveScores()
        calculateScore()
    }
    
    @IBAction func age70To79ButtonTapped(_ sender: UIButton) {
        age = 2
        ageButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        age70To79Button.setImage(image, for: .normal)
        saveScores()
        calculateScore()
    }
    
    @IBAction func age80AndMoreButtonTapped(_ sender: UIButton) {
        age = 3
        ageButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        age80AndMoreButton.setImage(image, for: .normal)
        saveScores()
        calculateScore()
    }
    
    func ageButtonImages() {
        let image = UIImage(named: "checkbox-unchecked.png")
        ageLess60Button.setImage(image, for: .normal)
        age60To69Button.setImage(image, for: .normal)
        age70To79Button.setImage(image, for: .normal)
        age80AndMoreButton.setImage(image, for: .normal)
        
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
    
    @IBAction func fallHistoryButtonTapped(_ sender: UIButton) {
        let image = UIImage(named: "checkbox-unchecked.png")
        let imageChecked = UIImage(named: "checkbox-checked.png")
        if fallHistoryButton.image(for: .normal) == UIImage(named: "checkbox-unchecked.png") {
            fallHistory = 5
            fallHistoryButton.setImage(imageChecked, for: .normal)
        } else {
            fallHistory = 0
            fallHistoryButton.setImage(image, for: .normal)
        }
        saveScores()
        calculateScore()
    }
    
    @IBAction func incontinenceButtonTapped(_ sender: UIButton) {
        let image = UIImage(named: "checkbox-unchecked.png")
        let imageChecked = UIImage(named: "checkbox-checked.png")
        if incontinenceButton.image(for: .normal) == UIImage(named: "checkbox-unchecked.png") {
            incontinence = 2
            incontinenceButton.setImage(imageChecked, for: .normal)
        } else {
            incontinence = 0
            incontinenceButton.setImage(image, for: .normal)
        }
        saveScores()
        calculateScore()
        
    }
    
    @IBAction func urgencyOrFrequencyButtonTapped(_ sender: UIButton) {
        let image = UIImage(named: "checkbox-unchecked.png")
        let imageChecked = UIImage(named: "checkbox-checked.png")
        if UrgencyOrFrequencyButton.image(for: .normal) == UIImage(named: "checkbox-unchecked.png") {
            urgencyOrFrequency = 2
            UrgencyOrFrequencyButton.setImage(imageChecked, for: .normal)
        } else {
            urgencyOrFrequency = 0
            UrgencyOrFrequencyButton.setImage(image, for: .normal)
        }
        saveScores()
        calculateScore()
    }
    
    
}
