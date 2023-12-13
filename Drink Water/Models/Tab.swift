//
//  Tab.swift
//  Drink Water
//
//  Created by Anton Rasen on 12.12.2023.
//

import Foundation
import SwiftUI

enum Tab: Int, Identifiable, CaseIterable, Comparable {
    static func < (lhs: Tab, rhs: Tab) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case reminders, home, history
    
    internal var id: Int { rawValue }
    
    var icon: String {
        switch self {
        case .reminders:
            return "bell.fill"
        case .home:
            return "drop.fill"
        case .history:
            return "calendar"
        
        }
    }
    
    var title: String {
        switch self {
        case .reminders:
            return ""
        case .home:
            return ""
        case .history:
            return ""
       
        }
    }
    
    var color: Color {
        switch self {
        case .reminders:
            return .teal
        case .home:
            return .cyan
        case .history:
            return .teal
       
        }
    }
}
