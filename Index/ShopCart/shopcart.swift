//
//  shopcart.swift
//  Ecommerce
//
//  Created by 黃仕杰 on 2017/12/20.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import UIKit

class shopcart: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!;
    var values: NSArray = [];
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.isHidden = true;
        NSGetValue.SET.currentVC = self;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        phpconnect();
    }
    
    func phpconnect() -> Void{
        let phpsql = E_Main();
        
        let setIP = NSGetValue.IP.ip;
        let setFile =  NSGetValue.Php_Files.shopcart;
        
        var postarray: [String] = [];
        postarray.append("id=\(NSGetValue.SET.id)");
        let poststring = phpsql.postArrToStr(postarray); // return post
        phpsql.postContent = poststring;
        
        phpsql.PHP_CONNECTION(IP: setIP, FileName: setFile) { (json) in
            self.values = json;
            self.tableView.isHidden = false;
            self.tableView.reloadData();
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return values.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var ToObjectArray: [String: String] = values[indexPath.row] as! [String : String] ;
        
        if(indexPath.row<0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "customerCell", for: indexPath) as! CustomerViewCell;
            cell.customerName.text = ToObjectArray["NameChi"]!+"("+ToObjectArray["Account"]!+")";
            
            return cell;
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as! ContentViewCell;
            cell.productName.text = ToObjectArray["Name"];
            cell.productFormat.text = "規格: "+ToObjectArray["Color"]!+" , "+ToObjectArray["Size"]!;
            cell.productPrice.text = "單價: "+ToObjectArray["Price"]!;
            cell.productQuantity.text = "數量: "+ToObjectArray["quantity"]!;
            
            let IP = NSGetValue.IP.ip;
            let File =  NSGetValue.Php_Picture.products;
            let imageAddress = IP+File+ToObjectArray["PictureName"]!;
            cell.productImage.image = LoadPicUrl(imageAddress: imageAddress);
            
            return cell;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwind(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
