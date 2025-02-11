
import SwiftUI
import CountryPicker

struct FloatingCurrencyPicker: View {
    @State var isToShowCountryPicker = false
    var title: String
    @Binding var prefixText: String
    @Binding var amount: String
    @Binding var countryIsoCodes: [String]?
    @Binding var selectedCountry: Country?
    var isRequired: Bool;
    var errorMessage: String?;


    var body: some View {
        HStack(spacing: 0){
            
       
            
            HStack(spacing: 0){
                Text(selectedCountry?.isoCode.getFlag() ?? "") // currency flag
                    .foregroundColor(Color.white)
                    .padding()
                    .cornerRadius(4.0)
                    .onTapGesture {
                            isToShowCountryPicker = true
                    }
                
                HStack(spacing: 0){
                    Text(selectedCountry?.currencyCode ?? "") // currency flag
                        .foregroundColor(Color.black)
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .cornerRadius(4.0)
                        .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 10))
                        .onTapGesture {
                                isToShowCountryPicker = true
                        }
                

                }   .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                            
                
                
                Image(systemName: isToShowCountryPicker ? "chevron.up" : "chevron.down")
                    .foregroundColor(Color.white)
                    .padding(EdgeInsets(top: 0, leading:0, bottom: 0, trailing: 10))
                   

            }   .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                .background(Color("primary.light"))
                .cornerRadius(50, corners: [UIRectCorner.topLeft, UIRectCorner.bottomLeft])


            HStack(spacing: 0){
                
                FloatingTextField(title: title,
                                  prefixText: .constant(selectedCountry?.currencySymbol ?? ""),
                                  text: $amount,
                                  isRequired: isRequired,
                                  errorMessage: errorMessage
                    ).keyboardType(.numberPad)
                    

            }.padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
            .cornerRadius(5, corners: [UIRectCorner.topLeft, UIRectCorner.bottomLeft])
            
         
            
         

            
        }
        .background(Color.white)
        .cornerRadius(50)


            .sheet(isPresented: $isToShowCountryPicker){
            CountryPickerView(countryIsoCodes: $countryIsoCodes, selectedCountry: $selectedCountry)
        }
    
    }
    
}


struct FloatingCurrencyPicker_Previews: PreviewProvider {
    
    @State static var isLoading = false
    @State static var validSendingCountries: [String]? = ["AU", "GB", "BW", "CA"]
    @State static var validReceptionCountries: [String]? = ["ZW"]
    @State static var terminalPhoneNumber: String = ""
    @State static var selectedCountryOfResidence: Country? = CountryManager.shared.findCountry(isCode: "GB")
    @State static var selectedSendingCountry: Country? = CountryManager.shared.findCountry(isCode: "AU")
    @State static var selectedRecievingCountry: Country? = CountryManager.shared.findCountry(isCode: "ZW")
    
    static var previews: some View {
        VStack(spacing: 16){
            Spacer()
            FloatingCurrencyPicker(title: "You send from \(selectedSendingCountry?.localizedName ?? "")",
                                   prefixText: .constant(selectedSendingCountry?.isoCode ?? ""),
                                   amount: .constant( "234.66"),
                                   countryIsoCodes: $validSendingCountries,
                                   selectedCountry: $selectedSendingCountry,
                                   isRequired: true)
            
            FloatingCurrencyPicker(title: "They Recieve in \(selectedRecievingCountry?.localizedName ?? "")",
                                   prefixText: .constant(selectedRecievingCountry?.isoCode ?? ""),
                                   amount: .constant( "234.66"),
                                   countryIsoCodes: $validReceptionCountries,
                                   selectedCountry: $selectedRecievingCountry,
                                   isRequired: true)
            Spacer()
        }.padding()
            .background(Color("secondary"))
    }
}
