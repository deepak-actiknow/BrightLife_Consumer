//
//  SettingsViewController.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 10/11/22.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var navigationBar: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.dropShadow()
    }
    @IBAction func actionBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
