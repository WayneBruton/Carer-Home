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
    
    //MARK: IB Outlets
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var ageLess60Button: UIButton!
    @IBOutlet weak var age60To69Button: UIButton!
    @IBOutlet weak var age70To79Button: UIButton!
    @IBOutlet weak var age80AndMoreButton: UIButton!
    @IBOutlet weak var fallHistoryButton: UIButton!
    @IBOutlet weak var scoreDescriptionLabel: UILabel!
    @IBOutlet weak var incontinenceButton: UIButton!
    @IBOutlet weak var UrgencyOrFrequencyButton: UIButton!
    
    //MARK: Variances & Constants
    
    var age: Int = 0
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
    
    let image = UIImage(named: "checkbox-unchecked.png")
    let imageChecked = UIImage(named: "checkbox-checked.png")
    
    let basicArray = ["age","fallHistory","bowel","medication","patientCareEquipment","mobility","cognition","incontinence","urgencyOrFrequency","requiresAssistance","unsteadyGait","impairmentMobility","alteredAwareness","impulsive","lackOfUnderstandingOfOnesLimitations"]
    
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
    
    var calcFR = CalculateFallRiskScores()
    //MARK: ViewDidLoad Etc
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageLess60Button.contentHorizontalAlignment = .left
        age70To79Button.contentHorizontalAlignment = .left
        age60To69Button.contentHorizontalAlignment = .left
        age80AndMoreButton.contentHorizontalAlignment = .left
        incontinenceButton.contentHorizontalAlignment = .left
        UrgencyOrFrequencyButton.contentHorizontalAlignment = .left
        resetScores()
        saveScores()
        calculateScore()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        retrieveScores()
        calculateScore()
    }
    
    //MARK: IB Actions
    
    @IBAction func ageLess60ButtonTapped(_ sender: UIButton) {
        age = 0
        ageButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        ageLess60Button.setImage(image, for: .normal)
        scoresArray[ageIndex].score = age
        saveScores()
        calculateScore()
    }
    
    @IBAction func age60To69ButtonTapped(_ sender: UIButton) {
        age = 1
        ageButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
         age60To69Button.setImage(image, for: .normal)
        scoresArray[ageIndex].score = age
        saveScores()
        calculateScore()
    }
    
    @IBAction func age70To79ButtonTapped(_ sender: UIButton) {
        age = 2
        ageButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        age70To79Button.setImage(image, for: .normal)
        scoresArray[ageIndex].score = age
        saveScores()
        calculateScore()
    }
    
    @IBAction func age80AndMoreButtonTapped(_ sender: UIButton) {
        age = 3
        ageButtonImages()
        let image = UIImage(named: "checkbox-checked.png")
        age80AndMoreButton.setImage(image, for: .normal)
        scoresArray[ageIndex].score = age
        saveScores()
        calculateScore()
    }
    
    @IBAction func fallHistoryButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == imageChecked {
            fallHistory = 5
        } else {
            fallHistory = 0
        }
        scoresArray[fallHistoryIndex].score = fallHistory
        saveScores()
        calculateScore()
    }
    
    @IBAction func incontinenceButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == imageChecked {
            incontinence = 2
        } else {
            incontinence = 0
        }
        scoresArray[incontinenceIndex].score = incontinence
        saveScores()
        calculateScore()
        
    }
    
    @IBAction func urgencyOrFrequencyButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == imageChecked {
            urgencyOrFrequency = 2
        } else {
            urgencyOrFrequency = 0
        }
        scoresArray[urgencyOrFrequencyIndex].score = urgencyOrFrequency
        saveScores()
        calculateScore()
    }
    
    //MARK: Functions
    
    func changeImage(sender: UIButton) {
        if sender.currentImage == image {
            sender.setImage(imageChecked, for: .normal)
        } else {
            sender.setImage(image, for: .normal)
        }
    }
    
    func ageButtonImages() {
        let image = UIImage(named: "checkbox-unchecked.png")
        ageLess60Button.setImage(image, for: .normal)
        age60To69Button.setImage(image, for: .normal)
        age70To79Button.setImage(image, for: .normal)
        age80AndMoreButton.setImage(image, for: .normal)
        
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
    
    //MARK: NSCoding
    
    func resetScores() {
        scoresArray.removeAll()
        saveScores()

        for i in 0...basicArray.count - 1 {
            let newItem = SaveFallRiskScores()
            //let name: String = basicArray[i]
            newItem.scoreName = basicArray[i]
            print(newItem.scoreName)
            scoresArray.append(newItem)
            saveScores()
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
