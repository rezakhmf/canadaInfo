//
//  CanadaInfoModel.swift
//  CanadaInfo
//
//  Created by Reza Farahani on 24/4/20.
//  Copyright © 2020 farahaniconsulting. All rights reserved.
//

import Foundation

// MARK: - CanadaInfoModel
public struct CanadaInfoModel: Codable {
    let title: String
    let rows: [Row]
}

// MARK: - Row
public struct Row: Codable {
    let title: String?
    let rowDescription: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageHref
    }
}

