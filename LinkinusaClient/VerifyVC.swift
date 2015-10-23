//
//  VerifyVC.swift
//  LinkinusaClient
//
//  Created by Fan Zhang on 9/29/15.
//  Copyright © 2015 TJV Studio. All rights reserved.
//

import Foundation

import UIKit

class VerifyVC : UIViewController {
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    @IBOutlet weak var verifyLabel: UILabel!
    
    let verifyCodeLength = 16
    
    @IBAction func btn1TUI(sender: UIButton) {
        if(verifyLabel.text?.characters.count<verifyCodeLength){
            verifyLabel.text = (verifyLabel.text ?? "") + "1"
        }
    }
    @IBAction func btn2TUI(sender: UIButton) {
        if(verifyLabel.text?.characters.count<verifyCodeLength){
            verifyLabel.text = (verifyLabel.text ?? "") + "2"
        }
    }
    @IBAction func btn3TUI(sender: UIButton) {
        if(verifyLabel.text?.characters.count<verifyCodeLength){
            verifyLabel.text = (verifyLabel.text ?? "") + "3"
        }
    }
    @IBAction func btn4TUI(sender: UIButton) {
        if(verifyLabel.text?.characters.count<verifyCodeLength){
            verifyLabel.text = (verifyLabel.text ?? "") + "4"
        }
    }
    @IBAction func btn5TUI(sender: UIButton) {
        if(verifyLabel.text?.characters.count<verifyCodeLength){
            verifyLabel.text = (verifyLabel.text ?? "") + "5"
        }
    }
    @IBAction func btn6TUI(sender: UIButton) {
        if(verifyLabel.text?.characters.count<verifyCodeLength){
            verifyLabel.text = (verifyLabel.text ?? "") + "6"
        }
    }
    @IBAction func btn7TUI(sender: UIButton) {
        if(verifyLabel.text?.characters.count<verifyCodeLength){
            verifyLabel.text = (verifyLabel.text ?? "") + "7"
        }
    }
    @IBAction func btn8TUI(sender: UIButton) {
        if(verifyLabel.text?.characters.count<verifyCodeLength){
            verifyLabel.text = (verifyLabel.text ?? "") + "8"
        }
    }
    @IBAction func btn9TUI(sender: UIButton) {
        if(verifyLabel.text?.characters.count<verifyCodeLength){
            verifyLabel.text = (verifyLabel.text ?? "") + "9"
        }
    }
    @IBAction func btn0TUI(sender: UIButton) {
        if(verifyLabel.text?.characters.count<verifyCodeLength){
            verifyLabel.text = (verifyLabel.text ?? "") + "0"
        }
    }
    @IBAction func btnDeleteTUI(sender: UIButton) {
        if(verifyLabel.text?.characters.count>0){
            let name: String = verifyLabel.text!
            let stringLength = verifyLabel.text?.characters.count
            let substringIndex = stringLength! - 1
            verifyLabel.text = (name as NSString).substringToIndex(substringIndex)
        }
    }
    
    
    @IBAction func btnVerifyTUI(sender: UIButton) {
        //TODO: Your verification code goes to here
    }
    
    
    @IBOutlet weak var topViewWrapper: UIView!
    // white status bar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topViewWrapper.layer.shadowOffset = CGSize(width: 0, height: 2.4)
        topViewWrapper.layer.shadowOpacity = 0.3
        topViewWrapper.layer.shadowRadius = 6
        topViewWrapper.layer.borderWidth = 0
        
        verifyLabel.textColor = UIColor.whiteColor()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}