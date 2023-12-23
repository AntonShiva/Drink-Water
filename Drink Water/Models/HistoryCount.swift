//
//  HistoryCount.swift
//  Drink Water
//
//  Created by Anton Rasen on 23.12.2023.
//

import Foundation
import SwiftData
@Model
class HistoryCount {
   
    var count = 0
   
    init(count: Int = 0) {
        self.count = count
    }
   
}
