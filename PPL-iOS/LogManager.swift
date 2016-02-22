//
//  LogManager.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/17/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import CoreData


class LogManager {
    
    static let sharedInstance = LogManager()
    
    var collectionOfWorkoutLogs = NSOrderedSet()
    
    private init()
    {
        collectionOfWorkoutLogs = NSOrderedSet()
    }
    
    func setProperties(exercises: [WorkoutLog])
    {
        let mutableCopy = collectionOfWorkoutLogs.mutableCopy() as! NSMutableOrderedSet
        mutableCopy.addObjectsFromArray(exercises)
        collectionOfWorkoutLogs = mutableCopy
    }
    
    func createWorkoutLog(managedContext: NSManagedObjectContext) -> WorkoutLog
    {
        let currentWorkoutLog = WorkoutLog(typeOfWorkout: LogManager.sharedInstance.getWorkoutType(), context: managedContext)
        return currentWorkoutLog
    }
    
    func addWorkoutLog(workoutLog: WorkoutLog)
    {
        let setOfworkoutLogs = collectionOfWorkoutLogs.mutableCopy() as! NSMutableOrderedSet
        
        var arrayOfWorkoutLogs = [WorkoutLog]()
        arrayOfWorkoutLogs.append(workoutLog)
        setOfworkoutLogs.addObjectsFromArray(arrayOfWorkoutLogs)
        
        collectionOfWorkoutLogs = setOfworkoutLogs
    }
}

extension LogManager {
    
}


