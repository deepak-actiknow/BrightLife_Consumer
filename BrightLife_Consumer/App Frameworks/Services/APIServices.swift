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
    
    //MARK: - create User: in Profile viewController
    
    func createUser(params: [String: AnyObject], completion: @escaping (_ status: Bool) -> Void) {
        ServiceHelper.sharedInstanceHelper.createRequest(method: "POST", showHud: true, params: params as [String : AnyObject], apiName: kCreate) { result, error in
            guard error == nil else {
                completion(false)
                return
            }
            print(result as Any)
            guard (result as? [String: Any] ?? [:])[kSuccess] as? Int ?? 0 == 1 else {
                Toast.show(message: (result as? [String: Any] ?? [:])[kMessage] as? String ?? "")
                return
            }
            //let response = (result as? [String: Any] ?? [:])
            let tokenId = result?.object(forKey: "token") as! String
            UserDefaults.standard.set(tokenId, forKey: "Token")
            UserDefaults.standard.synchronize()
            print(tokenId as String)
            completion(true)
        }
    }
    
    //MARK: -  Login With Google
    
    func checkEmail (params: [String: AnyObject], completion: @escaping (_ result: [String: Any]?, _ status: Bool) -> Void) {
        ServiceHelper.sharedInstanceHelper.createRequest(method: "GET", showHud: true, params: params as [String: AnyObject], apiName: kCheckEmail) { result, error in
            guard error == nil else {
                completion(nil, false)
                return
            }
            print(result as Any)
            guard (result as? [String: Any] ?? [:])[kSuccess] as? Int ?? 0 == 1 else {
                Toast.show(message: (result as? [String: Any] ?? [:])[kMessage] as? String ?? "")
                return
            }
            let tokenId = result?.object(forKey: "token") as! String
            UserDefaults.standard.set(tokenId, forKey: "Token")
            UserDefaults.standard.synchronize()
            print(tokenId as String)
            let response = (result as? [String: Any] ?? [:])
            completion(response, true)
        }
    }
    
    //MARK: - SeekViewController
    
    func userSeeks (params: [String: AnyObject], completion: @escaping (_ status: Bool) -> Void) {
        ServiceHelper.sharedInstanceHelper.createRequest(method: "POST", showHud: true, params: params as [String: AnyObject], apiName: kUserSeek) { result, error in
            guard error == nil else {
                completion(false)
                return
            }
            print(result as Any)
            guard (result as? [String: Any] ?? [:])[kSuccess] as? Int ?? 0 == 1 else {
                Toast.show(message: (result as? [String: Any] ?? [:])[kMessage] as? String ?? "")
                return
            }
          //  let response = (result as? [String: Any] ?? [:])
            completion(true)
        }
    }
    
    
    //MARK: - Get user seek list
    
    func getSeekList (params: [String: AnyObject], completion: @escaping (_ result: [[String: Any]]?, _ status: Bool) -> Void) {
        ServiceHelper.sharedInstanceHelper.createRequest(method: "GET", showHud: true, params: params, apiName: kSeekList) { result, error in
            guard error == nil else {
                completion(nil, false)
                return
            }
            print(result as Any)
            guard (result as? [String: Any] ?? [:])[kSuccess] as? Int ?? 0 == 1 else {
                Toast.show(message: (result as? [String: Any] ?? [:])[kMessage] as? String ?? "")
                return
            }
            let seekListJson = result?[kData] as! [[String: Any]]
            completion(seekListJson, true)
        }
    }
    
    //MARK: - Get provider list, will show the data in main screeen
    
    func getProviderList (params: [String: AnyObject], completion: @escaping (_ result: [[String: Any]]?, _ status: Bool) -> Void) {
        ServiceHelper.sharedInstanceHelper.createRequest(method: "GET", showHud: true, params: params, apiName: kProvider) { result, error in
            guard error == nil else {
                completion(nil, false)
                return
            }
            print(result as Any)
            guard (result as? [String: Any] ?? [:])[kSuccess] as? Int ?? 0 == 1 else {
                Toast.show(message: (result as? [String: Any] ?? [:])[kMessage] as? String ?? "")
                return
            }
            let providerList = result?[kData] as! [[String: Any]]
            completion(providerList, true)
        }
    }
    
    
    //MARK: - favourite provider - when fav button at right would be clicked, this would hit up
    
    func favouriteProvider (params: [String: AnyObject], completion: @escaping (_ result: [String: Any]?, _ status: Bool) -> Void) {
        ServiceHelper.sharedInstanceHelper.createRequest(method: "POST", showHud: true, params: params, apiName: kFavouriteProvider) { result, error in
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
    
    //MARK: - Category Data in collection View
    
    func getCategoryData (params: [String: AnyObject], completion: @escaping (_ result: [[String: Any]]?, _ status: Bool) -> Void)  {
        ServiceHelper.sharedInstanceHelper.createRequest(method: "GET", showHud: true, params: params, apiName: KCategory) { result, error in
            guard error == nil else {
                completion(nil, false)
                return
            }
            print(result as Any)
            guard (result as? [String: Any] ?? [:])[kSuccess] as? Int ?? 0 == 1 else {
                Toast.show(message: (result as? [String: Any] ?? [:])[kMessage] as? String ?? "")
                return
            }
            let categoryList = result?[kData] as! [[String: Any]]
            completion(categoryList, true)
        }
        
        
    }
    
    
    
}







