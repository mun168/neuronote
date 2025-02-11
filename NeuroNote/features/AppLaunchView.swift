

import SwiftUI

struct AppLaunchView: View {
    
    @State var isActive: Bool = false
    @ObservedObject var authManager = AuthManager.sharedManager
    
    var body: some View {
        
        ZStack{
            if(isActive){
                HomeView()
            }else{
                SplashScreen()
            }
            
        }.onAppear{
            
            
            authManager.refreshMe().sink { error in
                isActive = true
            } receiveValue: { responseDto in
                isActive = true

            }.store(in: &authManager.subscriptions)

        }
    }
}

#Preview {
    AppLaunchView()
}
