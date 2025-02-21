//
//  Nota.swift
//  AppTesting
//
//  Created by Carlos C on 21/2/25.
//

import Foundation

struct Nota: Identifiable, Hashable {
    
    let id: UUID
    let title: String
    let text: String?
    let creationDate: Date
    
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
