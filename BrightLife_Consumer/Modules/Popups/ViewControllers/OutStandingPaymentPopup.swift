//
//  OutStandingPaymentPopup.swift
//  BrightLife_Consumer
//
//  Created by Madhuraj on 11/11/22.
//

import UIKit

class OutStandingPaymentPopup: UIViewController {
    
    @IBOutlet weak var bottomConstraits: NSLayoutConstraint!
    
    var success: ((_ ammount: String)->Void) = {_  in}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bottomConstraits.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        bottomConstraits.constant = -280
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view.removeFromSuperview()
         }
        
    }
    
}
extension UIViewController {
    func showOutStandingPaymentPopup(success: @escaping ((_ ammount: String)->Void)) {
        let storyboard = UIStoryboard(name: "Popup", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "OutStandingPaymentPopup") as! OutStandingPaymentPopup
        controller.success = success
        addChild(controller)
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
}
