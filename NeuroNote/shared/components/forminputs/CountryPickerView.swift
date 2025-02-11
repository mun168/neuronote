
import SwiftUI
import CountryPicker

struct CountryPickerView : UIViewControllerRepresentable{

    @Binding var countryIsoCodes: [String]?
        
    @Binding var selectedCountry: Country?


    let countryManager = CountryManager.shared

    
    
    typealias UIViewControllerType = CountryPickerViewController

    func makeUIViewController(context: Context) -> CountryPickerViewController {
                
        countryManager.setCountries(isoCodes: countryIsoCodes)
        countryManager.config.selectedCountryCodeBackgroundColor = UIColor(Color("primary"))
        countryManager.config.closeButtonTextColor = UIColor(Color("primary"))
        print("makeUIViewController -> got countries !!!! \(countryIsoCodes)")

        let controller = CountryPickerViewController()
        
        controller.delegate = context.coordinator
        
        if let selectedCountry = selectedCountry {
            controller.selectedCountry  = selectedCountry.isoCode
        }
                
        return controller
    }
  
    func updateUIViewController(_ uiViewController: CountryPickerViewController, context: Context) {
        
        CountryManager.shared.setCountries(isoCodes: countryIsoCodes)

        print("updateUIViewController -> got countries !!!! \(countryIsoCodes)")
        
    }
    

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    

    
    class Coordinator: CountryPickerDelegate{
        
        internal init(parent: CountryPickerView) {
            self.parent = parent
        }
        
        
        let parent: CountryPickerView
        
        
        func countryPicker(didSelect country: Country) {
            
            parent.selectedCountry = country
            print("Country PickerVIew didSelect : \(country.localizedName) \(country.isoCode) \(country.phoneCode)")
        }
        
        
    }
}
