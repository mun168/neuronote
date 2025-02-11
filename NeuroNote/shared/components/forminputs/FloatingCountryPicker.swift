
import SwiftUI
import CountryPicker

struct FloatingCountryPicker: View {
    @State var isToShowCountryPicker = false
    var title: String
    var isPhoneNumberPicker: Bool
    @Binding var terminalPhoneNumber: String
    @Binding var countryIsoCodes: [String]?
    @Binding var selectedCountry: Country?
    var isRequired: Bool;
    var errorMessage: String?;



    var body: some View {
        HStack(spacing: 0){
            
            if(isPhoneNumberPicker){
                
                    HStack(spacing: 0){
                        Text("\(selectedCountry?.isoCode.getFlag() ?? "") +\(selectedCountry?.phoneCode ?? "")") // phone country code
                            .foregroundColor(Color.white)
                            .padding()
                            .cornerRadius(4.0)
                            .onTapGesture {
                                if(isPhoneNumberPicker){
                                    isToShowCountryPicker = true
                                }
                            }
                        
                        Image(systemName: isToShowCountryPicker ? "chevron.up" : "chevron.down")
                            .foregroundColor(Color.white)
                            .padding(EdgeInsets(top: 0, leading:0, bottom: 0, trailing: 10))
                           

                    }   .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                        .background(Color("primary.light"))
                        .cornerRadius(50, corners: [UIRectCorner.topLeft, UIRectCorner.bottomLeft])


            }
            
            HStack(spacing: 0){
                
                if(isPhoneNumberPicker){
                    
                    FloatingTextField(title: title,
                                      prefixText: .constant(""),
                                      text: $terminalPhoneNumber,
                                      isRequired: isRequired,
                                      errorMessage: errorMessage
                    ).disabled(!isPhoneNumberPicker)
                        .cornerRadius(5, corners: [.topLeft, .topRight])
                        .keyboardType(isPhoneNumberPicker ? .numberPad : .default)

                }else{
                   
                    FloatingTextField(title: title,
                                      prefixText: .constant(""),
                                      text: .constant("\(selectedCountry?.isoCode.getFlag() ?? "") \(selectedCountry?.localizedName ?? "")" ),
                                      isRequired: isRequired,
                                      errorMessage: errorMessage
                    ).disabled(!isPhoneNumberPicker)
                        .keyboardType(isPhoneNumberPicker ? .numberPad : .default)
                    
                }
                
                if(!isPhoneNumberPicker){
                    Image(systemName: isToShowCountryPicker ? "chevron.up" : "chevron.down")
                        .padding()
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

                }
            }.padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                .background(Color.white)

                .onTapGesture {
                    if(!isPhoneNumberPicker){
                        isToShowCountryPicker = true
                    }
                }
            
        }
        .cornerRadius(50, corners: isPhoneNumberPicker ? [UIRectCorner.topRight, UIRectCorner.bottomRight] : UIRectCorner.allCorners)


            .sheet(isPresented: $isToShowCountryPicker){
            CountryPickerView(countryIsoCodes: $countryIsoCodes, selectedCountry: $selectedCountry)
        }
    
    }
    
}


struct FloatingCountryPicker_Previews: PreviewProvider {
    
    @State static var isLoading = false
    @State static var countryIsoCodes: [String]? = ["ZW", "GB"]
    @State static var terminalPhoneNumber: String = ""
    @State static var selectedCountryOfResidence: Country? = CountryManager.shared.findCountry(isCode: "GB")
    @State static var selectedPhoneCountry: Country? = CountryManager.shared.findCountry(isCode: "ZW")
    
    
    static var previews: some View {
        VStack(spacing: 16){
            
            Spacer()
            FloatingCountryPicker(title: "Country of Residence",
                               isPhoneNumberPicker: false,
                               terminalPhoneNumber: .constant(""),
                               countryIsoCodes: .constant(nil),
                               selectedCountry: $selectedCountryOfResidence, isRequired: true)
            .padding(.bottom)
            
            
            FloatingCountryPicker(title: "Phone Number",
                               isPhoneNumberPicker: true,
                               terminalPhoneNumber: $terminalPhoneNumber,
                               countryIsoCodes: $countryIsoCodes,
                               selectedCountry: $selectedPhoneCountry, isRequired: false)
            Spacer()
            
        }.padding()
            .background(Color("secondary"))
    }
}
