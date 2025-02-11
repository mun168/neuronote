

import Foundation
import Combine
import SwiftUI

class AuthManager: AppDataManager {
    
    static let sharedManager = AuthManager()
    
    @Published var isUserLoggedIn = false

    @Published var user: AppUser? = nil

    
    func signIn(credentials: LoginCredentials) -> Future<LoginResponseDto, CoreError>{
                
        return Future{[unowned self] promise in
            
            
            
            post(path: "\(properties.authenticationApiBaseUrl)auth/login",
                 body: credentials.toDictionary()!,
            responseType: LoginResponseDto.self,
            isToAddAccessToken: true,
             isTerminalRequest: false)
            .sink { error in
                
                print("got some some object \(error)")
                
              promise(.failure(CoreError.somethingWentWrong()))

                
            } receiveValue: {[unowned self] response in
                
                UserDefaults.standard.set(response.data.accessToken, forKey: "token")

                let token = UserDefaults.standard.string(forKey: "token")


                print("token \(String(describing: token))")
                print("Response data:\n \(String(describing: response))")


                self.getMe().sink { error in
                    
                    promise(.failure(CoreError.somethingWentWrong()))

                } receiveValue: { [unowned self] appUser in
                    user = appUser
                    
                    isUserLoggedIn = true

                    promise(.success(response))
                }.store(in: &subscriptions)
                
            }.store(in: &subscriptions)

        }
    }
    
    
    func refreshMe() -> Future<LoginResponseDto, CoreError>{
                
       return Future{[unowned self] promise in
            get(path: "\(properties.authenticationApiBaseUrl)auth/token/refresh",
            responseType: LoginResponseDto.self,
            isToAddAccessToken: false,
             isTerminalRequest: false)
            .sink { _ in
                
                promise(.failure(CoreError.somethingWentWrong()))
                
            } receiveValue: {[unowned self] response in
                
                UserDefaults.standard.set(response.data.accessToken, forKey: "token")

                let token = UserDefaults.standard.string(forKey: "token")


                print("token \(String(describing: token))")
                print("Response data:\n \(String(describing: response))")

                self.getMe().sink { error in
                    
                    promise(.failure(CoreError.somethingWentWrong()))

                } receiveValue: { [unowned self] appUser in
                    user = appUser
                    
                    isUserLoggedIn = true

                    promise(.success(response))
                }.store(in: &subscriptions)
                
            }.store(in: &subscriptions)

        }
    }
    
    
    
    func getMe() -> Future<AppUser, CoreError>{
                
       return Future{[unowned self] promise in
            
            
        get(path: "\(properties.authenticationApiBaseUrl)auth/me", responseType: AppUser.self)
            .sink { _ in
                promise(.failure(CoreError.somethingWentWrong()))
            } receiveValue: {[unowned self] response in
                
                user = response

                promise(.success(response))
                
            }.store(in: &subscriptions)

        }
    }

    
}

