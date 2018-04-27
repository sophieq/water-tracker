//
//  Water.swift
//  WaterTracker
//
//  Created by Sophie Qin on 2017-06-07.
//  Copyright © 2017 Sophie Qin. All rights reserved.
//

import UIKit
import os.log

class Water {
    
    //MARK: Properties
    
    var date: String
    var cups: Int
    var photo: UIImage?
    
    
    //MARK: Initialization, a class that stores the data of each day on a cell
    init!(date: String, cups: Int, photo: UIImage?) {
        
        //if the date is empty then the cell can not be created
        if date.isEmpty {
            return nil
        }
        
        //initialize stored properties
        self.date = date
        self.cups = cups
        self.photo = photo

    }

    
}
