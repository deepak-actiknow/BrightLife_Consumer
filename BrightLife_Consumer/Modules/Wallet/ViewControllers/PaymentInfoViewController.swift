//
//  PaymentInfoViewController.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 11/11/22.
//

import UIKit

class PaymentInfoViewController: UIViewController {
    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var gstAmountLabel: UILabel!
    @IBOutlet weak var payableAmountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.dropShadow()
    }
    
    @IBAction func actionBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func actionProceedToPay(_ sender: Any) {
        let viewController = UIStoryboard(name: "Wallet", bundle: .main).instantiateViewController(withIdentifier: "ConfirmationViewController") as! ConfirmationViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
}
