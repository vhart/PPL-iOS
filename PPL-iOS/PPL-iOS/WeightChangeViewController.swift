//
//  WeightChangeViewController.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/24/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit

protocol WeightChangeViewControllerDelegate {
    func weightChanged(exerciseIndex: Int, weight: Double)
}

class WeightChangeViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var weightLabel: UILabel!
    var exerciseIndex: Int!
    var exerciseName: String!
    var weight: Double!
    var barbellExercises = [ExerciseName.deadlift, ExerciseName.barbellRow, ExerciseName.benchPress, ExerciseName.overheadPress, ExerciseName.squat, ExerciseName.romanianDeadlift, ExerciseName.legPress]
    var progressionScheme: ProgressionScheme!
    var delegate: WeightChangeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        navigationBar.tintColor = UIColor.whiteColor()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateLabel()
    }
    
    @IBAction func decreaseWeight(sender: AnyObject) {
        if progressionScheme == .Accessory {
            weight = weight - 2.5
        } else {
            weight = weight - 5.0
        }
        
        updateLabel()
    }
    
    @IBAction func increaseWeight(sender: AnyObject) {
        
        if progressionScheme == .Accessory {
            weight = weight + 2.5
        } else {
            weight = weight + 5.0
        }
        
        updateLabel()
    }
    
    func updateLabel() {
        weightLabel.text = "\(weight)"
        
        if barbellExercises.contains(exerciseName) {
            if weight <= 45.0 {
                navigationBar.topItem!.title = "Lift The Empty Bar"
            } else {
                navigationBar.topItem!.title = "Add \((weight-45.0)/2)lbs/side"
            }
        } else {
            navigationBar.topItem!.title = "Change Exercise Weight"
        }
        
        
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        self.delegate?.weightChanged(exerciseIndex, weight: weight)
    }
    
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
}
