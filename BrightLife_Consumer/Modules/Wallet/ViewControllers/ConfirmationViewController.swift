//
//  ConfirmationViewController.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 11/11/22.
//

import UIKit

class ConfirmationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func actionOkayButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
