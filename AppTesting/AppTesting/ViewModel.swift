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
    
    init(notas:[Nota] = []) {
        self.notas = notas
    }
    
    func addNota(titulo: String, text:String) {
        let newNota:Nota = .init(title: titulo, text: text, creationDate: .now)
        
        self.notas.append(newNota)
    }
    
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
