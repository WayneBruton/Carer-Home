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
    
    let userDefaults = UserDefaults.standard
    let image = UIImage(named: "checkbox-unchecked.png")
    let imageChecked = UIImage(named: "checkbox-checked.png")
    
    //MARK: ViewDidLoad etc
    
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
        calculateScore()
        medicationButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        noHighFallRiskDrugButton.setImage(image, for: .normal)
    }
    
    @IBAction func oneHighFallRiskDrugButtonTapped(_ sender: UIButton) {
        medication = 3
        calculateScore()
        medicationButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        oneHighFallRiskDrugButton.setImage(image, for: .normal)
    }
    
    @IBAction func twoOrMoreHighFallRiskDrugButtonTapped(_ sender: UIButton) {
        medication = 5
        calculateScore()
        medicationButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        twoOrMoreHighFallRiskDrugButton.setImage(image, for: .normal)
    }
    
    @IBAction func sedatedProcedureWithin24HoursButtonTapped(_ sender: UIButton) {
        medication = 7
        calculateScore()
        medicationButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        sedatedProcedureWithin24HoursButton.setImage(image, for: .normal)
    }
    
    @IBAction func noEquipmentPresentButtonTapped(_ sender: UIButton) {
        patientCareEquipment = 0
        calculateScore()
        patientCareEquipmentButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        noEquipmentPresentButton.setImage(image, for: .normal)
    }
    
    @IBAction func oneEquipmentPresentButtonTapped(_ sender: UIButton) {
        patientCareEquipment = 1
        calculateScore()
        patientCareEquipmentButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        oneEquipmentPresentButton.setImage(image, for: .normal)
    }
    
    @IBAction func twoEquipmentPresentButtonTapped(_ sender: UIButton) {
        patientCareEquipment = 2
        calculateScore()
        patientCareEquipmentButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        twoEquipmentPresentButton.setImage(image, for: .normal)
    }
    
    @IBAction func threeEquipmentPresentButtonTapped(_ sender: UIButton) {
        patientCareEquipment = 3
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
        bowel = incontinence + urgencyOrFrequency
        mobility = requiresAssistance + unsteadyGait + impairmentMobility
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
