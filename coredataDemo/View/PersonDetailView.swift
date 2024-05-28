//
//  PersonDetailView.swift
//  coredataDemo
//
//  Created by Chandrakant  Kondke on 28/05/24.
//

import Foundation
import SwiftUI
import CoreData

struct PersonDetailView: View {
    let person: Person

    var body: some View {
        VStack {
            Text("Name: \(person.name ?? "Unknown")")
                .font(.title)
                .padding()

            Text("Age: \(person.age)")
                .font(.body)
                .padding()

            Text("Gender: \(person.gender ?? "Unknown")")
                .font(.body)
                .padding()

            Spacer()
        }
        .navigationTitle("Person Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
