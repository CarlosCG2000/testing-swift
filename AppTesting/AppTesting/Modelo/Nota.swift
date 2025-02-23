//
//  Nota.swift
//  AppTesting
//
//  Created by Carlos C on 21/2/25.
//

import Foundation
import SwiftData

@Model // Macro de SwiftData
class Nota: Identifiable, Hashable {
    
    @Attribute(.unique) var id: UUID
    var title: String
    var text: String?
    var creationDate: Date
    
    var getText: String {
        return text ?? ""
    }
    
    init(id: UUID = UUID(), title: String, text: String?, creationDate: Date) {
        self.id = id
        self.title = title
        self.text = text
        self.creationDate = creationDate
    }
    
}
