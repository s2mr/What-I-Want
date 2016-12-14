//
//  WorkplaceManager.swift
//  What I Want
//
//  Created by Kazumasa Shimomura on 2016/11/27.
//  Copyright © 2016年 Kazumasa Shimomura. All rights reserved.
//

import UIKit

class WorkplaceManager: NSObject, NSCoding {

    var workplaces = [Workplace]()

    //NSUserDefaultl シリアライズ処理
    func encode(with aCoder: NSCoder) {
        aCoder.encode(workplaces, forKey: SerializedKey.Workplaces)
    }
    
    //NSUserDefaultl デシリアライズ処理
    required init(coder: NSCoder) {
        workplaces = coder.decodeObject(forKey: SerializedKey.Workplaces) as! [Workplace]
    }
    
    //イニシャライザ
    override init(){
        super.init()
    }
    
    
}
