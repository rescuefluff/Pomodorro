//
//  TimeInterval.swift
//  Pomodorro
//
//  Created by Вадим Медведев on 27.11.2020.
//  Copyright © 2020 SwiftBear. All rights reserved.
//

import Foundation

struct TimeInterval {
    let type: TimeIntervalType
    let time: Double
    
}

enum TimeIntervalType {
    case work
    case shortBreak
    case longBreak
}

struct Task {
    let intervals: [TimeInterval]
}
