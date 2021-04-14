//
//  NasaAppEndpoints.swift
//  NASAApp
//
//  Created by Ludovik on 12/04/2021.
//

import Foundation


class NasaAppEndpoints {
    
    static func listNasaItems() -> URL {
        return URL.init(string: "https://images-api.nasa.gov/search?q=%22%22")!
    }
    
    static let listNasaItemsUrl = "https://images-api.nasa.gov/search?q=%22%22"
}
