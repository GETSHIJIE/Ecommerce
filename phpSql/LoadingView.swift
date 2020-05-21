//
//  LoadingView.swift
//  ControllerLifeCycle
//
//  Created by 黃仕杰 on 2018/3/18.
//  Copyright © 2018年 SHIJIE. All rights reserved.
//

import Foundation
import UIKit

class LoadingView: UIView{
    
    func loadingview(_ UI: UIViewController) -> UIView {
        let loadingIndicator = UIActivityIndicatorView.init(frame: CGRect(x:0,y:0,width:50,height:50))
        let backgroundView = UIView();
        
        backgroundView.layer.cornerRadius = 05
        backgroundView.clipsToBounds = true
        backgroundView.isOpaque = false
        backgroundView.backgroundColor = UIColor.black;
        
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.color = UIColor.white
        loadingIndicator.startAnimating();
        UIApplication.shared.beginIgnoringInteractionEvents();
        
        let loadingLabel = UILabel()
        loadingLabel.text = "Loading..."
        loadingLabel.textColor = UIColor.white;
        let textSize: CGSize = loadingLabel.text!.size(withAttributes: [NSAttributedStringKey.font: loadingLabel.font ])
        
        loadingLabel.frame = CGRect(x:50, y:0, width:textSize.width, height:textSize.height)
        loadingLabel.center.y = loadingIndicator.center.y
        
        backgroundView.frame = CGRect(x:0, y:0, width:textSize.width + 70, height:50)
        backgroundView.center = UI.view.center;
        
        UI.view.addSubview(backgroundView)
        backgroundView.addSubview(loadingIndicator)
        backgroundView.addSubview(loadingLabel)
        
        return backgroundView;
    }
}
