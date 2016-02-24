//
//  LoggingViewController.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/23/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit
import CoreData

class LoggingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, LoggingButtonDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var workoutLog: WorkoutLog?
    var timer: NSTimer?
    var count = 0
    
    lazy var exercises: [Exercise] = {
        return self.workoutLog!.workout.exercises.array as! [Exercise]
    } ()
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = workoutLog!.date
        
    }
    
    func setLogged(sender: SetButton) {
        startTimer()
        
    }
    
    
    @IBAction func logWorkout(sender: AnyObject) {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save: \(error)")
        }
        
    }


    
    func logExerciseSet() {
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save: \(error)")
        }
        
        //get exercise
        
        //get sets
        
        //get currentSet
        
        //set number logged to set's numberOfReps
    }

    
    func startTimer(){
        
//        let popup = createTimerLabel()
        
        
        // popup.show()
        
        
        if let _ = timer {
            timer!.invalidate()
            count = 0
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
        } else {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
        }
        
    }
    
    func createTimerLabel() -> APNotificationAlertView {
        let popup = APNotificationAlertView.popupDialogWithText("\(self.count) Nice job completing the set. If it was easy, rest 90 sec. If not, 3 min. ", options: ["Done"])
        popup.customCompletionHandler = {
            (index: Int) -> Void in
            
            APNotificationAlertView.hideAnimated(true)
        }
        
        return popup
    }
    
    
    func countUp(){
        count += 1
        if count == 5 {
        }
        
    }
    
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
     func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return exercises.count
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LoggingCell", forIndexPath: indexPath) as! LoggingCollectionViewCell
        
        cell.layer.cornerRadius = 5.0
        cell.layer.masksToBounds = true
        
        let exercise = exercises[indexPath.section]
        var sets = exercise.numberOfSets.array as! [Set]
        let set = sets[0]
        
        cell.delegate = self
        cell.numberOfSets = Int16(sets.count)
        cell.numberOfReps = set.numberOfReps
        cell.exerciseNameLabel.text = exercise.exerciseName
        cell.setxRepsxWeightLabel.text = "\(sets.count)x\(set.numberOfReps) \(exercise.weight.cleanValue)lbs"
        cell.formatButtons()
        
        
        
        
        return cell
    }
    
    
}

extension LoggingViewController: UICollectionViewDelegateFlowLayout {
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


