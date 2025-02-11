

import SwiftUI

struct OTPInputView: View {
    
    @State var focusedIndex = -1
    @Binding var digitCount: Int
    @Binding var text: [String]
    
    
    
    var body: some View {
        HStack{
            ForEach.init(0..<digitCount, id: \.self) { singIndex in
                
                HStack(alignment: .center){
                    TextField("", text:
                            
                                Binding(
                                       get: { return getChar(atIndex: singIndex) },
                                       set: { (newValue) in
                                           setChar(newValue, at: singIndex)

                                       }
                                     )
                              
                              ,
                              onEditingChanged: { isInFocus in
                        focusedIndex = singIndex
                        setChar("", at: singIndex)

                    })
                    .fontWeight(.bold)
                    .padding(.all)
                    .foregroundColor(focusedIndex == singIndex ? Color.white : Color.black)
                }
                .frame(width: 45, height: 45)
                .background(focusedIndex == singIndex ? Color("primary.light") : Color(""))
                .cornerRadius(8)
                 
                    .overlay( //
                            //// apply a rounded border
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("primary.light") , lineWidth: 1)
                        )

            
            }
        }
    }
    
    func getChar(atIndex index: Int) -> String{
        
        let maxIndex = text.count - 1
        
        if(index <= maxIndex){
            return text[index]
        }else{
            text.append("")
            return ""
        }
    }
    
    
    func setChar(_ newText: String, at index:Int){
        
        var textArray = Array(text).map{"\($0)"}
        let maxIndex = text.count - 1
        
        if(index <= maxIndex){
            
            if let c = newText.last {
                
                print("settign char \(newText) at index \(index)")

                text[index] = "\(c)"
            }
                        
        }
        
    }
}

struct EncasorView: View{
    @State var text = ["1", "2", "X"]

    var body: some View{
         OTPInputView(digitCount: .constant(6), text:$text)

    }
}

#Preview {
        
     EncasorView()
}
