////
////  LoggingCollectionViewController.swift
////  PPL-iOS
////
////  Created by Jovanny Espinal on 2/22/16.
////  Copyright © 2016 Jovanny Espinal. All rights reserved.
////
//
//import UIKit
//import CoreData
//import AVFoundation
//
//class LoggingCollectionViewController: UICollectionViewController, LoggingButtonDelegate {
//    
//    
//    @IBOutlet weak var exerciseNameLabel: UILabel!
//    var workoutLog: WorkoutLog?
//    var timer: NSTimer?
//    var count = 0
//
//    lazy var exercises: [Exercise] = {
//        return self.workoutLog!.workout.exercises.array as! [Exercise]
//    } ()
//    var managedContext: NSManagedObjectContext!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.title = workoutLog!.date
//    }
//
//    
//    func setLogged() {
//        startTimer()
//    }
//    
//    func startTimer(){
//        
//        let popup = createTimerLabel()
//        
//        popup.show()
//
//        
//        if let _ = timer {
//            timer!.invalidate()
//            count = 0
//            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
//        } else {
//            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
//        }
//        
//    }
//    
//    func createTimerLabel() -> APNotificationAlertView {
//        let popup = APNotificationAlertView.popupDialogWithText("\(self.count)  If it was easy, rest 90 sec. If not, 3 min. ", options: ["Done"])
//        
//        
//        popup.position = APNotificationAlertViewPosition.Bottom
//        
//        popup.customCompletionHandler = {
//            (index: Int) -> Void in
//            
//            APNotificationAlertView.hideAnimated(true)
//        }
//        
//        return popup
//    }
//    
//    
//    func countUp(){
//        count += 1
//        if count == 5 {
//        }
//        
//    }
//    
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        
//        return exercises.count
//    }
//    
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LoggingCell", forIndexPath: indexPath) as! LoggingCollectionViewCell
//        
//        cell.layer.cornerRadius = 5.0
//        cell.layer.masksToBounds = true
//        
//        let exercise = exercises[indexPath.section]
//        var sets = exercise.numberOfSets.array as! [Set]
//        let set = sets[0]
//        
//        cell.delegate = self
//        cell.numberOfSets = Int16(sets.count)
//        cell.numberOfReps = set.numberOfReps
//        cell.exerciseNameLabel.text = exercise.exerciseName
//        cell.setxRepsxWeightLabel.text = "\(sets.count)x\(set.numberOfReps) \(exercise.weight.cleanValue)lbs"
//        cell.formatButtons()
//        
//        
//
//        
//        return cell
//    }
//
//
//}
//
//extension LoggingCollectionViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//            
//            return itemSizeForCells()
//    }
//    
//    func itemSizeForCells() -> CGSize {
//        let leftAndRightPaddings: CGFloat = 8.0
//        
//        let width = (CGRectGetWidth(collectionView!.frame) - leftAndRightPaddings)
//        let height = (CGRectGetHeight(collectionView!.frame)/6)
//        
//        return CGSize(width: width, height: height)
//        
//        
//    }
//}