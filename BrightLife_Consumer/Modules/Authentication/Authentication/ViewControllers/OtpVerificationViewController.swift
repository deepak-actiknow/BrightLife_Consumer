//
//  MobileVerificationViewController.swift
//  BrightLife
//
//  Created by MAC on 01/11/22.
//

import UIKit

class OtpVerificationViewController: UIViewController {
        @IBOutlet weak var otpSentMessageLabel: UILabel!
        @IBOutlet weak var otpSentMobilelabel: UILabel!

        @IBOutlet weak var firstDigitField: SingleDigitField!
        @IBOutlet weak var secondDigitField: SingleDigitField!
        @IBOutlet weak var thirdDigitField: SingleDigitField!
        @IBOutlet weak var fourthDigitField: SingleDigitField!
    
        @IBOutlet weak var resendCodeTimerLabel: UILabel!
        @IBOutlet weak var resendCodeButton: UIButton!
    
        @IBOutlet weak var incorrectOtpView: UIView!
    
    @IBOutlet weak var verifyButton: UIButton!
    
        let authVM = AuthenticationViewModel()
        var mobileNumber: String = ""
        var resendCodeCounter = 30
        var resendCodeTimer = Timer()
    
   // var phoneLabelValue = UserDefaults.standard.string(forKey: "phoneText" )
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstDigitField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        secondDigitField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        thirdDigitField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        fourthDigitField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        
        resendCodeTimerLabel.text = ""
        sendOTPCode()
        otpSentMobilelabel.text = mobileNumber
        otpSentMessageLabel.text = "We have sent an OTP on your number"
        
        
//MARK: - methods for regulating OTP textFields
        [firstDigitField,secondDigitField,thirdDigitField,fourthDigitField].forEach {
            $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        }
        // make the firsDigitField the first responder
        firstDigitField.isUserInteractionEnabled = true
        firstDigitField.becomeFirstResponder()
        
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        if firstDigitField.text == "" || secondDigitField.text == "" || thirdDigitField.text == "" || fourthDigitField.text == "" {
                verifyButton.isEnabled = false
                verifyButton.backgroundColor = UIColor(red: 0.23, green: 0.22, blue: 0.22, alpha: 1.00)
            }else{
                 verifyButton.isEnabled = true
                verifyButton.backgroundColor = UIColor(red: 0.49, green: 0.39, blue: 0.82, alpha: 1.00)
            }
        }
    
    @objc func editingChanged(_ textField: SingleDigitField) {
        // check if the deleteBackwards key was pressed
        if textField.pressedDelete {
            // reset its state
            textField.pressedDelete = false
            // if the field has text empty its content
            if textField.hasText {
                textField.text = ""
            } else {
                // otherwise switch the field, resign the first responder and activate the previous field and empty its contents
                switch textField {
                case secondDigitField, thirdDigitField, fourthDigitField:
                    textField.resignFirstResponder()
                    textField.isUserInteractionEnabled = false
                    switch textField {
                    case secondDigitField:
                        firstDigitField.isUserInteractionEnabled = true
                        firstDigitField.becomeFirstResponder()
                        firstDigitField.text = ""
                    case thirdDigitField:
                        secondDigitField.isUserInteractionEnabled = true
                        secondDigitField.becomeFirstResponder()
                        secondDigitField.text = ""
                    case fourthDigitField:
                        thirdDigitField.isUserInteractionEnabled = true
                        thirdDigitField.becomeFirstResponder()
                        thirdDigitField.text = ""
                    default:
                        break
                    }
                default: break
                }
            }
        }
        // make sure there is only one character and it is a number otherwise delete its contents
        guard textField.text?.count == 1, textField.text?.last?.isWholeNumber == true else {
            textField.text = ""
            return
        }
        // switch the textField, resign the first responder and make the next field active
        switch textField {
        case firstDigitField, secondDigitField, thirdDigitField:
            textField.resignFirstResponder()
            textField.isUserInteractionEnabled = false
            switch textField {
            case firstDigitField:
                secondDigitField.isUserInteractionEnabled = true
                secondDigitField.becomeFirstResponder()
            case secondDigitField:
                thirdDigitField.isUserInteractionEnabled = true
                thirdDigitField.becomeFirstResponder()
            case thirdDigitField:
                fourthDigitField.isUserInteractionEnabled = true
                fourthDigitField.becomeFirstResponder()
            default: break
            }
        case fourthDigitField:
            fourthDigitField.resignFirstResponder()
        default: break
        }
    }
    
    
    func sendOTPCode() {
    //Whatever your api logic
        // if OTP is being sent
              self.resendCodeTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimerLabel), userInfo: nil, repeats: true)
            
    }
    
    @objc func updateTimerLabel() {
      resendCodeCounter -= 1
      resendCodeTimerLabel.text = "in \(resendCodeCounter) seconds."
      if resendCodeCounter == 0 {
        resendCodeButton.isEnabled = true
        resendCodeTimer.invalidate()
          resendCodeTimerLabel.isHidden = true
      }
    }
    
    deinit{
        resendCodeTimer.invalidate()
    }
    
    @IBAction func resendAgainButtonClicked(_ sender: UIButton) {
        firstDigitField.text = ""
        secondDigitField.text = ""
        thirdDigitField.text = ""
        fourthDigitField.text = ""
        resendCodeCounter = 31
        resendCodeButton.isEnabled = false
        sendOTPCode()
      }
    
    @IBAction func verifyButtonClicked(_ sender: UIButton) {
        //Concatenated otp
        let otp: String = firstDigitField.text! + secondDigitField.text! + thirdDigitField.text! + fourthDigitField.text!
        print(otp)
        guard otp.count == 4 else {
           // self.verifyButton.backgroundColor = UIColor(red: 0.23, green: 0.22, blue: 0.22, alpha: 1.00)
            incorrectOtpView.isHidden = false
            firstDigitField.isError = true
            secondDigitField.isError = true
            thirdDigitField.isError = true
            fourthDigitField.isError = true
            return
        }
        //self.verifyButton.backgroundColor = UIColor(red: 0.49, green: 0.39, blue: 0.82, alpha: 1.00)
        firstDigitField.isError = false
        secondDigitField.isError = false
        thirdDigitField.isError = false
        fourthDigitField.isError = false
        incorrectOtpView.isHidden = true
        authVM.verifyOTP(target: self, number: mobileNumber, otp: otp)
    }
}

