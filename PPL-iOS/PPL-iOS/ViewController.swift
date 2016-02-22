//
//  ViewController.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/17/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var managedContext: NSManagedObjectContext!
    lazy var currentWorkoutLog: WorkoutLog = {
        return LogManager.sharedInstance.createWorkoutLog(self.managedContext)
    }()
    var timer: NSTimer?
    var count = 0
    var repCount: Int16 = 0

    @IBOutlet weak var setButtonLabel: UIButton!
    
    @IBOutlet weak var simulateWorkoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func simulateWorkoutTapped(sender: UIButton) {
        print("////////////////////////////Day \(count+1): \(currentWorkoutLog.workout.typeOfWorkout)")
        self.count += 1
        simulateWorkout(&currentWorkoutLog, numberOfReps: 12)
        
    }
    
    @IBAction func setButtonTapped(sender: UIButton) {
        if repCount < 1 {
            repCount = setMaxRepCount() + 1
        }
        startTimer()
        repCount -= 1
        sender.setTitle("\(repCount)", forState: .Normal)
    }
    
    func setMaxRepCount() -> Int16 {
        let mutableExercises = currentWorkoutLog.workout.exercises.copyToArray() as! [Exercise]
        let sets = mutableExercises[0].numberOfSets.array as! [Set]
        return sets[0].numberOfReps
    }

    func simulateWorkout(inout workoutLog: WorkoutLog, numberOfReps: Int16) {
        let mutableExercises = workoutLog.workout.exercises.mutableCopy() as! NSMutableOrderedSet
        
        print("/n\(workoutLog.workout.typeOfWorkout)")
        for exercise in mutableExercises {
            
            let exercise = exercise as! Exercise
            print("Exercise: \(exercise.exerciseName) ... Weight: \(exercise.weight)")
            
            for set in exercise.numberOfSets {
                let set = set as! Set
                set.checkForCompletion(numberOfReps)
            }
            exercise.checkForCompletionOfSets()
        }
        
        workoutLog.workout.exercises = mutableExercises
        
        LogManager.sharedInstance.addWorkoutLog(workoutLog)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save: \(error)")
        }
        
    }
    
    @IBAction func saveResultsTapped(sender: AnyObject) {
        startTimer()
        
    }
    
    func startTimer(){
        if let _ = timer {
            timer!.invalidate()
            count = 0
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
        } else {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
        }
    }
    
    func countUp(){
        count += 1
        updateLabel()
        if count == 5 {
            displayAlertView()
        }
        
    }
    
    func updateLabel(){
        print(count)
    }
    
    func displayAlertView(){
            print("time's up!")
    }
    
    func createCurrentWorkoutLog() -> WorkoutLog {
        return LogManager.sharedInstance.createWorkoutLog(self.managedContext)
    }
}

