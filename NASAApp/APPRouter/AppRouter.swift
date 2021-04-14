//
//  AppRouter.swift
//  NASAApp
//
//  Created by Ludovik on 13/04/2021.
//

import Foundation
import  UIKit


///A simple class to manage routing throughout the application
class AppRouter {
    
    static func showNasaItemDetailViewController(NavigationController nav: UINavigationController,
                                                 NasaItemViewModelProtocol itemProtocol: NASAItemViewModelProtocol){
        let detailScreen = NASAItemDetailViewController.instantiateForMainStoryBoard(WithIdentifier: "NASAItemDetailViewController") as! NASAItemDetailViewController
        let viewModel = NASAItemDetailViewControllerViewModel.init(ItemViewModelProtocol: itemProtocol)
        detailScreen.viewModel = viewModel
        nav.pushViewController(detailScreen, animated: true)
    }
}
