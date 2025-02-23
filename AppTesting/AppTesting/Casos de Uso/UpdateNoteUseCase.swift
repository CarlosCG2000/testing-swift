//
//  UpdateNoteUseCase.swift
//  AppTesting
//
//  Created by Carlos C on 23/2/25.
//

import Foundation

protocol UpdateNoteProtocol {
    func updateNoteWith(id: UUID, title: String, text: String) async throws
}


struct UpdateNoteUseCase: UpdateNoteProtocol {
    
    var notaDatabase: NotasDatabaseProtocol // Creamos una referencia a nuestra Base de datos
    
    init(notaDatabase: NotasDatabaseProtocol = NotaDatabase.shared) {
        self.notaDatabase = notaDatabase
    }
    
    func updateNoteWith(id: UUID, title: String, text: String) async throws {
        try await notaDatabase.updateNota(id: id, title: title, text: text)
    }
}
