//
//  CustomImageView.swift
//  NASAApp
//
//  Created by Ludovik on 14/04/2021.
//


import Foundation
import UIKit
import RxSwift

class CustomImageView: UIImageView {
    
    var url: String?
    
    var updatedImage: PublishSubject<UIImage> = PublishSubject()

    override var image: UIImage?{
        didSet{
            if let image = image {
                updatedImage.onNext(image)
            }
        }
    }
    
    
    func downloadImageFromUrl(_ url: String?){
        self.url = url
        loadImage(fromURL: url)
    }
    
    
    func clear(){
        url = nil
        image = nil
    }
    
    private func loadImage(fromURL url: String?) {
        guard let url = url, let imageURL = URL(string: url) else {
            return
        }
        
        let cache =  OfflineImageCacher.instance.cache
        let request = URLRequest(url: imageURL)
        DispatchQueue.global(qos: .userInitiated).async {[weak self] in
            if let data = cache?.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.update(toImage: image, FromDownloadedUrl: url)
                }
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache?.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            self?.update(toImage: image, FromDownloadedUrl: url)
                        }
                    }
                }).resume()
                
                
            }
        }
    }
    

    private func update(toImage image: UIImage?, FromDownloadedUrl downloadedUrl: String) {
        guard let url = url , url == downloadedUrl else {
            return
        }
        self.image = image
    }
    
}
