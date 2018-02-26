//
//  Identifiable.swift
//  Weather
//
//  Created by Tahmina Khanam on 26/2/18.
//

import Foundation
import UIKit

protocol Identifiable: class {
    static var reuseIdentifier: String { get }
}

extension Identifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Identifiable { }
extension UICollectionViewCell: Identifiable { }
