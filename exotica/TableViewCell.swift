//
//  TableViewCell.swift
//  exotica
//
//  Created by Nick Moignard on 2/3/18.
//  Copyright © 2018 Nick Moignard. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    

    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
