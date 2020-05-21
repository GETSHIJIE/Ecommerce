//
//  productDetail.swift
//  Ecommerce
//
//  Created by 黃仕杰 on 2018/3/15.
//  Copyright © 2018年 Ecommerce. All rights reserved.
//

import UIKit

class productDetail: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet var productName: UILabel!;
    @IBOutlet var productPrice: UILabel!;
    @IBOutlet var productPicture: UIImageView!;
    @IBOutlet var tableView: UITableView!;
    
    struct PD {
        var id: Int = 0;
        var y: Int = 0;
    }
    var pd = PD();
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.productPicture.isHidden = true;
        self.tableView.isHidden = true;
        NSGetValue.SET.currentVC = self;
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        phpconnect();
    }
    
    func phpconnect() -> Void{
        let phpsql = E_Main();
        
        var postarray: [String] = [];
        postarray.append("PD_id=\(pd.id)");
        let poststring = phpsql.postArrToStr(postarray); // return post
        phpsql.postContent = poststring;
        
        let setIP = NSGetValue.IP.ip;
        let setFile =  NSGetValue.Php_Files.productDetail;
        
        phpsql.PHP_CONNECTION(IP: setIP, FileName: setFile) { (json) in
            var ToObjectArray: [String: AnyObject] = [:];
            ToObjectArray = json[0] as! [String : AnyObject] ;
            self.productName.text = ToObjectArray["Name"] as? String;
            self.productPrice.text = "$"+(ToObjectArray["Price"]! as! String);
            
            let addr: String = NSGetValue.IP.ip+NSGetValue.Php_Picture.products+(ToObjectArray["PictureName"]! as! String);
            self.productPicture.image = LoadPicUrl(imageAddress: addr);
            
            self.productPicture.isHidden = false;
            self.tableView.isHidden = false;
            self.tableView.reloadData();
        }
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! productDetailCell;
        cell.SpecificationsBtn.layer.cornerRadius = cell.SpecificationsBtn.frame.height/2;
        cell.SpecificationsBtn.addTarget(self,
                                         action:  #selector(SpecificationsBtnClick),
                                         for: .touchUpInside);
        cell.SpecificationsBtn.setTitle("規格", for: .normal);
        
        return cell;
    }
    
    @IBAction func SpecificationsBtnClick (_ sender: UIButton){
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
