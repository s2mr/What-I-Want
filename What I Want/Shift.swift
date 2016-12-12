//
//  Shift.swift
//  What I Want
//
//  Created by Kazumasa Shimomura on 2016/11/23.
//  Copyright © 2016年 Kazumasa Shimomura. All rights reserved.
//

import Foundation

class Shift :NSObject, NSCoding {
    var hour: Double!
    var createdAt: Date!
    var workplaceName: String!
    
    init(workplaceName:String,hour:Double ) {
        self.hour = hour
        self.workplaceName = workplaceName
        
        self.createdAt = Date()

    }
    
    //NSUserDefaultl シリアライズ処理
    func encode(with aCoder: NSCoder) {
        aCoder.encode(hour, forKey: SerializedKey.Hour)
        aCoder.encode(createdAt, forKey: SerializedKey.CreatedAt)
        aCoder.encode(workplaceName, forKey: SerializedKey.WorkplaceName)
        //        aCoder.encodeObject(coin_list, forKey: "coin_list")
    }
    
    //NSUserDefaultl デシリアライズ処理
    required init?(coder aDecoder: NSCoder) {
        hour = aDecoder.decodeObject(forKey: SerializedKey.Hour) as? Double ?? 0.0
        createdAt = aDecoder.decodeObject(forKey: SerializedKey.CreatedAt) as? Date ?? Date()
        workplaceName = aDecoder.decodeObject(forKey: SerializedKey.WorkplaceName) as? String ?? "" //多次元配列への型キャストは、この様な書き方をします
//        coin_list = coder.decodeObjectForKey("coin_list") as! [[Int]]
    }
    
    
}
