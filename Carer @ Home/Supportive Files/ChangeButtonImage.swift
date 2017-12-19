//
//  ChangeButtonImage.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/12/19.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit

class ChangeButtonImage {
    
    let image = UIImage(named: "checkbox-unchecked.png")
    let imageChecked = UIImage(named: "checkbox-checked.png")
    
    func changeImage(sender: UIButton) {
        if sender.currentImage == image {
            sender.setImage(imageChecked, for: .normal)
        } else {
            sender.setImage(image, for: .normal)
        }
    }
}
