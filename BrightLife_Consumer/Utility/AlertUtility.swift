//
//  AlertUtility.swift
//  BrightLife
//
//  Created by MAC on 01/11/22.
//

import Foundation
import UIKit

class AlertUtility {
    var alert = UIAlertController()
    
    func showAlert (title: String, message: String, buttonTitle: String, viewController: UIViewController) {
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { UIAlertAction in
            self.alert.dismiss(animated: true)
        }))
        viewController.present(alert, animated: true)
    }
}
