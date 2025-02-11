//
//  Untitled.swift
//  NeuroNote
//
//  Created by Munashe Chibaya on 11/2/2025.
//

// ScanView.swift
import SwiftUI

struct ScanView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                NavigationLink(destination: Text("Room Scanner View")) {
                    ScanFeatureCard(
                        title: "Room Scanner",
                        description: "Scan and locate items",
                        icon: "camera.viewfinder"
                    )
                }
                
                NavigationLink(destination: Text("Inventory Management View")) {
                    ScanFeatureCard(
                        title: "Inventory Manager",
                        description: "Track grocery items",
                        icon: "cart.fill"
                    )
                }
            }
            .padding()
            .navigationTitle("Scan & Inventory")
        }
    }
}

struct ScanFeatureCard: View {
    let title: String
    let description: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .padding()
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

#Preview {
    ScanView()
}
