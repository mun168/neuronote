//
//  NotesView.swift
//  NeuroNote
//
//  Created by Munashe Chibaya on 11/2/2025.
//

// NotesView.swift
import SwiftUI

struct NotesView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Visual Notes")) {
                    Text("Grocery list photo")
                    Text("Bookshelf organization")
                }
                
                Section(header: Text("Audio Notes")) {
                    Text("Meeting ideas recording")
                    Text("Project brainstorm")
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                Button(action: {}) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    NotesView()
}
