//
//  UseCases.swift
//  coredataDemo
//
//  Created by Chandrakant  Kondke on 28/05/24.
//

import Foundation

class FetchPersonsUseCase {
    private let repository: PersonRepository
    
    init(repository: PersonRepository) {
        self.repository = repository
    }
    
    func execute() throws -> [Person] {
        return try repository.fetchPersons()
    }
}

class AddPersonUseCase {
    private let repository: PersonRepository
    
    init(repository: PersonRepository) {
        self.repository = repository
    }
    
    func execute(name: String, age: Int16, gender: String) throws {
        try repository.addPerson(name: name, age: age, gender: gender)
    }
}

class DeletePersonsUseCase {
    private let repository: PersonRepository
    
    init(repository: PersonRepository) {
        self.repository = repository
    }
    
    func execute(persons: [Person]) throws {
        try repository.deletePersons(persons)
    }
}
