//
//  NASAItemListViewControllerViewModel.swift
//  NASAApp
//
//  Created by Ludovik on 13/04/2021.
//

import Foundation
import RxSwift

final class NASAItemListViewControllerViewModel: NASAItemsManageable {
    

    var nasaItems: PublishSubject<[NASAItemListViewControllerTableViewCellViewModel]> = PublishSubject()
    var isLoading: PublishSubject<Bool> = PublishSubject()
    var error: PublishSubject<APiManager.ApiError> = PublishSubject()
    var isLoadingNextPage: PublishSubject<Bool> = PublishSubject()
    var service: NasaItemServiceProtocol!
    var nextUrl: String?
    
    private var rawItems: [NASAItemListViewControllerTableViewCellViewModel] = [] {
        didSet {
            self.nasaItems.onNext(rawItems)
        }
    }
    
    init(Service service:NasaItemServiceProtocol = NasaItemService()) {
        self.service = service
    }
    
    
    func refreshItems(){
        isLoading.onNext(true)
        service.fetchNasaItems(NextUrl: nil) {[weak self] (nasaItems, nextUrl) in
            guard let `self` = self else {return}
            self.isLoading.onNext(false)
            self.updateDataWithItems(nasaItems)
            self.nextUrl = nextUrl
        } failure: {[weak self] (error) in
            guard let `self` = self else {return}
            self.isLoading.onNext(false)
            self.error.onNext(error)
        }
    }
    
    func loadMoreItems() {
        
        guard let nextUrl = nextUrl else {
            isLoadingNextPage.onNext(false)
            return
        }
        isLoadingNextPage.onNext(true)
        service.fetchNasaItems(NextUrl: nextUrl) {[weak self] (nasaItems, nextUrl) in
            guard let `self` = self else {return}
            self.isLoadingNextPage.onNext(false)
            self.updateDataWithItems(nasaItems)
            self.nextUrl = nextUrl
        } failure: {[weak self] (error) in
            guard let `self` = self else {return}
            self.isLoadingNextPage.onNext(false)
            self.error.onNext(error)
        }
    }
    
    private func updateDataWithItems(_ items: [NasaItem]){
        var currentItems = rawItems
        currentItems.append(contentsOf: items.map{NASAItemListViewControllerTableViewCellViewModel(nasaItem: $0)})
        self.rawItems = currentItems
    }
    
}
