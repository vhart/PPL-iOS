 //
//  LoggingCollectionViewCell.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/22/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit

protocol LoggingButtonDelegate {
    func setLogged(sender: SetButton)
    func callSegueFromCell(myData dataobject: AnyObject)
}

class LoggingCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var setButtons: [SetButton]!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var setxRepsxWeightButton: SetButton!
    var delegate: LoggingButtonDelegate?
    var numberOfSets: Int16 = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setxRepsxWeightButton.tintColor = UIColor(red:0.0, green:0.44, blue:0.91, alpha:1.0)
        
    }
    
    func formatButtons(){
        for i in 0..<numberOfSets {
            formatButton(setButtons[Int(i)])
        }
        
        for i in 0..<5-numberOfSets {
            disableButton(setButtons[Int(5-i-1)])
        }
    }
    
    
    func disableButton(button: SetButton){
        button.hidden = true
        button.enabled = false
    }
    
    func formatButton(button:SetButton) {
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        
        if button.firstAttempt {
            formatInitialButtonState(button)
        } else {
            formatOngoingButtonState(button)
        }
        
    }
    
    @IBAction func setLogged(sender: SetButton) {

        if sender.repsCompleted < 0 {
            formatInitialButtonState(sender)
            sender.repsCompleted = sender.numberOfReps
        } else if sender.repsCompleted == 0 && sender.firstAttempt {
            sender.repsCompleted = sender.numberOfReps
            formatOngoingButtonState(sender)
            sender.repsCompleted -= 1
        } else {
            formatOngoingButtonState(sender)
            sender.repsCompleted -= 1
            
        }
        
        
        sender.firstAttempt = false
        self.delegate?.setLogged(sender)
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
        button.setTitle("\(button.repsCompleted)", forState: .Normal)
    }
    
    
    //When the weight button is clicked
    @IBAction func weightButtonTapped(sender: SetButton) {
        
        self.delegate?.callSegueFromCell(myData: sender)
        
    }
    
}


