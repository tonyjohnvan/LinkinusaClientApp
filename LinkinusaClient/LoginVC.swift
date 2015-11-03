//
//  LoginView.swift
//  LinkinusaClient
//
//  Created by Fan Zhang on 9/29/15.
//  Copyright © 2015 TJV Studio. All rights reserved.
//

import Foundation



import UIKit

class LoginVC: UIViewController, NSURLConnectionDelegate {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var regesterBtn: UIButton!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var LoadingIndicator: UIView!
    @IBOutlet weak var loadingIcon: UIActivityIndicatorView!
//    @IBOutlet var textFieldToBottomLayoutGuideConstraint: NSLayoutConstraint!
    
    lazy var data = NSMutableData()
    
    // white status bar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func LoginBtn(sender: AnyObject) {
        let username:NSString = txtUsername.text! as NSString
        let password:NSString = txtPassword.text! as NSString
        
        if ( username.isEqualToString("") || password.isEqualToString("") ) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "All fields are required"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else {
            // get user info from API
            startConnection()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadingIndicator.hidden = true
        
        // rounded corner
        loginBtn.layer.cornerRadius = 8
        regesterBtn.layer.cornerRadius = 8
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        loadingIcon.startAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func startConnection(){
        LoadingIndicator.hidden = false
        let username:String = txtUsername.text!
        let password:String = txtPassword.text!
        let urlPath: String = "http://linkinusa-backend.herokuapp.com/api/merchantLogin/\(username)/\(password)"
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData){
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        LoadingIndicator.hidden = true
        let jsonResult: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
        let status : String = jsonResult.valueForKey("status") as! String
        if (status == "0"){
            let merchantId: String = jsonResult.valueForKey("merchantId") as! String
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            prefs.setObject(merchantId, forKey: "merchantId")
            prefs.synchronize()
            self.performSegueWithIdentifier("login", sender: self)
        } else if (status == "1"){
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Customers are not allowed to login!"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else if(status == "2"){
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Username or password incorrect!"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        data.setData(NSData())
    }
    
    
}