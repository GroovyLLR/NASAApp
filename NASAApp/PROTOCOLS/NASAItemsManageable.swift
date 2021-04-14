//
//  NASAItemsManageable.swift
//  NASAApp
//
//  Created by Ludovik on 13/04/2021.
//

import Foundation
import RxSwift

protocol NASAItemsManageable  {
    
    var nasaItems: PublishSubject<[NASAItemListViewControllerTableViewCellViewModel]> {get set}
    var isLoading: PublishSubject<Bool> {get set}
    var isLoadingNextPage: PublishSubject<Bool> {get set}
    var error: PublishSubject<APiManager.ApiError> {get set}
    var nextUrl: String? {get set}
    
    func refreshItems()
    func loadMoreItems()
}


protocol NASAItemImageCollectionFetchable {
    func fetchImageCollectionForItem(_ item: NasaItem)
}
