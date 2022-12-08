//
//  FeelingsViewController.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 09/11/22.
//

import UIKit

class FeelingsViewController: UIViewController {
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //@IBOutlet weak var continueButton: UIButton!
    var arrCollectionTypeCoach: [String] = ["Relationship Coach", "Parenting Coach", "Emotional Wellbeing Coach", "Life Coach", "Career Coach", "Couple's Coach"]
    
    var feelingsVM = ExploreViewModel()
    var categoryDataList: [[String: Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarView.dropShadow()
        
        feelingsVM.getCategoryList { result in
            self.categoryDataList = result
            self.collectionView.reloadData()
        }

    }

    @IBAction func notificationButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "notify", sender: self)
    }
    
    @IBAction func actionWalletButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toWallet", sender: self)
    }
}

extension FeelingsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoachSelectionCell", for: indexPath) as! CoachSelectionCell
        let data = categoryDataList[indexPath.row]
        cell.labelCoach.text = data[kName] as? String ?? ""
        cell.imageTypeCoach.image = String.base64Convert(data[kImage] as? String ?? "")()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = UIStoryboard(name: "ExploreSB", bundle: .main).instantiateViewController(withIdentifier: "LifeCoachViewController") as! LifeCoachViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width-32) / 2.1, height: 98)
    }
}
