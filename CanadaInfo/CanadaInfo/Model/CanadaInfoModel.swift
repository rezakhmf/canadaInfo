//
//  CanadaInfoModel.swift
//  CanadaInfo
//
//  Created by Reza Farahani on 24/4/20.
//  Copyright © 2020 farahaniconsulting. All rights reserved.
//

import Foundation

// MARK: - CanadaInfoModel
public struct CanadaInfoModel {
    let title: String?
    let rows: [Row]?
    
    init(json: [String: Any]) throws {
        
        guard let title = json["title"] as? String else {
            throw SerializationError.missing("title")
        }
        
        guard let rows = json["rows"] as? NSArray else {
            throw SerializationError.missing("title")
        }
        
        var mRows: [Row]? = []
        for row in rows {
            if let dict = row as? NSDictionary {
                let title = dict.value(forKey:"title") as? String
                let description = dict.value(forKey:"description") as? String
                let imageHref = dict.value(forKey:"imageHref") as? String
                
                let row = Row(title: title, description: description, imageHref: imageHref)
                
                mRows?.append(row)
            }
        }
        
        // Initialize properties
        self.title = title
        self.rows = mRows
        
    }
}

// MARK: - Row
public struct Row {
    let title: String?
    let description: String?
    let imageHref: String?
}

