//
//  NASAItemViewModelProtocol.swift
//  NASAApp
//
//  Created by Ludovik on 13/04/2021.
//

import Foundation


protocol NASAItemViewModelProtocol {
    
    var nasaItem: NasaItem! {set get}
    var date: Date? {get}
    var photographer: String {get}
    var title: String {get}
    var desc: String {get}
    var imageUrl: String? {get}
    var formattedDate: String {get}
}

extension NASAItemViewModelProtocol {
    
    var formattedDate: String {
        guard let date = date else {
            return ""
        }
        return date.stringWithFormat("dd MMM, yyyy")
    }
}


