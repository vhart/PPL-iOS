//
//  Double+CleanValue.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/22/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

extension Double {
    var cleanValue: String {
            return self % 1 == 0 ? String(format: "%.0f", self) : String(self)
        }

}