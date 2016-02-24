//
//  WorkoutLogCollectionViewCell.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/22/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit

class WorkoutLogCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var typeOfWorkoutLabel: UILabel!
    @IBOutlet var exerciseNameLabels: [UILabel]!
    @IBOutlet var exerciseSetxRepxWeightLabels: [UILabel]!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateExerciseLabels(exercises: [Exercise]){
        
        clearExerciseLabesl()
        for i in 0..<exercises.count {
            
            let sets = exercises[i].numberOfSets.copyToArray() as! [Set]
            
            exerciseNameLabels[i].text = exercises[i].abbreviatedExerciseName()
            
            exerciseSetxRepxWeightLabels[i].text = "\(sets.count)x\(sets.first!.numberOfReps) \(exercises[i].weight.cleanValue)lbs"
            exerciseSetxRepxWeightLabels[i].textColor = UIColor.lightGrayColor()
            
//            if exercises[i].didCompleteAllSets {
//                exerciseSetxRepxWeightLabels[i].textColor = UIColor.greenColor()
//            } else {
//                exerciseSetxRepxWeightLabels[i].textColor = UIColor.redColor()
//            }
            
            exerciseSetxRepxWeightLabels[i].sizeToFit()
            exerciseNameLabels[i].sizeToFit()
        }
    }
    
    func clearExerciseLabesl(){
        for i in 0..<exerciseNameLabels.count {
            exerciseNameLabels[i].text = ""
            
            exerciseSetxRepxWeightLabels[i].text = ""

        }
    }
}
