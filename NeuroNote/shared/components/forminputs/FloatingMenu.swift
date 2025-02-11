

import SwiftUI

struct FloatingMenu<TValue, TView>: View where TValue: Hashable & CustomStringConvertible & Identifiable, TView: View
{
    
    var title = ""
    @Binding var selectedValue: TValue
    @Binding var elements: [TValue]
    @State var isMenuShown = false
    var onRenderElement: ((_ element: TValue) -> TView)?

    var body: some View {
        Menu {
            Picker(selection: $selectedValue, label: EmptyView()) {
                
                ForEach(elements){ singElement in
                    if let onRenderElement = onRenderElement {
                        onRenderElement(singElement)
                    }
                }
            
            }
        } label: {
            FloatingMenuLabel(title: title,
                              prefixText: .constant(""),
                              selection: selectedValue.description,
                         isRequired: true,
                              isToShowMenu: isMenuShown).multilineTextAlignment(.leading)
        }.onTapGesture {
             isMenuShown = true
        }
        .cornerRadius(50)
        
    }

}






struct FloatingMenuLabel: View {
    var title: String
    @Binding var prefixText: String
    var selection: String;
    var isRequired: Bool;
    @State var isToShowMenu = false
    var errorMessage: String?;


    var body: some View {
        HStack(spacing: 0){
            
            
            HStack(spacing: 0){
                
               
                FloatingTextField(title: title,
                                  prefixText: $prefixText,
                                  text: .constant(selection),
                                  isRequired: isRequired,
                                  errorMessage: errorMessage
                    ).disabled(true)
                    
                
                    Image(systemName: isToShowMenu ? "chevron.up" : "chevron.down")
                        .padding()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .background(Color.white)

            }.padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                .background(Color.white)

                
            
        }
        .cornerRadius(5)
        .onTapGesture {
                isToShowMenu = true
        }
    
    }
    
}


struct FloatingMenu_Previews: PreviewProvider {
    
    @State static var selectedMenuValue = "Cash"

    
    static var previews: some View {
        VStack{
            Spacer()
            FloatingMenu.init(title: "Payment Type",
                              selectedValue: $selectedMenuValue,
                              elements: .constant(["Cash", "Ecocash", "Bank Payment"])) { element in
                Text(element)
            }
            Spacer()
        }.padding()
            .background(Color("secondary"))
        
    }
}
