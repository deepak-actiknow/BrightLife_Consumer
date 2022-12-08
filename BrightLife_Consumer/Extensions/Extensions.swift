//
//  Extensions.swift
//  BrightLife
//
//  Created by MAC on 31/10/22.
//

import Foundation
import UIKit

//MARK: - extension for making top right and left corners round
extension UIView {
    func makeRoundCorners() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}

//MARK: - extension for downloading any image by just providing url of that image
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

//MARK: - extension for making text inside button with an underline
extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        //NSAttributedStringKey.foregroundColor : UIColor.blue
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    // MARK: - UIButton+Aligment

        func alignContentVerticallyByCenter(offset:CGFloat = 10) {
            let buttonSize = frame.size

            if let titleLabel = titleLabel,
                let imageView = imageView {

                if let buttonTitle = titleLabel.text,
                    let image = imageView.image {
                    let titleString:NSString = NSString(string: buttonTitle)
                    let titleSize = titleString.size(withAttributes: [
                        NSAttributedString.Key.font : titleLabel.font as Any
                        ])
                    let buttonImageSize = image.size

                    let topImageOffset = (buttonSize.height - (titleSize.height + buttonImageSize.height + offset)) / 2
                    let leftImageOffset = (buttonSize.width - buttonImageSize.width) / 2
                    imageEdgeInsets = UIEdgeInsets(top: topImageOffset,
                                                   left: leftImageOffset,
                                                   bottom: 0,right: 0)

                    let titleTopOffset = topImageOffset + offset + buttonImageSize.height
                    let leftTitleOffset = (buttonSize.width - titleSize.width) / 2 - image.size.width

                    titleEdgeInsets = UIEdgeInsets(top: titleTopOffset,
                                                   left: leftTitleOffset,
                                                   bottom: 0,right: 0)
                }
            }
        }
    
}

@IBDesignable extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 1

        layer.shadowPath = UIBezierPath(rect: CGRect(x: self.frame.origin.x, y: self.frame.origin.x, width: UIScreen.main.bounds.width, height: self.frame.height)).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var shadowColor: UIColor?{
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
        get{
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
    }

    @IBInspectable var shadowOpacity: Float{
        set {
            layer.shadowOpacity = newValue
        }
        get{
            return layer.shadowOpacity
        }
    }

    @IBInspectable var shadowOffset: CGSize{
        set {
            layer.shadowOffset = newValue
        }
        get{
            return layer.shadowOffset
        }
    }

    @IBInspectable var shadowRadius: CGFloat{
        set {
            layer.shadowRadius = newValue
        }
        get{
            return layer.shadowRadius
        }
    }
}

//MARK: - Alert view for asking confirmation
extension UIViewController {

func AskConfirmation (title:String, message:String, completion:@escaping (_ result:Bool) -> Void) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    self.present(alert, animated: true, completion: nil)

    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
        completion(true)
    }))

    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
        completion(false)
    }))
  }
}

//MARK: - EXTENSION FOR USERDEFAULTS

//extension UserDefaults {
//    func setIsLoggedIn (value: Bool) {
//        setValue(value, forKey: "isLoggedIn")
//    }
//
//    func isLoggedIn() -> Bool {
//        return bool(forKey: "isLoggedIn")
//    }
//
//}

//MARK: - extension for UIWindow

extension UIWindow {
    class func topWindow() -> UIWindow? {
        for window in UIApplication.shared.windows.reversed() {
            if window.windowLevel == UIWindow.Level.normal && !window.isHidden && window.frame != CGRect.zero { return window }
        }
        return nil
    }
}


//MARK: - Extension: String

extension String {
    func base64Convert() -> UIImage{
        if (self.isEmpty) {
            return UIImage()
        } else {
            let temp = self.components(separatedBy: ",")
            let dataDecoded : Data = Data(base64Encoded: temp[1], options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            return decodedimage!
        }
    }
}





