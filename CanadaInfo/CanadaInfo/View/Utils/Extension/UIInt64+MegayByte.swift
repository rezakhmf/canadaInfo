//
//  UIInt64+MegayByte.swift
//  CanadaInfo
//
//  Created by Reza Farahani on 27/4/20.
//  Copyright © 2020 farahaniconsulting. All rights reserved.
//

import Foundation

extension UInt64 {

    func megabytes() -> UInt64 {
        return self * 1024 * 1024
    }

}
