//
//  WaterConsumptionByDate.swift
//  Drink Water
//
//  Created by Anton Rasen on 27.12.2023.
//

import Foundation
import SwiftData
@Model
class WaterConsumptionByDate {
    let date: Date
   var vremia: [String] = []
    var porcaica: [Int] = []
    init(date: Date, vremia: [String], porcaica: [Int]) {
        self.date = date
        self.vremia = vremia
        self.porcaica = porcaica
    }
   
}
