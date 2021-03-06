//
//  TypeOfWorkouts.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/17/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

enum TypeOfWorkout: Int {
    case Pull = 0
    case Push = 1
    case Legs = 2
    case AlternatePull = 3
    case AlternatePush = 4
}

extension TypeOfWorkout: CustomStringConvertible {
    var description: String {
        switch self {
        case .Pull:
            return "Pull"
        case .Push:
            return "Push"
        case .Legs:
            return "Legs"
        case .AlternatePull:
            return "Alt Pull"
        case .AlternatePush:
            return "Alt Push"
        }
    }
}