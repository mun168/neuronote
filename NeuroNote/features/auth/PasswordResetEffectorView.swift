
import SwiftUI

struct PasswordResetEffectorView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        VStack{
           
            Spacer()
            
            VStack{
                
                HStack{
                    TitleView.init(title: "Reset your password",
                                   subTitle: "Please enter your OTP and your new password",
                                   successMessage: .constant(""),
                                   errorMessage: .constant(""))
                    Spacer()
                }.padding(EdgeInsets(top: 50, leading: 0, bottom: 40, trailing: 0))
                
                OTPInputView.init(digitCount: .constant(6)
                                  , text: .constant([""]))
                .padding(EdgeInsets.init(top: 25,
                                         leading: 0,
                                         bottom: 25,
                                         trailing: 0))
                
                FloatingTextField(title: "Password",
                                  prefixText: .constant("icon.lock"),
                                  text: .constant(""),
                                  isRequired: true,
                                  errorMessage: "")
                .padding(.bottom)
                
                
                FloatingTextField(title: "Confirm Password",
                                  prefixText: .constant("icon.lock"),
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
    PasswordResetEffectorView()
}
