//
//  FeelingsViewController.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 09/11/22.
//

import UIKit

class FeelingsViewController: UIViewController {
    @IBOutlet weak var navBarView: UIView!

    @IBOutlet weak var angerButton: UIButton!
    @IBOutlet weak var guiltButton: UIButton!
    @IBOutlet weak var fearButton: UIButton!
    @IBOutlet weak var sadnessButton: UIButton!
    @IBOutlet weak var lonelinessButton: UIButton!
    @IBOutlet weak var lifePressureButton: UIButton!
    @IBOutlet weak var stressButton: UIButton!
    @IBOutlet weak var burnOutButton: UIButton!
    @IBOutlet weak var datingButton: UIButton!
    @IBOutlet weak var marriageButton: UIButton!
    @IBOutlet weak var siblingButton: UIButton!
    @IBOutlet weak var parentsButton: UIButton!
    @IBOutlet weak var defiantBehaveButton: UIButton!
    @IBOutlet weak var tantrumsButton: UIButton!
    @IBOutlet weak var teenageIssueButton: UIButton!
    
    //@IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarView.dropShadow()
        
        
        
    }
    @IBAction func selectedEmotionsButton(sender: UIButton) {
        
        angerButton.isEnabled = true
        guiltButton.isEnabled = true
        fearButton.isEnabled = true
        sadnessButton.isEnabled = true
        lonelinessButton.isEnabled = true
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            // set deselected
            sender.isSelected = false
            sender.backgroundColor = UIColor(red: 0.93, green: 0.90, blue: 1.00, alpha: 1.00)
            sender.borderColor = UIColor(red: 0.49, green: 0.39, blue: 0.82, alpha: 1.00)
            sender.setTitleColor(.black, for: .selected)
            //self.continueButton.backgroundColor = UIColor(red: 0.49, green: 0.39, blue: 0.82, alpha: 1.00)
            print("button is selected")
        } else {
            // set selected
            sender.isSelected = true
            sender.backgroundColor = UIColor.white
            sender.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            print("button is DeSelected")
        }
        sender.isSelected.toggle()
    }
    
    
    @IBAction func selectedProfessionalButton(sender: UIButton) {
        
        switch sender {
        case lifePressureButton:
            lifePressureButton.isSelected = true
            stressButton.isSelected = false
            burnOutButton.isSelected = false
            stressButton.backgroundColor = UIColor.white
            stressButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            burnOutButton.backgroundColor = UIColor.white
            burnOutButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
        case stressButton:
            lifePressureButton.isSelected = false
            stressButton.isSelected = true
            burnOutButton.isSelected = false
            lifePressureButton.backgroundColor = UIColor.white
            lifePressureButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            burnOutButton.backgroundColor = UIColor.white
            burnOutButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
        case burnOutButton:
            lifePressureButton.isSelected = false
            stressButton.isSelected = false
            burnOutButton.isSelected = true
            stressButton.backgroundColor = UIColor.white
            stressButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            lifePressureButton.backgroundColor = UIColor.white
            lifePressureButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
        default:
            print("Default")
        }
        if sender.isSelected {
            // set deselected
             sender.isSelected = false
            sender.backgroundColor = UIColor(red: 0.93, green: 0.90, blue: 1.00, alpha: 1.00)
            sender.borderColor = UIColor(red: 0.49, green: 0.39, blue: 0.82, alpha: 1.00)
            sender.setTitleColor(.black, for: .selected)
            //self.continueButton.backgroundColor = UIColor(red: 0.49, green: 0.39, blue: 0.82, alpha: 1.00)
            print("Selected")
        }
        else {
            // set selected
            sender.isSelected = true
            sender.backgroundColor = UIColor.white
            sender.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            print("Deselected")
        }
        sender.isSelected.toggle()
      
    }
    
    @IBAction func selectedRelationshipButton(sender: UIButton) {
        
        switch sender.tag {
        case 1:
            datingButton.isSelected = true
            marriageButton.isSelected = false
            siblingButton.isSelected = false
            parentsButton.isSelected = false
            marriageButton.backgroundColor = UIColor.white
            marriageButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            siblingButton.backgroundColor = UIColor.white
            siblingButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            parentsButton.backgroundColor = UIColor.white
            parentsButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
   
        case 2:
            datingButton.isSelected = false
            marriageButton.isSelected = true
            siblingButton.isSelected = false
            parentsButton.isSelected = false
            datingButton.backgroundColor = UIColor.white
            datingButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            siblingButton.backgroundColor = UIColor.white
            siblingButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            parentsButton.backgroundColor = UIColor.white
            parentsButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)

        case 3:
            datingButton.isSelected = false
            marriageButton.isSelected = false
            siblingButton.isSelected = true
            parentsButton.isSelected = false
            datingButton.backgroundColor = UIColor.white
            datingButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            marriageButton.backgroundColor = UIColor.white
            marriageButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            parentsButton.backgroundColor = UIColor.white
            parentsButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)


        case 4:
            datingButton.isSelected = false
            marriageButton.isSelected = false
            siblingButton.isSelected = false
            parentsButton.isSelected = true
            datingButton.backgroundColor = UIColor.white
            datingButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            marriageButton.backgroundColor = UIColor.white
            marriageButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            siblingButton.backgroundColor = UIColor.white
            siblingButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)

        default:
            print("no button selected")
        }
      //  sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            sender.isSelected = false
            sender.backgroundColor = UIColor(red: 0.93, green: 0.90, blue: 1.00, alpha: 1.00)
            sender.borderColor = UIColor(red: 0.49, green: 0.39, blue: 0.82, alpha: 1.00)
            sender.setTitleColor(.black, for: .selected)
            //self.continueButton.backgroundColor = UIColor(red: 0.49, green: 0.39, blue: 0.82, alpha: 1.00)
            print("button selected")
        } else {
            sender.isSelected = true
            sender.backgroundColor = UIColor.white
            sender.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            print("button DeSelected")
        }
        sender.isSelected.toggle()
    }
    
    @IBAction func selectedChildrenButton(sender: UIButton) {
        
        
        
        switch sender.tag {
        case 1:
            defiantBehaveButton.isSelected = true
            tantrumsButton.isSelected = false
            teenageIssueButton.isSelected = false
            tantrumsButton.backgroundColor = UIColor.white
            tantrumsButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            teenageIssueButton.backgroundColor = UIColor.white
            teenageIssueButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
        case 2:
            defiantBehaveButton.isSelected = false
            tantrumsButton.isSelected = true
            teenageIssueButton.isSelected = false
            defiantBehaveButton.backgroundColor = UIColor.white
            defiantBehaveButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            teenageIssueButton.backgroundColor = UIColor.white
            teenageIssueButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
        case 3:
            defiantBehaveButton.isSelected = false
            tantrumsButton.isSelected = false
            teenageIssueButton.isSelected = true
            defiantBehaveButton.backgroundColor = UIColor.white
            defiantBehaveButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            tantrumsButton.backgroundColor = UIColor.white
            tantrumsButton.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
        default:
            print("No button Selected")
        }
        
        
      //  sender.isSelected = !sender.isSelected
        
        
        if sender.isSelected {
            // set deselected
            sender.isSelected = false
            sender.backgroundColor = UIColor(red: 0.93, green: 0.90, blue: 1.00, alpha: 1.00)
            sender.borderColor = UIColor(red: 0.49, green: 0.39, blue: 0.82, alpha: 1.00)
            sender.setTitleColor(.black, for: .selected)
           // self.continueButton.backgroundColor = UIColor(red: 0.49, green: 0.39, blue: 0.82, alpha: 1.00)
            print("Selected")
        } else {
            // set selected
            sender.isSelected = true
            sender.backgroundColor = UIColor.white
            sender.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            print("Deselected")
        }
        sender.isSelected.toggle()
    }
    
    @IBAction func SearchButtonAction(_ sender: Any) {
        let viewController = UIStoryboard(name: "ExploreSB", bundle: .main).instantiateViewController(withIdentifier: "LifeCoachViewController") as! LifeCoachViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func notificationButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "notify", sender: self)
    }
    
    @IBAction func actionWalletButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toWallet", sender: self)
    }
    
    
}
