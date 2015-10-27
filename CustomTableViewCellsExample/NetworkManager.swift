//
//  NetworkManager.swift
//  CustomTableViewCellsExample
//
//  Created by Bob Pascazio on 10/15/15.
//  Copyright © 2015 Bob Pascazio. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

@objc protocol NetworkManagerDelegate : NSObjectProtocol {
    func loadComplete()
    optional func loadFailed()
}

class NetworkManager: NSObject {
    
    var delegate:NetworkManagerDelegate?
    
    func loadCrafts() -> Void {
        
        Alamofire.request(.GET, "https://www.dropbox.com/s/2kom7jw5uiscj7y/content.json?dl=1", parameters: ["foo": "bar"])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                var crafts = Array<Craft>()
                
                if let JSON = response.result.value {
                    let num = JSON["number"] as! Int
                    let str = JSON["string"] as! String
                    //                    let table_data = JSON["table_data"] as! Array<String>
                    let adv_table_data = JSON["advanced_table_data"] as! Array<AnyObject>
                    print("number: \(num)")
                    print("string: \(str)")
                    for item in adv_table_data {
                        let name = item["name"] as! String
                        let url = item["url"] as! String
                        let weight = item["weight"] as! Float
                        let craft = Craft()
                        craft.title = name
                        craft.weight = weight
                        craft.imageURL = url
                        crafts.append(craft)
                    }
                    
                    /*                    for item in table_data {
                    print("item: \(item)")
                    let craft = Craft()
                    craft.title = item
                    crafts.append(craft)
                    }*/
                }
                
                // Apply craft array to the data manager
                DataManager.sharedInstance.crafts = crafts
                if let delegate_ = self.delegate {
                    delegate_.loadComplete()
                }
        }
    }
}