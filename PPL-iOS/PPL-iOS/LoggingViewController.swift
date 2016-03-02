//
//  LoggingViewController.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/23/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit
import CoreData
import AudioToolbox
import CloudKit

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
    
    @IBOutlet weak var timerDescription: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerContainer: UIView!
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
        timerContainer.hidden = true
    }
    
    @IBAction func logWorkout(sender: UIButton)
    {
        
        
        
        if workoutLog!.workout.attemptedAllSets() {
            workoutLog!.workout.checkForExerciseCompletion()
            LogManager.sharedInstance.addWorkoutLog(self.workoutLog!)
            
            do {
                try self.managedContext.save()
            } catch let error as NSError {
                print("Could not save: \(error)")
            }
            
            self.delegate?.loggedWorkout(self.managedContext)
            self.navigationController?.popViewControllerAnimated(true)
            
        } else {
            
            let alertController = UIAlertController(title: "Didn't Attempt All Sets", message: "Are you sure you want to finish the workout?", preferredStyle: .Alert)
            
            
            let attempt = UIAlertAction(title: "Attempt Unfinished Sets", style: .Default) { (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            let finishWorkout = UIAlertAction(title: "Leave Sets Unfinished", style: .Destructive) { (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
                self.workoutLog!.workout.checkForExerciseCompletion()
                LogManager.sharedInstance.addWorkoutLog(self.workoutLog!)
                
                do {
                    try self.managedContext.save()
                } catch let error as NSError {
                    print("Could not save: \(error)")
                }
                
                self.delegate?.loggedWorkout(self.managedContext)
                self.navigationController?.popViewControllerAnimated(true)
            }
            
            alertController.addAction(finishWorkout)
            alertController.addAction(attempt)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
        
        
    }
    
    
    @IBAction func dismissTimerButtonTapped(sender: UIButton)
    {
        timerContainer.hidden = true
        timer!.invalidate()
        count = 0
    }
    
    
    @IBAction func takePhotoTapped(sender: AnyObject)
    {
        let alertController = UIAlertController(title: "Progress Picture", message: "What do you want to do?", preferredStyle: .ActionSheet)
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .Default) { (action) -> Void in
            self.takePhoto()
        }
        
        let choosePicture = UIAlertAction(title: "Choose Photo From Library", style: .Default) { (action) -> Void in
            self.pickPhoto()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alertController.addAction(takePhoto)
        alertController.addAction(choosePicture)
        alertController.addAction(cancel)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
        
    }
    
    func configureTimerLabel() {
        let minutes = count / 60
        let seconds = count % 60
        
        timerLabel.text = String(format: "%d:%02d", minutes, seconds)
    }
    
    
    func startTimer()
    {
        
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
        configureTimerLabel()
        
        if count == 90 || count == 300 {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            AudioServicesPlayAlertSound(SystemSoundID(1033))
        }
        
    }
    
    func delay(delay: Double, closure: ()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            closure
        )
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
        if timerContainer.hidden == false {
            timerContainer.hidden = true
        }
        
        delay(0.7) {
            self.timerContainer.hidden = false
        }
        
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
        
        self.collectionView.reloadSections(indexSet)
        
        
    }
}

// MARK: WeightChangeViewControllerDelegate
extension LoggingViewController: WeightChangeViewControllerDelegate {
    func callSegueFromCell(myData dataobject: AnyObject)
    {
        self.performSegueWithIdentifier("ChangeWeight", sender:dataobject )
    }
}

extension LoggingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func pickPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .PhotoLibrary
            imagePicker.allowsEditing = false
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func takePhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        dismissViewControllerAnimated(true, completion: nil)
        
        //Where to save image and how
    }
}
