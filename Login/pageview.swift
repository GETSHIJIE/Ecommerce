//
//  pageview.swift
//  Ecommerce
//
//  Created by Kuo,Ting-You on 22/11/2017.
//  Copyright © 2017 Ecommerce. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var list = [UIViewController]();
    //用來放5個ViewController
    
    //var timer_counter = 0;
    //var timer = Timer();
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        for v in view.subviews{
            if v is UIScrollView{
                v.frame = view.bounds;
                break;     
            }
        }
    }
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let vc1 = storyboard?.instantiateViewController(withIdentifier: "vc1");
        let vc2 = storyboard?.instantiateViewController(withIdentifier: "vc2");
        let vc3 = storyboard?.instantiateViewController(withIdentifier: "vc3");
        let vc4 = storyboard?.instantiateViewController(withIdentifier: "vc4");
        let vc5 = storyboard?.instantiateViewController(withIdentifier: "vc5");
        
        
        list.append(vc1!);
        list.append(vc2!);
        list.append(vc3!);
        list.append(vc4!);
        list.append(vc5!);
        
        setViewControllers([list[0]], direction: .forward, animated: true, completion: nil);
        /*
         第一個參數放UIViewController,陣列是因為如果是用電子書的方式呈現，一開始可能有兩頁，只有一頁所以放list[0]
         direction  往後面滑動放 .forward
         第三個參數是需不需要有動畫呈現
         */
        dataSource = self;
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let index = list.index(of: viewController), index < list.count - 1 {
            return list[index + 1]; 
        }
        return nil;
        //判斷是否在最後一頁
    }
    //往後滑動時呼叫這個func
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let index = list.index(of: viewController), index > 0 {
            return list[index - 1];
        }
        return nil;
        //判斷是否在第一頁
    }
    //往前滑動時呼叫這個func
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return list.count;
    }
    //告訴PageViewController總共有幾頁
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0;
    }
    //目前在哪一頁要實作，會跟上面setViewControllers的第一個參數一樣
    
    
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
