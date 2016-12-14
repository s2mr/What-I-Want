//
//  ViewController.swift
//  What I Want
//
//  Created by Kazumasa Shimomura on 2016/11/23.
//  Copyright © 2016年 Kazumasa Shimomura. All rights reserved.
//

import UIKit

class ShiftManageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let ad = UIApplication.shared.delegate as! AppDelegate
    
    
    
    @IBOutlet weak var totalSalaryLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ad.load()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        setup()
    }
    
    
    @IBAction func inputButtonTapped(_ sender: AnyObject) {
        performSegue(withIdentifier: "toInput", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ad.workplaces.count
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ad.workplaces[section].workplaceName
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        
        
        
        for shift in ad.workplaces[section].shifts{
            
            let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
            
            var comps:DateComponents = calendar!.components(NSCalendar.Unit.month, from: shift.createdAt)
            let month = comps.month!
            
            switch  ad.period {
            case Periods.thisMonth:
                if month == TodayData.month {
                    count += 1
                }
            case Periods.prevMonth:
                if (TodayData.month - month) == 1{
                    count += 1
                }
            case Periods.Total:
                count += 1
            default:
                count = 0
            }
        }
        
        print(count)
        return count
//        return ad.workplaces[section].shifts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        let workplace = ad.workplaces[indexPath.section]
        
        var count = 0
        
        for (index, shift) in workplace.shifts.enumerated()
        
        switch ad.period {
        case Periods.prevMonth:
            <#code#>
        case Periods.thisMonth:
            
        case Periods.Total:
        default:
            <#code#>
        }
    
    
        let shift = workplace.shifts[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        
        cell.hourLabel.text = doubleToString(num: shift.hour) + "時間"
        cell.salaryLabel.text = doubleToString(num: shift.hour * Double(workplace.hourlyWage)) + "円"
        cell.dateLabel.text = dateFormatter.string(from: shift.createdAt)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "削除", handler: { action, indexPath in
            self.ad.workplaces[indexPath.section].shifts.remove(at: indexPath.row)
            self.ad.save()
            tableView.reloadData()
        })
        
        return [deleteAction]
    }
    
    func setup() {
        DispatchQueue.main.async {
            self.totalSalaryLabel.text = "Total : " + self.doubleToString(num: self.getTotalSalary()) + "円"
        }
    }
    
    func getWorkplace(workplaceName:String) -> Workplace {
        for workplace in ad.workplaces {
            if workplace.workplaceName == workplaceName {
                return workplace
            }
        }
        //エラー処理を書く
        return Workplace(workplaceName: "", hourlyWage: 0)
    }
    
    func getTotalSalary() -> Double {
        var totalSalary = 0.0

        for workplace in ad.workplaces{
            for shift in workplace.shifts {
                
                //                let workplaceName = shift.workplaceName
                let hour = shift.hour
                //                let hourWage = getWorkplace(workplaceName: workplaceName).hourlyWage
                let hourlyWage = workplace.hourlyWage
                
                totalSalary += hour! * Double(hourlyWage!)
            }
            
        }
        
        return totalSalary
    }
    
    public func doubleToString(num:Double) -> String {
        
        let intValue = Double(Int(num))
        
        //小数点以下が０の場合
        if num - intValue == 0 {
            return "".appendingFormat("%.0f", num)
        }else {
            return num.description
        }
        
        
    }
}

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}

