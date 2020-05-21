//
//  ContentViewCell.swift
//  Ecommerce
//
//  Created by 黃仕杰 on 2017/12/28.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import UIKit

class ContentViewCell: UITableViewCell {

    @IBOutlet var selectClick: UIButton!;
    @IBOutlet var productImage: UIImageView!;
    @IBOutlet var productQuantity: UILabel!
    @IBOutlet var productName: UILabel!;
    @IBOutlet var productFormat: UILabel!;
    @IBOutlet var productPrice: UILabel!;
    @IBOutlet var editClick: UIButton!;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
