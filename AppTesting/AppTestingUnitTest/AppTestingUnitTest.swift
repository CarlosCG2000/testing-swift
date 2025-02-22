//
//  AppTestingUnitTest.swift
//  AppTestingUnitTest
//
//  Created by Carlos C on 21/2/25.
//

import XCTest // acceder a todas las clases necesarios

@testable import AppTesting

final class AppTestingUnitTest: XCTestCase {

    // _________________ CICLO DE VIDA DEL TEST _________________
/**
    override func setUpWithError() throws {      // ANTES DE EJECUTARSE EL TEST
       
    }

    override func tearDownWithError() throws {       // DESPUÉS DE EJECUTARSE EL TEST, PARA LIMPIAR EL ESTADO

    }
 */
    //___________________________________________________________

/**
    func testExample() throws { }

    func testFailExample() throws {
        XCTFail("No se ha implementado el test") // siempre que se ejecute este comando va a fallar
    }
*/
    
    // Las funciones deben empezar por 'test'
    func testNotaInicializacion() {
        // Given or Arrange --> Preparamos los datos, es el estado inicial
        let title:String = "Titulo de una tarea"
        let text:String = "Texto de la tarea"
        let date:Date = Date()
        
        // When or Act --> donde ocurre la acción
        let nota = Nota(title: title, text: text, creationDate: date)
        
        // Then or Asset --> calcula el resutado o cambio de la accion o evento
        XCTAssertEqual(nota.title, title)
        XCTAssertEqual(nota.text, text)
        XCTAssertEqual(nota.creationDate, date)
    }
    
    func testNotaGetTextVacio() {
        // Given
        let title:String = "Titulo de una tarea"
        let date:Date = Date()
        
        // When
        let nota = Nota(title: title, text: nil, creationDate: date)
        
        // Then
        XCTAssertEqual(nota.getText, "")
    }

}
