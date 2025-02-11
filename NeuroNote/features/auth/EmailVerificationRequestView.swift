
import SwiftUI

struct EmailVerificationRequestView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        ScrollView{
           
            Spacer()
            
            VStack{
                
                HStack{
                    TitleView.init(title: "Email Verification",
                                   subTitle: "Please check your email for an OTP to verify your email",
                                   successMessage: .constant(""),
                                   errorMessage: .constant(""))
                    Spacer()
                }.padding(EdgeInsets(top: 50, leading: 0, bottom: 40, trailing: 0))
                
                
            }
            
            
            Spacer()
            
            
            CircularLoadingButton(title: "Open Gmail",
                                  isLoading: .constant(false),
                                  action: .constant({
                
               
                
            }))
            
            CircularLoadingButton(title: "Open Outlook",
                                  isLoading: .constant(false),
                                  action: .constant({
                
               
                
            }))
            
            
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
    EmailVerificationRequestView()
}
