//
//  ProfileViewController.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 10/11/22.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var nameInProfile: String = ""
    var mobileInProfile: String = ""
    var emailInProfile: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
//        nameLabel.text = UserDefaults.standard.string(forKey: "nameInEditProfile")
//        nameLabel.text = nameInProfile
//        mobileLabel.text = mobileInProfile
//        emailLabel.text = emailInProfile
       // EditProfileViewController.delegate = self
        navigationBar.dropShadow()
    }

    @IBAction func actionEditButton(_ sender: Any) {
        let viewController = UIStoryboard(name: "Profile", bundle: .main).instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        viewController.delegate = self
    }
    
    
    @IBAction func actionSettingsButton(_ sender: Any) {
        let viewController = UIStoryboard(name: "Profile", bundle: .main).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func actionBookingHistory(_ sender: Any) {
        let viewController = UIStoryboard(name: "Profile", bundle: .main).instantiateViewController(withIdentifier: "BookingHistoryViewController") as! BookingHistoryViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func actionBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ProfileViewController: DelegateProtocol {
    func didReceiveAllTheDetails(name: String, phone: String, email: String) {
        self.nameLabel.text = name
        self.mobileLabel.text = phone
        self.emailLabel.text = email
    }
    
    
}
