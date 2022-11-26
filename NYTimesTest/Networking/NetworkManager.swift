//
//  NetworkManager.swift
//  NYTimesTest
//
//  Created by Kito on 11/26/22.
//

import Alamofire

final class NetworkManager {
    
    func fetch<T: Decodable>(_ list: [String], of: T.Type, completion: @escaping ([T]) -> Void) {
        var items: [T] = []
        
        let fetchGroup = DispatchGroup()
        
        list.forEach { (url) in
            
            fetchGroup.enter()
            
            let parametrs = ["api-key": UserConstants.apiKey]
            AF.request(url, parameters: parametrs).validate().responseDecodable(of: T.self) { (response) in
                if let value = response.value {
                    items.append(value)
                }
                fetchGroup.leave()
            }
        }
        
        fetchGroup.notify(queue: .main) {
            completion(items)
        }
    }
}
