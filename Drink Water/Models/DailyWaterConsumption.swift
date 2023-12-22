//
//  DailyWaterConsumption.swift
//  Drink Water
//
//  Created by Anton Rasen on 22.12.2023.
//

import Foundation
import SwiftData
@Model
class DailyWaterConsumption {
    
    var totalWaterConsumed: Int
    let date: Date
    
    init(totalWaterConsumed: Int, date: Date) {
        self.totalWaterConsumed = totalWaterConsumed
        self.date = date
    }
   
}

