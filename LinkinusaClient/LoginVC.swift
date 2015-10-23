//
//  LoginView.swift
//  LinkinusaClient
//
//  Created by Fan Zhang on 9/29/15.
//  Copyright © 2015 TJV Studio. All rights reserved.
//

import Foundation



import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var regesterBtn: UIButton!
    
    // white status bar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // rounded corner
        loginBtn.layer.cornerRadius = 8
        regesterBtn.layer.cornerRadius = 8
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}