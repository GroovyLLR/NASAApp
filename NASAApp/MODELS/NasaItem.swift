//
//  NasaItem.swift
//  NASAApp
//
//  Created by Ludovik on 12/04/2021.
//

import Foundation

///class contains Codable object use to map response for fecthItem into appropriate objects
class NasaItem: Codable {
    
    var nasa_id: String?
    var center: String?
    var photographer: String?
    var date_created: String?
    var title: String?
    var description: String?
    var media_type: String?
    var keywords: [String]?
    
    var imageCollectionUrl: String?
    var thumbImageUrl: String?
    var largeImageUrl: String?
    
}


struct NASAItemsReponse: Codable {
    
    var collection: NASAItemResponseCollection?
    
    func allItems() -> [NasaItem] {
        return(collection?.items ?? []).map{$0.item}
    }
    
}


struct NASAItemResponseCollection: Codable {

    var links: [NASAItemResponseCollectionLinks]?
    var items: [NASAItemResponseCollectionItemData]?
    
    var nextUrl: String? {
        return links?.first?.nextUrl
    }
    
}

struct NASAItemResponseCollectionItemData: Codable {
    
    var data: [NasaItem]!
    var links: [NASAItemResponseCollectionItemDataLink]!
    var href: String?

    var item: NasaItem {
        let nItem = data.first!
        nItem.thumbImageUrl = thumbImageUrl
        nItem.imageCollectionUrl = href
        return nItem
    }
    
    var thumbImageUrl: String {
        return links.first?.thumbImageUrl ?? ""
    }
    
}

struct NASAItemResponseCollectionLinks: Codable {
    var nextUrl: String
    enum CodingKeys: String, CodingKey {
        case nextUrl = "href"
    }
}

struct NASAItemResponseCollectionItemDataLink: Codable {
    var thumbImageUrl: String?
    enum CodingKeys: String, CodingKey {
        case thumbImageUrl = "href"
    }
}








