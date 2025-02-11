

import Foundation
import SwiftData



class AppUser: AppEntity {
    
    static func == (lhs: AppUser, rhs: AppUser) -> Bool {
        return lhs.email == rhs.email
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(email)
    }
    
    var id: Int = 0
    var firstName = ""
    var lastName = ""
    var middleName: String? = nil
    
    var email = ""
    var createdAt: Date? = nil
    var updatedAt: Date? = nil
   
    init(id: Int, 
         firstName: String = "",
         middleName: String = "",
         lastName: String = "",
         email: String = "",
         createdAt: Date? = nil,
         updatedAt: Date? = nil) {
        self.id = id
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.email = email
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case middleName
        case lastName
        case email
        case createdAt
        case updatedAt
       }
    
    
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(Int.self, forKey: .id)
        self.firstName = try values.decode(String.self, forKey: .firstName)
        self.middleName = try values.decodeIfPresent(String.self, forKey: .middleName)
        self.lastName = try values.decode(String.self, forKey: .lastName)
        self.email = try values.decode(String.self, forKey: .email)
        
        let rawCreatedAt = try values.decode(String.self, forKey: .createdAt)
        let rawUpdatedAt = try values.decode(String.self, forKey: .updatedAt)
        self.createdAt = Date.fromIsoString(dateString: rawCreatedAt)
        self.updatedAt = Date.fromIsoString(dateString: rawUpdatedAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(middleName, forKey: .middleName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(email, forKey: .email)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)

    }
}
