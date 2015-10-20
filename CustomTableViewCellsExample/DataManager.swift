//
//  DataManager.swift
//  CustomTableViewCellsExample
//
//  Created by Bob Pascazio on 10/15/15.
//  Copyright © 2015 Bob Pascazio. All rights reserved.
//

import Foundation

class DataManager : NSObject {
    
    var crafts:[Craft]?
   
    class var sharedInstance: DataManager {
        struct Singleton {
            static let instance = DataManager()
        }
        return Singleton.instance
    }
    
    func getCraftCount() -> Int {
        var count:Int = 0
        if let crafts_ = crafts {
            count = crafts_.count
        }
        return count
    }
    
    func getCraftAtIndex(index:Int) -> Craft? {
        var craft:Craft?
        if let crafts_ = crafts {
            craft = crafts_[index]
        }
        return craft
    }
    
}