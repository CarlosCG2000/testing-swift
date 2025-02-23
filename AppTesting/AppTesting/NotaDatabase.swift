//
//  NotaData.swift
//  AppTesting
//
//  Created by Carlos C on 22/2/25.
//

import Foundation
import SwiftData

enum DatabaseError: Error { // 5. Posibles errores que se delegan a traves del `throws`
    case errorInsert
    case errorFetch
    case errorUpdate
    case errorDelete
}

protocol NotasDatabaseProtocol { // 7. Protocolo que conforma a la clase NotaDatabase
    func insertNota(nota:Nota) async throws
    func fetchAllNotas() async throws -> [Nota]
    func updateNota(id: UUID, title: String, text: String) async throws
    func removeNota(id: UUID) async throws
}

class NotaDatabase: NotasDatabaseProtocol { // Añadimos el protocolo (NotasDatabaseProtocol) para que nos facilite la inyección de dependecias.
    
    static let shared: NotaDatabase = NotaDatabase() // 1. Singleton - instancia unica que se ejecuta una única vez en nuestra aplicación
    
    private init() { } // 2. Constructor privado para solo poder declararse en el Singleton
    
    @MainActor
    static func setUpContainer(inMemory:Bool) -> ModelContainer { // 3. Función para crear un contenedor
        do {
            let container = try ModelContainer(for: Nota.self,
                                               configurations: ModelConfiguration(isStoredInMemoryOnly: inMemory)
            )
            
            container.mainContext.autosaveEnabled = true
            
            return container
            
        } catch {
            print("Error \(error.localizedDescription)")
            fatalError("Database can't be created")
        }
    }
    
    @MainActor
    var container:ModelContainer = setUpContainer(inMemory: false) // 4. Declaramos el contenedor a través de la función antes justo declarada
    
    // __________ 6. Funciones para operaciones en la BD __________
    
    @MainActor
    func insertNota(nota:Nota) throws { // 6.1. Funcion de crear una nota // throws delaga errores
        
        container.mainContext.insert(nota)
        
        do {
            try container.mainContext.save()
        } catch {
            print("Error \(error.localizedDescription)")
            throw DatabaseError.errorInsert
        }
        
    }
    
    @MainActor
    func fetchAllNotas() throws -> [Nota] { // 6.2. Esta función en mis otras app no las uso ya que con @Query ya puedo obtener los datos
        
        let fetchDescriptor = FetchDescriptor<Nota>(sortBy: [SortDescriptor<Nota>(\.creationDate)])
        
        do {
            return try container.mainContext.fetch(fetchDescriptor)
            
        } catch {
            print("Error \(error.localizedDescription)")
            throw DatabaseError.errorFetch
        }
        
    }
    
    @MainActor
    func updateNota(id: UUID, title: String, text: String) throws {
        
        let notePredicate = #Predicate<Nota>{
            $0.id == id
        }
        
        var fetchDescriptor = FetchDescriptor<Nota>(predicate: notePredicate)
        
        // fetchDescriptor.sortBy = [SortDescriptor<Nota>(\.creationDate)]
        fetchDescriptor.fetchLimit = 1 // queremos un solo resultado
        
        do {
            guard let updateNote = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorUpdate
            }
            
            updateNote.title = title // actualizamos el titulo de la nota
            updateNote.text = text // actualizamos el texto de la nota
            
            try container.mainContext.save()
            
        } catch {
            print("Error  actualizar nota: \(error.localizedDescription)")
            throw DatabaseError.errorUpdate
        }
    }
    
    @MainActor
    func removeNota(id: UUID) throws {
        
        let notePredicate = #Predicate<Nota>{
            $0.id == id
        }
        
        var fetchDescriptor = FetchDescriptor<Nota>(predicate: notePredicate)
        
        fetchDescriptor.fetchLimit = 1 // queremos un solo resultado
        
        do {
            guard let deleteNote = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorDelete
            }
            
            container.mainContext.delete(deleteNote) // borrar la nota
            
            try container.mainContext.save()
            
        } catch {
            print("Error al borrar nota: \(error.localizedDescription)")
            throw DatabaseError.errorDelete
        }
    }
    
}
