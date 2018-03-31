//
//  TimeSlotTableViewCell.swift
//  exotica
//
//  Created by Nick Moignard on 22/3/18.
//  Copyright © 2018 Nick Moignard. All rights reserved.
//

import UIKit

class TimeSlotTableViewCell: UITableViewCell {
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var upstairsMain: UILabel!
    @IBOutlet var upstairsSecondary: UILabel!
    @IBOutlet var downstairsOne: UILabel!
    @IBOutlet var downstairsTwo: UILabel!
    @IBOutlet var downstairsBooth: UILabel!
    @IBOutlet var downstairsBar: UILabel!
    
    var timeSlot: TimeSlot = TimeSlot()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        roundCorners()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func roundCorners() {
        self.timeLabel.layer.cornerRadius = 5;
        self.timeLabel.layer.masksToBounds = true;
        
        self.upstairsMain.layer.cornerRadius = 5
        self.upstairsMain.layer.masksToBounds = true;

        self.downstairsBar.layer.cornerRadius = 5;
        self.downstairsBar.layer.masksToBounds = true;
        
    }

}
