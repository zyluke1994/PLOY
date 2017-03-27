//
//  UIButton+CustomBorder.swift
//  Project2_Alex_Mai
//
//  Created by Alex Mai on 11/24/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

// Help from http://stackoverflow.com/questions/28492740/button-border-with-transparent-background-in-swift

import Foundation
import UIKit

extension UIButton
{
    func setBorder(sampleButton: UIButton?) {
        sampleButton?.tintColor =  UIColor.white
        sampleButton!.frame = CGRect(x:50, y:500, width:sampleButton!.frame.size.width, height: sampleButton!.frame.size.height)
        sampleButton!.layer.borderWidth = 1.0
        sampleButton!.layer.borderColor = UIColor.white.cgColor
        sampleButton!.layer.cornerRadius = 5.0

    }
    
}
