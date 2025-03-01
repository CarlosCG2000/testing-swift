//
//  ViewModelTest.swift
//  AppTestingUnitTest
//
//  Created by Carlos C on 22/2/25.
//

import XCTest
@testable import AppTesting

final class ViewModelTest: XCTestCase {
    
    var viewModel:ViewModel!
    
    override func setUpWithError() throws {  // ANTES DE EJECUTARSE EL TEST
        
        viewModel = ViewModel(
            createNoteUseCase: CreateNoteUseCaseMock(),
            fetchAllNoteUseCase: FetchAllNoteUseCaseMock(),
            updateNoteUseCase: UpdateNoteUseCaseMock(),
            deleteNoteUseCase: DeleteNoteUseCaseMock()
        )
    }

    override func tearDownWithError() throws { // DESPUÉS DE EJECUTARSE EL TEST, PARA LIMPIAR EL ESTADO
        mockDBNotas = []
    }

    // Tenemos que probar funciones con un Scope reducido, cuando más pequeño mejor el test
    
    func testAddtNota() async {
        // Give
        let title = "Prueba de Título"
        let text = "Prueba de Texto"
        
        // When
        await viewModel.addNota(titulo: title, text: text)
        
        // Then
        XCTAssertEqual(viewModel.notas.count, 1)
        
        XCTAssertEqual(viewModel.notas[0].title, title)
        XCTAssertEqual(viewModel.notas[0].text, text)
    }
    
    func testAddtTwoNota() async {
        // Give
        let title = "Prueba de Título"
        let text = "Prueba de Texto"
        
        let title2 = "Prueba de Título2"
        let text2 = "Prueba de Texto2"
        
        // When
        await viewModel.addNota(titulo: title, text: text)
        await viewModel.addNota(titulo: title2, text: text2)
        
        // Then
        XCTAssertEqual(viewModel.notas.count, 2)
        
        XCTAssertEqual(viewModel.notas[0].title, title)
        XCTAssertEqual(viewModel.notas[0].text, text)
        
        XCTAssertEqual(viewModel.notas[1].title, title2)
        XCTAssertEqual(viewModel.notas[1].text, text2)
    }
    
    
    func testUpdateNota() async {
        // Para actualizar una nota primero hay que crearla y como cada test es independiente, hay que crearla de nuevo
        
        //Give
        let title = "Prueba de Título"
        let text = "Prueba de Texto"
        
        await viewModel.addNota(titulo: title, text: text)
        
        let newTitle = "Nuevo de Título"
        let newText = "Nuevo de Texto"
        
        // When
        if let id = viewModel.notas.first?.id {
            await viewModel.updateNota(id: id, newTitulo: newTitle, newText: newText)
            
            // Then
            XCTAssertEqual(viewModel.notas.count, 1)
            XCTAssertEqual(viewModel.notas[0].title, newTitle)
            XCTAssertEqual(viewModel.notas[0].text, newText)
            
        } else {
            XCTFail("No se ha podido obtener el ID de la nota")
        }

    }
    
    func testDeleteNota() async {
        //Give
        let title = "Prueba de Título"
        let text = "Prueba de Texto"
        
        await viewModel.addNota(titulo: title, text: text)
        
        if let id = viewModel.notas.first?.id {
            // When
            await viewModel.deleteNota(id)
            
            // Then
            XCTAssertEqual(viewModel.notas.count, 0)
        } else {
            XCTFail("No se ha podido obtener el ID de la nota")
        }
    }

}
