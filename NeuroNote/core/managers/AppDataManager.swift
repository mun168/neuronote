
import Foundation
import Alamofire
import Combine

enum AppEnvType: String{
    case production = "production"
    case staging = "staging"
    case local = "local"

}

final class AlarmofireLogger: EventMonitor {
    func requestDidResume(_ request: Request) {
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let  message = "\n" + """
        ⚡️⚡️⚡️⚡️⚡️ Request Started: \(request)
        ⚡️⚡️⚡️⚡️⚡️ Request Started: \(request.request?.httpBody)
        ⚡️⚡️⚡️⚡️⚡️ Body Data: \(body)
        """
        NSLog(message)
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        NSLog("\n🕺🏽🕺🏽🕺🏽 Response Received: \(response.debugDescription)\n")
    }
    
    
    
}
//class BaseManager<TPathEnum: RawRepresentable>: ObservableObject where TPathEnum.RawValue == String{

class AppDataManager : ObservableObject{
//class BaseManager<TSelection: RawRepresentable> : ObservableObject where TSelection.RawValue == String{
 //   @Published var  selection: TSelection?;

    internal var subscriptions = Set<AnyCancellable>()

    
    var timeoutInterval = TimeInterval(120)
    
    var name: String{
        String(describing: self)
    }
    
    var headersForMultipart: HTTPHeaders{
        [
            "Content-Type": "multipart/form-data",
            "Accept": "application/json",
            "Authorization": "Bearer \(token)"
        ]
    }
    
    var headersForJson: HTTPHeaders{
        [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer \(token)"
        ]
    }
        
    var decoder = JSONDecoder()
    
    var encoder = JSONEncoder()
    
    ///alert message sheet state holder
    @Published public var isToPresentAlert = false
    
    @Published var isloading:Bool = false;
    /// holds state of the  error message
    @Published var errorMessage:String?=nil;
    
    /// holds state of the  success  message
    @Published var successMessage:String?=nil;

    /// current screen in the login,registration process
    var session = URLSession.shared
    
    private var manager: ServerTrustManager? = nil
    
    var alarmofireSession: Session? = nil
    
    internal var token: String {
            UserDefaults.standard.string(forKey: "token") ?? ""
    }
    
    var hasSuccessfullyUploadedKycDocs: Bool{
        get{
            UserDefaults.standard.bool(forKey: "completed")
        }
        
        set{
            UserDefaults.standard.set(newValue, forKey: "completed")
        }
    }
        
    var delegate = BaseManagerSessionDelegate()
    
    var appEnv: AppEnvType{
        
        let rawEnv = Bundle.main.object(forInfoDictionaryKey: "Env") as! String

        return AppEnvType(rawValue: rawEnv)!
    }

    func isAppEnv(env: AppEnvType) -> Bool{
        return appEnv.rawValue == env.rawValue
    }

    
    init(){
        
        switch(appEnv){
            
        case .production:
            manager = ServerTrustManager(evaluators: [
                "gateway.assureth.com": DisabledTrustEvaluator()]
            )
            
            alarmofireSession = Alamofire.Session(eventMonitors: [AlarmofireLogger()])
            
        case .staging, .local:
            manager = ServerTrustManager(evaluators: [
                "192.168.100.166": DisabledTrustEvaluator(),
                "staging.gateway.assureth.com": DisabledTrustEvaluator()]
            )
            
            alarmofireSession = Alamofire.Session(serverTrustManager: manager, eventMonitors: [AlarmofireLogger()])

            
        }

        
        loadPropertiesData()
        
        
        switch(appEnv){
    
        case .staging, .local:
            session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
            
        case .production:
            session = URLSession.shared

        }
        
        
    }
    
    /// models properties.json file which has application properties e.g urls
    @Published var properties : PropertyModel = PropertyModel();
    
    
    /**
    This function loads properties.json and populates the self.properties variable
    ## Important Notes ##
    1. It is called in the constructor
    */
    func loadPropertiesData()  {
        
        
        let fileName = "\(appEnv.rawValue)-properties"
        
         guard let url = Bundle.main.url(forResource: fileName, withExtension: "json")
             else {
                 print("Json file not found")
                 return
             }
         let data = try? Data(contentsOf: url)
        let properties1 = try? JSONDecoder().decode(PropertyModel.self, from: data!)
         self.properties = properties1!
         
     }
    
    
    func captureError(fromData data: Data?, isTerminalRequest: Bool = true){
        do{
            if let data = data{
                
                let genericError = try decoder.decode(CoreError.self, from: data)
                
                self.errorMessage = genericError.message
                                
                print("\n📕📕📕📕 Error \(genericError))")

            }
        } catch let error{
            print("\n📕📕📕📕 Error Capturing Error \(error))")

        }
        
        self.isloading = false;
    }
    
    func createGeneralQueryString(searchTerm: String? = nil,
                                  page: Int = 1,
                                  size: Int = 10,
                                  sortingOrder: AppSortingOrder = AppSortingOrder.descending,
                                  sortingKey: String = "id") -> String{
        var queryString = ""
        queryString += "?page=\(page)"
        queryString += "&size=\(size)"
        queryString += "&sortingOrder=\(sortingOrder.rawValue)"
        queryString += "&sortingKey=\(sortingKey)"
        
        let searchTerm = searchTerm?.count == 0 ? nil : searchTerm

        queryString += ((searchTerm != nil) ? "&searchTerm=\(searchTerm!)" : "")
        
        return queryString
    }
    
    func get<TResponse: Codable>(path: String,
                         responseType: TResponse.Type,
                   isToAddAccessToken: Bool = true,
                    isTerminalRequest: Bool = true) -> Future<TResponse, AFError>{
        
        self.isloading = true;
        clearMessages()

        
        var headers = applyToken(isToAdd: isToAddAccessToken, headers: headersForJson)


        return Future(){ [unowned self] promise in
            
            alarmofireSession?.request("\(path)", method: .get, headers: headers)
            {[unowned self] req in req.timeoutInterval = timeoutInterval}
                .validate()
                .responseDecodable { (response: DataResponse<TResponse, AFError>) in
                    
                    DispatchQueue.main.async {

                    switch (response.result)
                    {
                        
                    case .success(let result):
                        
                            
                        print("\n📗📗📗📗 Success : \(result)")
                            self.successMessage = ""
                        
                        if(isTerminalRequest){
                            self.isloading = false;
                        }
                            
                            promise(Result.success(result))

                        
                    case .failure(let error):
                        
                        print("\n📕📕📕📕 Failure \(error))")

                        self.captureError(fromData: response.data)
                        
                        promise(Result.failure(error))

                    }
                    
                    }
                     
                }
          }
        
    }
    
    func post<TResponse: Codable>(path: String,
                                                  body: Dictionary<String, Any>,
                                          responseType: TResponse.Type,
                                    isToAddAccessToken: Bool = true,
                                                  isTerminalRequest: Bool = true) -> Future<TResponse, AFError>
    {
        
        self.isloading = true;
        clearMessages()
          
        var headers = applyToken(isToAdd: isToAddAccessToken, headers: headersForJson)

                                              

        return Future(){[unowned self] promise in
            
            alarmofireSession?.request("\(path)", method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            {[unowned self] req in req.timeoutInterval = timeoutInterval}
                .responseDecodable { [unowned self]  (response: DataResponse<TResponse, AFError>) in
                    
                    DispatchQueue.main.async {

                    switch (response.result)
                    {
                        
                    case .success(let result):
                        
                            
                            print("\n📗📗📗📗 Success : \(result)")
                            self.successMessage = ""
                            
                        if(isTerminalRequest){
                            self.isloading = false;
                        }
                            
                            promise(.success(result))
                        
                        break
                    case .failure(let error):
                        
                        print("\n📕📕📕📕 Failure \(error))")

                        self.captureError(fromData: response.data)
                        
                        promise(.failure(error))
                        
                        break
                    }
                    
                    }
                     
                }
          }
        
    }
    
    
    func applyToken(isToAdd: Bool, headers: HTTPHeaders) ->HTTPHeaders{
        
        var headers = headers
        
        if(isToAdd){
            headers["Authorization"] = "Bearer \(token)"
        }else{
            headers["Authorization"] = nil
        }
        
        return headers
    }
    
    
    func put<TResponse: Codable>(path: String,
                                                  body: Dictionary<String, Any>,
                                          responseType: TResponse.Type,
                                    isToAddAccessToken: Bool = true,
                                                  isTerminalRequest: Bool = true) -> Future<TResponse, AFError>
    {
        
        self.isloading = true;
        clearMessages()
          
        var headers = applyToken(isToAdd: isToAddAccessToken, headers: headersForJson)

                                              

        return Future(){[unowned self] promise in
            
            alarmofireSession?.request("\(path)", method: .put, parameters: body, encoding: JSONEncoding.default, headers: headers)
            {[unowned self] req in req.timeoutInterval = timeoutInterval}
                .responseDecodable { [unowned self]  (response: DataResponse<TResponse, AFError>) in
                    
                    DispatchQueue.main.async {

                    switch (response.result)
                    {
                        
                    case .success(let result):
                        
                            
                            print("\n📗📗📗📗 Success : \(result)")
                            self.successMessage = ""
                            
                        if(isTerminalRequest){
                            self.isloading = false;
                        }
                            
                            promise(.success(result))
                        
                        break
                    case .failure(let error):
                        
                        print("\n📕📕📕📕 Failure \(error))")

                        self.captureError(fromData: response.data)
                        
                        promise(.failure(error))
                        
                        break
                    }
                    
                    }
                     
                }
          }
        
    }
    
    
    
    func delete<TResponse: Codable>(path: String,
                                            responseType: TResponse.Type,
                                      isToAddAccessToken: Bool = true,
                                      isTerminalRequest: Bool = true) -> Future<TResponse, AFError>{
        
        self.isloading = true;
        clearMessages()
        
        var headers = headersForJson
                                              
        if(isToAddAccessToken){
            headers["Authorization"] = "Bearer \(token)"
        }else{
            headers["Authorization"] = nil
        }

        return Future(){ [unowned self] promise in
            
            alarmofireSession?.request("\(path)", method: .delete, headers: headers)
            {[unowned self] req in req.timeoutInterval = timeoutInterval}
                .responseDecodable { (response: DataResponse<TResponse, AFError>) in
                    
                    DispatchQueue.main.async {

                    switch (response.result)
                    {
                        
                    case .success(let result):
                        
                            
                        print("\n📗📗📗📗 Success : \(result)")
                            self.successMessage = ""
                        
                        if(isTerminalRequest){
                            self.isloading = false;
                        }
                            
                            promise(Result.success(result))

                        
                    case .failure(let error):
                        
                        print("\n📕📕📕📕 Failure \(error))")

                        self.captureError(fromData: response.data)

                        promise(Result.failure(error))

                    }
                    
                    }
                     
                }
          }
        
    }
    
    
    /**
    This function clears the message and error variables
    */
    open func clearMessages() {
        isToPresentAlert = false
        errorMessage=""
        successMessage=""
    }
    
}


class BaseManagerSessionDelegate: NSObject, URLSessionDelegate
{
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

           print("*** received SESSION challenge...\(challenge)")
           let trust = challenge.protectionSpace.serverTrust!
           let credential = URLCredential(trust: trust)

         
               completionHandler(.useCredential, credential)
          
       }
}



