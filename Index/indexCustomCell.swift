//
//  indexCustomCell.swift
//  Ecommerce
//
//  Created by 黃仕杰 on 2017/12/27.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import UIKit

class indexCustomCell: UITableViewCell {
    
    
    @IBOutlet var productImage: UIImageView!;
    @IBOutlet var productName: UILabel!;
    @IBOutlet var productPrice: UILabel!;
    @IBOutlet var productCustomer: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
