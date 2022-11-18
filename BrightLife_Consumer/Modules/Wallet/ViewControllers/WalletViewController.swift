//
//  WalletViewController.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 11/11/22.
//

import UIKit

class WalletViewController: UIViewController {
    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.dropShadow()
    }

    @IBAction func actionHistoryButton (_ sender: Any) {
        let viewController = UIStoryboard(name: "Wallet", bundle: .main).instantiateViewController(withIdentifier: "WalletHistoryViewController") as! WalletHistoryViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func actionBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension WalletViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmountCollectionCell", for: indexPath) as! AmountCollectionCell
        switch indexPath.item {
        case 0:
            cell.amountLabel.text = "₹25"
        case 1:
            cell.amountLabel.text = "₹50"
        case 2:
            cell.amountLabel.text = "₹100"
        case 3:
            cell.amountLabel.text = "₹200"
        case 4:
            cell.amountLabel.text = "₹300"
        case 5:
            cell.amountLabel.text = "₹500"
        case 6:
            cell.amountLabel.text = "₹1000"
        case 7:
            cell.amountLabel.text = "₹2000"
        case 8:
            cell.amountLabel.text = "₹3000"
        case 9:
            cell.amountLabel.text = "₹4000"
        case 10:
            cell.amountLabel.text = "₹5000"
        case 11:
            cell.amountLabel.text = "₹8000"
        default:
            print("hooray!")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
                let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
                let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
                return CGSize(width: size, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = AmountCollectionCell()
        let viewController = UIStoryboard(name: "Wallet", bundle: .main).instantiateViewController(withIdentifier: "PaymentInfoViewController") as! PaymentInfoViewController
        //viewController.totalAmountLabel.text = cell.amountLabel.text
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
