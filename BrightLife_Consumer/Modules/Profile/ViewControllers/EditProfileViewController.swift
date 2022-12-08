//
//  EditProfileViewController.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 10/11/22.
//

import UIKit
import DropDown

protocol DelegateProtocol: AnyObject {
    func didReceiveAllTheDetails(name: String, phone: String, email: String)
}


class EditProfileViewController: UIViewController {
    
    weak var delegate: DelegateProtocol?
    
    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var nameEditProfileTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var dropDownCodeButton: UIButton!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryCodeNumLabel: UILabel!
    @IBOutlet weak var datePickerButton: UIButton!
    @IBOutlet weak var radioMale: UIButton!
    @IBOutlet weak var radioFemale: UIButton!
    @IBOutlet weak var radioOthers: UIButton!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    let dropDown = DropDown()
    var countryCodeArr: [String] = ["IND +91", "AUS +61","USA +1", "PAK +91", "ENG +44", "CHN +86"]
    let radioController = RadioButtonController ()
    
    var nameOfUser: String = ""
    var phoneOfuser: String = ""
    var emailOfUser: String = ""
    var birthdayOfUser: String = ""
    var genderOfUSer: String = ""
//    var emaillabelText: String = "Email Address"
//    var phonelabelText: String = "Phone Number"

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        emailLabel.text = emaillabelText
//        phoneLabel.text = phonelabelText
        nameEditProfileTextField.text = nameOfUser
        emailTextField.text = emailOfUser
        phoneNumberTextField.text = phoneOfuser
       // dateOfBirthTextField.text = birthdayOfUser
        RadioButtonInitiate()
        dropDownActivate()
        UserDefaults.standard.set(nameEditProfileTextField.text, forKey: "nameInEditProfile")
    }
    
    
    
  //MARK: - FUNCTION FOR DROPDOWN
    func dropDownActivate() {
        dropDown.anchorView = dropDownCodeButton
        dropDown.dataSource = countryCodeArr
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.countryCodeLabel.text = countryCodeArr[index]
        }
    }
    
    //  MARK: - RADIO BUTTON INITIATE
    func RadioButtonInitiate () {
        radioController.buttonsArray = [radioMale, radioFemale, radioOthers]
        radioController.defaultButton = radioMale
    }
    
    @IBAction func actionDropDownCodeButton(_ sender: Any) {
        dropDown.show()
    }
    
    @IBAction func changeGender(sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }
        
        switch button.tag {
        case 1:
            // Change to Male
            radioController.buttonArrayUpdated(buttonSelected: sender as! UIButton)
            
        case 2:
            // Change to Female
            radioController.buttonArrayUpdated(buttonSelected: sender as! UIButton)
            
        case 3:
            // Change to Others
            radioController.buttonArrayUpdated(buttonSelected: sender as! UIButton)
            
        default:
            print("Are You Alien ?")
            return
        }
    }
    
    @IBAction func datePickerButton(_ sender: UIButton) {
        self.showDatePickerPopup { selectedDate in
            sender.setTitle(selectedDate, for: .normal)
            self.birthdayOfUser = sender.titleLabel?.text ?? ""
        }
    }
    
    
    @IBAction func actionSaveButton(_ sender: Any) {
        delegate?.didReceiveAllTheDetails(name: nameEditProfileTextField.text!, phone: phoneOfuser, email: emailOfUser)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
