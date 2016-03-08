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

        guard !recentWorkoutLogsCopy.isEmpty else{
            return nil
        }
        
        recentWorkoutLogs.append(recentWorkoutLogsCopy.popLast()!)

        if !recentWorkoutLogsCopy.isEmpty {
            recentWorkoutLogs.append(recentWorkoutLogsCopy.popLast()!)
        }

        return recentWorkoutLogs
    }
}