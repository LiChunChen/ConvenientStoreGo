//
//  HistoryRecordCell.swift
//  BarCode
//
//  Created by ChenLiChun on 2017/9/11.
//  Copyright © 2017年 ChenLiChun. All rights reserved.
//

import UIKit

class HistoryRecordCell: UITableViewCell {

    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDetail: UILabel!
    @IBOutlet weak var itemHeart: UIImageView!
    @IBOutlet weak var heartNum: UILabel!
    @IBOutlet weak var itemStars: UIImageView!
    
    @IBOutlet weak var starsNum: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
