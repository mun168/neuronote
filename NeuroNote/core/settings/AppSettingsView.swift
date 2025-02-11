
import SwiftUI

struct AppSettingsView: View {
    
    @Environment(\.presentationMode)
       var presentationMode: Binding<PresentationMode>
    
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        NavigationView{
            
            Form{
                
                
                Section(header: Text("Connection Settings")) {

                    Toggle(isOn: $isDarkMode) {
                            Text("Dark Mode")
                        }
            }
                
                
             }.padding()
                .navigationBarTitle("App Settings")
                .navigationBarItems(leading: Button(action: {
                    
                }){
                    Text("Clear")
                        .foregroundColor(Color.red)
                })
                .navigationBarItems(trailing: Button("Done"){
                    self.presentationMode.wrappedValue.dismiss()
                })
            }

    }
}

#Preview {
    AppSettingsView()
}
