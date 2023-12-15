//
//  HistoryClass.swift
//  Drink Water
//
//  Created by Anton Rasen on 14.12.2023.
//

import Foundation
import SwiftUI

@MainActor
class HistoryClass: NSObject, ObservableObject {
    @Published var history = [String]()
    @Published var time = [String]()
    
    func addItem (item: String) {
        history.append(item)
    }
    func addTime (time: String) {
        self.time.append(time)
    }
}
