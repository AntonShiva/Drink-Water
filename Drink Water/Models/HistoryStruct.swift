//
//  HistoryStruct.swift
//  Drink Water
//
//  Created by Anton Rasen on 22.12.2023.
//

import Foundation
import SwiftData
@Model
class HistoryStruct {
   
    let weekday: String
    let porcia: Int
    let date: Date
    
    init(weekday: String, porcia: Int, date: Date) {
        self.weekday = weekday
        self.porcia = porcia
        self.date = date
    }
    
   
}
