//
//  CanadaInfoViewModel.swift
//  CanadaInfo
//
//  Created by Reza Farahani on 26/4/20.
//  Copyright © 2020 farahaniconsulting. All rights reserved.
//

import Foundation

protocol CanadaInfoViewModelProvier: class {
    func getCanadaInfo(completion: @escaping CompletionHandler)
}

public class CanadaInfoViewModel: CanadaInfoViewModelProvier {
    
    
    let canadaInfoRepository: CanadaInfoRepository
    
    init(canadaInfoRepository: CanadaInfoRepository = CanadaInfoRepository(environment: Environment())) {
        self.canadaInfoRepository = canadaInfoRepository
    }
    
    func getCanadaInfo(completion: @escaping CompletionHandler) {
        
        canadaInfoRepository.getCanadaInfo { response in
           
            switch response {
            case .failure(let error):
                completion(.failure(error))
            case .success(let canadaModel):
                completion(.success(canadaModel))
            }
        }
    }
}
