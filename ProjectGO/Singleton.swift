//
//  Singleton.swift
//  AFNetworkTest
//
//  Created by ChenLiChun on 2017/10/2.
//  Copyright © 2017年 ChenLiChun. All rights reserved.
//

import Foundation

class MyLove {
    
    static var myLoveShared: MyLove?
    class func sharedInstance() -> MyLove {
        if myLoveShared == nil {
            myLoveShared = MyLove()
        }
        return myLoveShared!
    }
    var myLoveList = [Int]()
    
}

class History {
    
    static var historyShared: History?
    class func sharedInstance() -> History {
        if historyShared == nil {
            historyShared = History()
        }
        return historyShared!
    }
    var historyList = [Int]()
    
}
