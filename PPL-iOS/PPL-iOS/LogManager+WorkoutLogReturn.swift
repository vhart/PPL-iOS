//
//  LogManager+WorkoutLogReturn.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/22/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

extension LogManager {
    func recentWorkoutLogs() -> [WorkoutLog]? {
        var recentWorkoutLogsCopy = self.collectionOfWorkoutLogs.copyToArray() as! [WorkoutLog]
        var recentWorkoutLogs = [WorkoutLog]()
        
        
        if recentWorkoutLogsCopy.isEmpty {
            return nil
        } else if recentWorkoutLogsCopy.count == 1 {
            recentWorkoutLogs.append(recentWorkoutLogsCopy.first!)
            print(recentWorkoutLogs.first!.workout.typeOfWorkout)
            return recentWorkoutLogs
        } else {
            recentWorkoutLogs.append(recentWorkoutLogsCopy.popLast()!)
            recentWorkoutLogs.append(recentWorkoutLogsCopy.popLast()!)
            print(recentWorkoutLogs.first!.workout.typeOfWorkout)
            return recentWorkoutLogs
        }
    }
}