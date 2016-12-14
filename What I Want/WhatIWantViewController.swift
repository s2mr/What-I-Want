//
//  WhatIWantViewController.swift
//  What I Want
//
//  Created by Kazumasa Shimomura on 2016/11/25.
//  Copyright © 2016年 Kazumasa Shimomura. All rights reserved.
//

import UIKit

class WhatIWantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let ad = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var necessaryPrice: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        necessaryPrice.text = (236304 - getTotalSalary()).description
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ad.workplaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = ad.workplaces[indexPath.row].workplaceName + "(\(ad.workplaces[indexPath.row].hourlyWage!)円/h)"
        
        let necessaryHour = Double(necessaryPrice.text!)! / Double(ad.workplaces[indexPath.row].hourlyWage)
        
        cell.detailTextLabel?.text = "あと".appendingFormat("%.0f", necessaryHour)  + "時間"
        return cell
    }
    
    
    
    func getTotalSalary() -> Int {
        
        
        var totalSalary:Int = 0
        
        for workplace in ad.workplaces{
            for shift in workplace.shifts {
                
                let hour = Int(shift.hour)
                let hourlyWage = workplace.hourlyWage
                
                totalSalary += hour * hourlyWage!
            }
            
        }
        
        return totalSalary
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
