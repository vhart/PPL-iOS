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

class LoggingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, LoggingButtonDelegate, WeightChangeViewControllerDelegate {
    
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var workoutLog: WorkoutLog?
    var timer: NSTimer?
    var count = 0
    var delegate: LoggingViewControllerDelegate?
    var exerciseIndex: Int = 0
    
    var exercises: [Exercise] {
        get {
            return self.workoutLog!.workout.exercises.array as! [Exercise]
        }
        
    }
    var managedContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = workoutLog!.date
        buttonContainer.layer.borderWidth = 1.0
        buttonContainer.layer.borderColor = UIColor(white:0.67, alpha:0.7).CGColor
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setLogged(sender: SetButton, set: Set) {
        startTimer()
        set.checkForCompletion(set.repsCompleted)
        logExerciseSet(sender, set: set)
        
        
    }
    
    func weightChanged(exerciseIndex: Int, weight: Double) {
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
    
    @IBAction func logWorkout(sender: UIButton) {
        
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
    
    
    func callSegueFromCell(myData dataobject: AnyObject) {
        self.performSegueWithIdentifier("ChangeWeight", sender:dataobject )
    }
    
    func logExerciseSet(setButton: SetButton, set: Set) {
//        let index = Int(setButton.exerciseIndex)
//        let setIndex = Int(setButton.setIndex)
//        
//        //Create mutable exercises
//        let mutableExercises = workoutLog!.workout.exercises.mutableCopy() as! NSMutableOrderedSet
//        
//        //Create exercise
//        let exercise = mutableExercises[index] as! Exercise
//        
//        //Create mutable sets
//        let sets = exercise.numberOfSets as! NSMutableOrderedSet
//        
//        set.repsCompleted = numberOfReps
//        set.firstAttempt = false
//        set.checkForCompletion(set.repsCompleted)
//        print(set.didCompleteSet)
//        print(set.repsCompleted)
//        
//        //Turn set into anyObject
//        let setA = set as AnyObject
//        
//        //Replace object at index in mutable sets with set
//        sets.replaceObjectAtIndex(setIndex, withObject: setA)
//        
//        //Set exercise sets to the new edited sets
//        exercise.numberOfSets = sets
//        
//        //Turn exercise into anyObject
//        let exerciseA = exercise as AnyObject
//        
//        //Replace object at index in mutable exercises with exercise
//        mutableExercises.replaceObjectAtIndex(index, withObject: exerciseA)
//        
//        
//        //Set exercises to edited exercises
//        workoutLog!.workout.exercises = mutableExercises
//        
//        //        do {
//        //            try managedContext.save()
//        //        } catch let error as NSError {
//        //            print("Could not save: \(error)")
//        //        }
//        
        
    }
    
    
    @IBAction func takePhotoTapped(sender: AnyObject) {
        
        
        
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
    
//    func createTimerLabel() -> APNotificationAlertView {
//        let popup = APNotificationAlertView.popupDialogWithText("\(self.count) Nice job completing the set. If it was easy, rest 90 sec. If not, 3 min. ", options: ["Done"])
//        popup.customCompletionHandler = {
//            (index: Int) -> Void in
//            
//            APNotificationAlertView.hideAnimated(true)
//        }
//        
//        return popup
//    }
    
    
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
        
        
        //The cell has a function that formats the buttons. This is where the buttons are being formatted and disabled if needed. Im thinking this is where the problem is, but I think the problem has to do with the reusing of the cells.
        cell.formatButtons()
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
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


