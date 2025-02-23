//
//  Mocks.swift
//  AppTesting
//
//  Created by Carlos C on 23/2/25.
//


import Foundation
@testable import AppTesting

//________________ MOCK'S _________________
var mockDBNotas: [Nota] = [] // variable que va a simular el almacenamiento en la BD

struct CreateNoteUseCaseMock: CreateNoteProtocol {
    func createNoteWith(title: String, text: String) async throws {
        let nota = Nota(id: UUID(), title: title, text: text, creationDate: Date())
        mockDBNotas.append(nota)
    }
}

struct FetchAllNoteUseCaseMock: FetchAllNoteProtocol {
    func fetchAll() async throws -> [Nota] {
        return mockDBNotas
    }
}

struct UpdateNoteUseCaseMock: UpdateNoteProtocol {
    func updateNoteWith(id: UUID, title: String, text: String) async throws {
        if let index = mockDBNotas.firstIndex(where: { $0.id == id }) {
            mockDBNotas[index].title = title
            mockDBNotas[index].text = text
        }
    }
}

struct DeleteNoteUseCaseMock: DeleteNoteProtocol {
    func deleteNoteWith(id: UUID) async throws {
        mockDBNotas.removeAll(where: { $0.id == id })
    }
}

// _______________________________________
