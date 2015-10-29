//
//  RatingVC.swift
//  LinkinusaClient
//
//  Created by Fan Zhang on 10/20/15.
//  Copyright © 2015 TJV Studio. All rights reserved.
//

import Foundation

import UIKit

class RatingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var topperView: UIView!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    lazy var data = NSMutableData()
    
    
    //var rates:[Rate] = RateData
    var rates:[Rate] = []
    
    // white status bar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewWillLayoutSubviews() {
        startConnection()
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
        
        
        
//        let merchantId : String = "UOEzAnYfBr"
//        let url = NSURL(string: "http://linkinusa-backend.herokuapp.com/api/rating/" + merchantId)
//        // request scancode rest api from backend
//        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
//            if let json: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary{
//                // get request status from output
//                if let ratings = json["result"] as? NSArray {
//                    for rating in ratings{
//                        let rate:Rate = Rate(username: rating["username"] as? String, content: rating["content"] as? String, star: (rating["star"] as? String)!, date: rating["date"] as? String, replyDate: rating["replyDate"] as? String, reply: rating["reply"] as? String)
//                        self.rates.append(rate)
//                    }
//                }
//                print(self.rates)
//            }
//            
//        }
//        
//        task.resume()
        
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
        
        cell.btnReply.tag = indexPath.row
        cell.btnReply.addTarget(self, action: "cellButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
//        return UITableViewCell()
    }
    
    func cellButtonClicked(sender:UIButton) {
        
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
            
            // TODO: Please Modify here for Backend API Access
            print("Text field: \(textField.text)")
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
        //test data: merchant ID
        let merchantId : String = "UOEzAnYfBr"
        let url = NSURL(string: "http://linkinusa-backend.herokuapp.com/api/rating/" + merchantId)
        
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
        let ratings:NSArray = json["rating"] as! NSArray
        print(ratings)
        for rating in ratings{
            let username = rating["username"] as! NSString as String
            let content = rating["content"] as! NSString as String
            let date = rating["date"] as! NSString as String
            let replyDate = rating["replyDate"] as! NSString as String
            let reply = rating["reply"] as! NSString as String
            let rate:Rate = Rate(username: username, content: content, star: "5", date: date, replyDate: replyDate, reply: reply)
            print(rate)
            self.rates.append(rate)
        }
        
        data.setData(NSData())
        mainTableView.reloadData()
    }
}