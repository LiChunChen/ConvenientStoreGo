//
//  URLManager.swift
//  AFNetworkTest
//
//  Created by ChenLiChun on 2017/10/2.
//  Copyright © 2017年 ChenLiChun. All rights reserved.
//

import Foundation

let requestURL = "https://convenientgo.000webhostapp.com/DBTest.php"
let categoryURL = "https://convenientgo.000webhostapp.com/Category.php"
let uploadURL = "https://convenientgo.000webhostapp.com/UpdateFavorite.php"
let insertURL = "https://convenientgo.000webhostapp.com/Insert.php"

struct Item {
    var barcode: Int?
    var name: String?
    var ml: String?
    var imgURL: String?
    var description: String?
    var ingredient: String?
    var favorite: Int?
    var stars: Double?
}

typealias DoneHandler = (Bool,Error?,[Item]?) -> Void

class URLManager {
    
    let session = URLSession.shared
    // configuration is a get-only property

    func askForRequest(parameters: [Any], urlString: String ,doneHandler:@escaping DoneHandler) {
        
        //        let parameters = ["barcodeNumber" : "1"]
        guard let url = URL(string: urlString) else { return }
        guard let data = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else { return }
        // JSONSerialization: 可以將 JSON 轉換為 Foundation 物件，或是將 Foundation 物件轉換為 JSON
        
        var request = URLRequest(url: url)
        request.httpBody = data
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
    
        let task = session.dataTask(with: request) { (data, resopnse, error) in
            if let error = error {
                NSLog("Download error: \(error)")
                DispatchQueue.main.async {
                    doneHandler(false, error, nil)
                }
                return
            }
            
            guard let data = data else {
                NSLog("Get data fail.")
                DispatchQueue.main.async {
                    doneHandler(false, nil, nil)
                }
                return
            }
            
            /// To Test I got the Data or not
//            let strData = String(data: data, encoding: .utf8)
//            NSLog("strData: \(strData ?? "Get strData fail.")")
            
//            DispatchQueue.main.async {
//                self.jsonResultLabel.text = "strData: \(strData ?? "Get strData fail.")"
//            }
        
            if let results = (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [[String: Any]] {
                
                var item = Item()
                var items = [Item]()
                for j in results {
                    item.barcode = j["barcode"] as? Int
                    item.name = j["name"] as? String
                    item.ml = j["ml"] as? String
                    item.imgURL = j["imgURL"] as? String
                    item.description = j["description"] as? String
                    item.ingredient = j["ingredient"] as? String
                    item.favorite = j["favorite"] as? Int
                    item.stars = j["stars"] as? Double
                    items.append(item)
//                        print(items)
                }
                DispatchQueue.main.async {
                    // Callback funciton
                    doneHandler(true, nil, items)
                }
            }else {
                NSLog("Get jsonResult fail.")
                DispatchQueue.main.async {
                    doneHandler(false, nil, nil)
                }
            }
        }
        // task 被創造出來的時候
        task.resume()
    }
    
    func changeToDB(parameter: [String:Any], urlString: String) {
        guard let url = URL(string: urlString) else { return }
        guard let data = try? JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted) else { return }
        var request = URLRequest(url: url)
        request.httpBody = data
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        let task = session.dataTask(with: request)
        task.resume()
    }
}
