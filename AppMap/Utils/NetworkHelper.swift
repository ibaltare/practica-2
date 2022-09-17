import Foundation

final class NetworkHelper {
    
    static let shared = NetworkHelper()
    
    private init() {}
    
    func networkCall(
            uri: String,
            method: String,
            authentication: String,
            credentials: String,
            jsonRequest: Bool,
            body: Data?,
            completion: @escaping (Data?, NetworkError?) -> Void
    ) {
        
        guard let url = URL(string: uri) else {
            completion(nil, .malformedURL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.setValue("\(authentication) \(credentials)", forHTTPHeaderField: "Authorization")
        
        if jsonRequest {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = body
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                completion(nil, .errorResponse)
                return
            }
          
            guard let httpResponse = (response as? HTTPURLResponse), httpResponse.statusCode == 200 else {
                completion(nil, .notAuthenticated)
                return
            }
            
            completion(data, nil)
            
        }
        
        task.resume()
    }
    
}

