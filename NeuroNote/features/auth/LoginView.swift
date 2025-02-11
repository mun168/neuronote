

import SwiftUI

struct LoginView: View, BaseView {
    
    
    typealias SomeErrorMessages = InputErrorMessages
    
    @State var inputErrorMessages = InputErrorMessages()
    
    
    struct InputErrorMessages{
        var email = ""
        var password = ""
    }
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @ObservedObject var authManager = AuthManager.sharedManager
    
    
    
    
    @State var isToShowForgotPasswordView = false
    @State var isToShowRegistrationView = false
    @State var hasSubmitBeenPressed = false
    
    @ObservedObject var loginDto: LoginCredentials = LoginCredentials(email: "", password: "")

    var body: some View {
        VStack{
           
            Spacer()
            
            VStack{
                
                HStack{
                    TitleView(title: "Sign In",
                                   subTitle: "Welcome Back",
                                   successMessage: $authManager.successMessage,
                                   errorMessage: $authManager.errorMessage)
                    Spacer()
                }.padding(EdgeInsets(top: 50, leading: 0, bottom: 40, trailing: 0))
                
                
                FloatingTextField(title: "Email",
                                  prefixText: .constant("icon.envelope"),
                                  text: $loginDto.email,
                                  isRequired: true,
                                  errorMessage: inputErrorMessages.email)
                .padding(.bottom)
                .onChange(of: loginDto.email) {
                    _ = isValid()
                }
                
                FloatingTextField(title: "Password",
                                  prefixText: .constant("icon.lock"),
                                  text: $loginDto.password,
                                  isRequired: true,
                                  errorMessage: inputErrorMessages.password,
                                  isSecure: .constant(true))
                .padding(.bottom)
                .onChange(of: loginDto.password) {
                    _ = isValid()
                }
                
                HStack{
                    Spacer()
                    Button(action: {
                        isToShowForgotPasswordView = true
                    }) {
                        Text("Forgot Password")
                            .foregroundColor(Color.black)
                            .underline()
                            
                    }
                }
            }
            .fullScreenCover(isPresented: $authManager.isUserLoggedIn){
                HomeView()
            }
            
            Spacer()
            
            CircularLoadingButton(title: "Submit",
                                  isLoading: $authManager.isloading,
                                  action: .constant({
                submit()
            }))
            
            HStack{
                Text("Don't you have an account?")
                
                
                Button(action: {
                    isToShowRegistrationView = true
                }) {
                    Text("Sign Up")
                        .foregroundColor(Color("primary.light"))
                        .underline()
                        
                }.sheet(isPresented: $isToShowRegistrationView){
                    RegistrationView()
                }
                
                
//                NavigationLink.init {
//                    RegistrationView()
//                } label: {
//                    Text("Sign Up")
//                        .foregroundColor(Color("primary.light"))
//                        .underline()
//                }

            }.padding([.top, .bottom])
            
            
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
            .sheet(isPresented: $isToShowForgotPasswordView){
              PasswordResetEmailRequestView()
            }

    }
    
    
    func isValid() -> Bool{
        
        var isValid = true
        
        if(hasSubmitBeenPressed){
            

            if(loginDto.email.isEmpty){
                inputErrorMessages.email = "Email is Required"
                isValid = false
            }else if(!loginDto.email.isValidEmail()){
                inputErrorMessages.email = "Invalid Email"
                isValid = false
            }else{
                inputErrorMessages.email = ""
            }
            
            
            
            if(loginDto.password.isEmpty){
                inputErrorMessages.password = "Password is Required"
                isValid = false
            }else{
                inputErrorMessages.password = ""
            }
            
            
        }
        return isValid
        
    }
    
    
    /**
     ## Process Airtime Bill ##
     usage: Function to Process Airtime Bill
    */
    
 
    
    func submit(){
        
        hasSubmitBeenPressed = true
        
        if(isValid()){
            
           _ =  authManager.signIn(credentials: loginDto)
            
        }
        
    }
}

#Preview {
    LoginView()
}
