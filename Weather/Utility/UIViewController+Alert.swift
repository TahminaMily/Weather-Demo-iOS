//
//  UIViewController+Alert.swift
//  Weather
//
//  Created by Tahmina Khanam on 26/2/18.
//

import UIKit

// helper method to show alert on viewcontroller
extension UIViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
