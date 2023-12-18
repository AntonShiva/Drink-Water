//
//  HistoryClass.swift
//  Drink Water
//
//  Created by Anton Rasen on 14.12.2023.
//

import Foundation
import SwiftUI

@MainActor
//class HistoryClass: NSObject, ObservableObject {
//    @Published var history = [String]()
//    @Published var time = [String]()
//    
//    func addItem (item: String) {
//        history.append(item)
//    }
//    func addTime (time: String) {
//        self.time.append(time)
//    }
//}
class HistoryClass: ObservableObject {
    @Published var history = [StepCount]()
    @Published var dailyConsumptions = [DailyWaterConsumption]()
       
    
    func addWaterConsumption(amount: Int, date: Date) {
            if let existingIndex = dailyConsumptions.firstIndex(where: { $0.date == date }) {
                dailyConsumptions[existingIndex].totalWaterConsumed += amount
            } else {
                let newConsumption = DailyWaterConsumption(date: date, totalWaterConsumed: amount)
                dailyConsumptions.append(newConsumption)
            }
        }
    
    
    func addItem(item: Int, date: String) {
        let stepCount = StepCount(day: date, steps: item)
        history.append(stepCount)
    }
}
