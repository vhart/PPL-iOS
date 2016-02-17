//
//  Workout.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/14/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

struct  Workout {
    let typeOfWorkout: TypeOfWorkout
    var exercises = [Exercise]()
    
    init(typeOfWorkout: TypeOfWorkout) {
        self.typeOfWorkout = typeOfWorkout
        createRoutine(typeOfWorkout)
    }
    
    internal mutating func createRoutine(typeOfWorkout: TypeOfWorkout) {
        switch typeOfWorkout {
        case .Pull:
            createPullRoutine()
        case .Push:
            createPushRoutine()
        case .Legs:
            createLegRoutine()
        case .AlternatePull:
            createAlternatePullRoutine()
        case .AlternatePush:
            createAlternatePushRoutine()
        }
    }
    
}

//Contains Base Routines
extension Workout {
    internal mutating func createBasePullRoutine() {
        let pulldown = Exercise(nameOfExercise: ExerciseName.pulldown, weightOfExercise: 85.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .UpperBody)
        exercises.append(pulldown)
        
        let seatedCableRow = Exercise(nameOfExercise: ExerciseName.seatedCableRow, weightOfExercise: 85.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .UpperBody)
        exercises.append(seatedCableRow)
        
        let facePull = Exercise(nameOfExercise: ExerciseName.facePull, weightOfExercise: 40.0, numberOfSets: 5, numberOfReps: 20, progressionScheme: .UpperBody)
        exercises.append(facePull)
        
        let hammerCurl = Exercise(nameOfExercise: ExerciseName.hammerCurl, weightOfExercise: 25.0, numberOfSets: 4, numberOfReps: 12, progressionScheme: .Accessory)
        exercises.append(hammerCurl)
        
        let dumbbellCurl = Exercise(nameOfExercise: ExerciseName.dumbbellCurl, weightOfExercise: 25.0, numberOfSets: 4, numberOfReps: 12, progressionScheme: .Accessory)
        exercises.append(dumbbellCurl)
    }
    
    internal mutating func createBasePushRoutine() {
        let inclineDumbbellPress = Exercise(nameOfExercise: ExerciseName.inclineDumbbellPress, weightOfExercise: 35.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .Accessory)
        exercises.append(inclineDumbbellPress)
        
        let tricepsPushDown = Exercise(nameOfExercise: ExerciseName.tricepsPushdown, weightOfExercise: 65.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .UpperBody)
        exercises.append(tricepsPushDown)
        
        let lateralRaises1 = Exercise(nameOfExercise: ExerciseName.lateralRaises1, weightOfExercise: 15.0, numberOfSets: 3, numberOfReps: 20, progressionScheme: .Accessory)
        exercises.append(lateralRaises1)
        
        let overheadTricepsExtensions = Exercise(nameOfExercise: ExerciseName.overheadTricepsExtension, weightOfExercise: 65.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .UpperBody)
        exercises.append(overheadTricepsExtensions)
        
        let lateralRaises2 = Exercise(nameOfExercise: ExerciseName.lateralRaises2, weightOfExercise: 15.0, numberOfSets: 3, numberOfReps: 20, progressionScheme: .Accessory)
        exercises.append(lateralRaises2)
    }
    
}

//Contains Different Types of Routines
extension Workout {
    internal mutating func createPullRoutine() {
        let deadlift = Exercise(nameOfExercise: ExerciseName.deadlift, weightOfExercise: 135.0, numberOfSets: 1, numberOfReps: 5, progressionScheme: .Deadlift)
        exercises.append(deadlift)
        
        createBasePullRoutine()
        
    }
    
    internal mutating func createPushRoutine() {
        let benchPress = Exercise(nameOfExercise: ExerciseName.benchPress, weightOfExercise: 135.0, numberOfSets: 5, numberOfReps: 5, progressionScheme: .UpperBody)
        exercises.append(benchPress)
        
        let overheadPress = Exercise(nameOfExercise: ExerciseName.overheadPress, weightOfExercise: 135.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .UpperBody)
        exercises.append(overheadPress)
        
        createBasePushRoutine()
        
    }
    
    internal mutating func createLegRoutine() {
        let squat = Exercise(nameOfExercise: ExerciseName.squat, weightOfExercise: 165.0, numberOfSets: 3, numberOfReps: 5, progressionScheme: .LowerBody)
        exercises.append(squat)
        
        let romanianDeadlift = Exercise(nameOfExercise: ExerciseName.romanianDeadlift, weightOfExercise: 175.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .LowerBody)
        exercises.append(romanianDeadlift)
        
        let legPress = Exercise(nameOfExercise: ExerciseName.legPress, weightOfExercise: 225.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .LowerBody)
        exercises.append(legPress)
        
        let legCurl = Exercise(nameOfExercise: ExerciseName.legCurl, weightOfExercise: 225.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .LowerBody)
        exercises.append(legCurl)
        
        let calfRaises = Exercise(nameOfExercise: ExerciseName.calfRaises, weightOfExercise: 180.0, numberOfSets: 5, numberOfReps: 20, progressionScheme: .LowerBody)
        exercises.append(calfRaises)
    }
}

//Contains Alternate Routines
extension Workout {
    internal mutating func createAlternatePullRoutine() {
        let barbellRow = Exercise(nameOfExercise: ExerciseName.barbellRow, weightOfExercise: 135.0, numberOfSets: 5, numberOfReps: 5, progressionScheme: .Deadlift)
        exercises.append(barbellRow)
        
        createBasePullRoutine()
        
    }
    
    internal mutating func createAlternatePushRoutine() {
        let overheadPress = Exercise(nameOfExercise: ExerciseName.overheadPress, weightOfExercise: 135.0, numberOfSets: 5, numberOfReps: 5, progressionScheme: .UpperBody)
        exercises.append(overheadPress)
        
        let benchPress = Exercise(nameOfExercise: ExerciseName.benchPress, weightOfExercise: 135.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .UpperBody)
        exercises.append(benchPress)
        
        createBasePushRoutine()
    }
}