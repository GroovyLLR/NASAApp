//
//  NASAItemDetailViewControllerViewModel.swift
//  NASAApp
//
//  Created by Ludovik on 13/04/2021.
//

import Foundation
import RxSwift

class NASAItemDetailViewControllerViewModel: NASAItemViewModelProtocol, NASAItemImageCollectionFetchable {
    
    var nasaItem: NasaItem!
    lazy var service = NasaItemService()
    
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
    
    var imageUrl: String?
    
    
    var imageUrlValue: PublishSubject<String> = PublishSubject()
    var lblTitleText: PublishSubject<String> = PublishSubject()
    var lblPhotographerText: PublishSubject<String> = PublishSubject()
    var lblDescText: PublishSubject<String> = PublishSubject()
    
    
    
    init(ItemViewModelProtocol itemViewModelProtocol: NASAItemViewModelProtocol) {
        self.nasaItem = itemViewModelProtocol.nasaItem
    }
    
    func loadValues(){
        lblTitleText.onNext(title)
        lblPhotographerText.onNext(photographerWithDateText)
        lblDescText.onNext(nasaItem.description ?? "")
        fetchImageCollectionForItem(nasaItem)
        
    }
    
    
    func fetchImageCollectionForItem(_ item: NasaItem) {
        
        if let imageUrl = item.largeImageUrl {
            imageUrlValue.onNext(imageUrl)
            return
        }
        
        service.fetchImageCollection(ForItem: item) {[weak self] (url) in
            guard let `self` = self else {return}
            item.largeImageUrl = url
            self.imageUrlValue.onNext(url)
        } failure: { (error) in
            
        }
    }
    
}

