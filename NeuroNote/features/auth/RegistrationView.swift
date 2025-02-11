

import SwiftUI
import CountryPicker



struct RegistrationView: View {
    
    @State var pageIndex = 0
    @State var pageCount = 2
    @AppStorage("isDarkMode") private var isDarkMode = false

    
    var maxPageIndex: Int {
        return pageCount-1
    }

    var body: some View {
        ScrollView{
           
            Spacer()
            
            VStack{
                
                HStack{
                    TitleView.init(title: "Sign Up",
                                   subTitle: "Please fill in your account details",
                                   successMessage: .constant(""),
                                   errorMessage: .constant(""))
                    Spacer()
                }.padding(EdgeInsets(top: 50, leading: 0, bottom: 40, trailing: 0))
                
                
                
                if(pageIndex == 0){
                    
                    // registration Page One
                    VStack{
                        HStack{
                            
                            FloatingMenu(title: "Title",
                                              selectedValue: .constant("Mr"),
                                              elements: .constant(["Mr", "Mrs", "Miss"])) { element in
                                Text(element)
                            }
                            
                            FloatingTextField(title: "First Name",
                                              prefixText: .constant("icon.envelope"),
                                              text: .constant(""),
                                              isRequired: true,
                                              errorMessage: "")
                            .padding(.bottom)
                        }
                        
                        FloatingTextField(title: "Middle Name",
                                          prefixText: .constant("icon.envelope"),
                                          text: .constant(""),
                                          isRequired: true,
                                          errorMessage: "")
                        .padding(.bottom)
                        
                        
                        
                        FloatingTextField(title: "Last Name",
                                          prefixText: .constant("icon.envelope"),
                                          text: .constant(""),
                                          isRequired: true,
                                          errorMessage: "")
                        .padding(.bottom)
                        
                    
                        FloatingTextField(title: "Email",
                                          prefixText: .constant("icon.envelope"),
                                          text: .constant(""),
                                          isRequired: true,
                                          errorMessage: "")
                        .padding(.bottom)
                    }
                    
                
                    
                }else if(pageIndex == 1){
                    
                    
                    // registration Page 2

                    VStack{
                        FloatingCountryPicker(title: "Phone Number",
                                           isPhoneNumberPicker: true,
                                              terminalPhoneNumber: .constant(""),
                                              countryIsoCodes: .constant(["ZW", "ZA", "KE", "MW", "BW"]),
                                              selectedCountry: .constant(CountryManager.shared.findCountry(isCode: "ZW")), isRequired: false)
                        .padding(.bottom)

                        
                        FloatingTextField(title: "Password",
                                          prefixText: .constant("icon.lock"),
                                          text: .constant(""),
                                          isRequired: true,
                                          errorMessage: "",
                                          isSecure: .constant(true))
                        .padding(.bottom)
                        
                    
                        FloatingTextField(title: "Confirm Password",
                                          prefixText: .constant("icon.lock"),
                                          text: .constant(""),
                                          isRequired: true,
                                          errorMessage: "",
                                          isSecure: .constant(true))
                        .padding(.bottom)
                    }
                    
                }
                
               
            }
            
            
            Spacer()
            
            PageControlView(pageIndex: $pageIndex, pageCount: $pageCount){ indicatorIndex in
                
                pageIndex = indicatorIndex
                
            }
            
            CircularLoadingButton(title: pageIndex == 0 ? "Next" : "Submit",
                                  isLoading: .constant(false),
                                  action: .constant({
                
                
                if(pageIndex < maxPageIndex){
                    pageIndex += 1
                }
                
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
    RegistrationView()
}
