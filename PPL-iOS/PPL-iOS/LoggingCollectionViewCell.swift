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
}

class LoggingCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet var setButtons: [SetButton]!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var setxRepsxWeightLabel: UILabel!
    var delegate: LoggingButtonDelegate?
    var numberOfSets: Int16 = 0
    var numberOfReps: Int16!
    var repCount: Int16 = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setxRepsxWeightLabel.textColor = UIColor(red:0.0, green:0.44, blue:0.91, alpha:1.0)
    }
    
    func formatButtons(){
        for i in 0..<numberOfSets {
            formatButton(setButtons[Int(i)], exerciseIndex: i)

            
        }
        
        let setButtonsCount = Int16(setButtons.count)
        
        for i in 0..<setButtonsCount-numberOfSets {
            disableButton(setButtons[Int(setButtonsCount-i-1)])
        }
    }
    
    func disableButton(button: SetButton){
        button.enabled = false
    }
    func formatButton(button:SetButton, exerciseIndex: Int16) {
        button.setTitle("", forState: .Normal)
        button.backgroundColor = UIColor.whiteColor()
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGrayColor().CGColor
        button.exerciseIndex = exerciseIndex
        initRepCount(button)

    }

    @IBAction func setLogged(sender: SetButton) {
        sender.backgroundColor = UIColor(red:0.0, green:0.44, blue:0.91, alpha:1.0)
        sender.layer.borderWidth = 0
        
        sender.setTitle("\(sender.repCount)", forState: .Normal)
        sender.tintColor = UIColor.whiteColor()
        
        if sender.repCount < 0 {
            formatButton(sender, exerciseIndex: sender.exerciseIndex)
        } else {
            sender.repCount -= 1
        }
        
        self.delegate?.setLogged(sender)
        
    }
    
    func initRepCount(buton: SetButton) {
        buton.repCount = numberOfReps
    }


}
