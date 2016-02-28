//
//  LoggingViewController.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/23/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit
import CoreData

protocol LoggingViewControllerDelegate {
    func loggedWorkout(context: NSManagedObjectContext)
}

class LoggingViewController: UIViewController {
    
    var managedContext: NSManagedObjectContext!
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var workoutLog: WorkoutLog?
    var timer: NSTimer?
    var delegate: LoggingViewControllerDelegate?
    var count = 0
    var exerciseIndex: Int = 0
    
    var exercises: [Exercise] {
        get {
            return self.workoutLog!.workout.exercises.array as! [Exercise]
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = workoutLog!.date
        buttonContainer.layer.borderWidth = 1.0
        buttonContainer.layer.borderColor = UIColor(white:0.67, alpha:0.7).CGColor
    }

    @IBAction func logWorkout(sender: UIButton)
    {
        workoutLog!.workout.checkForExerciseCompletion()
        LogManager.sharedInstance.addWorkoutLog(workoutLog!)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save: \(error)")
        }
        
        self.delegate?.loggedWorkout(managedContext)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func takePhotoTapped(sender: AnyObject)
    {
        
        
        
    }
    
    
    func startTimer()
    {
        //Show view containing timer label
        
        if let _ = timer {
            timer!.invalidate()
            count = 0
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
        } else {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
        }
    }
    
    func countUp()
    {
        count += 1
        
        if count == 180 || count == 300 {
            //Alarm goes off
        }

    }

    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ChangeWeight" {
            let weightChangeViewController = segue.destinationViewController as! WeightChangeViewController
            let button = sender as! SetButton
            
            weightChangeViewController.delegate = self
            weightChangeViewController.exerciseIndex = Int(button.exerciseIndex)
            
            let progressionScheme = exercises[Int(button.exerciseIndex)].progressionScheme
            let exerciseName = exercises[Int(button.exerciseIndex)].exerciseName
            
            weightChangeViewController.weight = exercises[Int(button.exerciseIndex)].weight
            weightChangeViewController.progressionScheme = progressionScheme
            weightChangeViewController.exerciseName = exerciseName
            
        }
    }
    
}


// MARK: UICollectionViewDelegateFlowLayout
extension LoggingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return itemSizeForCells()
    }
    
    func itemSizeForCells() -> CGSize
    {
        let leftAndRightPaddings: CGFloat = 8.0
        
        let width = (CGRectGetWidth(collectionView!.frame) - leftAndRightPaddings)
        let height = (CGRectGetHeight(collectionView!.frame)/6)
        
        return CGSize(width: width, height: height)
    }
}


// MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension LoggingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 1
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return exercises.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LoggingCell", forIndexPath: indexPath) as! LoggingCollectionViewCell
        
        cell.layer.cornerRadius = 5.0
        cell.layer.masksToBounds = true
        
        let exercise = exercises[indexPath.section]
        var sets = exercise.numberOfSets.array as! [Set]
        let set = sets[0]
        
        
        cell.delegate = self
        cell.sets = sets
        
        cell.exerciseNameLabel.text = exercise.exerciseName
        cell.setxRepsxWeightButton.setTitle("\(sets.count)x\(set.numberOfReps) \(exercise.weight.cleanValue)lbs", forState: .Normal)
        cell.numberOfSets = Int16(sets.count)
        
        
        cell.setxRepsxWeightButton.exerciseIndex = Int16(indexPath.section)
        
        
        for i in 0..<sets.count {
            cell.setButtons[i].setIndex = sets[i].setIndex
            cell.setButtons[i].exerciseIndex = Int16(indexPath.section)
            cell.setButtons[i].repsCompleted = sets[i].repsCompleted
            cell.setButtons[i].numberOfReps = sets[i].numberOfReps
            cell.setButtons[i].firstAttempt = sets[i].firstAttempt
            
        }
        
        cell.formatButtons()
        
        return cell
    }
}

// MARK: LoggingCollectionViewCellDelegate
extension LoggingViewController: LoggingCollectionViewCellDelegate {
    func setLogged(sender: SetButton, set: Set)
    {
        startTimer()
        set.checkForCompletion(set.repsCompleted)
        
    }
    
    func weightChanged(exerciseIndex: Int, weight: Double)
    {
        self.exerciseIndex = exerciseIndex
        
        let mutableExercises = workoutLog!.workout.exercises.mutableCopy() as! NSMutableOrderedSet
        let exercise = mutableExercises[exerciseIndex] as! Exercise
        exercise.weight = weight
        
        let exerciseA = exercise as AnyObject
        mutableExercises.replaceObjectAtIndex(exerciseIndex, withObject: exerciseA)
        
        workoutLog!.workout.exercises = mutableExercises
        
        var indexPaths = [NSIndexPath]()
        
        for i in 0..<exercises.count {
            let indexPath = NSIndexPath(forRow: 1, inSection: i)
            indexPaths.append(indexPath)
        }
        
        let indexSet = NSIndexSet(index: exerciseIndex)
        collectionView.reloadSections(indexSet)
        
    }
}

// MARK: WeightChangeViewControllerDelegate
extension LoggingViewController: WeightChangeViewControllerDelegate {
    func callSegueFromCell(myData dataobject: AnyObject)
    {
        self.performSegueWithIdentifier("ChangeWeight", sender:dataobject )
    }
}
