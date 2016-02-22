//
//  LogManager+WorkoutType.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/22/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

extension LogManager {
    func getWorkoutType() -> TypeOfWorkout
    {
        if var workoutLogsCopy = collectionOfWorkoutLogs.copyToArray() as? [WorkoutLog] where !workoutLogsCopy.isEmpty{
            return workoutType(&workoutLogsCopy)
        }
        
        return .Pull
    }
}

extension LogManager {
    
    func workoutType(inout workoutLogs: [WorkoutLog]) -> TypeOfWorkout
    {
        let mostRecentWorkoutType = workoutLogs.last!.workout.typeOfWorkout
        workoutLogs.removeLast()
        
        if workoutLogs.isEmpty {
            return workoutTypeHelper(fromPreviousWorkoutType: mostRecentWorkoutType)!
        } else {
            let secondMostRecentType = workoutLogs.last!.workout.typeOfWorkout
            return workoutTypeHelper(fromPreviousWorkoutTypes: (mostRecentWorkoutType, secondMostRecentType))!
        }
        
    }
    
    func workoutTypeHelper(fromPreviousWorkoutType typeOfWorkout: TypeOfWorkout) -> TypeOfWorkout?
    {
        switch typeOfWorkout{
        case .Pull:
            return .Push
        case .Push:
            return .Legs
        case .Legs:
            return .Push
        default:
            return nil
        }
        
    }
    
    func workoutTypeHelper(fromPreviousWorkoutTypes typesOfWorkout: (latestWorkout: TypeOfWorkout, secondLatestWorkout: TypeOfWorkout)) -> TypeOfWorkout?
    {
        
        switch (typesOfWorkout.latestWorkout, typesOfWorkout.secondLatestWorkout) {
        case (.Pull, _):
            return .Push
        case (.Push, _):
            return .Legs
        case (.Legs, .Push):
            return .AlternatePull
        case (.AlternatePull, _):
            return .AlternatePush
        case (.AlternatePush, _):
            return .Legs
        case (.Legs, .AlternatePush):
            return .Pull
        default:
            return nil
        }
    }
}