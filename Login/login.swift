//
//  login.swift
//  Ecommerce
//
//  Created by 黃仕杰 on 2017/10/26.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import UIKit

class login: UIViewController, UITextFieldDelegate{
    
    let con = false;
    var count: Int = 0;
    
    @IBOutlet var rememberImg: UIImageView!;
    @IBOutlet var agreeImg: UIImageView!;
    
    @IBOutlet var img1: UIImageView!;
    @IBOutlet var img2: UIImageView!;
    @IBOutlet var img3: UIImageView!;
    @IBOutlet var img4: UIImageView!;
    
    @IBOutlet var accountText: UITextField!;
    @IBOutlet var pwText: UITextField!;
    @IBOutlet var codeText: UITextField!;
    
    var code: String = "";
    let internet = Internet();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        anyClass = self;
        internet.buildingVIEW(); //離線狀態時 秀出警告View
        
        showRandom(); //驗證碼
        buildingImg(); //產生ImgClick
        buildingDelegate();
    }
    
    //--------------------------------------------------------------------
    func showRandom() -> Void {
        let show = random(4);
        
        for i in 0..<4 {
            code += show[i];
        }
        
        img1.image = UIImage(named: show[0]+".png");
        img2.image = UIImage(named: show[1]+".png");
        img3.image = UIImage(named: show[2]+".png");
        img4.image = UIImage(named: show[3]+".png");
    }
    
    func random(_ arraySize: Int) -> Array<String> {
        let letters: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
        var available = [String]();
        
        for _ in 0..<arraySize{
            let rand = Int(arc4random_uniform(UInt32(letters.count)));
            available.append(letters[rand]);
        }
        
        return available;
    }
    
    //--------------------------------------------------------------------
    
    func buildingImg() -> Void {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(login.rememberPW));
        singleTap.numberOfTapsRequired = 1;
        
        rememberImg.isUserInteractionEnabled = true;
        rememberImg.addGestureRecognizer(singleTap);
        
        let singleTap_agree = UITapGestureRecognizer(target: self, action: #selector(login.agreePrivate));
        singleTap_agree.numberOfTapsRequired = 1;
        agreeImg.isUserInteractionEnabled = true;
        agreeImg.addGestureRecognizer(singleTap_agree);
    }
    
    //--------------------------------------------------------------------
    
    func buildingDelegate() -> Void {
        self.accountText.delegate = self;
        self.pwText.delegate = self;
        self.codeText.delegate = self;
    }
    
    //--------------------------------------------------------------------
    
    @objc func rememberPW() -> Void {
        
        let bool = ImageBool(rememberImg, index: 0);
        print(bool);
        
        if (bool == false){
            rememberImg.image = UIImage(named: "rememberOK.png");
        }else{
            rememberImg.image = UIImage(named: "rememberPassword.png");
        }
    }
    
    //--------------------------------------------------------------------
    
    @objc func agreePrivate() -> Void {
        
        let bool = ImageBool(agreeImg , index: 0);
        print(bool);
        
        if (bool == false){
            agreeImg.image = UIImage(named: "agreeOK.png");
        }else{
            agreeImg.image = UIImage(named: "agree.png");
        }
        
    }
    
    //--------------------------------------------------------------------
    
    func ImageBool(_ ImgName: UIImageView , index: Int) -> Bool {
        
        let ImgTag = ImgName.tag;
        var bool = Bool();
        
        if(ImgTag == 0){
            bool = false;
        }else{
            bool = true;
        }
        
        switch index {
        case 0:
            if(ImgTag == 0){
                ImgName.tag = 1;
            }else{
                ImgName.tag = 0;
            }
            break;
            
        case 1:
            print(index);
            break;
            
        default:
            break;
        }
        
        return bool;
    }
    ///
    //--------------------------------------------------------------------
    
    @IBAction func LogInClick(_ sender: Any) {
        
        let agreeBool = ImageBool(agreeImg, index: 1);
        if(agreeBool == true){
            Login();
        }else{
            showMessage(UI: self,"同意未勾選");
            return;
        }
    }
    
    func replacing(_ string: String) -> String {
        
        let stringTo = string.replacingOccurrences(of: " ", with: "");
        return stringTo;
        
    }
    
    //--------------------------------------------------------------------
    // 觸控到螢幕,超出keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    //--------------------------------------------------------------------
    // 觸控到鍵盤return,在keyboard內
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        accountText.resignFirstResponder();
        pwText.resignFirstResponder();
        codeText.resignFirstResponder();
        
        return(true);
    }
    
    //--------------------------------------------------------------------
    //登入判斷
    
    private func Login() -> Void{
        let phpsql = E_Main();
        
        var postarray: [String] = [];
        postarray.append("account=\(accountText.text!)");
        postarray.append("password=\(pwText.text!)");
        
        let poststring = phpsql.postArrToStr(postarray); // return post
        phpsql.postContent = poststring;
         
        let setIP = NSGetValue.IP.ip; // get IP
        let setFile =  NSGetValue.Php_Files.login; //get php login file
        
        phpsql.PHP_CONNECTION(IP: setIP, FileName: setFile) { (json) in
            
            var ToObjectArray: [String: AnyObject] = [:];
            ToObjectArray = json[0] as! [String : AnyObject] ;
            let errorStatus = Int(ToObjectArray["errorStatus"]! as! String)!;
            
            if (errorStatus == 1){
                let codeString = self.replacing(self.codeText.text!);
                
                if (codeString == self.code){
                    let CustomerID = Int(ToObjectArray["CustomerID"]! as! String)!;
                    NSGetValue.SET.id = CustomerID;
                    //showMessage(UI: self,"登入成功");
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "index"){
                        self.show(vc, sender: self);
                    }
                    
                }else{
                    showMessage(UI: self,"驗證碼錯誤");
                }
            }else if(errorStatus == 2){
                showMessage(UI: self,"帳號或密碼有錯誤");
                return;
            }else if(errorStatus == 3){
                showMessage(UI: self,"post錯誤");
            }
        }
    }
    //--------------------------------------------------------------------
    
    @IBAction func unwindToLogin(for segue: UIStoryboardSegue) {
    }
    
    /* override func didReceiveMemoryWarning() {
     super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated.
     } */
    
    
}
