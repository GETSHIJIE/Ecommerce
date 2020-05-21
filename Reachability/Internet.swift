//
//  Internet.swift
//  Ecommerce
//
//  Created by 黃仕杰 on 2017/11/20.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import Foundation
import UIKit

/*
protocol InternetI {
    
    func InternetCtrateView() -> Void ;
    
}
extension InternetI{
    
    func InternetCtrateView(UI: UIViewController , VIEW: UIView) -> Void{
        
        var DynamicView: UIView;
        DynamicView = UIView(frame: CGRect(x: 0,
                                           y: VIEW.frame.maxY,
                                           width: VIEW.bounds.size.width,
                                           height: VIEW.bounds.size.height));
        DynamicView.backgroundColor = UIColor.red;
        DynamicView.alpha = 0.8;
        UI.view.addSubview(DynamicView);
        ReachabilityInternet();
    }
    
    func ReachabilityInternet() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: ReachabilityChangedNotification, object: reachability);
        do{
            try reachability.startNotifier();
        }catch{
            print("could not start reachability");
            return;
        }
    }
    
}*/


var anyClass: AnyObject!;

class Internet: UIViewController{
    private let reachability = Reachability()!;
    private var DynamicView: UIView!;

    func ReachabilityInternet() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: ReachabilityChangedNotification, object: reachability);
        do{
            try reachability.startNotifier();
        }catch{
            print("could not start reachability");
            return;
        }
    }
    
    @objc func internetChanged(note: Notification) -> Void {
        let reachability = note.object as! Reachability;
        
        if reachability.isReachable {
            if reachability.isReachableViaWiFi{
                DispatchQueue.main.async {
                    print("green_wifi");
                    self.OnOffLine(1);
                    self.view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1);
                }
            }else{
                DispatchQueue.main.async {
                    print("yello_internet");
                    self.OnOffLine(1);
                    self.view.backgroundColor = #colorLiteral(red: 0.9948318601, green: 0.9917954803, blue: 0, alpha: 1);
                }
            }
        }else{
            DispatchQueue.main.async {
                print("red");
                self.OnOffLine(0);
                self.view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1);
            }
        }
    }
    //--------------------------------------------------------------------
    
    func buildingVIEW() -> Void {
        DynamicView = UIView(frame: CGRect(x:0 ,y:-50 ,width:self.view.bounds.size.width ,height: 50));
        DynamicView.backgroundColor = UIColor.red;
        DynamicView.alpha = 0.8;
        anyClass.view.addSubview(DynamicView);
        
        ReachabilityInternet();
    }
    
    func OnOffLine(_ status: Int) -> Void {
        print("OffOnline");
        
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 0.01, repeats:
                true, block: {(timer) -> Void in
    
                    switch(status){
                    case 0:
                        if  self.DynamicView.frame.origin.y > 0 {
                            timer.invalidate();
                        } else {
                            self.DynamicView.frame = self.DynamicView.frame.offsetBy(dx: 0, dy: 1);
                        }
                        break;
                    case 1:
                        if self.DynamicView.frame.origin.y < -50 {
                            timer.invalidate();
                        } else {
                            self.DynamicView.frame = self.DynamicView.frame.offsetBy(dx: 0, dy: -1);
                        }
                        break;
                    default:
                        break;
                    }
            })
        }
    }
    
}


