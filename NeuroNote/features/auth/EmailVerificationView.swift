
import SwiftUI

struct EmailVerificationView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        ScrollView{
           
            Spacer()
            
            VStack{
                
                HStack{
                    TitleView.init(title: "Email Verification",
                                   subTitle: "Please enter the OTP you received in your email",
                                   successMessage: .constant(""),
                                   errorMessage: .constant(""))
                    Spacer()
                }.padding(EdgeInsets(top: 50, leading: 0, bottom: 40, trailing: 0))
                
                
                OTPInputView.init(digitCount: .constant(6),
                                  text: .constant([""]))
                
                
                HStack{
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("Resend OTP?")
                            .foregroundColor(Color.black)
                            .underline()
                            
                    }
                }.padding([.top, .bottom, .trailing])
               
            }
            
            
            Spacer()
            
            
            CircularLoadingButton(title: "Submit",
                                  isLoading: .constant(false),
                                  action: .constant({
                
               
                
            })).padding(EdgeInsets(top: 50, leading: 0, bottom: 40, trailing: 0))
            
            Spacer()
            
            VStack{
                Text("By using this app you accept these")
                Button(action: {
                    
                }) {
                    Text("Terms, conditions and privacy policy")
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .underline()
                        
                }
            }.padding(.top)
            
        }.padding()
            .background(Color("secondary"))
            .preferredColorScheme(isDarkMode ? .dark : .light)

    }
}

#Preview {
    EmailVerificationView()
}
