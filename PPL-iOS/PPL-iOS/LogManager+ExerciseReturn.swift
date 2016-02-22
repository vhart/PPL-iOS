//
//  LogManager+ExerciseReturn.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/22/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

extension LogManager {
    func previousExercises(fromWorkoutType typeOfWorkout: TypeOfWorkout) -> NSMutableOrderedSet? {
        let workoutLogs = collectionOfWorkoutLogs.copyToArray() as! [WorkoutLog]
        
        for workoutLog in workoutLogs.reverse() {
            if isWorkoutType(workoutLog, typeToMatch: typeOfWorkout) {
                return exercises(fromWorkoutLog: workoutLog)!
            }
        }
        
        return nil
    }
    
    func exercises(fromWorkoutLog workoutLog: WorkoutLog) -> NSMutableOrderedSet? {
        return workoutLog.workout.exercises as? NSMutableOrderedSet
    }
}

extension LogManager {
    func isWorkoutType(workoutLog: WorkoutLog, typeToMatch: TypeOfWorkout) -> Bool {
        return workoutLog.workout.typeOfWorkout == typeToMatch
    }
}