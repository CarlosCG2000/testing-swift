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
    
}
