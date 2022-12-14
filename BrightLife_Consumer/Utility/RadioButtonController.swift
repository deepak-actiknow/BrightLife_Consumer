//
//  RadioButtonController.swift
//  BrightLife
//
//  Created by MAC on 31/10/22.
//

import Foundation
import UIKit

class RadioButtonController: NSObject {
    var buttonsArray: [UIButton]! {
        didSet {
            for b in buttonsArray {
                b.setImage(UIImage(named: "radioOffBlack"), for: .normal)
                b.setImage(UIImage(named: "radioOn"), for: .selected)
            }
        }
    }
    var selectedButton: UIButton?
    var defaultButton: UIButton = UIButton() {
        didSet {
            buttonArrayUpdated(buttonSelected: self.defaultButton)
        }
    }

    func buttonArrayUpdated(buttonSelected: UIButton) {
        for b in buttonsArray {
            if b == buttonSelected {
                selectedButton = b
                b.isSelected = true
            } else {
                b.isSelected = false
            }
        }
    }
    
    func buttonArrayMultipleSelected (buttonsSelected: UIButton) {
        for b in buttonsArray {
            if b == buttonsSelected {
                selectedButton = b
                b.isSelected = true
            }
        }
    }
}

