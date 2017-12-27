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
    
    var calcFR = CalculateFallRiskScores()
    var constants = Constants()
    
    //MARK: ViewDidLoad Etc
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath!)
        adjustButtonAlignment()
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
        ageLess60Button.setImage(constants.imageChecked, for: .normal)
        scoresArray[constants.ageIndex].score = age
        saveScores()
        calculateScore()
    }
    
    @IBAction func age60To69ButtonTapped(_ sender: UIButton) {
        age = 1
        ageButtonImages()
         age60To69Button.setImage(constants.imageChecked, for: .normal)
        scoresArray[constants.ageIndex].score = age
        saveScores()
        calculateScore()
    }
    
    @IBAction func age70To79ButtonTapped(_ sender: UIButton) {
        age = 2
        ageButtonImages()
        age70To79Button.setImage(constants.imageChecked, for: .normal)
        scoresArray[constants.ageIndex].score = age
        saveScores()
        calculateScore()
    }
    
    @IBAction func age80AndMoreButtonTapped(_ sender: UIButton) {
        age = 3
        ageButtonImages()
        age80AndMoreButton.setImage(constants.imageChecked, for: .normal)
        scoresArray[constants.ageIndex].score = age
        saveScores()
        calculateScore()
    }
    
    @IBAction func fallHistoryButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == constants.imageChecked {
            fallHistory = 5
        } else {
            fallHistory = 0
        }
        scoresArray[constants.fallHistoryIndex].score = fallHistory
        saveScores()
        calculateScore()
    }
    
    @IBAction func incontinenceButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == constants.imageChecked {
            incontinence = 2
        } else {
            incontinence = 0
        }
        scoresArray[constants.incontinenceIndex].score = incontinence
        saveScores()
        calculateScore()
        
    }
    
    @IBAction func urgencyOrFrequencyButtonTapped(_ sender: UIButton) {
        changeImage(sender: sender)
        if sender.currentImage == constants.imageChecked {
            urgencyOrFrequency = 2
        } else {
            urgencyOrFrequency = 0
        }
        scoresArray[constants.urgencyOrFrequencyIndex].score = urgencyOrFrequency
        saveScores()
        calculateScore()
    }
    
    //MARK: Functions
    
    func changeImage(sender: UIButton) {
        if sender.currentImage == constants.imageUnchecked {
            sender.setImage(constants.imageChecked, for: .normal)
        } else {
            sender.setImage(constants.imageUnchecked, for: .normal)
        }
    }
    
    func ageButtonImages() {
        ageLess60Button.setImage(constants.imageUnchecked, for: .normal)
        age60To69Button.setImage(constants.imageUnchecked, for: .normal)
        age70To79Button.setImage(constants.imageUnchecked, for: .normal)
        age80AndMoreButton.setImage(constants.imageUnchecked, for: .normal)
        
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
    
    func adjustButtonAlignment() {
        ageLess60Button.contentHorizontalAlignment = .left
        age70To79Button.contentHorizontalAlignment = .left
        age60To69Button.contentHorizontalAlignment = .left
        age80AndMoreButton.contentHorizontalAlignment = .left
        incontinenceButton.contentHorizontalAlignment = .left
        UrgencyOrFrequencyButton.contentHorizontalAlignment = .left
    }
    
    //MARK: NSCoding
    
    func resetScores() {
        scoresArray.removeAll()
        saveScores()
        for i in 0...constants.basicArray.count - 1 {
            let newItem = SaveFallRiskScores()
            newItem.scoreName = constants.basicArray[i]
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
