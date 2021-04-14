//
//  APiManager.swift
//  NASAApp
//
//  Created by Ludovik on 13/04/2021.
//

import Foundation


class APiManager {
    
    
    struct ApiError: Error {
        var message: String
        var type: ApiErrorType
    }
    
    
    static func performRequest(Url urlString: String,
                               RequestType requestType: RequestType,
                               RequestContentType contentType: ApiRequestContentType,
                               RequestBody body: Any?,
                               completion: @escaping (ApiResponse) -> ()) {
        
        guard let url = URL.init(string: urlString) else {
            completion(ApiResponse.failure(ApiError.init(message: ApiErrorType.malformedUrl.localizedMessage, type: .malformedUrl)))
             return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.allHTTPHeaderFields = ["Content-Type": contentType.rawValue]
        request.httpMethod = requestType.rawValue
        
        if let body = body {
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            }catch {
                completion(ApiResponse.failure(ApiError.init(message: ApiErrorType.invalidRequestBody.localizedMessage, type: .invalidRequestBody)))
                return
            }
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(ApiResponse.failure(ApiError.init(message:error.localizedDescription, type: .requestError)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 400...599:
                    completion(ApiResponse.failure(ApiError.init(message: ApiErrorType.serverError.localizedMessage, type: .serverError)))
                case 200:
                    if let data = data {
                        completion(ApiResponse.success(data))
                    }else {
                        completion(ApiResponse.failure(ApiError.init(message: ApiErrorType.unknownError.localizedMessage, type: .unknownError)))
                    }
                default:
                    completion(ApiResponse.failure(ApiError.init(message: ApiErrorType.unknownError.localizedMessage, type: .unknownError)))
                }
            }
        }.resume()
    }
}

