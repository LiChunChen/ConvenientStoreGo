//
//  RadiusBtn.swift
//  GoGoGo
//
//  Created by gnoocl on 2017/8/31.
//  Copyright © 2017年 gnoocl. All rights reserved.
//

import UIKit

class RadiusBtn: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let a = "master"
    
    class func radiuscorner(btn:UIButton){
        //圓角
        btn.layer.cornerRadius = 50.0
        //陰影
        btn.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        btn.layer.shadowRadius = 5
        //陰影角度
        btn.layer.shadowOffset = CGSize(width: 5, height: 5)
        btn.layer.shadowOpacity = 0.7
        //邊框
        //chineseBTN.layer.borderColor = UIColor.blue.cgColor
        //chineseBTN.layer.borderWidth = 3
        //照片
        btn.layer.contentsGravity = kCAGravityResize
        btn.layer.masksToBounds = true
        
    }


}
