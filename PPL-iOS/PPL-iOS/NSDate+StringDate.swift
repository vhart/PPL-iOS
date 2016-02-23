//
//  NSDate+StringDate.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/20/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

extension NSDate {
    
    public static func stringDate() -> String
    {
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "dd MMM"
        
        return dateFormatter.stringFromDate(currentDate)
    }
}