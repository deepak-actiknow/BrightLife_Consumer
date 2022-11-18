//
//  GoogleProfileViewController.swift
//  BrightLife
//
//  Created by MAC on 31/10/22.
//

import UIKit
import DropDown
import DatePicker

class GoogleProfileViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
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
    @IBOutlet weak var emailTextView: UIView!
    
    @IBOutlet weak var continueButton: UIButton!
    let dropDown = DropDown()
    var countryCodeArr: [String] = ["IND +91", "AUS +61","USA +1", "PAK +91", "ENG +44", "CHN +86"]
    let radioController = RadioButtonController ()
    
    var nameOfUser: String = ""
    var emailOfUser: String = ""
    var birthdayOfUser: String = ""
    var genderOfUSer: String = ""
//    var emaillabelText: String = "Email Address"
//    var phonelabelText: String = "Phone Number"

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        emailLabel.text = emaillabelText
//        phoneLabel.text = phonelabelText
        nameTextField.text = nameOfUser
        dateOfBirthTextField.text = birthdayOfUser
        
        //adding targets to enable continue button
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        dateOfBirthTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        radioController.selectedButton?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        RadioButtonInitiate()
        dropDownActivate()
   
    }
    
    
    @objc func textFieldDidChange(_ sender: UITextField) {
            if nameTextField.text == "" || dateOfBirthTextField.text == ""  {
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
        let minDate = DatePickerHelper.shared.dateFrom(day: 18, month: 08, year: 1990)!
                let maxDate = DatePickerHelper.shared.dateFrom(day: 18, month: 08, year: 2030)!
                let today = Date()
                // Create picker object
                let datePicker = DatePicker()
                // Setup
                datePicker.setup(beginWith: today, min: minDate, max: maxDate) { (selected, date) in
                    if selected, let selectedDate = date {
                        print(selectedDate.string())
                    } else {
                        print("Cancelled")
                    }
                }
                // Display
                datePicker.show(in: self, on: sender)
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
    
    @IBAction func actionContinue(_ sender: Any) {
        
        let nameText = nameTextField.text
        let phonetext = phoneNumberTextField.text
        let dOBText = dateOfBirthTextField.text
        
        if (nameText!.isEmpty || phonetext!.isEmpty || dOBText!.isEmpty) {
            AlertUtility().showAlert(title: "Attention!", message: "Fill All the required Fields", buttonTitle: "OK", viewController: self)
            return
        } else if (nameText!.isEmpty) {
            AlertUtility().showAlert(title: "Attention!", message: "Fill Your Name ", buttonTitle: "OK", viewController: self)
               return
           } else if (phonetext!.isEmpty) {
               AlertUtility().showAlert(title: "Attention!", message: "Fill Phone Number", buttonTitle: "OK", viewController: self)
               return
           } else if (dOBText!.isEmpty) {
               AlertUtility().showAlert(title: "Attention!", message: "Fill Date Of Birth", buttonTitle: "OK", viewController: self)
               return
           } else  {
               self.performSegue(withIdentifier: "loggedin", sender: self)
           }
        
    }
}
