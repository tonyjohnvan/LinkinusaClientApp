//
//  OrderAllData.swift
//  LinkinusaClient
//
//  Created by Fan Zhang on 10/22/15.
//  Copyright © 2015 TJV Studio. All rights reserved.
//

import Foundation

import UIKit

struct OrderAll {
    var orderName: String
    var oringinalPrice: String
    var price: String
    var sold: Int
    var redeemed: Int
    
    init(orderName: String, oringinalPrice: String, price: String, sold: Int, redeemed: Int) {
        self.orderName = orderName
        self.oringinalPrice = oringinalPrice
        self.price = price
        self.sold = sold
        self.redeemed = redeemed
    }
}


//Set up sample data
let OrderAllData = [
    OrderAll(
        orderName: "你永远猜不到这会是一个多么神奇的产品名字",
        oringinalPrice: "123.00",
        price: "12.00",
        sold: 120,
        redeemed: 64
    ),
    OrderAll(
        orderName: "产品名字 很长 很长 很长 很长 很长 很长 很长 很长",
        oringinalPrice: "354.00",
        price: "12.00",
        sold: 120,
        redeemed: 64
    ),
    OrderAll(
        orderName: "阿西吧",
        oringinalPrice: "2,345.00",
        price: "123.00",
        sold: 120,
        redeemed: 64
    ),
    OrderAll(
        orderName: "一只沉默的蛋糕",
        oringinalPrice: "34.00",
        price: "23.00",
        sold: 120,
        redeemed: 64
    ),
    OrderAll(
        orderName: "应该没有这么多吧。。。",
        oringinalPrice: "345.00",
        price: "12.00",
        sold: 120,
        redeemed: 64
    )
]