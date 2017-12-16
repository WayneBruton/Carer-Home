//
//  Conversions.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/02.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import Foundation

class Conversion {
    // Liquid Conversions
    // Temperature Conversions
    // Measurement Conversions
    
    init() {
        
    }
    
    func celciusToFahrenheit(celcius : Double) -> Double {
        let resultInFahrenheit = (celcius * 1.8) + 32
        return resultInFahrenheit
    }
    
    func fahrenheitToCelcius(fahrenheit : Double) -> Double {
        let resultInCelcius = (fahrenheit - 32)/1.8
        return resultInCelcius
    }
    
}
