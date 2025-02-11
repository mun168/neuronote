
import SwiftUI

public struct FloatingTextField: View {
    
    @FocusState private var isTextfieldInSatus: Bool
    @FocusState private var isLabelInFocus: Bool

    @State public var isFocused: Bool = false
    public var title: String;
    @Binding public var prefixText: String
    @Binding public var text: String;
    public var isRequired: Bool;
    public var errorMessage: String?;

    public var isNested: Bool = false;
    @Binding public var isSecure: Bool
    public var isToHighlightOnError: Bool = false;

  
   public init(title: String,
               prefixText: Binding<String>,
               text: Binding<String>,
               isRequired: Bool,
               errorMessage: String? = nil,
               isNested: Bool = false,
               isSecure: Binding<Bool> = .constant(false),
               isToHighlightOnError: Bool = false) {
        
        self.title = title
        self._prefixText = prefixText
        self._text = text
        self.isRequired = isRequired
        self.errorMessage = errorMessage
        self.isNested = isNested
        self._isSecure = isSecure
        self.isToHighlightOnError = isToHighlightOnError

    }

    public var body: some View {
        
        VStack(alignment: .leading){
            
            ZStack(alignment: .leading) {
               
                // MARK: Textfield Proper
                HStack(spacing: 0){

                    if(!prefixText.isEmpty){
                        
                        
                        if(prefixText.starts(with: "icon.")){
                            Image(systemName: prefixText.replacingOccurrences(of: "icon.", with: ""))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2))
                                .foregroundColor(isFocused ? Color.black : Color.gray)
                        }else{
                            
                            Text(prefixText)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2))

                                .foregroundColor(Color.black)
                        }
                                
                    }
                    
                    
                    if(isSecure){
                        SecureField("", text: $text)
                        .multilineTextAlignment(.leading)
                        .focused($isTextfieldInSatus) //Actual Text Field
                             .cornerRadius(4.0)
                             .foregroundColor(Color.black)
                    }else{
                        TextField("", text: $text, onEditingChanged: { isInFocus in
                            isFocused = isInFocus
                        })
                        .multilineTextAlignment(.leading)
                        .focused($isTextfieldInSatus) //Actual Text Field
                             .cornerRadius(4.0)
                             .foregroundColor(Color.black)
                    }
                    
                    if let errorMessage = errorMessage,
                       !errorMessage.isEmpty{
                        Image(systemName: "exclamationmark.circle.fill")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2))

                            .foregroundColor(Color("materialErrorRed"))
                    }
                    
                    
            }
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                .offset(x: 0, y: 2)
                
                
                // MARK: Floating Title
                HStack(spacing:2){
                    Text(title) // Label
                        .foregroundColor(isFocused ? Color.black : Color.gray)
                
                if(isRequired){
                    Text("*").font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color("requiredRed"))
                }
                }.focused($isLabelInFocus)
                    .offset(x: CGFloat(prefixText.isEmpty || !$text.wrappedValue.isEmpty ? 0 : -11 + ((prefixText.starts(with: "icon.") ? 2 : prefixText.count)  * 19)),
                            y: !isFocused && $text.wrappedValue.isEmpty ? 2 : -20)
                    .scaleEffect(!isFocused && $text.wrappedValue.isEmpty ? 1 : 0.7, anchor: .zero)
                    .onTapGesture {
                        isFocused = true
                        isTextfieldInSatus = true
                    }
                  
            .padding(EdgeInsets(top: 5, leading:5, bottom: 0, trailing: 10))
    //                .animation(.spring(response: 0.2, dampingFraction: 1))
                
            }
            .padding()
            .overlay( //
                    //// apply a rounded border
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(errorMessage != nil && !(errorMessage!.isEmpty) && isToHighlightOnError ?  Color("materialErrorRed") : (isFocused ? Color("primary.light" ) : Color.white), lineWidth: 1)
                )
            .background(Color.white)

//            .border(isFocused ? Color.primary : Color.red)
            .cornerRadius(100)
//            

            if let errorMessage = errorMessage,
               !errorMessage.isEmpty{
                Text(errorMessage)
                    .foregroundColor(Color("materialErrorRed"))
                    .font(.system(size: 12))
                    .padding(EdgeInsets(top: -6, leading: 12, bottom: 0, trailing: 0))
                    .animation(.spring(response: 1,
                                       dampingFraction: 0.5,
                                       blendDuration: 0.5),
                               value: 0.5)

            }
        }
        
    }
}


struct FloatingTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16){
            ScrollView{
              
                Group{
                    
                    TextField.init(text: .constant("Hello world")) {
                        Text("Please work!!")
                    }
                    
                    
                    FloatingTextField(title: "First Name",
                                      prefixText: .constant("$"),
                                      text: .constant("This is some Text"),
                                      isRequired: true,
                                      errorMessage: "", isToHighlightOnError: true)
                    
                   
                    FloatingTextField(title: "First Name",
                                      prefixText: .constant("$"),
                                      text: .constant("This is some Text"),
                                      isRequired: false,
                                      errorMessage: "Field is required")

                    
                    
                    FloatingTextField(title: "First Name",
                                      prefixText: .constant("icon.envelope"),
                                      text: .constant(""),
                                      isRequired: true,
                                      errorMessage: "Field is required")
                    
                    
                    FloatingTextField(title: "First Name",
                                      prefixText: .constant("$"),
                                      text: .constant(""),
                                      isRequired: false,
                                      errorMessage: "Field is required")
                    
                    
                    FloatingTextField(title: "First Name",
                                      prefixText: .constant(""),
                                      text: .constant("This is some Text"),
                                      isRequired: true,
                                      errorMessage: "Field is required")
                    
                    FloatingTextField(title: "First Name",
                                      prefixText: .constant(""),
                                      text: .constant("This is some Text"),
                                      isRequired: false,
                                      errorMessage: "Field is required")
                    
                    FloatingTextField(title: "First Name",
                                      prefixText: .constant(""),
                                      text: .constant(""),
                                      isRequired: true,
                                      errorMessage: "Field is required")
                    
                    FloatingTextField(title: "First Name",
                                      prefixText: .constant(""),
                                      text: .constant(""),
                                      isRequired: false,
                                      errorMessage: "Field is required")
                    
                    FloatingTextField(title: "",
                                      prefixText: .constant("$"),
                                      text: .constant("This is some Text"),
                                      isRequired: true,
                                      errorMessage: "Field is required")
                    
                    FloatingTextField(title: "",
                                      prefixText: .constant("$"),
                                      text: .constant("This is some Text"),
                                      isRequired: false,
                                      errorMessage: "Field is required")
                    
                }
                
                Group{
                    FloatingTextField(title: "",
                                      prefixText: .constant("$"),
                                      text: .constant(""),
                                      isRequired: true,
                                      errorMessage: "Field is required")
                    
                    FloatingTextField(title: "",
                                      prefixText: .constant("$"),
                                      text: .constant(""),
                                      isRequired: false,
                                      errorMessage: "Field is required")
                    
                    FloatingTextField(title: "",
                                      prefixText: .constant(""),
                                      text: .constant("This is some Text"),
                                      isRequired: true,
                                      errorMessage: "Field is required")
                    
                    FloatingTextField(title: "",
                                      prefixText: .constant(""),
                                      text: .constant("This is some Text"),
                                      isRequired: false,
                                      errorMessage: "Field is required")
                    
                    
                    FloatingTextField(title: "",
                                      prefixText: .constant(""),
                                      text: .constant(""),
                                      isRequired: true,
                                      errorMessage: "Field is required")
                    
                    
                    FloatingTextField(title: "",
                                      prefixText: .constant(""),
                                      text: .constant(""),
                                      isRequired: false,
                                      errorMessage: "Field is required")
                }
            }

        }.preferredColorScheme(.light).padding().background(Color("secondary"))
    }
}
