//
//  CalculateFallRiskScores.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/20.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import Foundation

class CalculateFallRiskScores {
    
    func calc(bowel: Int, incontinence: Int, urgencyOrFrequency: Int, mobility: Int, requiresAssistance: Int, unsteadyGait: Int, impairmentMobility: Int , cognition: Int, alteredAwareness: Int, impulsive: Int, lackOfUnderstandingOfOnesLimitations: Int, age: Int, fallHistory: Int, medication: Int, patientCareEquipment: Int  ) -> Int {
        let bowel = incontinence + urgencyOrFrequency
        let mobility = requiresAssistance + unsteadyGait + impairmentMobility
        let cognition = alteredAwareness + impulsive + lackOfUnderstandingOfOnesLimitations
        let score = age + fallHistory + bowel + medication + patientCareEquipment + mobility + cognition
        return score
    }
}
