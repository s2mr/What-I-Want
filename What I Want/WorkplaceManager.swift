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
    
    //リストを取得
    func getWorkplaces(){
        
        //実際は外部ファイルからステージ情報取得する処理を書きます。
        //今回はテストなので、直接Stageオブジェクトを４つほど作成
//        for i in 0...3{
//            let stage = Stage()
//            stage_list.append(stage)
//        }
        
    }
    
    //イニシャライザ
    override init(){
        super.init()
//        self.getStageList() //stage_listの取得
    }
    
    
}
