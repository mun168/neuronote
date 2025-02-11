
import SwiftUI

struct PageControlView: View {
    
    @Binding var pageIndex: Int
    @Binding var pageCount: Int
    var onIndicatorClicked: (_ indicatorIndex: Int)->Void

    var body: some View {
        
        HStack(alignment: .center){
            ForEach.init(0..<pageCount,
                         id: \.self) {singIndex in
                
                Text("•")
                    .font(.system(size: pageIndex == singIndex ? 60 : 40))
                    .fontWeight(.heavy)
                    .foregroundColor(pageIndex == singIndex ? Color("primary.light") :
                                     Color("primary"))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom:(pageIndex == singIndex) ? 2 : 0, trailing: 0))
                    .onTapGesture {
                        onIndicatorClicked(singIndex)
                    }
                
            }
        }
    }
}

#Preview {
    PageControlView.init(pageIndex: .constant(0), pageCount: .constant(3)) { indicatorIndex in
        print("On indicator with index clicked \(indicatorIndex)")
    }
}
