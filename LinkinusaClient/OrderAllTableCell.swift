//
//  OrderAllTableCell.swift
//  LinkinusaClient
//
//  Created by Fan Zhang on 10/22/15.
//  Copyright © 2015 TJV Studio. All rights reserved.
//

import UIKit

class OrderAllTableCell: UITableViewCell {
    
    @IBOutlet weak var lblOrderName: UILabel!
    @IBOutlet weak var lblOrignalPrice: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSold: UILabel!
    @IBOutlet weak var lblRedeemed: UILabel!
    @IBOutlet weak var lblLeft: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
