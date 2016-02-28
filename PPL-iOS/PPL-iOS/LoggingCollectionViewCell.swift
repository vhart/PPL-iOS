 //
 //  LoggingCollectionViewCell.swift
 //  PPL-iOS
 //
 //  Created by Jovanny Espinal on 2/22/16.
 //  Copyright © 2016 Jovanny Espinal. All rights reserved.
 //
 
 import UIKit
 
 protocol LoggingCollectionViewCellDelegate {
    func setLogged(sender: SetButton, set: Set)
    func callSegueFromCell(myData dataobject: AnyObject)
 }
 
 class LoggingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var setButtons: [SetButton]!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var setxRepsxWeightButton: SetButton!
    var delegate: LoggingCollectionViewCellDelegate?
    var numberOfSets: Int16 = 0
    var sets: [Set]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setxRepsxWeightButton.tintColor = UIColor(red:0.0, green:0.44, blue:0.91, alpha:1.0)
        
    }
    
    @IBAction func setLogged(sender: SetButton) {
        let set = sets[Int(sender.setIndex)]
        
        if set.repsCompleted == 0 && set.firstAttempt {
            set.repsCompleted = set.numberOfReps
            formatOngoingButtonState(sender)
        } else {
            set.repsCompleted -= 1
            
            if set.repsCompleted < 0 {
                set.repsCompleted = 0
                set.firstAttempt = true
                formatInitialButtonState(sender)
                
            } else {
                formatOngoingButtonState(sender)
                set.firstAttempt = false
            }
            
            
        }
        
        self.delegate?.setLogged(sender, set: set)
    }
    
    //When the weight button is clicked
    @IBAction func weightButtonTapped(sender: SetButton)
    {
        self.delegate?.callSegueFromCell(myData: sender)
    }
    
 }
 
 // MARK: Button Formatting
 extension LoggingCollectionViewCell {
    func formatButtons(){
        for i in 0..<sets.count {
            formatButton(setButtons[Int(i)])
        }
        
        for i in 0..<5-sets.count {
            disableButton(setButtons[Int(5-i-1)])
        }
    }
    
    
    func disableButton(button: SetButton){
        button.hidden = true
        button.enabled = false
    }
    
    func formatButton(button:SetButton) {
        let set = sets[Int(button.setIndex)]
        
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        
        if set.firstAttempt {
            if !(set.repsCompleted == set.numberOfReps){
                formatInitialButtonState(button)
            } else {
                formatOngoingButtonState(button)
            }
        } else {
            formatOngoingButtonState(button)
        }
        
    }
    
    func formatInitialButtonState(button: SetButton) {
        button.setTitle("", forState: .Normal)
        button.backgroundColor = UIColor.whiteColor()
        button.layer.borderColor = UIColor.lightGrayColor().CGColor
        button.layer.borderWidth = 1.0
    }
    
    func formatOngoingButtonState(button: SetButton) {
        updateLabel(button)
        button.backgroundColor = UIColor(red:0.0, green:0.44, blue:0.91, alpha:1.0)
        button.layer.borderWidth = 0
        button.tintColor = UIColor.whiteColor()
    }
    
    func updateLabel(button: SetButton) {
        let set = sets[Int(button.setIndex)]
        
        button.setTitle("\(set.repsCompleted)", forState: .Normal)
    }
 }
 
