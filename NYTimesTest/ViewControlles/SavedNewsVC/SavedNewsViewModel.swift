//
//  SavedNewsViewModel.swift
//  NYTimesTest
//
//  Created by Kito on 11/26/22.
//

import Foundation

final class SavedNewsViewModel {
    var sectionsData: [SectionModel] = []
    var onUpdate:(() -> Void)?
    
    private let coreDataManager = NewsLocalStorageManager()
    
    func fetchFromCoreData() {
        sectionsData = []
        guard let emailed = coreDataManager.fetchNewsFromCoreData(entityName: "Emailed") else { return }
        guard let shared = coreDataManager.fetchNewsFromCoreData(entityName: "Shared") else { return }
        guard let viewed = coreDataManager.fetchNewsFromCoreData(entityName: "Viewed") else { return }
        
        sectionsData.append(SectionModel(num_result: emailed.count, data: emailed, index: 0))
        sectionsData.append(SectionModel(num_result: shared.count, data: shared, index: 1))
        sectionsData.append(SectionModel(num_result: viewed.count, data: viewed, index: 2))
        
        onUpdate?()
    }
    
    func onSectionTap(section: Int) {
        sectionsData[section].isOpen = !sectionsData[section].isOpen
        onUpdate?()
    }
    
    func onFavoriteButtonTapped(at indexPath: IndexPath) {
        sectionsData[indexPath.section].data[indexPath.row].isSaved = !sectionsData[indexPath.section].data[indexPath.row].isSaved
        
        let sectionTitle = sectionsData[indexPath.section].title
        let articleTitle = sectionsData[indexPath.section].data[indexPath.row].title
        
        coreDataManager.deleteNewFromCoreDataEntity(title: articleTitle, entityName: sectionTitle)
        fetchFromCoreData()
    }
}
