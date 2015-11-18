//
//  VerifyVC.swift
//  LinkinusaClient
//
//  Created by Fan Zhang on 9/29/15.
//  Copyright © 2015 TJV Studio. All rights reserved.
//

import Foundation

import UIKit

class VerifyVC : UIViewController, NSURLConnectionDelegate {
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

    @IBAction func actLogout(sender: AnyObject) {
        let alert = UIAlertController(title: "登出", message: "您确定要登出系统？未保存的修改将丢失", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { action in
            let appDomain = NSBundle.mainBundle().bundleIdentifier
            NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)

            let alert = UIAlertController(title: "", message: "登出成功!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "确认", style: .Default, handler: { action in
                self.performSegueWithIdentifier("logout1", sender: self)
    }))
            self.presentViewController(alert, animated: true, completion: nil)

        }))
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    let verifyCodeLength = 16

    lazy var data = NSMutableData()

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
        //order verification
        let orderNum: NSString = verifyLabel.text! as NSString
        if (orderNum.isEqualToString("")){
            let alert = UIAlertController(title: "", message: "订单号不能为空！", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "确认", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else
        {
            startConnection()
        }
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

    func startConnection(){
        let orderNum : String = verifyLabel.text!
        let urlPath: String = "http://linkinusa-backend.herokuapp.com/api/scanOrder/\(orderNum)"
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
    }

    func connection(connection: NSURLConnection, didReceiveData data: NSData){
        self.data.appendData(data)
    }

    func connectionDidFinishLoading(connection: NSURLConnection) {
        let jsonResult: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
        let status : String = jsonResult.valueForKey("status") as! String
        print(status)
        if(status == "0"){
            let alert = UIAlertController(title: "", message: "订单验证成功!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "确认", style: .Default, handler: {action in
                self.verifyLabel.text = ""
    }))
            self.presentViewController(alert, animated: true, completion: nil)
        }else if(status == "1")
        {
            let alert = UIAlertController(title: "", message: "请勿重复验证!", preferredStyle: .Alert)
            print(status)
            alert.addAction(UIAlertAction(title: "确认", style: .Default, handler: {action in
                self.verifyLabel.text = ""
    }))
            self.presentViewController(alert, animated: true, completion: nil)
        }else if(status == "2")
        {
            let alert = UIAlertController(title: "", message: "订单不存在!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "确认", style: .Default, handler: {action in
                self.verifyLabel.text = ""
    }))
            self.presentViewController(alert, animated: true, completion: nil)
        }else if(status == "3")
        {
            let alert = UIAlertController(title: "", message: "未知错误，请重试!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "确认", style: .Default, handler: {action in
                self.verifyLabel.text = ""
    }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        data.setData(NSData())
    }


}