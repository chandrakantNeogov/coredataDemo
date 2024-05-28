//
//  PersonRepository.swift
//  coredataDemo
//
//  Created by Chandrakant  Kondke on 28/05/24.
//

import Foundation
import CoreData

protocol PersonRepository {
    func fetchPersons() throws -> [Person]
    func addPerson(name: String, age: Int16, gender: String) throws
    func deletePersons(_ persons: [Person]) throws
}

class CoreDataPersonRepository: PersonRepository {
    private let viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
    }
    
    func fetchPersons() throws -> [Person] {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Person.name, ascending: true)]
        return try viewContext.fetch(request)
    }
    
    func addPerson(name: String, age: Int16, gender: String) throws {
        let newPerson = Person(context: viewContext)
        newPerson.name = name
        newPerson.age = age
        newPerson.gender = gender
        try viewContext.save()
    }
    
    func deletePersons(_ persons: [Person]) throws {
        persons.forEach(viewContext.delete)
        try viewContext.save()
    }
}
