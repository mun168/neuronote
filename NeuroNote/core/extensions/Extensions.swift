
import Foundation
import SwiftUI



protocol JSONStringConvertible : CustomStringConvertible
{
  
}

public protocol DefaultConstructable {
  init()
}


extension JSONStringConvertible where Self : Codable & JSONStringConvertible{
    var description: String{
        do{
            return try String(data: JSONEncoder().encode(self), encoding: .utf8) ?? ""
        }catch let error {
            print("JSONStringConvertible Error \(error)")
        }
        return ""
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    
     func endEditing() {
         
            UIApplication.shared.endEditing()
    }
    
  @ViewBuilder func isHidden(_ shouldHide: Bool) -> some View {
    switch shouldHide {
    case true: self.hidden().frame(width: 0, height: 0, alignment: .center).animation(.default, value: 1)
      case false: self
    }
  }
}

extension Data {
    enum ImageContentType: String {
        case jpg = "image/jpeg",
             png = "image/png",
             gif = "image/gif",
             tiff = "image/tif",
             unknown = "image/unknown"

        var fileExtension: String {
            return self.rawValue.replacingOccurrences(of: "image/", with: "")
        }
        
    }
    
    
    

    var imageContentType: ImageContentType {

        var values = [UInt8](repeating: 0, count: 1)

        self.copyBytes(to: &values, count: 1)

        switch (values[0]) {
        case 0xFF:
            return .jpg
        case 0x89:
            return .png
        case 0x47:
           return .gif
        case 0x49, 0x4D :
           return .tiff
        default:
            return .unknown
        }
    }
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


extension Data{
    
    static func fileData(url: URL?) -> Data?{
        
        if let url = url{
            do {
                url.startAccessingSecurityScopedResource()
                let data = try Data.init(contentsOf: url, options: .alwaysMapped)
                url.stopAccessingSecurityScopedResource()
                
                return data
            } catch let error{
                print(error.localizedDescription)
            }
        }
        return nil
    }
}


extension String{
    func toDouble()-> Double?{
        Double(self)
    }
    

}

extension Double{
    
    func toString() -> String?{
        String(self)
    }
    func toDestinationCurrency(_ rate: Double)-> Double{
         self * rate
    }

    func toSendingCurrency(_ rate: Double) -> Double{
        self / rate
    }

    func to2Dp()-> Double{
        (self * 100.0).rounded() / 100.0
    }

    
    func roundToTenAnd2Dp() -> Double{
        return self.roundToTen().roundTo(2)
    }

    func roundToTen() -> Double{
        return (self / 10.0).rounded() * 10.0
    }

    func roundTo(_ decimals: Int) -> Double {
        var multiplier = 1.0
        for _ in 1...decimals{
             multiplier *= 10
        }
        
        return (self * multiplier).rounded() / multiplier
    }


}


extension Encodable {
    func toDictionary() -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                throw NSError(domain: "ConversionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert object to dictionary."])
            }
            return dictionary
        } catch {
            print("Failed to convert object to dictionary: \(error)")
            return nil
        }
    }
}


///String  extension to check  if email is valid
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

extension Date {
    static func fromIsoString(dateString: String?)-> Date?{
        
        if let dateString {
           
            let dateFormatter = ISO8601DateFormatter()
            let date = dateFormatter.date(from: dateString)

            return date
        }
        
        return nil
    }
}


extension String: Identifiable {
    public var id: String { self }
}
extension Int: Identifiable {
    public var id: Int { self }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
