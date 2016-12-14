//
//  AppDelegate.swift
//  What I Want
//
//  Created by Kazumasa Shimomura on 2016/11/23.
//  Copyright © 2016年 Kazumasa Shimomura. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var workplaces:[Workplace] = [Workplace]()
    var period = Periods.Total

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        TodayData.month = Int(formatter.string(from: date))!
        
        print("Month : \(TodayData.month)")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    
    func load() {
        let ud = UserDefaults()
        
        
        if let data = ud.object(forKey: "WORKPLACES") as? NSData {
            let unarchive = NSKeyedUnarchiver.unarchiveObject(with: data as Data)
            workplaces = unarchive as! [Workplace]
        }
        
        
        
//        if let data = ud.object(forKey: "SHIFTS") as? NSData {
//            let unarchive = NSKeyedUnarchiver.unarchiveObject(with: data as Data)
//            shifts = unarchive as! [Shift]
//        }
    }

    
    func save() {
 
        let ud = UserDefaults()

        let archive1 = NSKeyedArchiver.archivedData(withRootObject: workplaces)
        ud.set(archive1, forKey: "WORKPLACES")
        
//        let archive2 = NSKeyedArchiver.archivedData(withRootObject: shifts)
//        ud.set(archive2, forKey: "SHIFTS")
        
    }
 
    
}

