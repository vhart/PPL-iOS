//
//  LoggingCollectionViewCell.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/22/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit

class LoggingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var set1Button: UIButton!
    @IBOutlet weak var set2Button: UIButton!
    @IBOutlet weak var set3Button: UIButton!
    @IBOutlet weak var set4Button: UIButton!
    @IBOutlet weak var set5Button: UIButton!
    var repCount = 12
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func formatButtons(){
        formatButton(set1Button)
        formatButton(set2Button)
        formatButton(set3Button)
        formatButton(set4Button)
        formatButton(set5Button)
        
    }
    
    func formatButton(button:UIButton) {
        button.setTitle("", forState: .Normal)
        button.backgroundColor = UIColor.whiteColor()
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGrayColor().CGColor
        button.setImage(UIImage(named:"thumbsUp.png"), forState: .Normal)

    }

    @IBAction func setLogged(sender: UIButton) {
        sender.backgroundColor = UIColor.redColor()
        sender.layer.borderWidth = 0
        
        sender.setTitle("\(repCount)", forState: .Normal)
        sender.tintColor = UIColor.whiteColor()
        repCount -= 1
        
        if repCount < 0 {
            formatButton(sender)
            repCount = 12
            
        }
        
    }


}
