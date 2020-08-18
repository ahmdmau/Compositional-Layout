//
//  TopCategoryCell.swift
//  FoodDelivery
//
//  Created by Ahmad Maulana on 11/08/20.
//  Copyright © 2020 Ahmad Maulana. All rights reserved.
//

import UIKit

class TopCategoryCell: UICollectionViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        contentView.layer.masksToBounds = true
        layer.cornerRadius = 10
        self.itemImageView.roundUpCorners(.allCorners, radius: 10)
    }

}
