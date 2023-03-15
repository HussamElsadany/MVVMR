//
//  URLSession + Task.swift
//  VIPER_Example
//
//  Created by Hussam Elsadany on 17/07/2022.
//

import Foundation
import CoreError

typealias DataResult = Result<Data, CoreError>

extension URLSession {
   
   func dataTask(with request: URLRequest, completion: @escaping (DataResult) -> Void) -> URLSessionDataTask {
       
       return self.dataTask(with: request) { data, response, error in
           
           if let error = CoreError(data: data, response: response, error: error) {
               completion(.failure(error))
               return
           }
           else if let data = data {
               completion(.success(data))
           }
           else {
               completion(.failure(.request(code: "\(URLError.unknown.rawValue)")))
           }
           
       }
   }
}
