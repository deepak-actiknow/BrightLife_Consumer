//
//  ExploreViewModel.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 02/12/22.
//

import UIKit

class ExploreViewModel {
    
    func getCategoryList (completion: @escaping (_ result: [[String: Any]]) -> Void) {
        let param = [:] as [String: AnyObject]
        APIServices.sharedInstance.getCategoryData(params: param) { response, status in
            guard status else {
                Toast.show(message: kSometingWrong)
                return
            }
            print(response as Any)
            completion(response ?? [])
        } 
    }
}

