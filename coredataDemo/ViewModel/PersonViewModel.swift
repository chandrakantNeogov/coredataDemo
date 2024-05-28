//
//  PersonViewModel.swift
//  coredataDemo
//
//  Created by Chandrakant  Kondke on 27/05/24.
//

import Foundation
import SwiftUI
import CoreData
class PersonViewModel: ObservableObject {
    @Published var persons: [Person] = []
    
    private let fetchPersonsUseCase: FetchPersonsUseCase
    private let addPersonUseCase: AddPersonUseCase
    private let deletePersonsUseCase: DeletePersonsUseCase
    
    init(fetchPersonsUseCase: FetchPersonsUseCase,
         addPersonUseCase: AddPersonUseCase,
         deletePersonsUseCase: DeletePersonsUseCase) {
        self.fetchPersonsUseCase = fetchPersonsUseCase
        self.addPersonUseCase = addPersonUseCase
        self.deletePersonsUseCase = deletePersonsUseCase
        fetchPersons()
    }
    
    func fetchPersons() {
        do {
            persons = try fetchPersonsUseCase.execute()
        } catch {
            print("Failed to fetch persons: \(error)")
        }
    }
    
    func addPerson(name: String, age: Int16, gender: String) {
        withAnimation {
           
            do {
                try addPersonUseCase.execute(name: name, age: age, gender: gender)
                fetchPersons()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func deletePerson(at offsets: IndexSet) {
        withAnimation {
            let personsToDelete = offsets.map { persons[$0] }
            
            do {
                try deletePersonsUseCase.execute(persons: personsToDelete)
                fetchPersons()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func deleteAllPersons() {
        withAnimation {
            do {
                try deletePersonsUseCase.execute(persons: persons)
                fetchPersons()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
