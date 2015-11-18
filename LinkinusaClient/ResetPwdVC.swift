//
//  ResetPwdVC.swift
//  LinkinusaClient
//
//  Created by Qiang Zhang on 11/4/15.
//  Copyright © 2015 Unity Global Corp. All rights reserved.
//

import Foundation

import UIKit

class ResetPwdVC : UIViewController, NSURLConnectionDelegate {
    @IBOutlet weak var email: UITextField!

    lazy var data = NSMutableData()

    @IBAction func resetPwd(sender: AnyObject) {
        let textField : NSString = email.text! as NSString
        print(textField)

        if ( textField.isEqualToString("")) {
            let alert = UIAlertController(title: "", message: "登录密码不能为空！", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "确认", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else
        {
            startConnection()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
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
        let urlPath : NSString = "http://linkinusa-backend.herokuapp.com/api/resetPwd/\(email.text!)"
        let urlStr : NSString = urlPath.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let url: NSURL = NSURL(string: urlStr as String)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
    }

    func connection(connection: NSURLConnection, didReceiveData data: NSData){
        self.data.appendData(data)
    }

    func connectionDidFinishLoading(connection: NSURLConnection) {
        let jsonResult: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
        let status = jsonResult["status"] as? String

        if (status == "0"){
            let alert = UIAlertController(title: "", message: "恭喜，密码重置链接已发送到您的邮箱，请进入邮箱重置密码！", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "确认", style: .Default, handler: {
                action in
                self.performSegueWithIdentifier("submit", sender: self)
    }))
            self.presentViewController(alert, animated: true, completion: nil)
        } else
        {
            let alert = UIAlertController(title: "", message: "未知错误，请重试！", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "确认", style: .Default, handler: {action in
                self.email.text = ""
    }))
            self.presentViewController(alert, animated: true, completion: nil)
        }


    }

}