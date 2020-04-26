//
//  SerializationError.swift
//  CanadaInfo
//
//  Created by Reza Farahani on 26/4/20.
//  Copyright © 2020 farahaniconsulting. All rights reserved.
//

import Foundation

public enum SerializationError: Error {
    
    case missing(String)
    case invalid(String, Any)
}
