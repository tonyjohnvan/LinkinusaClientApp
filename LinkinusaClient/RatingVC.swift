//
//  RatingVC.swift
//  LinkinusaClient
//
//  Created by Fan Zhang on 10/20/15.
//  Copyright © 2015 TJV Studio. All rights reserved.
//

import Foundation

import UIKit

class RatingVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate {
    
    @IBOutlet weak var lblAvgScore: UILabel!
    @IBOutlet weak var lbl5sNum: UILabel!
    @IBOutlet weak var lbl4sNum: UILabel!
    @IBOutlet weak var lbl3sNum: UILabel!
    @IBOutlet weak var lbl2sNum: UILabel!
    @IBOutlet weak var lbl1sNum: UILabel!
    @IBOutlet weak var lblNumOfReviews: UILabel!
    
    @IBOutlet weak var topperView: UIView!

    @IBOutlet weak var mainTableView: UITableView!

    lazy var data = NSMutableData()

    @IBAction func actLogout(sender: UIButton) {
        let alert = UIAlertController(title: "登出", message: "您确定要登出系统？未保存的修改将丢失", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    //var rates:[Rate] = RateData
    var rates: [Rate] = []

    // white status bar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func viewWillLayoutSubviews() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // add the shadow of the view
        topperView.layer.shadowColor = UIColor.blackColor().CGColor

        topperView.layer.shadowOffset = CGSizeZero
        topperView.layer.shadowOpacity = 0.5
        topperView.layer.shadowRadius = 5

        // setting up the table view

        mainTableView.allowsSelection = false;
        mainTableView.separatorStyle = .None
        startConnection()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

//        let cell = tableView.dequeueReusableCellWithIdentifier("rateCell", forIndexPath: indexPath)

        let cell = tableView.dequeueReusableCellWithIdentifier("rateCell") as! RateTabelCell


        let oneRate = rates[indexPath.row] as Rate
        cell.lblUsername.text = oneRate.username
        cell.lblContent.text = oneRate.content

        cell.backgroundColor = UIColor.clearColor()

        cell.imageBG.image = UIImage(named: "tabelCardItemBG")

        switch oneRate.star {
            case "1": cell.imageRate.image = UIImage(named: "1sr")
            case "2": cell.imageRate.image = UIImage(named: "2sr")
            case "3": cell.imageRate.image = UIImage(named: "3sr")
            case "4": cell.imageRate.image = UIImage(named: "4sr")
            case "5": cell.imageRate.image = UIImage(named: "5sr")
            default: cell.imageRate.image = UIImage(named: "1sr")
        }
        cell.lblReply.text = oneRate.reply == "" ? "暂无回复内容" : oneRate.reply
        cell.lblReplyDate.text = oneRate.replyDate == "" ? "" : oneRate.replyDate

        cell.btnReply.tag = indexPath.row
        cell.btnReply.addTarget(self, action: "cellButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)

        return cell
//        return UITableViewCell()
    }

    func cellButtonClicked(sender: UIButton!) {

        let buttonRow = sender.tag

        print("Button \(buttonRow) tapped")

        //1. Create the alert controller.
        let alert = UIAlertController(title: "\(rates[buttonRow].username)的留言", message: rates[buttonRow].content, preferredStyle: .Alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = "感谢您的支持"
        })

        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "留言", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField

        // Backend API Access
            print("Text field: \(textField.text)")
            
            let url = NSURL(string: "http://linkinusa-backend.herokuapp.com/api/reply")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            let merchantId : String = prefs.stringForKey("merchantId")!
            
            let commentId: String = self.rates[buttonRow].commentId
            
            let postString = "commentId=\(commentId)&reply=\(textField.text!)&merchantId=\(merchantId)"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
                data, response, error in
                let json = ((try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)) as? NSDictionary)
                
                if let parseJSON = json {
                    let status = parseJSON["status"] as? String
                    let alert = UIAlertController(title: "Alert", message: status, preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                        //display reply on page
                        let date = NSDate()
                        let formatter = NSDateFormatter()
                        formatter.timeStyle = .ShortStyle
                        self.rates[buttonRow].reply = textField.text!
                        self.rates[buttonRow].replyDate = formatter.stringFromDate(date)
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.mainTableView.reloadData()
                        })
                        
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
            task.resume()
    }))

        //4. add Cancel for nothing

        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "取消", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            print("Text field: \(textField.text!) Canceled")
    }))

        //5. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // create url connection and send rest api request
    func startConnection(){
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let merchantId : String = prefs.stringForKey("merchantId")!
        let url = NSURL(string: "http://linkinusa-backend.herokuapp.com/api/rating/\(merchantId)")

        let request: NSURLRequest = NSURLRequest(URL: url!)
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
    }
    // receive data from server
    func connection(connection: NSURLConnection, didReceiveData data: NSData){
        self.data.appendData(data)
    }
    // data received successfully
    func connectionDidFinishLoading(connection: NSURLConnection) {
        // convert json data to swift object
        let json: NSDictionary = ((try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary)
        let ratings: NSArray = json["rating"] as! NSArray
        if (ratings.count > 0){
            for rating in ratings{
                let commentId = rating["commentId"] as! NSString as String
                let username = rating["username"] as! NSString as String
                let content = rating["content"] as! NSString as String
                let date = rating["date"] as! NSString as String
                let replyDate = rating["replyDate"] as! NSString as String
                let reply = rating["reply"] as! NSString as String
                let rate: Rate = Rate(commentId: commentId, username: username, content: content, star: "5", date: date, replyDate: replyDate, reply: reply)
                self.rates.append(rate)
            }
        }else{
            let alert = UIAlertController(title: "Alert", message: "No rating found for you!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        data.setData(NSData())
        mainTableView.reloadData()
    }
}