//
//  WorkoutLog.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/17/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import CoreData


class WorkoutLog: NSManagedObject {
    
    // Insert code here to add functionality to your managed object subclass
    
    convenience init(typeOfWorkout: TypeOfWorkout, context: NSManagedObjectContext)
    {
        let entity = NSEntityDescription.entityForName("WorkoutLog", inManagedObjectContext: context)
        
        self.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        self.workout = Workout(typeOfWorkout: typeOfWorkout, context: context)
        
        self.date = NSDate.stringDate()
        
        updateExercises(context)
    }
    
    func updateExercises(context: NSManagedObjectContext)
    {
        if let updatedExercises = LogManager.sharedInstance.updatedExercises(self, context: context) {
            self.resetExerciseSets(updatedExercises)
        }
    }
    
    func resetExerciseSets(var previousWorkoutExercises: NSOrderedSet)
    {
        resetExerciseSetsHelper(&previousWorkoutExercises)

        workout.exercises = previousWorkoutExercises
    }
    
    func resetExerciseSetsHelper(inout exercises: NSOrderedSet)
    {
        if let exercises = exercises.array as? [Exercise] {
           
            for exercise in exercises {
               exercise.resetExerciseSetCompletion()
            }
        }
    }
}
