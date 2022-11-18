//
//  SingleDigitField.swift
//  BrightLife
//
//  Created by MAC on 01/11/22.
//

import UIKit

class SingleDigitField: UITextField {
    var pressedDelete = false
    
    // hide cursor
        override func caretRect(for position: UITextPosition) -> CGRect { .zero }
        // hide selection
        override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] { [] }
        // disable copy paste
        override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool { false }
        // override deleteBackward method, set the property value to true and send an action for editingChanged
        override func deleteBackward() {
            pressedDelete = true
            sendActions(for: .editingChanged)
        }
    
    var isError: Bool = false {
        didSet{
            if isError {
                self.layer.borderColor = UIColor(red: 0.86, green: 0.30, blue: 0.27, alpha: 1.00).cgColor
                self.layer.borderWidth = 1
                self.layer.cornerRadius = 5
            } else {
                self.layer.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00).cgColor
                self.layer.borderWidth = 1
                self.layer.cornerRadius = 5
            }
        }
    }
    
}
