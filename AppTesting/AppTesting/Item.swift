//
//  Item.swift
//  AppTesting
//
//  Created by Carlos C on 21/2/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
