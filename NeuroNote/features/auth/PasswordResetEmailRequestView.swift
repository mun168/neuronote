

import SwiftUI

struct PasswordResetEmailRequestView: View {
    @Environment(\.dismiss) var dismiss

    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        VStack{
           
            Spacer()
            
            VStack{
                
                HStack{
                    TitleView.init(title: "Forgot your Password?",
                                   subTitle: "Please enter the email you used to signup for an account",
                                   successMessage: .constant(""),
                                   errorMessage: .constant(""))
                    Spacer()
                }.padding(EdgeInsets(top: 50, leading: 0, bottom: 40, trailing: 0))
                
                
                FloatingTextField(title: "Email",
                                  prefixText: .constant("icon.envelope"),
                                  text: .constant(""),
                                  isRequired: true,
                                  errorMessage: "")
                .padding(.bottom)
                
                
            }
            
            
            Spacer()
            
            CircularLoadingButton(title: "Submit",
                                  isLoading: .constant(false),
                                  action: .constant({}))
            
            HStack{
                Text("Remembered your password?")
                Button(action: {
                    dismiss()
                }) {
                    Text("Sign In")
                        .foregroundColor(Color("primary.light"))
                        .underline()
                        
                }
            }.padding([.top, .bottom])
            
            
            Spacer()
            
            
        }.padding()
            .background(Color("secondary"))
            .preferredColorScheme(isDarkMode ? .dark : .light)

    }

}

#Preview {
    PasswordResetEmailRequestView()
}
