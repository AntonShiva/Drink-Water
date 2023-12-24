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
    
    var porcia: Int
    let date: Date
    
    init(porcia: Int, date: Date) {
        self.porcia = porcia
        self.date = date
    }
   
}
