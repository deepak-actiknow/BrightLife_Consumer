//
//  GoogleProfileViewController.swift
//  BrightLife
//
//  Created by MAC on 31/10/22.
//

import UIKit
import DropDown


class GoogleProfileViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var datePickerButton: UIButton!
    @IBOutlet weak var dropDownCodeButton: UIButton!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryCodeNumLabel: UILabel!
    @IBOutlet weak var radioMale: UIButton!
    @IBOutlet weak var radioFemale: UIButton!
    @IBOutlet weak var radioOthers: UIButton!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var continueButton: UIButton!
    let dropDown = DropDown()
    var countryCodeArr: [String] = ["IND +91", "AUS +61","USA +1", "PAK +91", "ENG +44", "CHN +86"]
    let radioController = RadioButtonController ()
    
    var radioButtonTitle: String = ""
    var nameOfUser: String = ""
    var emailOfUser: String = ""
    var birthdayOfUser: String = ""
    var genderOfUSer: String = ""
    var emaillabelText: String = ""
 

    var authVM = AuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = emailOfUser
        nameTextField.text = nameOfUser
        
        //adding targets to enable continue button
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        datePickerButton.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        radioController.selectedButton?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        RadioButtonInitiate()
        dropDownActivate()
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        if nameTextField.text == "" {
                continueButton.isEnabled = false
                continueButton.backgroundColor = UIColor(red: 0.23, green: 0.22, blue: 0.22, alpha: 1.00)
            }else{
                 continueButton.isEnabled = true
                continueButton.backgroundColor = UIColor(red: 0.49, green: 0.39, blue: 0.82, alpha: 1.00)
            }
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
    
    @IBAction func datePickerAction(_ sender: UIButton) {
        self.showDatePickerPopup { selectedDate in
            sender.setTitle(selectedDate, for: .normal)
            self.birthdayOfUser = sender.titleLabel?.text ?? ""
        }
    }
    
    @IBAction func changeGender(sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }
        
        switch button.tag {
        case 1:
            // Change to Male
            radioController.buttonArrayUpdated(buttonSelected: sender as! UIButton)
            radioButtonTitle = "Male"

        case 2:
            // Change to Female
            radioController.buttonArrayUpdated(buttonSelected: sender as! UIButton)
            radioButtonTitle = "Female"

        case 3:
            // Change to Others
            radioController.buttonArrayUpdated(buttonSelected: sender as! UIButton)
            radioButtonTitle = "Others"

        default:
            print("Are You Alien ?")
            return
        }
        genderOfUSer = radioButtonTitle

    }
    
    @IBAction func actionContinue(_ sender: Any) {
        
        let nameText = nameTextField.text
        let phonetext = phoneNumberTextField.text
        //let dOBText = datePickerButton.titleLabel?.text ?? ""
        
        if (nameText!.isEmpty || phonetext!.isEmpty) {
            AlertUtility().showAlert(title: "Attention!", message: "Fill All the required Fields", buttonTitle: "OK", viewController: self)
            return
        } else if (nameText!.isEmpty) {
            AlertUtility().showAlert(title: "Attention!", message: "Fill Your Name ", buttonTitle: "OK", viewController: self)
               return
           } else if (phonetext!.isEmpty) {
               AlertUtility().showAlert(title: "Attention!", message: "Fill Phone Number", buttonTitle: "OK", viewController: self)
               return
           }
//        else if ((datePickerButton.titleLabel?.text?.isEmpty) != nil) {
//               AlertUtility().showAlert(title: "Attention!", message: "Fill Date Of Birth", buttonTitle: "OK", viewController: self)
//               return
//   }
            else {
               //self.performSegue(withIdentifier: "loggedin", sender: self)
                authVM.createProfile(target: self, name: nameTextField.text ?? "", email: emailOfUser, phone: phoneNumberTextField.text ?? "", dOB: datePickerButton.titleLabel?.text ?? "", gender: genderOfUSer, role: "Client")
           }
        
    }
}
