//
//  DataServices.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 14/11/22.
//

import Foundation

final class DataServices {
    static let sharedInstance = DataServices()
    
    //to pass differnt parameter for same API endpoints 
    var isCreateHeader: Bool = false
    
}
