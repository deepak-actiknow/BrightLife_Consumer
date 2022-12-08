//
//  ServiceHelper.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 14/11/22.
//

import Foundation
import Alamofire

typealias progressBlock = (_ progress: Double) -> Void //2
typealias completionBlock = (_ response: Any?, _ error: Error?) -> Void //3

final class ServiceHelper {
    
    //shared instance of Class
    class var sharedInstanceHelper: ServiceHelper {
        struct Static {
            static let instance = ServiceHelper()
        }
        return Static.instance
    }
    
    
    /// Create Request for webservice
    ///
    /// - Parameters:
    ///   - method: request type (post, get, put)
    ///   - params: request parameters
    ///   - apiName: api name to create url
    ///   - completionHandler: closure
    
    
    func createRequest(method: String,showHud :Bool, params: [String: AnyObject]!, apiName: String, completionHandler:@escaping (_ response: AnyObject?, _ error: NSError?) -> Void) {
        let parameters = params
        let url = kBaseURL + apiName
        if showHud {
            Loader.beginLoading(in: UIWindow.topWindow()!, allowUserIntraction: false)
        }
        var headers: HTTPHeaders? = nil
        if apiName != kLogin && apiName != kCreate && apiName != kCheckEmail && apiName != kVerifyOTP {
            let TokenID = UserDefaults.standard.string(forKey: "Token") ?? ""
            headers = [
                "x-access-token": "\(TokenID)",
                "Accept": "application/json"
            ]
        } else {
            if DataServices.sharedInstance.isCreateHeader {
                let TokenID = UserDefaults.standard.string(forKey: "Token") ?? ""
                headers = [
                    "x-access-token": "\(TokenID)",
                    "Accept": "application/json"
                ]
                DataServices.sharedInstance.isCreateHeader = false
            }
        }
        
        
        
        AF.request(url, method: HTTPMethod(rawValue: method), parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            if showHud {
                Loader.endLoading(from: UIWindow.topWindow()!)
            }
            switch response.result {
            case .success(let value):
                if let JSON = value as? [String: Any] {
                    if JSON[kMessage] as? String == "Unauthenticated." {
                        let domain = Bundle.main.bundleIdentifier!
                        UserDefaults.standard.removePersistentDomain(forName: domain)
                        UserDefaults.standard.synchronize()
                        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                        if let topController = keyWindow?.rootViewController as? UINavigationController {
                            let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "LoginPhoneViewController") as! LoginPhoneViewController
                            topController.pushViewController(viewController, animated: true)
                        }
                    } else {
                        completionHandler(JSON as AnyObject?, nil)
                    }
                }
            case .failure(let error):
            print(error as AnyObject? as Any)
            completionHandler(nil, error as NSError?)
            }
        }
        
    }
    
    func createRawRequest(apiName: String, params: [String: AnyObject]!, completionHandler:@escaping (_ response: AnyObject?, _ error: NSError?) -> Void) {
        let urlString = kBaseURL + apiName
        guard let url = URL(string: urlString) else {return}
        var request        = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody   = try JSONSerialization.data(withJSONObject: params!)
        } catch let error {
            print("Error : \(error.localizedDescription)")
        }
        Loader.beginLoading(in: UIWindow.topWindow()!, allowUserIntraction: false)
        AF.request(request).responseJSON{ response in
            Loader.endLoading(from: UIWindow.topWindow()!)
            switch response.result {
            case .success(let value):
                if let JSON = value as? [String: Any] {
                    if JSON[kMessage] as? String == "Unauthenticated." {
                        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                        if let topController = keyWindow?.rootViewController as? UINavigationController {
                            let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "LoginPhoneViewController") as! LoginPhoneViewController
                            topController.pushViewController(viewController, animated: true)
                        }
                    } else {
                        completionHandler(JSON as AnyObject?, nil)
                    }
                }
            case .failure(let error):
            print(error as AnyObject? as Any)
            completionHandler(nil, error as NSError?)
            }
        }
    } 
}
