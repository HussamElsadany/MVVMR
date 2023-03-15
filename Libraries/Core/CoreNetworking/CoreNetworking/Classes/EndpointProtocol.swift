//
//  EndpointProtocol.swift
//
//  Created by Hussam Elsadany on 19/06/2022.
//

import Foundation

public protocol EndpointProtocol {
    var baseURL: String {get}
    var  path: String {get}
    var  method: HttpMethod {get}
    var  params: [String : String]? {get}
    var  body: [String : AnyObject]? {get}
    var  headers: [String : String]? {get}
    var cachingKey: String {get}
    func decoder<T: Codable>(type: T.Type) -> ResultDecoder<T>
}


public extension EndpointProtocol {
    
    var method: HttpMethod { .get }

    var params: [String : String]? { nil }
    
    var body: [String : AnyObject]? { nil }
    
    var headers: [String : String]? {  nil }

    var urlRequest: URLRequest? {
        guard var urlComponents = URLComponents(string: "\(baseURL)")
        else {return nil}
        
        let queryItems:[URLQueryItem] = params?.compactMap { URLQueryItem(name: $0.key, value: $0.value)} ?? []
        urlComponents.queryItems = queryItems
        urlComponents.path = path
        
        guard let url = urlComponents.url
        else {return nil}
        

        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = method.value
    

        
        if let body = body,
           let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) {
            urlRequest.httpBody = httpBody
        }

        return urlRequest
    }
    
    var cachingKey: String {
        let paramsKey = params?.values.joined(separator: "_") ?? "_"
        return "\(baseURL)\(path)\(paramsKey)"
    }
    
    
    func decoder<T: Codable>(type: T.Type) ->  ResultDecoder<T> {
        
        let decoder = ResultDecoder<T> { data in
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let value =  try jsonDecoder.decode(type, from: data)
            return value
        }
        
        return decoder
    }
    
}

