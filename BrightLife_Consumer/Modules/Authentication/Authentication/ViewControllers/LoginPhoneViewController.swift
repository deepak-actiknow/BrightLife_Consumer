//
//  ViewController.swift
//  BrightLife
//
//  Created by MAC on 31/10/22.
//

import UIKit
import DropDown
import GoogleSignIn
import FirebaseAuth
import FirebaseCore
import FBSDKLoginKit

class LoginPhoneViewController: UIViewController {
    
    @IBOutlet weak var dropDownCodeButton: UIButton!
    
    @IBOutlet weak var loginMainView: UIView!
    @IBOutlet weak var termsOfUseButton: UIButton!
    @IBOutlet weak var privacyPolicyButtonButton: UIButton!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryCodeNumLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var googleSignInButton: UIButton!
    @IBOutlet weak var faceBookSignInButton: UIButton!
    
    
    let dropDown = DropDown()
    var countryCodeArr: [String] = ["IND +91", "AUS +61","USA +1", "PAK +91", "ENG +44", "CHN +86"]
    var receivedPhoneNumber: String = ""
    let signInConfig = GIDConfiguration(clientID: "142258145373-k947ofh06v0d0k1rm11qa9ejatc9h2q9.apps.googleusercontent.com")
    var nameOfFbUser: String = ""
    var emailOfFbUser: String = ""
    var birthdayOfFBUser: String = ""
    var genderOfFBUser: String = ""
    var emailOfGoogleUser: String = ""
    
    let authVM = AuthenticationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        faceBookLogin()
        googleLogin()
        
        receivedPhoneNumber = phoneNumberTextField.text ?? ""
        UserDefaults.standard.set(phoneNumberTextField.text, forKey: "phoneNumber")
        UserDefaults.standard.synchronize()
        //UserDefaults.standard.set(receivedPhoneNumber, forKey: "phoneText")
        loginMainView.makeRoundCorners()
        
        dropDownActivate()
        
    }
    
    //MARK: - Button Actions
    
    @IBAction func actionDropDownCodeButton(_ sender: Any) {
        dropDown.show()
    }
    
    
    @IBAction func actionSendOtp(_ sender: Any) {
        authVM.sendOtp(target: self, number: phoneNumberTextField.text!, role: "Client")
    }
    
    @IBAction func actionPrivacyPolicy(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func actiontermsOfUse(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "TermsOfUseViewController") as! TermsOfUseViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func actionGoogleSignIn (_ Sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            
            let userProfile = user.profile
            let emailAddress = user.profile?.email
            let fullName = user.profile?.name
            let givenName = user.profile?.givenName
            let familyName = user.profile?.familyName
            
            
            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            print("\n")
            print("User Profile Data: \(String(describing: userProfile))")
            print("Name: \(String(describing: fullName))")
            print("emailAddress: \(String(describing: emailAddress))")
            print("GivenName: \(String(describing: givenName))")
            print("FamilyName: \(String(describing: familyName))")
            print("profilePicUrl: \(String(describing: profilePicUrl))")
            
            self.emailOfGoogleUser = emailAddress ?? ""
            self.authVM.checkEmail(target: self, email: self.emailOfGoogleUser, role: "Client")
            
            let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "GoogleProfileViewController") as! GoogleProfileViewController
            viewController.nameOfUser = fullName ?? ""
            viewController.emailOfUser = emailAddress ?? ""
            //            viewController.emailLabel.isHidden = true
            //            viewController.emailTextView.isHidden = true
            //            viewController.emailLabel.isHidden = true
            //            viewController.emailTextField.isHidden = true
        //    self.navigationController?.pushViewController(viewController, animated: true)
            
            
            user.authentication.do { authentication, error in
                guard error == nil else { return }
                guard let authentication = authentication else { return }
                
                let idToken = authentication.idToken
                // Send ID token to backend (example below).
                self.tokenSignInExample(idToken: idToken ?? "")
            }
            
            
            // If sign in succeeded, display the app's main content View.
            
        }
        
        
        
        
    }
    
    @IBAction func actionfaceBookLogin(_ sender: Any) {
        
        let fbLoginManager : LoginManager = LoginManager()
        
        fbLoginManager.logIn(permissions: ["public_profile","email"], from: self) { (result, error) in
            
            if (error == nil) {
                let fbloginresult : LoginManagerLoginResult = result!
                    if let token = AccessToken.current,
                                  !token.isExpired {
                                  // User is logged in, do work such as go to next view controller.
                                let token = token.tokenString
                                let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields" : " id, email, first_name, last_name, picture, short_name, name, middle_name, name_format, age_range, birthday, gender, profile_pic"], tokenString: token, version: nil, httpMethod: .get)
                                request.start { (connection, result, error) in
                                    if error == nil {
                                        let dict = result as! [String: AnyObject] as NSDictionary
                    
                                        let name = dict.object(forKey: "name") as! String
                                        let email = dict.object(forKey: "email") as! String
                                        let birthday = dict.object(forKey: "birthday") as! String
                                        let gender = dict.object(forKey: "gender") as! String
                    
                                        self.nameOfFbUser = name
                                        self.emailOfFbUser = email
                                        self.birthdayOfFBUser = birthday
                                        self.genderOfFBUser = gender
                    
                                        print("Name: \(name)")
                                        print("Email: \(email)")
                                        print("Birthday: \(birthday)")
                                        print("Gender: \(gender)")
                                    } else {
                                        print(error?.localizedDescription as Any)
                                    }
                                }
                    
                                let viewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "GoogleProfileViewController") as! GoogleProfileViewController
                                viewController.emailLabel.isHidden = false
                                viewController.emailTextField.isHidden = false
                                viewController.nameOfUser = self.nameOfFbUser
                                viewController.emailOfUser = self.emailOfFbUser
                                //viewController.dateOfBirthTextField = birthdayOfFBUser
                                self.navigationController?.pushViewController(viewController, animated: true)
                            }
                        
                        
                    }
                }
            }
        
        //MARK: - Different Functions
        
        //MARK: - FUNCTION FOR DROPDOWN
        func dropDownActivate() {
            dropDown.anchorView = dropDownCodeButton
            dropDown.dataSource = countryCodeArr
            
            dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
            dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
            dropDown.direction = .bottom
            
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.countryCodeLabel.text = countryCodeArr[index]
            }
        }
        
        
        //MARK: - sending token to server - google Auth
        func tokenSignInExample(idToken: String) {
            guard let authData = try? JSONEncoder().encode(["idToken": idToken]) else {
                return
            }
            let url = URL(string: "https://yourbackend.example.com/tokensignin")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.uploadTask(with: request, from: authData) { data, response, error in
                // Handle response from your backend.
                if data != nil && error == nil {
                    do {
                        _ = try JSONEncoder().encode(idToken)
                    } catch let error {
                        debugPrint(error.localizedDescription)
                    }
                }
            }
            task.resume()
        }
                
        //MARK: - google Login Function
        func googleLogin () {
            if GIDSignIn.sharedInstance.hasPreviousSignIn() {
                GIDSignIn.sharedInstance.restorePreviousSignIn()
            }
        }
    }
    

    //MARK: - extension for facebook login action
    extension LoginPhoneViewController: LoginButtonDelegate {
        func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
            let token = result?.token?.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email,name, first_name, last_name, picture, short_name, name, middle_name, name_format, age_range"], tokenString: token, version: nil, httpMethod: .get)
            request.start { (connection, result, error) in
                print("\(result ?? "")")
            }
        }
        func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
            print("LogOut")
        }
    }

