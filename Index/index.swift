//
//  index.swift
//  Ecommerce
//
//  Created by 黃仕杰 on 2017/12/14.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import UIKit

class index: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var searchBar: UISearchBar!;
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
        let setFile =  NSGetValue.Php_Files.index;
        
        phpsql.PHP_CONNECTION(IP: setIP, FileName: setFile) { (json) in
            self.values = json;
            self.tableView.isHidden = false;
            self.tableView.reloadData();
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text="";
        searchBar.showsCancelButton = false;
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true;
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.0;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return values.count ;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_product", for: indexPath) as! indexCustomCell;
        
        var ToObjectArray: [String: String] = [:];
        ToObjectArray = values[indexPath.row] as! [String : String] ;
        
        cell.tag = Int(ToObjectArray["ProductID"]!)!
        cell.productCustomer.text = "賣家："+ToObjectArray["Account"]!;
        cell.productName.text = ToObjectArray["Name"] ;
        cell.productPrice.text = "$"+ToObjectArray["Price"]!;
        
        let IP = NSGetValue.IP.ip;
        let File =  NSGetValue.Php_Picture.products;
        let imageAddress = IP+File+ToObjectArray["PictureName"]!
        cell.productImage.image = LoadPicUrl(imageAddress: imageAddress);
        
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "INtoPD"){
            let Celltag = sender as! UITableViewCell;
            let newVC: productDetail = segue.destination as! productDetail;
            let PD_id = Celltag.tag;
            newVC.pd.id = PD_id;
        }
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        //self.navigationController?.popViewController(animated: true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

}
