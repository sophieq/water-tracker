//
//  WaterViewController.swift
//  WaterTracker
//
//  Created by Sophie Qin on 2017-05-25.
//  Copyright © 2017 Sophie Qin. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var count:Int = 0
    var oneday: Water?
    
    // creating a picker view where the user can input how much water they consumed
    let water_amount = ["Enter Amount of Water Consumed", "1/4 cup", "1/2 cup", "3/4 cup", "1 cup"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return water_amount[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return water_amount.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        label.text = water_amount[row]
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //handles the text field’s user input through delegate callbacks
        dateTextField.delegate = self
        
        updateSaveButtonState()
        
        
        //updates the data (image and labels) from the day log to this screen
        if let cup = oneday {
            navigationItem.title = cup.date
            dateTextField.text = cup.date
            counterLabel.text = "\(cup.cups)"
            myImageView.image = cup.photo
            
        }
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //hides the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //disables the Save button while the user begins typing
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //updates the navigation title when the user finishes typing
        navigationItem.title = textField.text
        //allows save button to be used again
        updateSaveButtonState()
    }
    
    //MARK: Navigation
    
    //cancel button will change view controller if pressed
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        let isPresentingInAddWaterMode = presentingViewController is UINavigationController
        
        if isPresentingInAddWaterMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The WaterViewController is not inside a navigation controller.")
        }
        
    }
 
    //passes data from this view controller to WaterTableViewCtoller
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
    
    //updates the information of the day cell
        let update = dateTextField.text
        count = Int(counterLabel.text!)!
        let upphoto = myImageView.image
    oneday = Water(date: update!, cups: count, photo: upphoto)

    }
 
 
    
    
    //updates the water glass image
    
    @IBAction func enter(_ sender: Any)
    {
        
        if let amount = label?.text
        {
            if amount == "1/4 cup"
            {
                oneQuarterCup()
            }
            else if amount == "1/2 cup"
            {
                halfCup()
            }
            else if amount == "3/4 cup"
            {
                threeQuarterCup()
            }
            else if amount == "1 cup"
            {
                fullCup()
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //updates and displays the number of cups drank
    func updateCounterLabel()
    {
        counterLabel?.text = "\(count)"
    }
    
    //allows for button the be disable when needed
    private func updateSaveButtonState() {
        let text = dateTextField.text ?? ""
        
        if text != nil {
            saveButton.isEnabled = true
            
        }
    }

    //if user inputs a quarter cup
    func oneQuarterCup()
    {
        if myImageView.image == UIImage(named: "empty")
        {
            myImageView.image = UIImage(named: "quarter")
        }
        else if myImageView.image == UIImage(named: "quarter" )
        {
            myImageView.image = UIImage(named: "half")
        }
        else if myImageView.image == UIImage(named: "half")
        {
            myImageView.image = UIImage(named: "threequarter")
        }
        else if myImageView.image == UIImage(named: "threequarter")
        {
            myImageView.image = UIImage(named: "full")
        }
        else if myImageView.image == UIImage(named:"full")
        {
            myImageView.image = UIImage(named: "quarter")
            count += 1
            updateCounterLabel()
        }
    }
    
     //if user inputs a half cup
    func halfCup()
    {
        if myImageView.image == UIImage(named: "empty")
        {
            myImageView.image = UIImage(named: "half")
        }
        else if myImageView.image == UIImage(named: "quarter" )
        {
            myImageView.image = UIImage(named: "threequarter")
        }
        else if myImageView.image == UIImage(named: "half" )
        {
            myImageView.image = UIImage(named: "full")
        }
        else if myImageView.image == UIImage(named: "threequarter" )
        {
            myImageView.image = UIImage(named: "full")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                // delays the image update by 0.1 seconds
                
                self.myImageView.image = UIImage(named: "quarter")
                self.count += 1
                self.updateCounterLabel()
            }

        }
        else if myImageView.image == UIImage(named: "full")
        {
            myImageView.image = UIImage(named: "half")
            count += 1
            updateCounterLabel()
        }

    }
     //if user inputs a three quarters cup
    func threeQuarterCup()
    {
        if myImageView.image == UIImage(named: "empty")
        {
            myImageView.image = UIImage(named: "threequarter")
        }
        else if myImageView.image == UIImage(named: "quarter")
        {
            myImageView.image = UIImage(named: "full")
        }
        else if myImageView.image == UIImage(named: "half")
        {
            myImageView.image = UIImage(named: "full")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                
                self.myImageView.image = UIImage(named: "quarter")
                self.count += 1
                self.updateCounterLabel()
            }
        }
        else if myImageView.image == UIImage(named: "threequarter")
        {
            myImageView.image = UIImage(named: "full")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                
                self.myImageView.image = UIImage(named: "half")
                self.count += 1
                self.updateCounterLabel()
            }
            
        }
        else if myImageView.image == UIImage(named: "full")
        {
            myImageView.image = UIImage(named: "threequarter")
            count += 1
            updateCounterLabel()
        }
    }
    
     //if user inputs a cup
    func fullCup()
    {
        if myImageView.image == UIImage(named: "empty")
        {
            myImageView.image = UIImage(named: "full")
        }
        else if myImageView.image == UIImage(named: "quarter")
        {
            myImageView.image = UIImage(named: "full")
            
            DispatchQueue.main.asyncAfter(deadline:.now() + 0.1) {
                
                self.myImageView.image = UIImage(named: "quarter")
                self.count += 1
                self.updateCounterLabel()
            }
        }
        else if myImageView.image == UIImage(named: "half")
        {
            myImageView.image = UIImage(named: "full")
            
            DispatchQueue.main.asyncAfter(deadline:.now() + 0.1) {
                
                self.myImageView.image = UIImage(named: "half")
                self.count += 1
                self.updateCounterLabel()
            }
        }
        else if myImageView.image == UIImage(named: "threequarter")
        {
            myImageView.image = UIImage(named: "full")
            
            DispatchQueue.main.asyncAfter(deadline:.now() + 0.1) {
                
                self.myImageView.image = UIImage(named: "threequarter")
                self.count += 1
                self.updateCounterLabel()
            }
        }
        else if myImageView.image == UIImage(named: "full")
        {
            myImageView.image = UIImage(named: "full")
            count += 1
            updateCounterLabel()
 
        }
    }
    
    //reset button will return the counter to zero and the image to empty cups if pressed
    @IBAction func reset(_ sender: Any) {
        
        count = 0
        updateCounterLabel()
        myImageView.image = UIImage(named: "empty")
    }

}

