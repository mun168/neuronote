
import SwiftUI

struct UserProfileView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        VStack {
            Text("User Profile")
        }.background(Color("secondary"))
            .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    UserProfileView()
}
