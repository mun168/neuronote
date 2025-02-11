// DashboardView.swift
import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Upcoming Reminders Section
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Upcoming Reminders")
                                .font(.headline)
                            Spacer()
                            Image(systemName: "bell.fill")
                        }
                        Divider()
                        Text("No upcoming reminders")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    
                    // Recent Notes Section
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Recent Notes")
                                .font(.headline)
                            Spacer()
                            Image(systemName: "note.text")
                        }
                        Divider()
                        Text("No recent notes")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
                .padding()
            }
            .navigationTitle("Dashboard")
        }
    }
}

#Preview {
    DashboardView()
}
