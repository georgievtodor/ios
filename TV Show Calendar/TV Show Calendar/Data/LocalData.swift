//
//  LocalData.swift
//  TV Show Calendar
//
//  Created by Todor on 4/2/17.
//  Copyright © 2017 Todor. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LocalData {
    let tvShowEntity = "TvShow"
    
    func getAll() -> [TvShow] {
        let tvShows = self.fetch(entityName: tvShowEntity) as? [TvShow]
    
        return tvShows ?? [TvShow]()
    }
    
    func save(tvShow: TvShowModelDelegate) {
        let entity = self.createEntity(for: tvShowEntity)
        let tvShowToAdd: TvShow = TvShow(entity: entity!, insertInto: self.context)
        tvShowToAdd.id = tvShow.id
        tvShowToAdd.name = tvShow.name
        tvShowToAdd.tvDescription = tvShow.description
        tvShowToAdd.imagePath = tvShow.imagePath
        tvShowToAdd.backDropPath = tvShow.backDropPath
        tvShowToAdd.rating = tvShow.rating
        
        self.context.insert(tvShowToAdd)
        self.appDelegate.saveContext()
    }
    
    var appDelegate: AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    var context: NSManagedObjectContext {
        get {
            return self.appDelegate.persistentContainer.viewContext
        }
    }
    
    func createEntity(for entityName: String) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: entityName, in: self.context)
    }
    
    func insert(_ object: NSManagedObject) {
        self.context.insert(object)
    }
    
    func fetch(entityName: String)
        -> [Any]? {
            
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        let data = try? self.context.fetch(fetchRequest)
        return data
    }
    
    func saveContext() {
        self.appDelegate.saveContext()
    }
}