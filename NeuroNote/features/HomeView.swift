// HomeView.swift
import SwiftUI

struct HomeView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Dashboard")
                }
            
            RemindersView()
                .tabItem {
                    Image(systemName: "bell.fill")
                    Text("Reminders")
                }
            
            ScanView()
                .tabItem {
                    Image(systemName: "camera.viewfinder")
                    Text("Scan")
                }
            
            NotesView()
                .tabItem {
                    Image(systemName: "note.text")
                    Text("Notes")
                }
            
            UserProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    HomeView()
}
