//
//  Extensions.swift
//  Drink Water
//
//  Created by Anton Rasen on 16.11.2023.
//

import SwiftUI

extension Color {
    static let background = LinearGradient(gradient: Gradient(colors: [ Color("darkBly"),  Color("bly"),Color("darkBly"), Color("darkBly"),Color("darkBly"), Color("darkBly"),Color("darkBly"),Color("darkBly"), Color("darkBly"),Color("darkBly"),Color("darkBly"), Color("bly"), Color("darkBly"),Color("darkBly"),Color("darkBly"), Color("darkBly"),Color("darkBly"),Color("darkBly"), Color("darkBly"),Color("darkBly"),Color("darkBly"), Color("bly"), Color("SvetloCyan")]), startPoint: .top, endPoint: .bottom)
    
    static let backgroundTab = LinearGradient(gradient: Gradient(colors: [Color("bly"), Color("darkBly"), Color("bly"), Color("darkBly")]), startPoint: .top, endPoint: .bottom)
    static let manColor = Color("Light cyanide")
    static let bgTabBar = Color("SvetloCyan")
    static let bgTabBarDark = Color("darkBly")
    static let blyL = Color("bly")
    static let blyVtoroi = Color("vtoroi")
    
}

extension Date {
    func localString(dateStyle: DateFormatter.Style = .long, timeStyle: DateFormatter.Style = .long) -> String {
        return DateFormatter.localizedString(from: self, dateStyle: dateStyle, timeStyle: timeStyle)
    }
}

extension String {
   func date(format: String) -> Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = format
           dateFormatter.timeZone = TimeZone.current
           let date = dateFormatter.date(from: self)
           return date
       }
   }
