//
//  ShiftInputViewController.swift
//  What I Want
//
//  Created by Kazumasa Shimomura on 2016/11/23.
//  Copyright © 2016年 Kazumasa Shimomura. All rights reserved.
//

import UIKit

class ShiftInputViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var hours = [Double]()
    
    let ad = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if UIMenuController.shared.isMenuVisible {
            UIMenuController.shared.isMenuVisible = false
        }
        
        return false
    }
    
    @IBAction func addWorkplaceButtonTapped(_ sender: AnyObject) {
        let ac = UIAlertController(title: "新規", message: "勤務先の名称と時給を入力してください", preferredStyle: .alert)
        ac.addTextField(configurationHandler: { workplaceNameField in
            workplaceNameField.placeholder = "Lawson"
        })
        
        ac.addTextField(configurationHandler: { hourlyWageField in
            hourlyWageField.placeholder = "800"
            hourlyWageField.keyboardType = .numberPad
            hourlyWageField.delegate = self
        })
        
        let addAction = UIAlertAction(title: "Add", style: .default, handler: { action in
            if ac.textFields![0].text != "" && ac.textFields![1].text != "" {
                self.ad.workplaces.append((Workplace(workplaceName: ac.textFields![0].text!, hourlyWage: Int(ac.textFields![1].text!)!)))

                self.ad.save()
                print(self.ad.workplaces.last!.workplaceName)
                print(self.ad.workplaces.last!.hourlyWage)
                
                DispatchQueue.main.async {
                    self.pickerView.reloadAllComponents()
                }
                
            }else {
                print("空欄があります")
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(addAction)
        ac.addAction(cancelAction)
        
        present(ac, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonTapped(_ sender: AnyObject) {
        
        let nameRow = pickerView.selectedRow(inComponent: 0)
        let hourRow = pickerView.selectedRow(inComponent: 1)
        
//        ad.shifts.append(shift)
        
        let shift = Shift(workplaceName: ad.workplaces[nameRow].workplaceName, hour: hours[hourRow])
        
        ad.workplaces[nameRow].shifts.append(shift)
        ad.save()
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return ad.workplaces.count
        } else{
            return hours.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0{
            return ad.workplaces[row].workplaceName
        }else{
            return hours[row].description
        }
    }
    
    func setup() {
        for x in 1...50 {
            hours.append(Double(x) * 0.25)
        }
        
    }
//    
//    func getWorkplace() -> Workplace{
//        
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


