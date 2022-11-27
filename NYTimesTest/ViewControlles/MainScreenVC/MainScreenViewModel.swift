//
//  MainScreenViewModel.swift
//  NYTimesTest
//
//  Created by Kito on 11/24/22.
//

import Foundation

final class MainScreenViewModel {
    
    var sectionsData: [SectionModel] = []
    var onUpdate:(() -> Void)?
    
    func sendMultiplyRequest() {
        let nm = NetworkManager()
        
        nm.fetch([UserConstants.emailedUrlPath,
                  UserConstants.sharedUrlPath,
                  UserConstants.viewedUrlPath],
                 of: NewsResponceModel.self) { [weak self] items in
            
            self?.sectionsData = []
            
            for index in 0..<items.count {
                let cellData = items[index].results.compactMap { model in
                    return CellDataModel(responceData: model)
                }
                
                let sectionModel = SectionModel(num_result: items[index].num_results,
                                                data: cellData,
                                                index: index)
                self?.sectionsData.append(sectionModel)
            }
            self?.syncCoreDataWithCurrentNews()
        }
    }
    
    func onSectionTap(section: Int) {
        sectionsData[section].isOpen = !sectionsData[section].isOpen
        onUpdate?()
    }
    
    func onFavoriteButtonTapped(at indexPath: IndexPath) {
        let dbManager = NewsLocalStorageManager()
        
        sectionsData[indexPath.section].data[indexPath.row].isSaved = !sectionsData[indexPath.section].data[indexPath.row].isSaved
        
        let sectionTitle = sectionsData[indexPath.section].title
        let article = sectionsData[indexPath.section].data[indexPath.row]
        
        if sectionsData[indexPath.section].data[indexPath.row].isSaved {
            dbManager.saveNewToCoreDataEntity(articleToSave: article, entityName: sectionTitle)
        } else {
            dbManager.deleteNewFromCoreDataEntity(title: article.title, entityName: sectionTitle)
        }
        
        onUpdate?()
    }
    
    func syncCoreDataWithCurrentNews() {
        let dbManager = NewsLocalStorageManager()
        
        //loop in sections
        for section in 0..<sectionsData.count {
            guard let savedNews = dbManager.fetchNewsFromCoreData(entityName: sectionsData[section].title) else { return }
            
            // set false for all news in section
            for index in 0..<sectionsData[section].data.count {
                self.sectionsData[section].data[index].isSaved = false
            }
            
            // loop in saved to coreData news and search by title
            for savedNew in savedNews {
                for index in 0..<sectionsData[section].data.count {
                    if savedNew.title == self.sectionsData[section].data[index].title {
                        self.sectionsData[section].data[index].isSaved = true
                    }
                }
            }
        }
        
        onUpdate?()
    }
}
