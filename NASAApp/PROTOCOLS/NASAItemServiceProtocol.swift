//
//  NASAItemServiceProtocol.swift
//  NASAApp
//
//  Created by Ludovik on 12/04/2021.
//

import Foundation
import RxSwift


protocol NasaItemServiceProtocol {
    
    func fetchNasaItems(NextUrl nextUrl: String?,
                        success: @escaping (_ items: [NasaItem],_ nextUrl: String?) -> (),
                                failure: @escaping (_ error: APiManager.ApiError) -> ())
    
    func parseData(_ data: Data?) -> ([NasaItem], String?)
    func parseImageCollection(_ data: Data?) -> String?
}


extension NasaItemServiceProtocol {
    
    func parseData(_ data: Data?) -> ([NasaItem], String?){
        guard let data = data else {
            return ([], nil)
        }
        
        do{
            let response = try JSONDecoder().decode(NASAItemsReponse.self, from: data)
            return (response.allItems(), response.collection?.nextUrl)
            
            
        }catch{
            return ([], nil)
        }
    }
    
    func parseImageCollection(_ data: Data?) -> String?{
        guard let data = data else {
            return nil
        }
        do {
            if let results = try JSONSerialization.jsonObject(with: data, options: []) as? [String] {
                return results.first(where: {$0.contains("~orig")}) ?? results.first(where: {$0.contains("~large")})
            }else{
                return nil
            }
        } catch  {
            return nil
        }
    }
    
}
