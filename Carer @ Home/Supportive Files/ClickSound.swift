//
//  ClickSound.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/10.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import Foundation
import AVFoundation

class ClickSound {
    
    var clickSoundEffect : AVAudioPlayer?
    
    func playSound() {
        let path = Bundle.main.path(forResource : "keyboard_tap.mp3", ofType : nil)
        let url = URL(fileURLWithPath: path!)
        do {
            clickSoundEffect = try AVAudioPlayer(contentsOf: url)
            clickSoundEffect?.volume = 0.01
            clickSoundEffect?.play()
        } catch {
            // couldn't load file :(
            print("couldn't load file :(")
        }
    }
    

    
}
