

import SwiftUI

struct PhoneVerificationSuccessView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        ScrollView{
           
            Spacer()
            
            VStack{
                
                HStack{
                    TitleView.init(title: "Phone Verification",
                                   subTitle: "Phone verified Successfully",
                                   successMessage: .constant(""),
                                   errorMessage: .constant(""))
                    Spacer()
                }.padding(EdgeInsets(top: 50, leading: 0, bottom: 40, trailing: 0))
                
                Image("auth-success")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
               
               
            }
            
            
            Spacer()
            
            
            CircularLoadingButton(title: "Login",
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
    PhoneVerificationSuccessView()
}
