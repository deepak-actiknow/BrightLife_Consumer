//
//  HomeViewController.swift
//  BrightLife_Consumer
//
//  Created by Madhuraj on 07/11/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var navBarView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarView.dropShadow()
        // Do any additional setup after loading the view.
    }
    @IBAction func notificationButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "notify", sender: self)
    }

    @IBAction func actionWalletButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toWallet", sender: self)
    }

}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        return cell
    }
    
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDescription", sender: self)
    }
    
}
