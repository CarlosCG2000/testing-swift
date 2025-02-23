//
//  DeleteNoteUseCase.swift
//  AppTesting
//
//  Created by Carlos C on 23/2/25.
//

import Foundation


protocol DeleteNoteProtocol {
    func deleteNoteWith(id: UUID) async throws
}

public class DeleteNoteUseCase:DeleteNoteProtocol {
    
    var notaDatabase: NotasDatabaseProtocol // Creamos una referencia a nuestra Base de datos
    
     init(noteDatabase: NotasDatabaseProtocol = NotaDatabase.shared) {
        self.notaDatabase = noteDatabase
    }
    
     func deleteNoteWith(id: UUID) async throws {
        let notaDatabase = NotaDatabase.shared
        try await notaDatabase.removeNota(id: id)
    }
}
