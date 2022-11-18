//
//  FavouriteViewController.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 09/11/22.
//

import UIKit

class FavouriteViewController: UIViewController {
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var tableView: UITableView!

   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarView.dropShadow()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func actionWalletButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toWallet", sender: self)
    }
    
    @IBAction func notificationButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "notify", sender: self)
    }

}
extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
       // tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FavouriteCell")
        return cell
    }
    
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toLifeCoachDescription", sender: self)
    }
    
}
