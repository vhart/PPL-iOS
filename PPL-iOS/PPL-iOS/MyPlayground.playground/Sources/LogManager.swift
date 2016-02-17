//
//  LogManager.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/17/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

public struct LogManager {
    public var collectionOfWorkoutLogs = OrderedDictionary<Int, (date: String, workoutLog: WorkoutLog)>()
    
    public init(){
        
    }
    
   public mutating func addWorkoutLog(workoutLog: WorkoutLog) {
        let dateString = workoutLog.date
        
        if var lastKey = collectionOfWorkoutLogs.keys.last {
            lastKey += 1
            collectionOfWorkoutLogs[lastKey] = (dateString, workoutLog)
        } else {
            collectionOfWorkoutLogs[0] = (dateString, workoutLog)
        }
        
    }
    
    public func returnPreviousWorkoutExercises(workoutLog: WorkoutLog) -> [Exercise]? {
        let typeOfWorkout = workoutLog.workout.typeOfWorkout
        
        switch typeOfWorkout {
        case .Pull:
            return returnPreviousPullExercises()
        case .Push:
            return returnPreviousPushExercises()
        case .AlternatePull:
            return returnPreviousAlternatePullExercises()
        case .AlternatePush:
            return returnPreviousAlternatePushExercises()
        case .Legs:
            return returnPreviousWorkoutExercisesHelper(.Legs)
        }
    }
    
}


// Different types of exercise returns
extension LogManager {
    func returnPreviousPushExercises() -> [Exercise] {
        
        var pushExercises = [Exercise]()
        
        if var regularPushExercises = returnPreviousWorkoutExercisesHelper(.Push), alternatePushExercises = returnPreviousWorkoutExercisesHelper(.AlternatePush) {
            pushExercises.insert(regularPushExercises[0], atIndex: 0)
            pushExercises.insert(regularPushExercises[1], atIndex: 1)
            alternatePushExercises.removeRange(0...1)
            
            pushExercises += alternatePushExercises
        }
        
        return pushExercises
    }
    
    func returnPreviousAlternatePushExercises() -> [Exercise] {
        var pushExercises = [Exercise]()
        
        if var regularPushExercises = returnPreviousWorkoutExercisesHelper(.Push) {
            regularPushExercises.removeRange(0...1)
            if var alternatePushExercises = returnPreviousWorkoutExercisesHelper(.AlternatePush) {
                pushExercises.insert(alternatePushExercises[0], atIndex: 0)
                pushExercises.insert(alternatePushExercises[1], atIndex: 1)
                pushExercises += regularPushExercises
            } else {
                let workoutTemp = Workout(typeOfWorkout: .AlternatePush)
                var altExercises = workoutTemp.exercises
                altExercises.removeRange(1..<altExercises.count)
                altExercises += regularPushExercises
                return altExercises
            }
        }
        
        return pushExercises
    }
    
    func returnPreviousPullExercises() -> [Exercise] {
        var pullExercises = [Exercise]()
        
        if var regularPullExercises = returnPreviousWorkoutExercisesHelper(.Pull), alternatePullExercises = returnPreviousWorkoutExercisesHelper(.AlternatePull) {
            pullExercises.insert(regularPullExercises[0], atIndex: 0)
            alternatePullExercises.removeFirst()
            
            pullExercises += alternatePullExercises
        }
        
        return pullExercises
    }
    
    func returnPreviousAlternatePullExercises() -> [Exercise] {
        var pullExercises = [Exercise]()
        
        if var regularPullExercises = returnPreviousWorkoutExercisesHelper(.Pull) {
            regularPullExercises.removeFirst()
            if var alternatePullExercises = returnPreviousWorkoutExercisesHelper(.AlternatePull) {
                pullExercises.insert(alternatePullExercises[0], atIndex: 0)
                pullExercises += regularPullExercises
                
            } else {
                let workoutTemp = Workout(typeOfWorkout: .AlternatePull)
                var altExercises = workoutTemp.exercises
                altExercises.removeRange(1..<altExercises.count)
                altExercises += regularPullExercises
                return altExercises
            }
        }
        
        return pullExercises
    }
    
    func returnPreviousWorkoutExercisesHelper(typeOfWorkout: TypeOfWorkout) -> [Exercise]? {
        let keys = collectionOfWorkoutLogs.keys.reverse()
        for i in keys {
            if let pastWorkoutType = collectionOfWorkoutLogs[i] {
                if pastWorkoutType.workoutLog.workout.typeOfWorkout == typeOfWorkout {
                    return pastWorkoutType.workoutLog.workout.exercises
                }
            }
        }
        return nil
        
    }
    
}
