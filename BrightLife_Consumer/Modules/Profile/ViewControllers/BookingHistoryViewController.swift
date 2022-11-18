//
//  BookingHistoryViewController.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 10/11/22.
//

import UIKit

class BookingHistoryViewController: UIViewController {
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

extension BookingHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingHistoryCell") as! BookingHistoryCell
        return cell
    }
    
}
