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
    
    case home, reminders, history, nastroiki
    
    internal var id: Int { rawValue }
    
    var icon: String {
        switch self {
            
        case .home:
                    return "drop.fill"
            
        case .reminders:
            return "bell.fill"
        
        case .history:
            return "calendar"
        case .nastroiki:
            return "gear"
        
        }
    }
    
    var title: String {
        switch self {
            
        case .home:
            return ""
        case .reminders:
            return ""
       
        case .history:
            return ""
        case .nastroiki:
            return ""
        }
    }
    
    
    
    var color: Color {
        switch self {
          
        case .home:
            return .cyan
            
        case .reminders:
            return .teal
       
        case .history:
            return .teal
        case .nastroiki:
            return .cyan
        }
    }
}
