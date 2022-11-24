//
//  MainScreenViewModel.swift
//  NYTimesTest
//
//  Created by Kito on 11/24/22.
//

import Foundation
import Alamofire

final class MainScreenViewModel {
    
    func sendRequest() {
        let apiKey = UserConstants.apiKey
        let url = UserConstants.emailedUrlPath
        
        let parametrs = ["api-key": apiKey]
        let request = AF.request(url, parameters: parametrs)
        
        request.response { data in
            print(data)
        }
    }
}
