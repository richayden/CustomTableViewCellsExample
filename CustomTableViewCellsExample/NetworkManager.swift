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
        
        let url = "https://api.myjson.com/bins/38qaw"
        
        Alamofire.request(.GET, url, parameters: ["foo": "bar"])
            .responseJSON { response in
                
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)
                let jsonArray = JSON(response.data!)
                for (index, subJson) in jsonArray {
                    
                    print("\(index) \(subJson)")
                }
        }
/*            let json = JSON(response)
            for (_,subJson):(String, JSON) in json {
                let craft = Craft()
                craft.title = subJson["title"].stringValue
            }*/
                
/*            let dataManager = DataManager.sharedInstance
                
            // Setup crafts data and array
            let craft = Craft()
            craft.title = "Apple Watch Case"
            let crafts = [craft]
                
            // Apply craft array to the data manager
                
            dataManager.crafts = crafts*/
            if let delegate_ = self.delegate {
                delegate_.loadComplete()
            }
            
        
    }
}