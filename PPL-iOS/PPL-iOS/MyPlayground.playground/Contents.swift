import Foundation

var logManager = LogManager()

func simulateWorkout(inout workout: WorkoutLog, numberOfRepsPerSet: Int) {
    
    let exercises = workout.workout.exercises
    
    //Loop through every exercise in workout
    for exercise in exercises {
        
        //Loop through every set in sets of exercise
        for set in exercise.sets {
            
            //Check for set completion
            set.checkForCompletion(numberOfRepsPerSet)
        }
        
        //Check for completion of sets
        exercise.checkForCompletionOfSets()
    }
    
    logManager.addWorkoutLog(workout)
}


//WEEK 1 SIMULATION

// Day 1: Pull
var workoutLog1 = WorkoutLog(typeOfWorkout: .Pull)
workoutLog1.workout.exercises
simulateWorkout(&workoutLog1, numberOfRepsPerSet: 12)


// Day 2: Push
var workoutLog2 = WorkoutLog(typeOfWorkout: .Push)
workoutLog2.workout.exercises
simulateWorkout(&workoutLog2, numberOfRepsPerSet: 13)

// Day 3: Legs
var workoutLog3 = WorkoutLog(typeOfWorkout: .Legs)
workoutLog3.workout.exercises
simulateWorkout(&workoutLog3, numberOfRepsPerSet: 12)

// Day 4: Alternate Pull
var workoutLog4 = WorkoutLog(typeOfWorkout: .AlternatePull)
if let pastWorkoutExercies = logManager.returnPreviousWorkoutExercises(workoutLog4) {
    workoutLog4.updateWeightsFromPreviousWorkout(pastWorkoutExercies)
}
workoutLog4.workout.exercises
simulateWorkout(&workoutLog4, numberOfRepsPerSet: 14)

// Day 5: Alternate Push
var workoutLog5 = WorkoutLog(typeOfWorkout: .AlternatePush)
if let pastWorkoutExercies2 = logManager.returnPreviousWorkoutExercises(workoutLog5) {
    workoutLog5.updateWeightsFromPreviousWorkout(pastWorkoutExercies2)
}
workoutLog5.workout.exercises
simulateWorkout(&workoutLog5, numberOfRepsPerSet: 12)

// Day 6: Legs
var workOutLog6 = WorkoutLog(typeOfWorkout: .Legs)
if let pastWorkoutExercises1 = logManager.returnPreviousWorkoutExercises(workOutLog6) {
    workOutLog6.updateWeightsFromPreviousWorkout(pastWorkoutExercises1)
}
workOutLog6.workout.exercises
simulateWorkout(&workOutLog6, numberOfRepsPerSet: 13)


//WEEK 2 SIMULATION

// Day 1: Pull
var workOutLog7 = WorkoutLog(typeOfWorkout: .Pull)
if let pastWorkoutExercises1 = logManager.returnPreviousWorkoutExercises(workOutLog7) {
    workOutLog7.updateWeightsFromPreviousWorkout(pastWorkoutExercises1)
}
workOutLog7.workout.exercises
simulateWorkout(&workOutLog7, numberOfRepsPerSet: 13)


// Day 2: Push
var workOutLog8 = WorkoutLog(typeOfWorkout: .Push)
if let pastWorkoutExercises1 = logManager.returnPreviousWorkoutExercises(workOutLog8) {
    workOutLog8.updateWeightsFromPreviousWorkout(pastWorkoutExercises1)
}
workOutLog8.workout.exercises
simulateWorkout(&workOutLog8, numberOfRepsPerSet: 13)


// Day 3: Legs
var workOutLog9 = WorkoutLog(typeOfWorkout: .Legs)
if let pastWorkoutExercises1 = logManager.returnPreviousWorkoutExercises(workOutLog9) {
    workOutLog9.updateWeightsFromPreviousWorkout(pastWorkoutExercises1)
}
workOutLog9.workout.exercises
simulateWorkout(&workOutLog9, numberOfRepsPerSet: 13)


// Day 4: Alternate Pull
var workOutLog10 = WorkoutLog(typeOfWorkout: .AlternatePull)
if let pastWorkoutExercises1 = logManager.returnPreviousWorkoutExercises(workOutLog10) {
    workOutLog10.updateWeightsFromPreviousWorkout(pastWorkoutExercises1)
}
workOutLog10.workout.exercises
simulateWorkout(&workOutLog10, numberOfRepsPerSet: 13)


// Day 5: Alternate Push
var workOutLog11 = WorkoutLog(typeOfWorkout: .AlternatePush)
if let pastWorkoutExercises1 = logManager.returnPreviousWorkoutExercises(workOutLog11) {
    workOutLog11.updateWeightsFromPreviousWorkout(pastWorkoutExercises1)
}
workOutLog11.workout.exercises
simulateWorkout(&workOutLog11, numberOfRepsPerSet: 13)



// Day 6: Legs
var workOutLog12 = WorkoutLog(typeOfWorkout: .Legs)
if let pastWorkoutExercises1 = logManager.returnPreviousWorkoutExercises(workOutLog12) {
    workOutLog12.updateWeightsFromPreviousWorkout(pastWorkoutExercises1)
}
workOutLog12.workout.exercises
simulateWorkout(&workOutLog12, numberOfRepsPerSet: 13)





















