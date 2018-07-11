//
//  CustomTeamCell.swift
//  RICBT
//
//  Created by Zachary Johnson on 3/17/18.
//  Copyright © 2018 ZacharyJohnson. All rights reserved.
//

import UIKit

class CustomTeamCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
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
