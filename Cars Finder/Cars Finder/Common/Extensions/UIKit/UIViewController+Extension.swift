//
//  UIViewController+Extension.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import UIKit

extension UIViewController {

    static func make(from storyboardName: String, preLoadSetup: ((Self) -> Void)?) -> Self? {
        let vc = UIStoryboard(name: storyboardName, bundle: .main)
            .instantiateViewController(withIdentifier: String(describing: Self.self)) as? Self
        if let vc = vc {
            preLoadSetup?(vc)
        }
        return vc
    }

    static func make(from storyboardName: String) -> Self? {
        make(from: storyboardName, preLoadSetup: nil)
    }

    static func makeFromStoryboard(preLoadSetup: ((UIViewController) -> Void)?) -> Self? {
        make(from: String(describing: Self.self), preLoadSetup: preLoadSetup)
    }

    static func makeFromStoryboard() -> Self? {
        makeFromStoryboard(preLoadSetup: nil)
    }
}

extension UIViewController {
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
