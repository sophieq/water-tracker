//
//  WaterTableViewController.swift
//  WaterTracker
//
//  Created by Sophie Qin on 2017-06-07.
//  Copyright © 2017 Sophie Qin. All rights reserved.
//

import UIKit
import os.log

class WaterTableViewController: UITableViewController {

    //MARK: PROPERTIES
    
    var daywater = [Water]()
    var passingcount = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load the sample data.
        loadSampleDays()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    // returns the amount of cells that should be created
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daywater.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //resuse table cells
        let cellIdentifier = "WaterTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WaterTableViewCell  else {
            fatalError("The dequeued cell is not an instance of WaterTableViewCell.")
        }
        // Fetches the appropriate day for the data source layout.
        
        let oneday = daywater[indexPath.row]
        
        cell.dateLabel.text = oneday.date
        
        if let number = cell.numberLabel{
            number.text = "\(oneday.cups)"
            passingcount = number.text!
        }
        
        if let whichphoto = cell.photoImageView{
            whichphoto.image = oneday.photo
        }
        
        return cell
        
    }

    // Editing button
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // deletes cell from day logger
            daywater.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    // MARK: - Navigation

    // passing information into ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
       
        case "AddItem": //if user wants to add a new day
            os_log("Adding a new day.", log: OSLog.default, type: .debug)
            
        case "ShowDetail": //if user wants to view detail of a specific day
            guard let waterDetailViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            var cupscounted = segue.destination as! ViewController
            cupscounted.count = Int(passingcount)!
            
            guard let selectedWaterCell = sender as? WaterTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedWaterCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedWater = daywater[indexPath.row]
            waterDetailViewController.oneday = selectedWater
        
        default: break
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        
    }

    
    //cancel button, if the button is pressed, View Controller will come back to this screen via segue
    
    @IBAction func unwindToDayLog(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? ViewController, let cup = sourceViewController.oneday {
    
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                daywater[selectedIndexPath.row] = cup
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                
            } else {

                let newIndexPath = IndexPath(row: daywater.count, section: 0)
                
                daywater.append(cup)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
        }
        
    }
    
    //creates sample day
    
    private func loadSampleDays() {
    
        let photo1 = UIImage(named: "half")
        
        guard let day1 = Water(date: "June 10", cups: 5, photo: photo1) else {
            fatalError("Unable to instantiate day1")
        }
        
        daywater += [day1]
        
    }

}

