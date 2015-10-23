//
//  OrderDetailData.swift
//  LinkinusaClient
//
//  Created by Fan Zhang on 10/23/15.
//  Copyright © 2015 TJV Studio. All rights reserved.
//

import Foundation

import UIKit

struct OrderDetail {
    var orderNo: String
    var time: String
    var username: String
    var quantity: Int
    var status: Int
    
    init(orderNo: String, time: String, username: String, quantity: Int, status: Int) {
        self.orderNo = orderNo
        self.time = time
        self.username = username
        self.quantity = quantity
        self.status = status
    }
}


//Set up sample data
let OrderDetailData = [
    OrderDetail(
        orderNo: "WTF12128",
        time: "2015/10/11",
        username: "唐僧洗发用飘柔",
        quantity: 3,
        status: 0
    ),
    OrderDetail(
        orderNo: "WTF12138",
        time: "2015/10/12",
        username: "唐僧洗发用飘柔吗？",
        quantity: 2,
        status: 1
    ),
    OrderDetail(
        orderNo: "WTF12129",
        time: "2015/10/14",
        username: "唐僧洗发不用飘柔",
        quantity: 6,
        status: 1
    ),
    OrderDetail(
        orderNo: "WTF12325",
        time: "2015/10/16",
        username: "唐僧洗发不用飘柔…吧",
        quantity: 9,
        status: 0
    ),
    OrderDetail(
        orderNo: "WTF12986",
        time: "2015/10/21",
        username: "唐僧洗发用不用飘柔？",
        quantity: 1,
        status: 1
    )
]