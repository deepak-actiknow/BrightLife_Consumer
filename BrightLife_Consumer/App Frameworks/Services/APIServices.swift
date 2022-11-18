//
//  APIServices.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 14/11/22.
//

import Foundation
import UIKit

final class APIServices {
    let myGroup = DispatchGroup()
    //shared instance of the class
    static let sharedInstance = APIServices()
    
    
    
    //MARK: - Login With Phone API
    func phoneLogin(params: [String: AnyObject], completion:@escaping (_ otp: String?, _ status: Bool) -> Void) {
        ServiceHelper.sharedInstanceHelper.createRequest(method: "POST", showHud: true, params:params as [String : AnyObject], apiName: kLogin) { (result, error) in
            guard error == nil else {
                completion(nil, false)
                return
            }
            print(result as Any)
            guard (result as? [String: Any] ?? [:])[kSuccess] as? Int ?? 0 == 1 else {
                Toast.show(message: (result as? [String: Any] ?? [:])[kMessage] as? String ?? "")
                return
            }
            let otpValue = (result as? [String: Any] ?? [:])[kOTP] as? String ?? ""
            completion(otpValue, true)
            
        }
    }
    
    //MARK: - Verify OTP API
    func otpVerify(params: [String: AnyObject], completion:@escaping (_ otp: [String: Any]?, _ status: Bool) -> Void) {
        ServiceHelper.sharedInstanceHelper.createRequest(method: "POST", showHud: true, params:params as [String : AnyObject], apiName: kVerifyOTP) { (result, error) in
            guard error == nil else {
                completion(nil, false)
                return
            }
            print(result as Any)
            guard (result as? [String: Any] ?? [:])[kSuccess] as? Int ?? 0 == 1 else {
                Toast.show(message: (result as? [String: Any] ?? [:])[kMessage] as? String ?? "")
                return
            }
            let response = (result as? [String: Any] ?? [:])
            completion(response, true)
            
        }
    }
    
}
