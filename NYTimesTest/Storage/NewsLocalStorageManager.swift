//
//  NewsLocalStorageManager.swift
//  NYTimesTest
//
//  Created by Kito on 11/26/22.
//

import CoreData
import UIKit

final class NewsLocalStorageManager {
    
    private var managedContext: NSManagedObjectContext?  {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return nil }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        return managedContext
    }
    
    func saveNewToCoreDataEntity(articleToSave: CellDataModel, entityName: String) {
        
        print("start save to coreData")
        
        guard let managedContext = managedContext else { return}
        guard let entity = NSEntityDescription.entity(forEntityName: entityName,
                                                      in: managedContext) else { return }
        
        let article = NSManagedObject(entity: entity,
                                      insertInto: managedContext)
        
        article.setValue(articleToSave.title, forKey: "title")
        article.setValue(articleToSave.abstract, forKey: "abstract")
        article.setValue(articleToSave.published_date, forKey: "published_date")
        article.setValue(articleToSave.section, forKey: "section")
        article.setValue(articleToSave.source, forKey: "source")
        article.setValue(articleToSave.url, forKey: "url")
        article.setValue(articleToSave.isSaved, forKey: "isSaved")
        
        do {
            try managedContext.save()
            print("CoreData saved")
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchNewsFromCoreData(entityName: String) -> [CellDataModel]? {
        
        print("start fetch from coreData")
        guard let managedContext = managedContext else { return nil}
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            var articles =  [CellDataModel]()
            
            let fetchedArticles = try managedContext.fetch(fetchRequest)
            
            for fetched in fetchedArticles {
                
                let newArticle = CellDataModel(url: fetched.value(forKey: "url") as! URL,
                                               source: fetched.value(forKey: "source") as! String,
                                               section: fetched.value(forKey: "section") as! String,
                                               published_date: fetched.value(forKey: "published_date") as! String,
                                               title: fetched.value(forKey: "title") as! String,
                                               abstract: fetched.value(forKey: "abstract") as! String,
                                               isSaved: fetched.value(forKey: "isSaved") as! Bool)
                articles.append(newArticle)
            }
            
            return articles
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return nil
        
    }
    
    func deleteNewFromCoreDataEntity(title: String, entityName: String) {
        
        print("Start delete from CoreData")
        
        guard let managedContext = managedContext else { return}
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let pred = NSPredicate(format: "title=%@", title)
        
        fetchRequest.predicate = pred
        
        do {
            let articles = try managedContext.fetch(fetchRequest)
            if !articles.isEmpty,
               let objectDelete = articles[0] as? NSManagedObject {
                managedContext.delete(objectDelete)
            }
            
            try managedContext.save()
            print("CoreData saved")
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
