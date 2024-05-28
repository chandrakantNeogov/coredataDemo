//
//  Person+CoreDataProperties.swift
//  coredataDemo
//
//  Created by Chandrakant  Kondke on 27/05/24.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var gender: String?

}

extension Person : Identifiable {

}
