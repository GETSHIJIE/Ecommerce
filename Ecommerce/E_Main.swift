//
//  ViewController.swift
//  Ecommerce
//
//  Created by 黃仕杰 on 2017/10/26.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import UIKit
import CoreData

///=================================Get Value=================================

public class NSGetValue {
    
    struct SET{
        static var id: Int = 0;
        static var currentVC: UIViewController = UIViewController();
    }
    
    struct IP {
        static let ip: String = "http://172.20.10.3:8080/";
    }
    
    struct Php_Files {
        private static let mainF: String = "E-iOSphp/"
        static let login: String = mainF+"login.php";
        static let register: String = mainF+"register.php";
        static let forget_password: String = mainF+"forget_password.php";
        static let checkpassword: String = mainF+"checkpassword.php";
        static let index: String = mainF+"Index/index.php";
        static let productDetail: String = mainF+"Index/productDetail.php";
        static let shopcart: String = mainF+"Index/ShopCart/shopcart.php";
    }
    
    struct Php_Picture {
        private static let mainF: String = "E-PICphp/"
        static let products: String = mainF+"products/";
    }
}

///=================================PHP=================================

class E_Main: PHPSQL{
    var postContent: String = "";
};

///=================================CoreData=================================

class E_CoreData: CoreDataConnect{
    var myContext: NSManagedObjectContext;
    required init(context:NSManagedObjectContext) {
        self.myContext = context;
    }
};

///=================================CoreData=================================

func LoadPicUrl(imageAddress: String) -> UIImage?{
    if let imageUrl = URL(string: imageAddress){
        
        var downLoadImage: UIImage?;
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.global().async {
            do{
                let imageData = try Data(contentsOf: imageUrl);
                downLoadImage = UIImage(data: imageData)!
            }catch{
                print("ERROR : "+error.localizedDescription)
            }
            group.leave()
        }
        
        group.wait()
        return downLoadImage;
        
    }else{
        print("ERROR : The picture's url isn't exist !")
        return nil;
    }
}

///=================================showMessage=================================

public func showMessage(UI: UIViewController, _ string: String) -> Void {
    
    //let CVC = NSGetValue.SET.currentVC;

    let myAlert: UIAlertController = UIAlertController(title: "System Messgae", message: string, preferredStyle: .alert);
    let action = UIAlertAction(title: "關閉", style: UIAlertActionStyle.default, handler: {action in print("done")});
    myAlert.addAction(action);
    UI.present(myAlert, animated: true, completion: nil);
}




