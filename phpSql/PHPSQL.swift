//
//  PHPSQL.swift
//  Ecommerce
//
//  Created by 黃仕杰 on 2017/12/7.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import Foundation
import UIKit

protocol PHPSQL {
    var postContent: String { get set };
    func postArrToStr(_ postArray: [String]) -> String;
    func PHP_CONNECTION(IP: String , FileName: String , content:@escaping (_ json: NSArray) -> Void) -> Void;
}
extension PHPSQL{
    func postArrToStr(_ postArray: [String]) -> String{
        var str: String = "";
        let ArrayCount: Int = postArray.count;
        for i in 0..<ArrayCount{
            if(i==0){
                str = postArray[0];
            }else{
                str += "&"+postArray[i];
            }
        }
        print(str);
        return str;
    }
    
    func PHP_CONNECTION(IP: String , FileName: String , content:@escaping (_ json: NSArray) -> Void) -> Void {
        
        let CVC = NSGetValue.SET.currentVC;
        let LV = LoadingView();
        let lv = LV.loadingview(CVC);
        CVC.view.addSubview(lv);
        
        let url = URL(string: "\(IP)\(FileName)");
        var request = URLRequest(url: url!);
        request.httpMethod = "POST";
        request.httpBody = postContent.data(using: .utf8);
        
        let task = URLSession.shared.dataTask(with: request){
            data , response , error in
            
            guard let data = data else {
                print(error!);
                return ;
            }
            
            print(url as Any);
            
            do{
                let responseString = String(data: data, encoding: .utf8);
                print(responseString!);
                
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! NSArray;
                
                DispatchQueue.main.async {
                    lv.isHidden = true;
                    UIApplication.shared.endIgnoringInteractionEvents();
                    content(json);
                }
                
            } catch let Error {
                print("PHP Connection error：\(Error)");
            }
        }
        task.resume();
    }
}


