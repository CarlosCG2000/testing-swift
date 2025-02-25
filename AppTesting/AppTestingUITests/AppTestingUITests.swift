//
//  AppTestingUITests.swift
//  AppTestingUITests
//
//  Created by Carlos C on 23/2/25.
//

import XCTest

final class AppTestingUITests: XCTestCase {

    // [ Los Breakpoint son las lineas creadas manualmente ]
    
    func testCrearNota() throws {
        let app = XCUIApplication()
        
        app.launch() // esta linea hay que añadirla para que se ejecute la app
        
        app.toolbars["Toolbar"]/*@START_MENU_TOKEN@*/.staticTexts["Crear nota"]/*[[".otherElements[\"Crear nota\"]",".buttons[\"Crear nota\"].staticTexts[\"Crear nota\"]",".staticTexts[\"Crear nota\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()

        let collectionViewsQuery = app.collectionViews
        let tituloTextField = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Titulo"]/*[[".cells.textFields[\"Titulo\"]",".textFields[\"Titulo\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/// .textViews.matching(identifier: "create_titulo_id").element
        tituloTextField.tap()
        tituloTextField.typeText("Prueba de Título") // Escribimos en el campo de texto

        let descripciNTextField = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Descripción"]/*[[".cells.textFields[\"Descripción\"]",".textFields[\"Descripción\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ // .textViews.matching(identifier: "create_descrip_id").element
        descripciNTextField.tap()
        descripciNTextField.typeText("Prueba de Texto") // Escribimos en el campo de texto
        
        app.navigationBars["Nueva nota"]/*@START_MENU_TOKEN@*/.buttons["Guardar"]/*[[".otherElements[\"Guardar\"].buttons[\"Guardar\"]",".buttons[\"Guardar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testCrearDosNotaBorrarPrimera() throws {
        let app = XCUIApplication()
        
        app.launch() // esta linea hay que añadirla para que se ejecute la app
        
        app.toolbars["Toolbar"]/*@START_MENU_TOKEN@*/.staticTexts["Crear nota"]/*[[".otherElements[\"Crear nota\"]",".buttons[\"Crear nota\"].staticTexts[\"Crear nota\"]",".staticTexts[\"Crear nota\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()

        let collectionViewsQuery = app.collectionViews
        
        // Creamos primera nota
        let tituloTextField = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Titulo"]/*[[".cells.textFields[\"Titulo\"]",".textFields[\"Titulo\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/// .textViews.matching(identifier: "create_titulo_id").element
        tituloTextField.tap()
        tituloTextField.typeText("Prueba de Título") // Escribimos en el campo de texto

        let descripciNTextField = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Descripción"]/*[[".cells.textFields[\"Descripción\"]",".textFields[\"Descripción\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ // .textViews.matching(identifier: "create_descrip_id").element
        descripciNTextField.tap()
        descripciNTextField.typeText("Prueba de Texto") // Escribimos en el campo de texto
        
        app.navigationBars["Nueva nota"]/*@START_MENU_TOKEN@*/.buttons["Guardar"]/*[[".otherElements[\"Guardar\"].buttons[\"Guardar\"]",".buttons[\"Guardar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // Creamos segunda nota
        app.toolbars["Toolbar"]/*@START_MENU_TOKEN@*/.staticTexts["Crear nota"]/*[[".otherElements[\"Crear nota\"]",".buttons[\"Crear nota\"].staticTexts[\"Crear nota\"]",".staticTexts[\"Crear nota\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tituloTextField2 = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Titulo"]/*[[".cells.textFields[\"Titulo\"]",".textFields[\"Titulo\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/// .textViews.matching(identifier: "create_titulo_id").element
        tituloTextField2.tap()
        tituloTextField2.typeText("22222 Prueba de Título") // Escribimos en el campo de texto

        let descripciNTextField2 = collectionViewsQuery/*@START_MENU_TOKEN@*/.textFields["Descripción"]/*[[".cells.textFields[\"Descripción\"]",".textFields[\"Descripción\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ // .textViews.matching(identifier: "create_descrip_id").element
        descripciNTextField2.tap()
        descripciNTextField2.typeText("2222 Prueba de Texto") // Escribimos en el campo de texto
        
        app.navigationBars["Nueva nota"]/*@START_MENU_TOKEN@*/.buttons["Guardar"]/*[[".otherElements[\"Guardar\"].buttons[\"Guardar\"]",".buttons[\"Guardar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // Eliminar primera nota
        let firstNota = collectionViewsQuery.cells.element(boundBy: 0)
        firstNota.tap()
        app.buttons["Eliminar nota"].tap()
    }

}


