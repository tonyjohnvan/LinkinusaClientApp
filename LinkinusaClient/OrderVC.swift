//
//  OrderVC.swift
//  LinkinusaClient
//
//  Created by Fan Zhang on 10/22/15.
//  Copyright © 2015 TJV Studio. All rights reserved.
//

import Foundation

import UIKit

class OrderVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate {
    @IBOutlet weak var topperView: UIView!

    @IBOutlet weak var btnAllOrders: UIButton!

    @IBOutlet weak var btnOrderDetail: UIButton!

    @IBOutlet weak var topTabBG: UIImageView!

    var refreshControlTotalOrders: UIRefreshControl!
    var refreshControlOrderDetail: UIRefreshControl!

    @IBAction func actLogout(sender: UIButton) {
        let alert = UIAlertController(title: "登出", message: "您确定要登出系统？未保存的修改将丢失", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: {action in
            let appDomain = NSBundle.mainBundle().bundleIdentifier
            NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)

            let alert = UIAlertController(title: "", message: "登出成功!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "确认", style: .Default, handler: { action in
                self.performSegueWithIdentifier("logout3", sender: self)
    }))
            self.presentViewController(alert, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    lazy var data = NSMutableData()

    @IBAction func btnAllOrdersAct(sender: UIButton) {
        // Select All Orders and show allOrderTV(TabelView)
        // 1. Change BGImg
        topTabBG.image = UIImage(named: "topTab")

        allOrderTV.hidden = false
        orderDetailTV.hidden = true
    }

    @IBAction func btnOrderDetailAct(sender: UIButton) {
        // Select Orders Detail and show orderDetailTV(TabelView)
        // 1. Change BGImg
        topTabBG.image = UIImage(named: "topTab_2")

        allOrderTV.hidden = true
        orderDetailTV.hidden = false
    }

    // table. allOrderTV
    @IBOutlet weak var allOrderTV: UITableView!

    var allOrders: [OrderAll] = []//OrderAllData

    // table. orderDetailTV
    @IBOutlet weak var orderDetailTV: UITableView!

    var orderDetails: [OrderDetail] = []//OrderDetailData

    // white status bar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // add the shadow of the view
        topperView.layer.shadowColor = UIColor.blackColor().CGColor

        topperView.layer.shadowOffset = CGSizeZero
        topperView.layer.shadowOpacity = 0.5
        topperView.layer.shadowRadius = 5

        // setting up the table view

        allOrderTV.allowsSelection = false;
        allOrderTV.separatorStyle = .None
        orderDetailTV.allowsSelection = false;
        orderDetailTV.separatorStyle = .None

        //hide orderdetail table
        orderDetailTV.hidden = true

        // UIViewtable pull refresh
        self.refreshControlTotalOrders = UIRefreshControl()
        self.refreshControlTotalOrders.attributedTitle = NSAttributedString(string: "下拉刷新")
        self.refreshControlTotalOrders.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)

        self.refreshControlOrderDetail = UIRefreshControl()
        self.refreshControlOrderDetail.attributedTitle = NSAttributedString(string: "下拉刷新")
        self.refreshControlOrderDetail.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)

        self.allOrderTV.addSubview(refreshControlTotalOrders)
        self.orderDetailTV.addSubview(refreshControlOrderDetail)

        startConnection()

    }

    func refresh(sender: AnyObject)
    {
        // Code to refresh table view
        allOrders = []
        orderDetails = []
        startConnection()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if(tableView == self.allOrderTV){
            return allOrders.count
        }
        else{
            return orderDetails.count
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if(tableView == self.allOrderTV) {
            // populate to All Order table
            let cell = tableView.dequeueReusableCellWithIdentifier("allOrderCell") as! OrderAllTableCell

            let oneAllOrder = allOrders[indexPath.row] as OrderAll

            cell.backgroundColor = UIColor.clearColor()

            cell.lblOrderName.text = oneAllOrder.orderName

            // add a stroke through the price
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "$\(oneAllOrder.oringinalPrice)")
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
            cell.lblOrignalPrice.attributedText = attributeString

            cell.lblPrice.text = "$\(oneAllOrder.price)"
            cell.lblSold.text = "\(oneAllOrder.sold)"
            cell.lblRedeemed.text = "\(oneAllOrder.redeemed)"
            cell.lblLeft.text = "\(oneAllOrder.sold - oneAllOrder.redeemed)"

            return cell
        } else
        {
            // populate to Order Detail table
            let cell = tableView.dequeueReusableCellWithIdentifier("orderDetailCell") as! OrderDetailTableCell
            let oneOrderDetail = orderDetails[indexPath.row] as OrderDetail

            cell.backgroundColor = UIColor.clearColor()

            cell.lblOrderNo.text = oneOrderDetail.orderNo
            cell.lblTime.text = oneOrderDetail.time
            cell.lblUserName.text = oneOrderDetail.username
            cell.lblQuantity.text = "数量 x \(oneOrderDetail.quantity)"

            if(oneOrderDetail.status==0){
                // already Verified
                cell.imageVerify.hidden = false
                // hide button and verified
                cell.imageUnverified.hidden = true
                cell.btnVerify.hidden = true
            } else
            {
                // need verification
                cell.imageVerify.hidden = true
                // show the button and unverified
                cell.imageUnverified.hidden = false
                cell.btnVerify.hidden = false
            }

            cell.btnVerify.tag = indexPath.row
            cell.btnVerify.addTarget(self, action: "verifyButtonClicked: ", forControlEvents: UIControlEvents.TouchUpInside)

            return cell
        }

    }

    func verifyButtonClicked(sender: UIButton) {
        //TODO: use this part to change the status of order
        let buttonRow = sender.tag
        print("Button \(buttonRow) tapped")

        let orderNum = orderDetails[buttonRow].orderNo

        let url = NSURL(string: "http://linkinusa-backend.herokuapp.com/api/submitOrder/\(orderNum)")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            data, response, error in
            let json = ((try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)) as? NSDictionary)

            if let parseJSON = json {
                let status = parseJSON["status"] as? String
                let alert = UIAlertController(title: "", message: status, preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "确认", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                //display reply on page
                self.orderDetails[buttonRow].status = 0
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.orderDetailTV.reloadData()
    })

            }
        }
        task.resume()
    }

    // create url connection and send rest api request
    func startConnection(){
        let prefs: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let merchantId : String = prefs.stringForKey("merchantId")!
        let url = NSURL(string: "http://linkinusa-backend.herokuapp.com/api/order/\(merchantId)")

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
        print(data)
        let json: NSDictionary = ((try! NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)) as! NSDictionary)
        let totalOrders: NSArray = json["totalOrder"] as! NSArray
        let orderDetail: NSArray = json["orderDetail"] as! NSArray
        if (totalOrders.count > 0 && orderDetail.count > 0){
            // generate totalOrders data
            for order in totalOrders{
                let orderName = order["orderName"] as! NSString as String
                let originalPrice = order["originalPrice"] as! NSString as String
                let price = order["price"] as! NSString as String
                let sold = order["sold"] as! Int
                let redeemed = order["redeemed"] as! Int
                let orderAll: OrderAll = OrderAll(orderName: orderName, oringinalPrice: originalPrice, price: price, sold: sold, redeemed: redeemed)
                self.allOrders.append(orderAll)
    }
            // generate orderDetail data
            for detail in orderDetail{
                let orderNo = detail["orderNo"] as! NSString as String
                let time = detail["time"] as! NSString as String
                let username = detail["username"] as! NSString as String
                let quantity = detail["quantity"] as! Int
                let status = detail["status"] as! Int
                let orderDetail: OrderDetail = OrderDetail(orderNo: orderNo, time: time, username: username, quantity: quantity, status: status)
                self.orderDetails.append(orderDetail)
    }
        }else
        {
            let alert = UIAlertController(title: "", message: "暂无订单!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "确认", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        self.refreshControlTotalOrders.endRefreshing()
        self.refreshControlOrderDetail.endRefreshing()
        data.setData(NSData())
        allOrderTV.reloadData()
        orderDetailTV.reloadData()
    }

}
