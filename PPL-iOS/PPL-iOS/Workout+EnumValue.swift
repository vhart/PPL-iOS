//
//  Workout+EnumValue.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/17/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

extension Workout {
    var typeOfWorkout: TypeOfWorkout {
        get {
            return TypeOfWorkout(rawValue: typeOfWorkoutRaw.integerValue)!
        }
        set {
            typeOfWorkoutRaw = NSNumber(integer: newValue.rawValue)
        }
    }
}