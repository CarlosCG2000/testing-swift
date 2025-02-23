//
//  CreateNoteUseCase.swift
//  AppTesting
//
//  Created by Carlos C on 22/2/25.
//

import Foundation

protocol CreateNoteProtocol {
    func createNoteWith(title: String, text: String) async throws
}

struct CreateNoteUseCase: CreateNoteProtocol {
    
    var notaDatabase : NotasDatabaseProtocol // 1. De forma abstracta llamamos al protocolo 'NotasDatabaseProtocol' creando una referencia a nuestra BD
    
    init(notaDatabase: NotasDatabaseProtocol = NotaDatabase.shared) { // 2. Inicializamos el protocolo
        self.notaDatabase = notaDatabase
    }
    
    func createNoteWith(title: String, text: String) async throws {
        let nota: Nota = .init(id: .init(), title: title, text: text, creationDate: .now)
        
        try await notaDatabase.insertNota(nota: nota)
    }
}
