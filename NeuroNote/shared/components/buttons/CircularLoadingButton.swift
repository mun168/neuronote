
import SwiftUI
import LoadingButton

struct CircularLoadingButton: View{
    var title: String
    @Binding var isLoading: Bool
    @Binding var action : () -> Void
    var style = LoadingButtonStyle(width: UIScreen.main.bounds.width - 32,
                              height: 54,
                              cornerRadius: 50,
                              backgroundColor: Color("primary"),
                              loadingColor: Color("primary"),
                              strokeWidth: 5,
                                   strokeColor: .white)
    
    var body: some View {
        LoadingButton(action: action,
                         isLoading: $isLoading,
                         style: style) {
               Text(title).foregroundColor(Color.white)
           }
       }
}


struct CircularLoadingButton_Previews: PreviewProvider {
    @State static var isLoading = false

    static var previews: some View {
        VStack{
            CircularLoadingButton(title: "Submit",
                                  isLoading: $isLoading,
                                  action: .constant({}))
        }.padding()
    }
}
