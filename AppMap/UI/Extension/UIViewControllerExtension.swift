//
//  UIViewControllerExtension.swift
//  AppMap
//
//  Created by Nicolas on 11/09/22.
//

import UIKit

extension UIViewController {
    
  func showAlert(title: String, message: String = "") {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "OK", style: .default)
    alert.addAction(alertAction)
    present(alert, animated: true)
  }
}
