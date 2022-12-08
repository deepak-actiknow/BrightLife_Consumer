//
//  ProviderDescriptionViewController.swift
//  BrightLife_Consumer
//
//  Created by Madhuraj on 09/11/22.
//

import UIKit
import SendbirdChatSDK
//import SendBirdUIKit

class ProviderDescriptionViewController: UIViewController {
   
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var profileView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarView.dropShadow()
        //self.profileView.dropShadow()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func quickChatButtonAction(_ sender: Any) {
        self.showChatPaymentPopup { ammount in
        }
    }
    
    @IBAction func bookSessionButonAction(_ sender: Any) {
        self.showOutStandingPaymentPopup { ammount in
        }
    }
}

extension ProviderDescriptionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoachPhotoCollectionCell", for: indexPath) as! CoachPhotoCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width-32) / 2.1, height: 72)
    }
}
    
    
    
