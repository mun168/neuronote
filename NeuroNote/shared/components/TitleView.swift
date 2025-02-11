

import SwiftUI

public struct TitleView: View {
    public var title: String
    public var subTitle: String
    @Binding var successMessage: String?
    @Binding var errorMessage: String?
    
    
   public init(title: String,
         subTitle: String,
         successMessage: Binding<String?>,
         errorMessage: Binding<String?>) {
        self.title = title
        self.subTitle = subTitle
        self._successMessage = successMessage
        self._errorMessage = errorMessage
    }

//
//    init(title: String,
//         subTitle: String,
//         successMessage: Binding<String?>? = nil,
//         errorMessage:  Binding<String?>? = nil) {
//        self.title = title
//        self.subTitle = subTitle
//        self.successMessage = successMessage
//        self.errorMessage = errorMessage
//    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 5){
            
            Text(title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(Color("primary"))
            
             if let errorMessage = errorMessage,
                errorMessage.count > 0 {
                 Text(errorMessage)
                     .font(.system(size: 14))
                     .foregroundColor(Color("materialErrorRed"))

             }else if let successMessage = successMessage,
                      successMessage.count > 0{
                 Text(successMessage)
                     .font(.system(size: 14))
                     .foregroundColor(Color("primary.light"))
             }else{
                 Text(subTitle)
                     .font(.system(size: 14))
             }
            
            Spacer().frame(height: CGFloat(15))
            
        }
    }
}


struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading){
            TitleView(title: "Sign In",
                      subTitle: "Welcome Back",
                      successMessage: .constant(nil), errorMessage: .constant(nil))
        }.padding()
    }
}
