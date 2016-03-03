//
//  WorkoutViewController.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/23/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit
import CoreData

class WorkoutViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var managedContext: NSManagedObjectContext!
    var currentWorkoutLog: WorkoutLog!
    var count = 0
    var recentWorkoutLogs: [WorkoutLog]? {
        get {
            return LogManager.sharedInstance.recentWorkoutLogs()
        }
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
        self.tabBarController?.tabBar.hidden = false
    }
    
    @IBAction func saveWorkout(sender: AnyObject)
    {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save: \(error)")
        }
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "LogWorkout" {
            self.tabBarController?.tabBar.hidden = true
            let loggingViewController = segue.destinationViewController as! LoggingViewController
            loggingViewController.delegate = self
            loggingViewController.workoutLog = currentWorkoutLog
            loggingViewController.managedContext = managedContext
        }
    }
}


// MARK: UICollectionViewDelegateFlowLayout
extension WorkoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return itemSizeForCells()
    }
    
    func itemSizeForCells() -> CGSize
    {
        let leftAndRightPaddings: CGFloat = 8.0
        
        let width = (CGRectGetWidth(collectionView!.frame) - leftAndRightPaddings)
        let height = (CGRectGetHeight(collectionView!.frame)/6)+8.0
        
        return CGSize(width: width, height: height)
    }
}

// MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension WorkoutViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 1
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        if let numberOfWorkoutLogs = recentWorkoutLogs?.count where numberOfWorkoutLogs > 0 {
            return numberOfWorkoutLogs + 1
        }
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WorkoutLogCell", forIndexPath: indexPath) as! WorkoutLogCollectionViewCell
        
        cell.layer.cornerRadius = 5.0
        cell.layer.masksToBounds = true
        
        
        if indexPath.section == 0 {
            cell.typeOfWorkoutLabel.text = "\(currentWorkoutLog.workout.typeOfWorkout)"
            cell.updateExerciseLabels(currentWorkoutLog.workout.exercises.copyToArray() as! [Exercise])
            cell.dateLabel.text = "Today"
        } else if let workoutLogs = recentWorkoutLogs {
            let workoutLog = workoutLogs[indexPath.section - 1]
            
            let typeOfWorkout = workoutLog.workout.typeOfWorkout
            
            cell.typeOfWorkoutLabel.text = "\(typeOfWorkout)"
            cell.dateLabel.text = "\(workoutLog.date)"
            cell.updateExerciseLabels(workoutLog.workout.exercises.copyToArray() as! [Exercise])
        }
        
        return cell
    }
}

// MARK: LoggingViewControllerDelegate
extension WorkoutViewController: LoggingViewControllerDelegate {
    func loggedWorkout(context: NSManagedObjectContext)
    {
        managedContext = context
        currentWorkoutLog = LogManager.sharedInstance.createWorkoutLog(managedContext)
        collectionView.reloadData()
    }
}