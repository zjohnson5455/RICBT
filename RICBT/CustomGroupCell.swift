//
//  CustomGroupCell.swift
//  RICBT
//
//  Created by Zachary Johnson on 3/13/18.
//  Copyright © 2018 ZacharyJohnson. All rights reserved.
//

import UIKit

class CustomGroupCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var pic: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
