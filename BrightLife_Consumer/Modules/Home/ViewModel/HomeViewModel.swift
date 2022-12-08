//
//  HomeViewModel.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 30/11/22.
//

import UIKit

class HomeViewModel {
    
    func getProviderList (role: String, isFav: Bool = false, isCategory: String = "", completion: @escaping(_ result: [[String: Any]]) -> Void) {
        DataServices.sharedInstance.isCreateHeader = true
        var  param = [
            kRole: role
        ] as! [String: AnyObject]
        if isFav {
            param[kIsFavorite] = 1 as AnyObject
        }
        if isCategory != "" {
            param[kCategoryId] = isCategory as AnyObject
        }
        APIServices.sharedInstance.getProviderList(params: param) { response, status in
           
            guard status else {
                Toast.show(message: kSometingWrong)
                return
            }
            print(response as Any)
            completion(response ?? [])
        }
    }

    //MARK: - to add favorite provider from home
    func favouriteProviderClicked (target: UIViewController, favouriteUserId: Int) {
        let param = [
            kFavouriteUserId: favouriteUserId
        ] as! [String: AnyObject]
        APIServices.sharedInstance.favouriteProvider(params: param) { response, status in
            guard status else {
                Toast.show(message: kSometingWrong)
                return
            }
            guard response?[kMessage] as? String ?? "" == "Provider mark as favourite successfully" else {
                return
            }
        }
    }
    
    
}
