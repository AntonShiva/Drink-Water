//
//  DailyRate.swift
//  Drink Water
//
//  Created by Anton Rasen on 02.01.2024.
//

import SwiftData
@Model
class DailyRate {
   
    var dailyRate = 1800
   
    init(dailyRate: Int = 1800) {
        self.dailyRate = dailyRate
    }
   
}
