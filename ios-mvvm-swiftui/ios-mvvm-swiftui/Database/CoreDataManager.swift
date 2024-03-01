//
//  CoreDataManager.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 1/3/24.
//

import CoreData

protocol DataManager: AnyObject {
    var viewContext: NSManagedObjectContext { get }
    
    func saveContext() -> Bool
    func getIssues() -> [Issue]
}

class CoreDataManager: DataManager {
    static let shared = CoreDataManager()
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private init() {
        persistentContainer = NSPersistentContainer(name: "ios_mvvm_swiftui")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Fail error: \(error)")
            }
        }
    }

    func saveContext() -> Bool {
        guard viewContext.hasChanges else { return false }

        do {
            try viewContext.save()
            return true
        } catch {
            let error = error as NSError
            fatalError("Fail error: \(error), \(error.userInfo)")
        }
    }
    
    func getIssues() -> [Issue] {
        let request: NSFetchRequest<Issue> = Issue.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
}

