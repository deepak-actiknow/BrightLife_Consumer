//
//  PhoneProfileViewController.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 04/11/22.
//

import UIKit
import DropDown


class PhoneProfileViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTexField: UITextField!
    @IBOutlet weak var datePickerButton: UIButton!
    @IBOutlet weak var radioMale: UIButton!
    @IBOutlet weak var radioFemale: UIButton!
    @IBOutlet weak var radioOthers: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    
    
    let radioController = RadioButtonController ()
    
    var radioButtonTitle: String = ""
    var nameOfUser: String = ""
    var emailOfUser: String = ""
    var birthdayOfUser: String = ""
    var genderOfUSer: String = ""
    var phoneNumber: String = ""
    let authVM = AuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.text = nameOfUser
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailTexField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        radioController.selectedButton?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        RadioButtonInitiate()
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        if nameTextField.text == ""  {
            continueButton.isEnabled = false
            continueButton.backgroundColor = UIColor(red: 0.23, green: 0.22, blue: 0.22, alpha: 1.00)
        }else{
            continueButton.isEnabled = true
            continueButton.backgroundColor = UIColor(red: 0.49, green: 0.39, blue: 0.82, alpha: 1.00)
        }
    }
    
    
    //  MARK: - RADIO BUTTON INITIATE
    func RadioButtonInitiate () {
        radioController.buttonsArray = [radioMale, radioFemale, radioOthers]
        radioController.defaultButton = radioMale
    }
    
    @IBAction func datePicketButtonAction(_ sender: UIButton) {
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
        let emailText = emailTexField.text
        //let dOBText = dateOfBirthTextField.text
        
        if (nameText!.isEmpty || emailText!.isEmpty ) {
            AlertUtility().showAlert(title: "Attention!", message: "Fill All the required Fields", buttonTitle: "OK", viewController: self)
            return
        } else if (nameText!.isEmpty) {
            AlertUtility().showAlert(title: "Attention!", message: "Fill Your Name ", buttonTitle: "OK", viewController: self)
            return
        } else if (emailText!.isEmpty) {
            AlertUtility().showAlert(title: "Attention!", message: "Fill Phone Number", buttonTitle: "OK", viewController: self)
            return
        } else  {
            authVM.createProfile(target: self, name: nameTextField.text!, email: emailTexField.text!, phone: phoneNumber, dOB: datePickerButton.titleLabel?.text ?? "", gender: genderOfUSer, role: "Client")
        }
    }

    
}
