//
//  SexSelect.swift
//  Ecommerce
//
//  Created by zinfu on 2017/12/29.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import UIKit

class SexSelect: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let sex = ["男","女"]
    static var whatSex = "男"
    
    static public var Sex_num:String="0"
    
    // UIPickerViewDataSource 必須實作的方法：UIPickerView 有幾列可以選擇
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewDataSource 必須實作的方法：UIPickerView 各列有多少行資料
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sex.count
    }
    
    // UIPickerView 每個選項顯示的資料
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sex[row]
    }
    
    // UIPickerView 改變選擇後執行的動作
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        SexSelect.whatSex = sex[row]
        // 將改變的結果印出來
        
        
        switch row {
        case 0: SexSelect.Sex_num="1"; break
        case 1: SexSelect.Sex_num="2"; break
            
        default:
            break
        }
        
        
        
        print("選擇的是 \(SexSelect.whatSex)")
    }
    
    public func getSex()->String{
        print(SexSelect.whatSex)
        return SexSelect.whatSex
    }
    
    public func getSexNum()->String{
        print(SexSelect.Sex_num)
        return SexSelect.Sex_num
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
