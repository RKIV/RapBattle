//
//  CoreDataHelper.swift
//  RapApp
//
//  Created by Michael Hayashi on 7/19/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//


import UIKit
import CoreData

struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    static func newRapNote() -> RapNote {
        let rapNote = NSEntityDescription.insertNewObject(forEntityName: "rapNote", into: context) as! RapNote
        
        return rapNote
    }
    
    static func saveRapNote() {
        do {
            try context.save()
        } catch let error {
            print ("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(rapNote: RapNote) {
        context.delete(rapNote)
        
        saveRapNote()
    }
    
    static func retrieveRapNotes() -> [RapNote] {
        do {
            let fetchRequest = NSFetchRequest<RapNote>(entityName: "rapNote")
            let results = try context.fetch(fetchRequest)
            
            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
    
}
