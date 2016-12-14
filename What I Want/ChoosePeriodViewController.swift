//
//  ChoosePeriodViewController.swift
//  What I Want
//
//  Created by Kazumasa Shimomura on 2016/12/12.
//  Copyright © 2016年 Kazumasa Shimomura. All rights reserved.
//

import UIKit

class ChoosePeriodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    let ad = UIApplication.shared.delegate as! AppDelegate
    let periods = [Periods.thisMonth, Periods.prevMonth, Periods.Total]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        <#code#>
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return periods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = periods[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ad.period = periods[indexPath.row]
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

struct Periods {
    static let thisMonth = "今月"
    static let prevMonth = "先月"
    static let Total =  "全期間"
}

struct TodayData {
    static var month = 1
}
