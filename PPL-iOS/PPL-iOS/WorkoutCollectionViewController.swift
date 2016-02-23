//
//  WorkoutCollectionViewController.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/22/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit
import CoreData

class WorkoutCollectionViewController: UICollectionViewController {
    var managedContext: NSManagedObjectContext!
    lazy var recentWorkoutLogs: [WorkoutLog]? = {
        
        return LogManager.sharedInstance.recentWorkoutLogs()
        
    }()
    var currentWorkoutLog: WorkoutLog!
    
    override func viewDidLoad() {
        
        
        

    }
    
    @IBAction func saveWorkout(sender: AnyObject) {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save: \(error)")
        }
    }
   
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        if let numberOfWorkoutLogs = recentWorkoutLogs?.count where numberOfWorkoutLogs > 1{
            
            if numberOfWorkoutLogs == 1 {
                return numberOfWorkoutLogs
            } else {
                return numberOfWorkoutLogs + 1
            }
            
        }
        
        return 2
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WorkoutLogCell", forIndexPath: indexPath) as! WorkoutLogCollectionViewCell
        
        cell.layer.cornerRadius = 5.0
        cell.layer.masksToBounds = true
        
        if indexPath.section == 0 {
            cell.typeOfWorkoutLabel.text = "\(currentWorkoutLog.workout.typeOfWorkout)"
            cell.updateExerciseLabels(currentWorkoutLog.workout.exercises.copyToArray() as! [Exercise])
            cell.dateLabel.text = "\(currentWorkoutLog.date)"
        } else if let workoutLogs = recentWorkoutLogs {
            let workoutLog = workoutLogs[indexPath.section - 1]
            let typeOfWorkout = workoutLog.workout.typeOfWorkout
            cell.typeOfWorkoutLabel.text = "\(typeOfWorkout)"
            cell.dateLabel.text = "\(workoutLog.date)"
            cell.updateExerciseLabels(workoutLog.workout.exercises.copyToArray() as! [Exercise])
        }
        

        return cell
    }
    
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue == "LogWorkout" {
            let loggingViewController = segue.destinationViewController as! LoggingCollectionViewController
            loggingViewController.workoutLog = currentWorkoutLog
        }
        
    }

}

extension WorkoutCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
            return itemSizeForCells()
    }
    
    func itemSizeForCells() -> CGSize {
        let leftAndRightPaddings: CGFloat = 8.0
        
        let width = (CGRectGetWidth(collectionView!.frame) - leftAndRightPaddings)
        let height = (CGRectGetHeight(collectionView!.frame)/6)
        
        return CGSize(width: width, height: height)
        
        
    }
}


