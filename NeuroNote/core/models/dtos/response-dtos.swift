
import Foundation

class LoginResponseDto: ObservableObject, Codable {
    var message: String
    var data: AuthTokenObject
}
