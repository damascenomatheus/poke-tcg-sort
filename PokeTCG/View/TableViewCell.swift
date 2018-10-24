//
//  TableViewCell.swift
//  PokeTCG
//
//  Created by Matheus Damasceno on 17/10/18.
//  Copyright © 2018 Matheus Damasceno. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteImageCell: UIImageView!
    @IBOutlet weak var favoriteNameCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
