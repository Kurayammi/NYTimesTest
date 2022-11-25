//
//  MainScreenViewModel.swift
//  NYTimesTest
//
//  Created by Kito on 11/24/22.
//

import Foundation
import Alamofire

struct MainScreenModel: Decodable {
    var num_results: Int
    var results: [NewsResponceModel]
}

struct NewsResponceModel: Decodable {
    var url: URL
    var source: String
    var section: String
    var published_date: String
    var title: String
    var abstract: String
}

struct SectionModel {
    var isOpen = false
    var num_result: Int
    var data: [NewsResponceModel]
}

final class MainScreenViewModel {
    
    var sectionsData: [SectionModel] = []
    
    var onUpdate:(() -> Void)?
    
    func sendRequest(for url: String = "") {
        let apiKey = UserConstants.apiKey
        let url = UserConstants.emailedUrlPath
        
        let parametrs = ["api-key": apiKey]
        print("Start request")
        AF.request(url, parameters: parametrs)
            .validate()
            .responseDecodable(of: MainScreenModel.self) {
                (responce) in
                guard let articles = responce.value else {return}
                print(articles)
                
                let sectionModel = SectionModel(num_result: articles.num_results,
                                                data: articles.results)
                self.sectionsData.append(sectionModel)
                print(self.sectionsData[0].num_result)
                self.onUpdate?()
            }
        
        print("Stop request")
    }
    
    func onSectionTap(section: Int) {
        sectionsData[section].isOpen = !sectionsData[section].isOpen
        onUpdate?()
    }
}
