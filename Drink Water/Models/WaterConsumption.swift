//
//  WaterConsumption.swift
//  Drink Water
//
//  Created by Anton Rasen on 24.12.2023.
//

import Foundation
import SwiftData
import SQLite

@Model
class WaterConsumption {
    var id: Int64
    var porcia: Int
    let date: Date

    init(id: Int64, porcia: Int, date: Date) {
        self.id = id
        self.porcia = porcia
        self.date = date
    }

    required init(row: Row) throws {
        id = try row.get("id")
        porcia = try row.get("porcia")
        date = try row.get("date")
    }
}

extension WaterConsumption: Table {
    static var tableName: String {
        return "water_consumption"
    }
}
