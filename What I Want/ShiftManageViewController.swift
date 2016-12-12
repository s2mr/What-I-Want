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
        
        /*
        let vc = ShiftInputViewController()
        
//        vc.view.frame = CGRect(vc.view.frame.origin.x + (vc.view.frame.size.width - 600)/2,
//                                            vc.view.frame.origin.y,
//                                            600,
//                                            vc.view.frame.size.height)
        vc.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 500)
//        vc.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin
        vc.view.autoresizingMask = [.flexibleHeight , .flexibleLeftMargin , .flexibleRightMargin]
        vc.modalPresentationStyle = .none

        vc.view.superview?.backgroundColor = UIColor.clear
        
        present(vc, animated: true, completion: nil)
 */
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ad.workplaces.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ad.workplaces[section].workplaceName
    }
    
    
    /*
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        var titles = [String]()
        
        for workplace in ad.workplaces {
            titles.append(workplace.workplaceName)
        }
        
        return titles
    }
 */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return ad.workplaces[section].shifts.count
        
//        return getRowsForWorkplaces(workplace: ad.workplaces[section])
        
        
//        return ad.shifts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        
//        let shift = ad.shifts[indexPath.row]

        let shift = ad.workplaces[indexPath.section].shifts[indexPath.row]
        
        
        let workplace = ad.workplaces[indexPath.section]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        
        cell.hourLabel.text = doubleToString(num: shift.hour) + "時間"
//        cell.detailTextLabel?.text = ad.shifts[indexPath.row].createdAt.description
        
        cell.salaryLabel.text = doubleToString(num: shift.hour * Double(workplace.hourlyWage)) + "円"
        
        cell.dateLabel.text = dateFormatter.string(from: shift.createdAt)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    /*
    func getRowsForWorkplaces(workplace: Workplace) -> Int {
        
        var count = 0
        
        for shift in ad.workplaces {
            if shift.workplaceName == workplace.workplaceName {
                count += 1
            }
        }
        
        return count
    }
 */
    
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

