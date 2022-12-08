//
//  HomeViewController.swift
//  BrightLife_Consumer
//
//  Created by Madhuraj on 07/11/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var dataList: [[String: Any]] = []

    var homeVM = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarView.dropShadow()
        homeVM.getProviderList(role: "Provider") { result in
            self.dataList = result
            self.tableView.reloadData()
        }
        
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
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        let data = dataList[indexPath.row]
        cell.providerNameLabel.text = data[kName] as? String ?? ""
        cell.providerRatingLabel.text = (data[KUserDetails] as? [String: Any])?[kRating] as? String ?? ""
        cell.providerShortDescriptionLabel.text = (data[KUserDetails] as? [String: Any])?[KShortDescription] as? String ?? ""
        cell.providerImage.downloaded(from: data[kImage] as? String ?? "")
        
        cell.favouriteButton.addTarget(self, action: #selector(favouriteButtonClicked), for: .touchUpInside)
        if data[kIsFavorite] as? Int ?? 0 == 0 {
            cell.favouriteButton.setImage(UIImage(named:"favouriteLoveEmpty"), for: .normal)
        } else {
            cell.favouriteButton.setImage(UIImage(named:"favouriteLove"), for: .normal)
        }
        cell.favouriteButton.tag = indexPath.row
        return cell
    }
    
    @objc func favouriteButtonClicked (sender: UIButton) {
        let indexpathrow = sender.tag
        sender.isSelected.toggle()
        if sender.isSelected {
            print("button isnt tapped as it is deselected")
        } else {
            homeVM.favouriteProviderClicked(target: self, favouriteUserId: indexpathrow)
            self.tableView.reloadData()
        }
      }
        
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDescription", sender: self)
        }
    
    }
    
  
    

