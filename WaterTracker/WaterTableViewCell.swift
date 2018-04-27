//
//  WaterTableViewCell.swift
//  WaterTracker
//
//  Created by Sophie Qin on 2017-06-07.
//  Copyright © 2017 Sophie Qin. All rights reserved.
//

import UIKit

class WaterTableViewCell: UITableViewCell {
    
    //MARK: Properties of the day log 
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
