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
}
