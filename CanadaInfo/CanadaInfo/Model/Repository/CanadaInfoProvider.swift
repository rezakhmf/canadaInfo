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
                        
                        //MARK: - convet data to string in UTF8
                        let candanInfoModelJsonString = String(decoding: data, as: UTF8.self)
                        //MARK: - convet data to data in UTF8
                        let candanInfoModelJsonData:Data = candanInfoModelJsonString.data(using: .utf8)!
                        //MARK: - convet data to Dictionary
                        if let candanInfoModelJsonObject = try JSONSerialization.jsonObject(with: candanInfoModelJsonData, options: .allowFragments) as? [String: Any] {
                            
                            //MARK: - parse to model
                            let canandaInfoModel = try CanadaInfoModel(json: candanInfoModelJsonObject)
                            
                            completion(.success(canandaInfoModel))
                            
                        } else {
                            completion(.failure(SerializationError.missing("the data format is wrong") as NSError))
                        }
                    } catch {
                        print(error.localizedDescription)
                        completion(.failure(error as NSError))
                    }
                }
        }
    }
}
