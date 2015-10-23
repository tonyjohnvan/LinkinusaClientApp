//
//  OrderVC.swift
//  LinkinusaClient
//
//  Created by Fan Zhang on 10/22/15.
//  Copyright © 2015 TJV Studio. All rights reserved.
//

import Foundation

import UIKit

class OrderVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var topperView: UIView!
    
    @IBOutlet weak var btnAllOrders: UIButton!
    
    @IBOutlet weak var btnOrderDetail: UIButton!
    
    @IBOutlet weak var topTabBG: UIImageView!
    
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
    
    var allOrders:[OrderAll] = OrderAllData
    
    // table. orderDetailTV
    @IBOutlet weak var orderDetailTV: UITableView!
    
    var orderDetails:[OrderDetail] = OrderDetailData
    
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
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "$\(oneAllOrder.oringinalPrice)")
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
            cell.lblOrignalPrice.attributedText = attributeString
            
            cell.lblPrice.text = "$\(oneAllOrder.price)"
            cell.lblSold.text = "\(oneAllOrder.sold)"
            cell.lblRedeemed.text = "\(oneAllOrder.redeemed)"
            
            return cell
        } else {
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
            } else {
                // need verification
                cell.imageVerify.hidden = true
                // show the button and unverified
                cell.imageUnverified.hidden = false
                cell.btnVerify.hidden = false
            }
            
            cell.btnVerify.tag = indexPath.row
            cell.btnVerify.addTarget(self, action: "verifyButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            
            return cell
        }
        
    }
    
    func verifyButtonClicked(sender:UIButton) {
        //TODO: use this part to change the status of order
        let buttonRow = sender.tag
        print("Button \(buttonRow) tapped")
    }
    
}
