//
//  LogManager+ExerciseUpdate.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/22/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

import CoreData

extension LogManager {
    
    func updatedExercises(workoutLog: WorkoutLog, context: NSManagedObjectContext) -> NSOrderedSet? {
        
        switch workoutLog.workout.typeOfWorkout {
        case .Pull:
            return updatePullExercises()
        case .Push:
            return updatePushExercises()
        case .AlternatePull:
            return updateAlternatePullExercises(context)
        case .AlternatePush:
            return updateAlternatePushExercises(context)
        case .Legs:
            return updateLegExercises()
        }
    }
}

extension LogManager {
    func updatePullExercises() -> NSOrderedSet?
    {
        if let pullExercise = previousExercises(fromWorkoutType: .Pull)?.array as? [Exercise], var alternatePullExercises = previousExercises(fromWorkoutType: .AlternatePull)?.array as? [Exercise] {
            return updatedPullTypeExercises(&alternatePullExercises, compoundExerciseFrom: pullExercise)
        }
        
        return nil
    }
    
    func updatePushExercises() -> NSOrderedSet?
    {
        if let regularPushExercises = previousExercises(fromWorkoutType: .Push)?.array as? [Exercise], var alternatePushExercises = previousExercises(fromWorkoutType: .AlternatePush)?.array as? [Exercise] {
            return updatedPushTypeExercises(&alternatePushExercises, compoundExerciseFrom: regularPushExercises)
        }
        
        return nil
    }
    
    func updateLegExercises() -> NSOrderedSet?
    {
        return previousExercises(fromWorkoutType: .Legs)
    }
    
    func updateAlternatePullExercises(context: NSManagedObjectContext) -> NSOrderedSet?
    {
        if let previousPullExercises = previousExercises(fromWorkoutType: .Pull)?.array as? [Exercise] {
            return alternatePullExercises(previousPullExercises, context: context)
        }
        
        return nil
    }
    
    func updateAlternatePushExercises(context: NSManagedObjectContext) -> NSOrderedSet?
    {
        if let previousPushExercises = previousExercises(fromWorkoutType: .Push)?.array as? [Exercise] {
            return alternatePushExercises(previousPushExercises, context: context)
        }
        
        return nil
    }
}

