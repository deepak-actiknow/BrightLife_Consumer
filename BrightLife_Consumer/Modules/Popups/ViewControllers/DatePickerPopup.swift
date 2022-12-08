//
//  DatePickerPopup.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 24/11/22.
//

import UIKit

class DatePickerPopup: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var bottomConstraits: NSLayoutConstraint!
    var success: ((_ selectedDate: String)->Void) = {_  in}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bottomConstraits.constant = 0
        datePicker.maximumDate = Date()
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
    
    @IBAction func dateSelected(_ sender: Any) {
        bottomConstraits.constant = -280
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            self.success(formatter.string(from: self.datePicker.date))
            self.view.removeFromSuperview()
         }
    }
    

}
extension UIViewController {
    func showDatePickerPopup(success: @escaping ((_ selectedDate: String)->Void)) {
        let storyboard = UIStoryboard(name: "Popup", bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: "DatePickerPopup") as! DatePickerPopup
        controller.success = success
        addChild(controller)
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
}
