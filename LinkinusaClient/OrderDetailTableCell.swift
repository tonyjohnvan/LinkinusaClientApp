//
//  OrderDetailTableCell.swift
//  LinkinusaClient
//
//  Created by Fan Zhang on 10/23/15.
//  Copyright © 2015 TJV Studio. All rights reserved.
//

import UIKit

class OrderDetailTableCell: UITableViewCell {

    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var imageVerify: UIImageView!
    @IBOutlet weak var imageUnverified: UIImageView!
    @IBOutlet weak var btnVerify: UIButton!
    
    @IBAction func btnVerifyAction(sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
