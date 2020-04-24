//
//  NetworkError.swift
//  CanadaInfo
//
//  Created by Reza Farahani on 24/4/20.
//  Copyright © 2020 farahaniconsulting. All rights reserved.
//

import Foundation

let networkErrorDomain = "Canada Network Error Domain"

public enum NetworkErrorDomain: Error {
    
    public static let responseIsNull = NSError(domain: networkErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "the response is nil"])
    public static let baseURLORTargetEndpointIsNull = NSError(domain: networkErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "the baseURL or Target endpoints is nil"])
    
}

