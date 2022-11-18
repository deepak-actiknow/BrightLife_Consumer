//
//  WalletHistoryViewController.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 11/11/22.
//

import UIKit

class WalletHistoryViewController: UIViewController {
    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.dropShadow()
    }
    @IBAction func actionBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension WalletHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletHistoryCell", for: indexPath) as! WalletHistoryCell
        if indexPath.row % 2 == 0 {
            cell.amountLabel.text = "+ ₹100"
            cell.amountLabel.textColor = UIColor.green
            cell.titleHistory.text = "Add Money"
        } else {
            cell.amountLabel.text = "- ₹100"
            cell.amountLabel.textColor = UIColor.red
            cell.titleHistory.text = "Chat with Peyush Bhatia"
        }
        return cell
    }
    
}
