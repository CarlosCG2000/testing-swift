//
//  FetchAllNoteUseCase.swift
//  AppTesting
//
//  Created by Carlos C on 22/2/25.
//

import Foundation

struct FetchAllNoteUseCase {
    
    var notaDatabase: NotasDatabaseProtocol
    
    init(notaDatabase: NotasDatabaseProtocol = NotaDatabase.shared) {
        self.notaDatabase = notaDatabase
    }
    
    func fetchAll() async throws -> [Nota] {
        return try await notaDatabase.fetchAllNotas()
    }
}
