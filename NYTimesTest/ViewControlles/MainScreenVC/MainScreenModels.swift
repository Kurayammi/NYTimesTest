//
//  MainScreenModels.swift
//  NYTimesTest
//
//  Created by Kito on 11/26/22.
//

import Foundation

struct CellDataModel {
    var url: URL
    var source: String
    var section: String
    var published_date: String
    var title: String
    var abstract: String
    var isSaved = false
    
    init(responceData: DataResponceModel) {
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
        case 0: return "Emailed"
        case 1: return "Shared"
        case 2: return "Viewed"
        default: return ""
        }
    }
    
}
