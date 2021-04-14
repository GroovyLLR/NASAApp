//
//  NASAItemListViewControllerTableViewCellViewModel.swift
//  NASAApp
//
//  Created by Ludovik on 13/04/2021.
//

import Foundation


class NASAItemListViewControllerTableViewCellViewModel: NASAItemViewModelProtocol {
    
    var nasaItem: NasaItem!
    
    var date: Date? {
        guard let dateValue = nasaItem?.date_created else {
            return nil
        }
        let date = Date.dateWith(WithDateFormat: "yyyy-MM-dd'T'HH:mm:sss'Z'", DateString: dateValue)
        return date
    }
    
    var photographer: String {
        return nasaItem.photographer ?? ""
    }
    
    var title: String {
        return nasaItem.title ?? ""
    }
    
    var desc: String {
        return nasaItem.description ?? ""
    }
    
    var photographerWithDateText: String {
        photographer.count > 0 ? "\(photographer) | \(formattedDate)" : formattedDate
    }
    
    var imageUrl: String? {
        return nasaItem.thumbImageUrl
    }
    
    init(nasaItem: NasaItem) {
        self.nasaItem = nasaItem
    }
    
}
