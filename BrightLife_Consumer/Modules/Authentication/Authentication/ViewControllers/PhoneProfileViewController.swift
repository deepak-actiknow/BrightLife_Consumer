//
//  PhoneProfileViewController.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 04/11/22.
//

import UIKit
import DropDown
import DatePicker

class PhoneProfileViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTexField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var datePickerButton: UIButton!
    @IBOutlet weak var radioMale: UIButton!
    @IBOutlet weak var radioFemale: UIButton!
    @IBOutlet weak var radioOthers: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    
    let radioController = RadioButtonController ()
    
    var nameOfUser: String = ""
    var emailOfUser: String = ""
    var birthdayOfUser: String = ""
    var genderOfUSer: String = ""
    
    
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
        let minDate = DatePickerHelper.shared.dateFrom(day: 18, month: 08, year: 1940)!
                let maxDate = DatePickerHelper.shared.dateFrom(day: 18, month: 08, year: Calendar.current.component(.year, from: Date()))!
                let today = Date()
                let datePicker = DatePicker()
                datePicker.setup(beginWith: today, min: minDate, max: maxDate) { (selected, date) in
                    if selected, let selectedDate = date {
                        print(selectedDate.stringShort())
                        sender.setTitle(selectedDate.string(), for: .normal)
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
                let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "SeekViewController") as! SeekViewController
                self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    
}
