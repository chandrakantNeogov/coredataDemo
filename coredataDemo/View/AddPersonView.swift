//
//  AddPersonView.swift
//  coredataDemo
//
//  Created by Chandrakant  Kondke on 28/05/24.
//

import Foundation
import SwiftUI

struct AddPersonView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var gender: String = "male" // Default selection

    var onAdd: (String, Int16, String) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }
                
                
                Section(header: Text("Age")) {
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Gender")) {
                    Picker("Gender", selection: $gender) {
                        Text("Male").tag("male")
                        Text("Female").tag("female")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Add") {
                if let age = Int16(age) {
                    onAdd(name, age, gender)
                    presentationMode.wrappedValue.dismiss()
                } else {
                    
                }
            })
            .navigationBarTitle("Add Person", displayMode: .inline)
        }
    }
}

#Preview {
    AddPersonView { name, age, gender in
        // Preview action
    }
}

