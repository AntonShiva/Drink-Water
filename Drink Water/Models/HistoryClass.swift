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

let dat = "20231214".date(format:"yyyyMMdd")
let date = "20231215".date(format:"yyyyMMdd")
let date1 = "20231216".date(format:"yyyyMMdd")
let date2 = "20231217".date(format:"yyyyMMdd")
let date3 = "20231218".date(format:"yyyyMMdd")
let date4 = "20231219".date(format:"yyyyMMdd")

class HistoryClass: ObservableObject {
    
    @Published var history = [HistoryStruct]()
   
   
    @Published var dailyConsumptions = [DailyWaterConsumption(date: dat!, totalWaterConsumed: 1500),DailyWaterConsumption(date: date!, totalWaterConsumed: 3000), DailyWaterConsumption(date: date1!, totalWaterConsumed: 2100), DailyWaterConsumption(date: date2!, totalWaterConsumed: 1500),DailyWaterConsumption(date: date3!, totalWaterConsumed: 1200), DailyWaterConsumption(date: date4!, totalWaterConsumed: 2500)]
    
    
    
    
       
    
    func addWaterConsumption(amount: Int, date: Date) {
            if let existingIndex = dailyConsumptions.firstIndex(where: { $0.date == date }) {
                dailyConsumptions[existingIndex].totalWaterConsumed += amount
            } else {
                let newConsumption = DailyWaterConsumption(date: date, totalWaterConsumed: amount)
                dailyConsumptions.append(newConsumption)
            }

        }
    
    
//    func addItem(item: Int, date: String) {
//        let stepCount = StepCount(day: date, steps: item)
//        history.append(stepCount)
//    }
}
