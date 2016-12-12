//
//  Workplace.swift
//  What I Want
//
//  Created by Kazumasa Shimomura on 2016/11/23.
//  Copyright © 2016年 Kazumasa Shimomura. All rights reserved.
//

import Foundation

class Workplace:NSObject, NSCoding {
//    var id: Int!
    var workplaceName: String!
    var hourlyWage: Int!
    
    var shifts = [Shift]()
    
    init (workplaceName: String, hourlyWage:Int) {
        self.workplaceName = workplaceName
        self.hourlyWage = hourlyWage
        
//        self.id = 0
    }
    
    // 以下NSCodingのための処理
    required init?(coder aDecoder: NSCoder) {
        /*
        let workplaceName = aDecoder.decodeObject(forKey: "workplaceName") as? String!
        let hourlyWage = aDecoder.decodeObject(forKey: "hourlyWage") as? Int!
        let shifts = aDecoder.decodeObject(forKey: "shifts") as? [Shift]
        if let unwrapWorkplaceName=workplaceName,let unwrapHourlyWage=hourlyWage, let unwrapShifts=shifts{
            self.workplaceName = unwrapWorkplaceName
            self.hourlyWage = unwrapHourlyWage
            self.shifts = unwrapShifts
        }
 */
        
        self.workplaceName  = aDecoder.decodeObject(forKey: SerializedKey.WorkplaceName)   as? String    ?? ""
        self.hourlyWage     = aDecoder.decodeObject(forKey: SerializedKey.HourlyWage)     as? Int ?? 0
        self.shifts         = aDecoder.decodeObject(forKey: SerializedKey.Shifts) as? [Shift] ?? []
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.workplaceName, forKey: SerializedKey.WorkplaceName)
        aCoder.encode(self.hourlyWage, forKey: SerializedKey.HourlyWage)
        aCoder.encode(self.shifts, forKey: SerializedKey.Shifts)
    }
  
}

/*
class WorkplaceService {
    
    static let sharedInstance = WorkplaceService()
    
    private let userDefaults = UserDefaults.standard
    
    func register(workplaceName: String, hourlyWage:Int) {
        
        let archivedObject = NSKeyedArchiver.archivedData(withRootObject: Workplace(workplaceName: workplaceName, hourlyWage: hourlyWage))
        self.userDefaults.set(archivedObject, forKey: UserDefaultsKey.Workplace)
        self.userDefaults.synchronize()
    }
    
    var registeredWorkplace: Workplace? {
        
        guard let unarchivedObject = self.userDefaults.object(forKey: UserDefaultsKey.Workplace) as? NSData,
            let user = NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? Workplace else {
                
                return nil
        }
        
        return user
    }
}
*/


struct SerializedKey {
    static let WorkplaceName    = "workplaceName"
    static let HourlyWage       = "hourlyWage"
    static let Shifts           = "shifts"
    static let Workplaces       = "workplaces"
    
    static let Hour             = "hour"
    static let CreatedAt        = "createdAt"
//    static let WorkplaceName    = "workplaceName"
}

struct UserDefaultsKey {
    static let Workplace        = "workplace"
}

/*
extension UserDefaults {
    var logDatas:[Workplace]{
        get{
            let rowData = self.object(forKey: "WORKPLACES") as? Data? ?? Data()
            let datas = NSKeyedUnarchiver.unarchiveObject(with: rowData!) as? [Workplace] ?? []
            return datas
        }
        set(newDatas){
            let archive = NSKeyedArchiver.archivedData(withRootObject: newDatas)
            self.set(archive, forKey: "WORKPLACES")
        }
    }
}
 
 */
