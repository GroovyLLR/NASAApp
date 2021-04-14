//
//  LocalError.swift
//  NASAApp
//
//  Created by Ludovik on 12/04/2021.
//

import Foundation


enum RequestType: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

enum ApiErrorType: Error {
    
    case requestError
    case serverError
    case unknownError
    case malformedUrl
    case invalidRequestBody
    
    var localizedMessage: String {
        switch self {
        case .unknownError, .malformedUrl, .invalidRequestBody:
            return "There was a problem processing your request please try again later"
        case .requestError, .serverError:
            return ""
        }
    }
}

enum ApiResponse {
    case success(Data)
    case failure(APiManager.ApiError)
}

enum ApiRequestContentType: String {
    case json = "application/json"
    case form = "application/x-www-form-urlencoded"
}
