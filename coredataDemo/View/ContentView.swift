//
//  ContentView.swift
//  coredataDemo
//
//  Created by Chandrakant  Kondke on 27/05/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var viewModel: PersonViewModel
    
    @State private var isShowingAddPersonSheet = false
    @State private var isShowingDeleteAllConfirmation = false
    
    
    init(context: NSManagedObjectContext) {
        let repository = CoreDataPersonRepository(context: context)
        let fetchPersonsUseCase = FetchPersonsUseCase(repository: repository)
        let addPersonUseCase = AddPersonUseCase(repository: repository)
        let deletePersonsUseCase = DeletePersonsUseCase(repository: repository)
        
        _viewModel = StateObject(wrappedValue: PersonViewModel(
            fetchPersonsUseCase: fetchPersonsUseCase,
            addPersonUseCase: addPersonUseCase,
            deletePersonsUseCase: deletePersonsUseCase
        ))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.persons) { person in
                    NavigationLink(destination: PersonDetailView(person: person)) {
                        Text(person.name ?? "Unknown")
                    }
                }
                .onDelete(perform: viewModel.deletePerson(at:))
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: { isShowingAddPersonSheet = true }) {
                        Label("Add Person", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    Button(action: { isShowingDeleteAllConfirmation = true }) {
                        Label("Delete All", systemImage: "trash")
                    }
                }
            }
            .alert(isPresented: $isShowingDeleteAllConfirmation){
                Alert(
                    title: Text("Delete All Persons"),
                    message: Text("Are you sure you want to delete all persons? This action cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        viewModel.deleteAllPersons()
                    },
                    secondaryButton: .cancel()
                )
            }
            
        }
        .sheet(isPresented: $isShowingAddPersonSheet) {
            AddPersonView { name, age, gender in
                viewModel.addPerson(name: name, age: age, gender: gender)
            }
        }
    }
}

#Preview {
    ContentView(context: PersistenceController.preview.container.viewContext)
}

