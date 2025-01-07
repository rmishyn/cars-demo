//
//  UIApplication+Extension.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import UIKit

extension UIApplication {
    
    static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .first { $0 is UIWindowScene }
            .flatMap { $0 as? UIWindowScene }?
            .windows
            .first(where: \.isKeyWindow)
    }
    
    static var keyWindowScene: UIWindowScene? {
        UIApplication.shared.connectedScenes
            .first { $0 is UIWindowScene }
            .flatMap { $0 as? UIWindowScene }
    }
}
