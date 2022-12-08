//
//  AuthViewModel.swift
//  BrightLife_Consumer
//
//  Created by Madhuraj on 17/11/22.
//

import UIKit

class AuthenticationViewModel {
    //MARK: - Send OTP ViewModel
    func sendOtp(target: UIViewController, number: String, role: String) {
        let param = [
            kPhone: number,
            kRole: role
        ] as! [String: AnyObject]
        
        guard number.count == 10 else {
            Toast.show(message: "Invalid Number!")
            return
        }
        APIServices.sharedInstance.phoneLogin(params: param) { otp, status in
            guard status else {
                Toast.show(message: kSometingWrong)
                return
            }
            let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "OtpVerificationViewController") as! OtpVerificationViewController
            viewController.mobileNumber = number
            target.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    //MARK: - Verify OTP ViewModel
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
            
            //if user is registered, user will go homepage directly, if not registered, then will go to PhoneProfileViewController
            guard response?[kMessage] as? String ?? "" == "Please Register" else {
                target.performSegue(withIdentifier: "goToHomeVC", sender: target)
                return
            }
            let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "PhoneProfileViewController") as! PhoneProfileViewController
            viewController.phoneNumber = number
            target.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    //MARK: - Create User ViewModel
    
    func createProfile (target: UIViewController, name: String, email: String, phone: String, dOB: String, gender: String, role: String) {
        let param = [
            kName: name,
            kEmail: email,
            kDOB: dOB,
            kGender: gender,
            kPhone: phone,
            kRole: role
        ] as! [String: AnyObject]
        APIServices.sharedInstance.createUser(params: param) { status in
            guard status else {
                Toast.show(message: kSometingWrong)
                return
            }
            let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "SeekViewController") as! SeekViewController
            target.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    //MARK: - GoogleSignIn ViewModel
    
    func checkEmail (target: UIViewController, email: String, role: String) {
        let param = [
            kEmail: email,
            kRole: role
        ] as! [String: AnyObject]
        APIServices.sharedInstance.checkEmail(params: param) { response, status in
            guard status else {
                Toast.show(message: kSometingWrong)
                return
            }
            print(response as Any)
            guard response?[kMessage] as? String ?? "" == "Email not exist" else {
                target.performSegue(withIdentifier: "goToHomeVC", sender: target)
                return
            }
            
            let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "GoogleProfileViewController") as! GoogleProfileViewController
            viewController.emailOfUser = email
            target.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    //MARK: - SeekList
    
        func getSeekList (target: SeekViewController) {
                    let param = [:] as [String: AnyObject]
            APIServices.sharedInstance.getSeekList(params: param) { (response, status) in
                guard status else {
                 Toast.show(message: kSometingWrong)
                 return
                }
                print(response as Any)
                var seekNameList: [String] = []
                var seekNameIdList: [Int] = []
                let seekList = response ?? [[:]]
                for seekName in seekList {
                 //   seekNameList.append(contentsOf: seekName[kName] as! [String])
                    seekNameList.append(seekName[kName] as! String)
                    seekNameIdList.append(seekName[kId] as! Int)
                }
//                guard response?[kMessage] as? String ?? "" == "Seeks List" else {
//                    return
//                }
                target.arrTableItems = seekNameList
                target.seekIndexId = seekNameIdList
                target.tableView.reloadData()
            }
         }

    
    //MARK: - SeekVC
    
    func userSeek (target: UIViewController, seeks: String) {
        let param = [
            kSeek: seeks
        ] as! [String: AnyObject]
        APIServices.sharedInstance.userSeeks(params: param) { status in
            guard status else {
                Toast.show(message: kSometingWrong)
                return
            }
            target.performSegue(withIdentifier: "loggedin", sender: target)
        }
    }
    
    
}

