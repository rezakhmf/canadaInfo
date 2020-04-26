//
//  CanadaInfoViewModel.swift
//  CanadaInfo
//
//  Created by Reza Farahani on 26/4/20.
//  Copyright © 2020 farahaniconsulting. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire

protocol CanadaInfoViewModelProvier: class {
    func getCanadaInfo(completion: @escaping (CanadaInfoModel) -> Void)
    func retrieveImage(for url: String, completion: @escaping (UIImage) -> Void) -> Request
}

public class CanadaInfoViewModel: CanadaInfoViewModelProvier {
    
    
    let canadaInfoRepository: CanadaInfoRepository
    
    init(canadaInfoRepository: CanadaInfoRepository = CanadaInfoRepository(environment: Environment())) {
        self.canadaInfoRepository = canadaInfoRepository
    }
    
    func getCanadaInfo(completion: @escaping (CanadaInfoModel) -> Void) {
        
        canadaInfoRepository.getCanadaInfo { response in
           
            switch response {
            case .failure(let error):
                print(error.description)
            case .success(let canadaInfoModel):
                completion(canadaInfoModel)
            }
        }
    }
    
    func retrieveImage(for url: String, completion: @escaping (UIImage) -> Void) -> Request {
        return AF.request(url, method: .get).responseImage { response in
                   switch response.result {
                   case .failure(let error) :
                       print(error)
                   case .success(let image):
                       completion(image)
                   }
               }
    }
}
