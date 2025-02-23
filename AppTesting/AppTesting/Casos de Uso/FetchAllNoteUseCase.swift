//
//  FetchAllNoteUseCase.swift
//  AppTesting
//
//  Created by Carlos C on 22/2/25.
//

import Foundation

protocol FetchAllNoteProtocol {
    func fetchAll() async throws -> [Nota]
}

struct FetchAllNoteUseCase: FetchAllNoteProtocol {
    
    var notaDatabase: NotasDatabaseProtocol // Creamos una referencia a nuestra Base de datos
    
    init(notaDatabase: NotasDatabaseProtocol = NotaDatabase.shared) {
        self.notaDatabase = notaDatabase
    }
    
    func fetchAll() async throws -> [Nota] {
        return try await notaDatabase.fetchAllNotas()
    }
}
