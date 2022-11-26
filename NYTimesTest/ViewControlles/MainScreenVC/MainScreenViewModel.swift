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

struct CellDataModel {
    var url: URL
    var source: String
    var section: String
    var published_date: String
    var title: String
    var abstract: String
    var isSaved = false
    
    init(responceData: NewsResponceModel) {
        self.url = responceData.url
        self.source = responceData.source
        self.section = responceData.section
        self.published_date = responceData.published_date
        self.title = responceData.title
        self.abstract = responceData.abstract
    }
    
    init(url: URL,
         source: String,
         section: String,
         published_date: String,
         title: String,
         abstract: String,
         isSaved: Bool) {
        
        self.url = url
        self.source = source
        self.section = section
        self.published_date = published_date
        self.title = title
        self.abstract = abstract
        self.isSaved = isSaved
    }
}

struct SectionModel {
    
    var isOpen = false
    var num_result: Int
    var data: [CellDataModel]
    
    let index: Int
    var title: String {
        switch index {
        case 0: return "Most Emailed"
        case 1: return "Most Shared"
        case 2: return "Most Viewed"
        default: return ""
        }
    }
    
}

final class MainScreenViewModel {
    
    var sectionsData: [SectionModel] = []
    
    var onUpdate:(() -> Void)?
    
    private let nm = NetworkManager()
    
    func sendMultiplyRequest() {
        nm.fetch([UserConstants.emailedUrlPath,
                  UserConstants.sharedUrlPath,
                  UserConstants.viewedUrlPath],
                 of: MainScreenModel.self) { [weak self] items in
            
            for index in 0..<items.count {
                let cellData = items[index].results.compactMap { model in
                    return CellDataModel(responceData: model)
                }
                
                let sectionModel = SectionModel(num_result: items[index].num_results,
                                                data: cellData,
                                                index: index)
                self?.sectionsData.append(sectionModel)
            }
            self?.onUpdate?()
        }
    }
    
    func onSectionTap(section: Int) {
        sectionsData[section].isOpen = !sectionsData[section].isOpen
        onUpdate?()
    }
    
    func onFavoriteButtonTapped(at indexPath: IndexPath) {
        sectionsData[indexPath.section].data[indexPath.row].isSaved = !sectionsData[indexPath.section].data[indexPath.row].isSaved
        onUpdate?()
    }
}
