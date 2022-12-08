//
//  CardView.swift
//  BrightLife_Consumer
//
//  Created by Madhuraj on 07/11/22.
//

import Foundation
import UIKit

class CardView: UIView {

    override func layoutSubviews() {
        layer.cornerRadius = 10
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10)

        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 0.87, green: 0.82, blue: 1.00, alpha: 1.00).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3);
        layer.shadowOpacity = 0.3
        layer.shadowPath = shadowPath.cgPath
    }

}
