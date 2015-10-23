//
//  CustomizedTabBarController.swift
//  LinkinusaClient
//
//  Created by Fan Zhang on 9/29/15.
//  Copyright © 2015 TJV Studio. All rights reserved.
//

import Foundation



import UIKit

class CustomizedTabBarController: UITabBarController {
    
    override func viewWillLayoutSubviews() {
        let tbh: CGFloat = 65
        self.tabBar.frame.size.height = tbh
        self.tabBar.frame.origin.y = self.view.frame.size.height - tbh - 5
        
        self.tabBar.layer.shadowColor = UIColor.grayColor().CGColor
        
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -1.2)
        self.tabBar.layer.shadowOpacity = 0.2
        self.tabBar.layer.shadowRadius = 3
        self.tabBar.layer.borderWidth = 0
        
        // no use...
        let barbuttonFont = UIFont.systemFontOfSize(120)
        
        self.tabBarItem.setTitleTextAttributes([NSFontAttributeName: barbuttonFont, NSForegroundColorAttributeName:UIColor.whiteColor()], forState: UIControlState.Normal)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}