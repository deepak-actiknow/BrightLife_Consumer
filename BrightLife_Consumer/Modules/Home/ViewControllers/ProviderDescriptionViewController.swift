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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarView.dropShadow()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func quickChatButtonAction(_ sender: Any) {
        self.showChatPaymentPopup { ammount in
        }
//        SBUGlobals.currentUser = SBUUser(userId: "raj")
//        let channelListVC = SBUGroupChannelViewController(channelURL: "sendbird_group_channel_223009464_3f4d30f10942103d1b7289f1ee08f0b5944e5c76")
//
//        let naviVC = UINavigationController(rootViewController: channelListVC)
//        self.present(naviVC, animated: true)
    }
    
    @IBAction func bookSessionButonAction(_ sender: Any) {
        self.showOutStandingPaymentPopup { ammount in
        }
    }
    
}
