//
//  Issue+CoreDataProperties.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 1/3/24.
//
//

import Foundation
import CoreData


extension Issue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Issue> {
        return NSFetchRequest<Issue>(entityName: "Issue")
    }

    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var date: Date?
    @NSManaged public var details: String?

}

extension Issue : Identifiable {

}
