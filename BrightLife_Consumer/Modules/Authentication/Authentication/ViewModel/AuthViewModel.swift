//
//  AuthViewModel.swift
//  BrightLife_Consumer
//
//  Created by Madhuraj on 17/11/22.
//

import Foundation
import UIKit

class AuthenticationViewModel {
    
    func sendOtp(target: UIViewController, number: String) {
        guard number.count == 10 else {
            Toast.show(message: "Invalid Number!")
            return
        }
        APIServices.sharedInstance.phoneLogin(params: [kPhone: number as AnyObject]) { otp, status in
            let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "OtpVerificationViewController") as! OtpVerificationViewController
            viewController.mobileNumber = number
            target.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
    func verifyOTP(target: UIViewController, number: String, otp: String) {
        let param = [
            kPhone: number,
            kOTP: otp
        ] as! [String: AnyObject]
        APIServices.sharedInstance.otpVerify(params: param) { response, status in
            guard status else {
                Toast.show(message: kSometingWrong)
                return
            }
            guard response?[kMessage] as? String ?? "" == "Please Register" else {
                return
            }
            let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "PhoneProfileViewController") as! PhoneProfileViewController
            target.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
}
