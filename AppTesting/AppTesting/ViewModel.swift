//
//  ViewModel.swift
//  AppTesting
//
//  Created by Carlos C on 21/2/25.
//

import Foundation

@Observable // cada cambio en la variable 'notas' del 'View Model' sera escuchado por la vista
final class ViewModel {
    
    var notas:[Nota]
    
    //  Los casos de uso de SwiftData
    var createNoteUseCase:CreateNoteUseCase
    var fetchAllNoteUseCase:FetchAllNoteUseCase
    
    init(notas:[Nota] = [],
         // los casos de usos de SwiftData
         createNoteUseCase:CreateNoteUseCase = CreateNoteUseCase(),
         fetchAllNoteUseCase:FetchAllNoteUseCase = FetchAllNoteUseCase()
    ) {
        self.notas = notas
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllNoteUseCase = fetchAllNoteUseCase
        
        Task {
            await fetchAllNotas()
        }
    }
    
    //___________ Casos de uso de SwiftData ___________
    func addNota(titulo: String, text:String) async {
        do {
            try await createNoteUseCase.createNoteWith(title: titulo, text: text)
            await fetchAllNotas()
        } catch {
            print("Error al crear nota: \(error)")
        }
    }
    
    func fetchAllNotas() async {
        do {
            self.notas = try await fetchAllNoteUseCase.fetchAll()
        } catch {
            print("Error al fetchAllNotas: \(error)")
        }
    }
    //__________________________________________________
    
    /*
    func addNota(titulo: String, text:String) {
        let newNota:Nota = .init(title: titulo, text: text, creationDate: .now)
        
        self.notas.append(newNota)
    }
    */
    
    func updateNota(id:UUID, newTitulo: String, newText:String) {
        if let index = self.notas.firstIndex(where: {$0.id == id}) {
            let updNota:Nota = .init(title: newTitulo, text: newText, creationDate: self.notas[index].creationDate)
            self.notas[index] = updNota
        }
    }
    
    func deleteNota(_ id: UUID){
        /*
         if let index = self.notas.firstIndex(where: { $0.id == id }){
         self.notas.remove(at: index)
         }
         */
        self.notas.removeAll(where:{$0.id == id})
    }
    
}
