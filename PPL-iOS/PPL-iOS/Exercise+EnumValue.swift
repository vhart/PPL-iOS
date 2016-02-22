//
//  Exercise+EnumValue.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/17/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

extension Exercise {
    var progressionScheme: ProgressionScheme {
        get {
            return ProgressionScheme(rawValue: progressionSchemeRaw.integerValue)!
        }
        set {
            progressionSchemeRaw = NSNumber(integer: newValue.rawValue)
        }
    }
}