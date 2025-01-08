//
//  String+Extension.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import Foundation

extension String {
    var urlValue: URL? {
        URL(string: self)
    }
}
