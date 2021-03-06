//
//  Workout.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/17/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import CoreData


class Workout: NSManagedObject {
    

// Insert code here to add functionality to your managed object subclass

    convenience init(typeOfWorkout: TypeOfWorkout, context: NSManagedObjectContext)
    {
        let entity = NSEntityDescription.entityForName("Workout", inManagedObjectContext: context)
        
        self.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        self.typeOfWorkout = typeOfWorkout
        createRoutine(typeOfWorkout, context: context)
    }
    
    func createRoutine(typeOfWorkout: TypeOfWorkout, context: NSManagedObjectContext)
    {
        switch typeOfWorkout {
        case .Pull:
            createPullRoutine(context)
        case .Push:
            createPushRoutine(context)
        case .Legs:
            createLegRoutine(context)
        case .AlternatePull:
            createAlternatePullRoutine(context)
        case .AlternatePush:
            createAlternatePushRoutine(context)
        }
    }
    
    func checkForExerciseCompletion() {
        
        let mutableExercises = exercises.mutableCopy() as! NSMutableOrderedSet
        
        for exercise in mutableExercises {
            
            let exercise = exercise as! Exercise
            exercise.checkForCompletionOfSets()
            print("exercise completion = \(exercise.didCompleteAllSets)")
        }
        
        exercises = mutableExercises
    }
    
    func attemptedAllSets() -> Bool
    {
        for exercise in exercises {
            let exercise = exercise as! Exercise
            
            if !exercise.attemptedAllSets() {
                return false
            }
            
            print("\(exercise.attemptedAllSets())")
        }
        
        return true
        
    }
}

