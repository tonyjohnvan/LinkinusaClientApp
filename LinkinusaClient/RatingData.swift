//
//  RatingData.swift
//  LinkinusaClient
//
//  Created by Fan Zhang on 10/20/15.
//  Copyright © 2015 TJV Studio. All rights reserved.
//

import Foundation

import UIKit

struct Rate {
    var commentId: String
    var username: String
    var content: String
    var star: String
    var date: String
    var replyDate: String
    var reply: String

    init(commentId: String, username: String, content: String, star: String, date: String, replyDate: String, reply: String) {
        self.commentId = commentId
        self.username = username
        self.content = content
        self.star = star
        self.date = date
        self.replyDate = replyDate
        self.reply = reply
    }
}


//Set up sample data
//let RateData = [
//    Rate(username: "唐僧洗头用飘柔",
//        content:"店家服务很给力呀，折扣力度很高！下次还来！",
//        star: "4",
//        date: "2015-10-20",
//        replyDate: "",
//        reply: ""
//    ),
//    Rate(username: "唐僧洗头不用飘柔",
//        content:"店家服务很给力呀，折扣力度很高！下次还来！",
//        star: "5",
//        date: "2015-10-20",
//        replyDate: "",
//        reply: ""
//    ),
//    Rate(username: "叫我小纯洁",
//        content:"店家服务很给力呀，折扣力度很高！下次还来！",
//        star: "3",
//        date: "2015-10-20",
//        replyDate: "",
//        reply: ""
//    ),
//    Rate(username: "好像就只能这么长",
//        content:"店家服务很给力呀，折扣力度很高！下次还来！",
//        star: "1",
//        date: "2015-10-20",
//        replyDate: "",
//        reply: ""
//    ),
//    Rate(username: "随便起个名字吧",
//        content:"店家服务很给力呀，折扣力度很高！下次还来！",
//        star: "2",
//        date: "2015-10-20",
//        replyDate: "",
//        reply: ""
//    ),
//    Rate(username: "都是从文件里来的",
//        content:"店家服务很给力呀，折扣力度很高！下次还来！店家服务很给力呀，折扣力度很高！下次还来！",
//        star: "4",
//        date: "2015-10-20",
//        replyDate: "",
//        reply: ""
//    ),
//    Rate(username: "服务器端自己连哈",
//        content:"店家服务很给力呀，折扣力度很高！下次还来！",
//        star: "5",
//        date: "2015-10-20",
//        replyDate: "",
//        reply: ""
//    )
//]
