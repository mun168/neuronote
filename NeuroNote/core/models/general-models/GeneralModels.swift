

import Foundation

// Mark: - General Protocols

protocol Nameable {
    var name: String { get set }
}

protocol DateTimeTrackable {
    var createdAt: Date? { get set }
    var updatedAt: Date? { get set }
}

protocol AppEntity: DateTimeTrackable, ObservableObject, Codable, Identifiable, Hashable, Equatable {
    var id: Int { get set }
}

extension AppEntity {
    
   
}

protocol NameableAppEntity: Nameable, AppEntity {
}

extension NameableAppEntity {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name.lowercased() == rhs.name.lowercased()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}


// Mark: - General Enums




enum AddressType: String, Codable{
    case deliveryAddress = "DELIVERY_ADDRESS",
         physicalAddress = "PHYSICAL_ADDRESS"
}


enum GenderType: String, Codable {
    case male = "MALE",
         female = "FEMALE",
         indeterminate = "INDETERMINATE"
}

enum SalutationType: String, Codable {
    case mr = "MR",
         mrs = "MRS",
         ms = "MS",
         dr = "DR",
         miss = "MISS",
         prof = "PROF",
         indeterminate = "INDETERMINATE"
}




enum UserStatus: String, Codable {
    case active = "ACTIVE",
         suspended = "SUSPENDED",
         indeterminate = "INDETERMINATE"
}


enum DictionaryType: String, Codable {
    case wordDictionary = "WORD_DICTIONARY",
         phraseDictionary = "PHRASE_DICTIONARY",
         idiomDictionary = "IDIOM_DICTIONARY"

}



enum QuizCategory: String, Codable {
    case baseVocEssentials = "BASE_VOC_ESSENTIALS"
}

enum QuizDifficultyLevel: String, Codable, CaseIterable{
    case  easy = "EASY",
          medium = "MEDIUM",
          hard = "HARD"
}

enum QuizLanguage: String, Codable{
    case englishToShona = "ENGLISH_TO_SHONA",
         shonaToEnglish = "SHONA_TO_ENGLISH"
}

enum QuizType: String, Codable, CaseIterable {
    case imageToWordMatch = "IMAGE_TO_WORD_MATCH",
         audioToWordMatch = "AUDIO_TO_WORD_MATCH"
}

enum AnswerType: String, Codable {
    case correct = "CORRECT",
         wrong = "WRONG"
}

enum AppSortingOrder: String, Codable {
    case descending = "DESCENDING",
    ascending = "ASCENDING"
}

enum AppLanguageType: String, Codable, CaseIterable{
    case baseLanguage = "SHONA",
         transLanguage = "ENGLISH"
}


// Mark: - General Structs


struct PropertyModel:Codable{
    var  authenticationApiBaseUrl:String=""
    var timout:Double=10.0;
}




class CoreError: Error, Codable, JSONStringConvertible{
    
    var message: String = ""
    var code: Int = 0
    var errors: [String]? = []
    var timestamp: String = ""
    
  
    static func somethingWentWrong() -> CoreError {
        return CoreError.init(
            message: "Something Went Wrong",
            code: 500,
            timestamp: Date.now.description)
    }
    
    init(message: String, 
         code: Int,
         errors: [String]? = nil,
         timestamp: String){
        self.message = message
        self.code = code
        self.errors = errors
        self.timestamp = timestamp
    }
}



// MARK: - Pagination

class GenericResponse<T: Codable>: Codable, ObservableObject {
    
    var data: T?
    var links: PaginationLinks = PaginationLinks()
    
    internal init(data: T? = nil,
                  links: PaginationLinks = PaginationLinks()) {
        self.data = data
        self.links = links
    }
}

class PaginationLinks: Codable {
  
    var totalPages: Int = 0
        var totalObjects: Int = 0
        var currentPage: Int = 0
        var pageSize: Int = 0
    
    internal init(totalPages: Int = 0,
                  totalObjects: Int = 0,
                  currentPage: Int = 0,
                  pageSize: Int = 0) {
        self.totalPages = totalPages
        self.totalObjects = totalObjects
        self.currentPage = currentPage
        self.pageSize = pageSize
    }
    
    
}

class AppSearchOptions: ObservableObject, Codable, Equatable, Hashable, DefaultConstructable {

    var searchTerm: String = ""
    var dictionaryType: DictionaryType = .wordDictionary

    init(searchTerm: String = "",
         dictionaryType: DictionaryType = .wordDictionary) {
       self.searchTerm = searchTerm
       self.dictionaryType = dictionaryType
   }
    
    static func == (lhs: AppSearchOptions, rhs: AppSearchOptions) -> Bool {
        lhs.searchTerm.lowercased() == rhs.searchTerm.lowercased() && lhs.dictionaryType == rhs.dictionaryType
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(searchTerm)
        hasher.combine(dictionaryType.rawValue)
    }
    
    required init() {
        
    }
    
}

class WordSearchOptions: AppSearchOptions {
    var baseVocEssentialName: String? = nil
    var wordOriginName: String? = nil
    var partOfSpeechName: String? = nil
    var formalityName: String? = nil
    var dialectName: String? = nil
}

class QuizSearchOptions: AppSearchOptions {
    
     var quizType: QuizType = .imageToWordMatch
     var difficultyLevel: QuizDifficultyLevel = .easy

}

class AppSettings: ObservableObject, Codable {
   var appLanguageType: AppLanguageType = .baseLanguage
   var isAllowedToConnectViaWifi = true
   var isAllowedToConnectViaCellularData = false
   var isAllowedToSyncViaWifi = true
   var isAllowedToSyncViaCellularData = false

}


// Authentication

class LoginCredentials: ObservableObject, Codable {
     var email: String
     var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}


class AuthTokenObject: ObservableObject, Codable {
    var tokenType = ""
    var accessToken = ""
    var expiresIn = 0
    var scope = ""
    var limits: String? = nil
    var apps = ""
    var jti = ""
    var isMultiFactorAuthEnabled = false
}


protocol BaseView{
    associatedtype SomeErrorMessages
    
    var hasSubmitBeenPressed: Bool {get set}
    var inputErrorMessages: SomeErrorMessages {get set}
    func isValid() -> Bool
    func submit() -> Void
    
}

