//
//  NSOrderedSet+SetToArray.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/21/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

extension NSOrderedSet {
    func copyToArray() -> [AnyObject]
    {
        return self.mutableCopy().array
    }
}
