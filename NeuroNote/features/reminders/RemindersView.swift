//
//  RemindersView.swift
//  NeuroNote
//
//  Created by Munashe Chibaya on 11/2/2025.
//

// RemindersView.swift
import SwiftUI

struct RemindersView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Location-Based")) {
                    Text("Buy groceries when near store")
                    Text("Pick up prescription at pharmacy")
                }
                
                Section(header: Text("Task Reminders")) {
                    Text("Doctor appointment at 2 PM")
                    Text("Take medication after lunch")
                }
            }
            .navigationTitle("Reminders")
            .toolbar {
                Button(action: {}) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    RemindersView()
}
