//
//  RateTabelCell.swift
//  LinkinusaClient
//
//  Created by Fan Zhang on 10/21/15.
//  Copyright © 2015 TJV Studio. All rights reserved.
//

import UIKit

class RateTabelCell: UITableViewCell {

    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    
    @IBOutlet weak var lblRateDate: UILabel!
    
    @IBOutlet weak var lblReplyDate: UILabel!
    @IBOutlet weak var lblReply: UILabel!
    
    @IBOutlet weak var imageBG: UIImageView!
    
    @IBOutlet weak var imageRate: UIImageView!
    
    @IBOutlet weak var btnReply: UIButton!
    
    
    @IBAction func replyAction(sender: UIButton) {
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
