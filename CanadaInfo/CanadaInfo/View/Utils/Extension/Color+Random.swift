//
//  Color+Random.swift
//  CanadaInfo
//
//  Created by Reza Farahani on 26/4/20.
//  Copyright © 2020 farahaniconsulting. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
   public static var randomColor: UIColor? {
        
        let colorsName: [String] = ["blue_currency","green_currency","orange_currency","purple_currency","red_currency"]
        let color = UIColor(named: colorsName[Int.random(in: 0 ..< colorsName.count)])
        
        return color
    }
}

