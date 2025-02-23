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
        let updateNoteUseCase = UpdateNoteUseCase(notaDatabase: database)
        let deleteNoteUseCase = DeleteNoteUseCase(noteDatabase: database)
        
        // Inicializamos nuestro ViewModel con los use cases
        sut = ViewModel(createNoteUseCase: createNoteUseCase,
                        fetchAllNoteUseCase: fetchAllNoteUseCase,
                        updateNoteUseCase: updateNoteUseCase,
                        deleteNoteUseCase: deleteNoteUseCase)
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
    
    // 4. Actualizar una nota en la BD
    func testUpdateNote() {
        // Given
        let title = "Prueba de Título"
        let text = "Prueba de Texto"
        
        Task{
            await sut.addNota(titulo: title, text:text)
            
            let newTitle = "Nuevo de Título"
            let newText = "Nuevo de Texto"
            
            if let id = sut.notas.first?.id {
                // When
                await sut.updateNota(id: id, newTitulo: newTitle, newText: newText)
                
                // Then
                XCTAssertEqual(sut.notas.count, 1)
                XCTAssertEqual(sut.notas[0].title, newTitle)
                XCTAssertEqual(sut.notas[0].text, newText)
                
            } else {
                XCTFail("No se ha podido obtener el ID de la nota")
            }
        }
    }
    
    // 5. Borrar una nota en la BD
    func testDeleteNote() {
        // Given
        let title = "Prueba de Título"
        let text = "Prueba de Texto"
        let title2 = "Prueba de Título 2"
        let text2 = "Prueba de Texto 2"
        let text3 = "Prueba de Texto 3"
        let title3 = "Prueba de Título 3"
        
        Task{
            await sut.addNota(titulo: title, text: text)
            await sut.addNota(titulo: title2, text: text2)
            await sut.addNota(titulo: title3, text: text3)
            
            if let id = sut.notas.last?.id {
                // When
                await sut.deleteNota(id)
                
                // Then
                XCTAssertEqual(sut.notas.count, 2)
            } else {
                XCTFail("No se ha podido obtener el ID de la nota")
            }
        }
    }
    
    // 6. Test que lance un error
    func testRemoveNoteInDatabaseShouldThrowsError() async {
        
        await sut.deleteNota(UUID())
        
        XCTAssertEqual(sut.notas.count, 0) // comprobamos que el número de notas es 0
        XCTAssertNotNil(sut.databaseError) // comprobamos que el error no es nulo si no que tiene un valor de error de base de datos
        
    }
}
