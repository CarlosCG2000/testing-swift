//
//  ViewModelIntegrationTests.swift
//  AppTestingUnitTest
//
//  Created by Carlos C on 22/2/25.
//

import XCTest
@testable import AppTesting

@MainActor
final class ViewModelIntegrationTests: XCTestCase {
    
    var sut:ViewModel!
    
    override func setUpWithError() throws { // Configuración que se debe de repetir en cada ejecución de un test
        
        let database = NotaDatabase.shared // Declaramos nuestro Singleton de la Base de datos
        database.container = NotaDatabase.setUpContainer(inMemory : true)// y lo elegimos en memoria
        
        // Declaramos los use cases
        let createNoteUseCase = CreateNoteUseCase(notaDatabase: database)
        let fetchAllNoteUseCase = FetchAllNoteUseCase(notaDatabase: database)
        
        sut = ViewModel(createNoteUseCase: createNoteUseCase, fetchAllNoteUseCase: fetchAllNoteUseCase) // Inicializamos nuestro ViewModel con los use cases
    }
    
    override func tearDownWithError() throws { }
    
    // Funciones:
    
    // 1. Insertar nota en BD
    func testCreateNote() {
        // Given
        let title = "Prueba de Título"
        let text = "Prueba de Texto"
        
        Task{
            await sut.addNota(titulo: title, text:text)
            
            // When
            let nota = sut.notas.first
            
            // Then
            XCTAssertNotNil(nota, "La nota no se ha creado")
            XCTAssertEqual(sut.notas.count, 1, "El número de notas no coincide")
            XCTAssertEqual(nota?.title, title, "El título no coincide")
            XCTAssertEqual(nota?.text, text, "El texto no coincide")
        }
    }
    
    // 3. Crear dos nots en BD
    func testCreateTwoNote() {
        // Given
        let title = "Prueba de Título"
        let title2 = "Prueba de Título 2"
        let text = "Prueba de Texto"
        let text2 = "Prueba de Texto 2"
        
        Task{
            await sut.addNota(titulo: title, text:text)
            await sut.addNota(titulo: title2, text:text2)
            
            // When
            let nota = sut.notas.first
            let nota2 = sut.notas.last
            
            // Then
            XCTAssertNotNil(nota, "La nota no se ha creado")
            XCTAssertNotNil(nota2, "La nota 2 no se ha creado")
            XCTAssertEqual(sut.notas.count, 2, "El número de notas no coincide")
            XCTAssertEqual(nota?.title, title, "El título no coincide")
            XCTAssertEqual(nota2?.title, title2, "El título 2 no coincide")
            XCTAssertEqual(nota?.text, text, "El texto no coincide")
            XCTAssertEqual(nota2?.text, text2, "El texto 2 no coincide")
            
        }
    }
    
    // 3. Recuperar todas las notas de la BD
    func testFetchAllNotes() {
        // Given
        let title = "Prueba de Título"
        let title2 = "Prueba de Título 2"
        let text = "Prueba de Texto"
        let text2 = "Prueba de Texto 2"
        
        Task{
            await sut.addNota(titulo: title, text:text)
            await sut.addNota(titulo: title2, text:text2)
            
            await sut.fetchAllNotas()
            
            // When
            let firstNota = sut.notas.first
            let lastNote = sut.notas.last
            
            // Then
            XCTAssertNotNil(firstNota, "La nota no se ha creado")
            XCTAssertNotNil(lastNote, "La nota 2 no se ha creado")
            XCTAssertEqual(sut.notas.count, 2, "El número de notas no coincide")
            XCTAssertEqual(firstNota?.title, title, "El título no coincide")
            XCTAssertEqual(firstNota?.text, text, "El texto no coincide")
            XCTAssertEqual(lastNote?.title, title2, "El título 2 no coincide")
            XCTAssertEqual(lastNote?.text, text2, "El texto 2 no coincide")
        }
    }
}
