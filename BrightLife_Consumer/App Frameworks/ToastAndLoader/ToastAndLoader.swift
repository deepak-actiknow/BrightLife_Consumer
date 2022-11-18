//
//  ToastAndLoader.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 14/11/22.
//

import UIKit
import Toast_Swift

let LoadingIndicatorTag = 9864

struct Toast {
    
    static func show(message:String) {
        UIWindow.topWindow()?.makeToast(message)
    }
}

struct Loader {
    static func beginLoading(in view:UIView, allowUserIntraction:Bool) {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.color = UIColor.black
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.tag = LoadingIndicatorTag
        indicator.startAnimating()
        view.isUserInteractionEnabled = allowUserIntraction
    }
    
    static func endLoading(from view:UIView) {
        view.viewWithTag(LoadingIndicatorTag)?.removeFromSuperview()
        view.isUserInteractionEnabled = true
    }
}

protocol Loadable {
    func beginLoading(in view:UIView, allowUserIntraction:Bool)
}

extension Loadable {
    func beginLoading(in view:UIView, allowUserIntraction:Bool = true) {
        Loader.beginLoading(in: view, allowUserIntraction: allowUserIntraction)
    }
    
    func endLoading(from view:UIView) {
        Loader.endLoading(from: view)
    }
}
