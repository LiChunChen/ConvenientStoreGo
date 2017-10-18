//
//  shop.swift
//  ShopMapAPI
//
//  Created by Michelle Chen on 2017/9/14.
//  Copyright © 2017年 Michelle Chen. All rights reserved.
//

import Foundation
import MapKit

struct Shop{
    var title: String?
    var address: String?
    var category: String?
    var coordinate: Dictionary<String, Any>?

}

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}
