//
//  UIViewController+Extension.swift
//  NASAApp
//
//  Created by Ludovik on 13/04/2021.
//

import Foundation
import UIKit

extension UIViewController {
    static func instantiateForMainStoryBoard(WithIdentifier id: String) -> UIViewController {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: id)
    }
}
