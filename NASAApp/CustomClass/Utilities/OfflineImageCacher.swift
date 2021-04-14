//
//  OfflineImageCacher.swift
//  NASAApp
//
//  Created by Ludovik on 14/04/2021.
//

import Foundation

///Single with a custom URLCache object initialize against a folder directory
class OfflineImageCacher {
    
    static let instance = OfflineImageCacher()
    var cache: URLCache!
    
    init(){
        let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let diskCacheURL = cachesURL.appendingPathComponent("DownloadCache")
        cache = URLCache(memoryCapacity: 10_000_000, diskCapacity: 1_000_000_000, directory: diskCacheURL)
    }
}
