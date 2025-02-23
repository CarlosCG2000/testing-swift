//
//  CreateViewNoteSnapshotTest.swift
//  AppTestingUnitTest
//
//  Created by Carlos C on 23/2/25.
//

import XCTest

import SnapshotTesting // la dependencia de SnapshotTesting
@testable import AppTesting

final class CreateViewNoteSnapshotTest: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testCreateNoteView() throws {
        let creavUIView = NuevaNotaView(viewModel: .init()) // creamos una instancia de la nota nueva
        assertSnapshot(of: creavUIView, as: .image) // comparamos el snapshot de la vista con la imagen de referencia | La primera vez que se ejecute dara error proque necesita crear la imagen de referencia
    
    }

    func testCreateNoteViewWithData() throws {
        let creavUIView = NuevaNotaView(viewModel: .init(),
                                        titulo: "Seguir estudiando es bueno 🤓",
                                        texto: "Estudiar es una de las mejores formas de aprender y crecer. No te rindas, sigue adelante y verás los resultados. 🚀") // creamos una instancia de la nota nueva
        assertSnapshot(of: creavUIView, as: .image) // comparamos el snapshot de la vista con la imagen de referencia
    
    }

}
