//
//  CustomerViewCell.swift
//  Ecommerce
//
//  Created by 黃仕杰 on 2017/12/28.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import UIKit

class CustomerViewCell: UITableViewCell {

    @IBOutlet var customerName: UILabel!
    @IBOutlet var selectClick: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
