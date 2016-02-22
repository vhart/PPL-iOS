//
//  LogManager+ExerciseUpdateHelpers.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/22/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import CoreData

// MARK: Global Update Helpers
extension LogManager {
    func addBaseExercises(inout updatedExercises: NSMutableOrderedSet, baseExercises: [Exercise])
    {
        updatedExercises.addObjectsFromArray(baseExercises)
    }
}


// MARK: Pull Update Helpers
extension LogManager {
    func alternatePullExercises(var previousPullExercises: [Exercise], context: NSManagedObjectContext) -> NSOrderedSet?
    {
        if let previousAlternatePullExercises = previousExercises(fromWorkoutType: .AlternatePull)?.array as? [Exercise] {
            return updatedPullTypeExercises(&previousPullExercises, compoundExerciseFrom: previousAlternatePullExercises)
        } else {
            let workoutTemp = Workout(typeOfWorkout: .AlternatePull, context: context)
            return updatedPullTypeExercises(previousPullExercises, workoutTemp: workoutTemp)
        }
    }
    
    func updatedPullTypeExercises(inout baseExercises: [Exercise], compoundExerciseFrom previousExercise: [Exercise]) -> NSMutableOrderedSet
    {
        var updatedExercises = NSMutableOrderedSet()
        
        removePreviousPullTypeCompoundExercises(&baseExercises)
        
        addCompoundExerciseFromPullExercise(&updatedExercises, exercises: previousExercise)
        
        addBaseExercises(&updatedExercises, baseExercises: baseExercises)
        
        return updatedExercises
    }
    
    func updatedPullTypeExercises(var previousBaseExercises: [Exercise], workoutTemp: Workout) -> NSMutableOrderedSet?
    {
        if let alternatePullExercises = workoutTemp.exercises.array as? [Exercise] {
            return updatedPullTypeExercises(&previousBaseExercises, compoundExerciseFrom: alternatePullExercises)
        }
        
        return nil
    }
    
    func addCompoundExerciseFromPullExercise(inout updatedExercises: NSMutableOrderedSet, exercises: [Exercise])
    {
        updatedExercises.addObject(exercises[0])
    }
    
    func removePreviousPullTypeCompoundExercises(inout previousExercises: [Exercise])
    {
        previousExercises.removeFirst()
    }
}


// MARK: Push Update Helpers
extension LogManager {
    func alternatePushExercises(var previousPushExercises: [Exercise], context: NSManagedObjectContext  ) -> NSOrderedSet?
    {
        if let previousAlternatePushExercises = previousExercises(fromWorkoutType: .AlternatePush)?.array as? [Exercise] {
            return updatedPushTypeExercises(&previousPushExercises, compoundExerciseFrom: previousAlternatePushExercises)
        } else {
            let workoutTemp = Workout(typeOfWorkout: .AlternatePush, context: context)
            return updatedPushTypeExercises(previousPushExercises, workoutTemp: workoutTemp)
        }
        
    }
    
    func updatedPushTypeExercises(inout baseExercises: [Exercise], compoundExerciseFrom previousAlternatePushExercises: [Exercise]) -> NSMutableOrderedSet
    {
        var updatedAlternatePushExercises = NSMutableOrderedSet()
        
        removePreviousPushTypeCompoundExercises(&baseExercises)
        
        addCompoundExercisesFromPushExercise(&updatedAlternatePushExercises, exercises: previousAlternatePushExercises)
        
        addBaseExercises(&updatedAlternatePushExercises, baseExercises: baseExercises)
        
        return updatedAlternatePushExercises
    }
    
    func updatedPushTypeExercises(var previousBaseExercises: [Exercise], workoutTemp: Workout) -> NSMutableOrderedSet?
    {
        if let alternatePushExercises = workoutTemp.exercises.array as? [Exercise]{
            return updatedPushTypeExercises(&previousBaseExercises, compoundExerciseFrom: alternatePushExercises)
        }
        
        return nil
    }
    
    func addCompoundExercisesFromPushExercise(inout updatedExercises: NSMutableOrderedSet, exercises: [Exercise])
    {
        updatedExercises.addObject(exercises[0])
        updatedExercises.addObject(exercises[1])
    }
    
    func removePreviousPushTypeCompoundExercises(inout previousExercises: [Exercise])
    {
        previousExercises.removeRange(0...1)
    }
}