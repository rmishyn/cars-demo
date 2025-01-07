//
//  UITableViewCell+Extension.swift
//  Cars Finder
//
//  Created by Ruslan Mishyn on 07.01.2025.
//

import UIKit

extension UITableViewCell {
    class func registerWithNib(for tableView: UITableView) {
        let cellIdentifier = self.identifier
        tableView.register(self, forCellReuseIdentifier: cellIdentifier)
        let cellNib = UINib(nibName: identifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }
}
