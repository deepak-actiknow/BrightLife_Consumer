//
//  TermsOfUseViewController.swift
//  BrightLife
//
//  Created by MAC on 01/11/22.
//

import UIKit
import WebKit

class TermsOfUseViewController: UIViewController {
  @IBOutlet weak var webView: WKWebView!

//    override func loadView() {
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        view = webView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://collegezing.com/api/privacyPolicy")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    @IBAction func actionBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }


}
