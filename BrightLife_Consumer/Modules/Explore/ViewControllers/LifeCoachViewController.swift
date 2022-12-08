//
//  ExploreViewController.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 09/11/22.
//

import UIKit

class LifeCoachViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var categoryProvidersDataList: [[String: Any]] = []

    var lifeCoachVM = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lifeCoachVM.getProviderList(role: "Provider", isCategory: "1") { result in
            self.categoryProvidersDataList = result
            self.tableView.reloadData()
        }
        
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
 
}
extension LifeCoachViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryProvidersDataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        let data = categoryProvidersDataList[indexPath.row]
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
           // homeVM.favouriteProviderClicked(target: self, favouriteUserId: arrProviderId[indexpathrow])
            self.tableView.reloadData()
        }
      }

    }
    

    

