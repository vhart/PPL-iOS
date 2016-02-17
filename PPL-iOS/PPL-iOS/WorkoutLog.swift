//
//  WorkoutLog.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/17/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

struct WorkoutLog {
    var workout: Workout
    let date: String
    
    init(typeOfWorkout: TypeOfWorkout) {
        self.workout = Workout(typeOfWorkout: typeOfWorkout)
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        self.date = dateFormatter.stringFromDate(currentDate)
    }
    
    mutating func updateWeightsFromPreviousWorkout(previousWorkoutExercises: [Exercise]) {
        
        for exercise in previousWorkoutExercises {
            exercise.didCompleteAllSets = false
        }
        
        workout.exercises = previousWorkoutExercises
    }
}
