//
//  CanadaInfoProvider.swift
//  CanadaInfo
//
//  Created by Reza Farahani on 24/4/20.
//  Copyright © 2020 farahaniconsulting. All rights reserved.
//

import Foundation
import Alamofire

//MARK: - completion handler
public typealias CompletionHandler = (Result<(CanadaInfoModel), NSError>) -> Void

//MARK: - Canada Info Provider
protocol CanadaInfoProvider: class {
    func getCanadaInfo(completion: @escaping CompletionHandler)
}

//MARK: - Canada Info Provider implementation
public class CanadaInfoRepository: CanadaInfoProvider {
    
    let environment: Environment
    
    public init(environment: Environment) {
        self.environment = environment
    }
    
    func getCanadaInfo(completion: @escaping CompletionHandler) {
        
        guard let baseUrl = environment.baseUrl, let  canadaFactsEndpoint = environment.canadaFactsEndpoint else {
            completion(.failure(NetworkErrorDomain.baseURLORTargetEndpointIsNull))
            return
        }
        
        AF.request(baseUrl + canadaFactsEndpoint)
            .validate()
            .response { response in
                
                switch response.result {
                case .failure(let error):
                    completion(.failure(error as NSError))
                case .success(let data):
                    guard let data = data else {
                        completion(.failure(NetworkErrorDomain.responseIsNull))
                        return
                    }
                    
                    do {
                        let canadaInfo = try JSONDecoder().decode(CanadaInfoModel.self, from: data)
                        completion(.success(canadaInfo))
                    } catch {
                        completion(.failure(error as NSError))
                    }
                }
        }
    }
}
