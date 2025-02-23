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
    var databaseError:DatabaseError? // variable que guardara el error de la base de datos. Hemos ehco la prueba en el método de la función deleteNota()
    
    //  Los casos de uso de SwiftData, evez del useCase concretos usamos la abstraction con los protocolos
    var createNoteUseCase: CreateNoteProtocol // CreateNoteUseCase
    var fetchAllNoteUseCase: FetchAllNoteProtocol // FetchAllNoteUseCase
    var deleteNoteUseCase: DeleteNoteProtocol // DeleteNoteUseCase
    var updateNoteUseCase: UpdateNoteProtocol // UpdateNoteUseCase
    
    init(notas:[Nota] = [],
         // los casos de usos de SwiftData
         createNoteUseCase: CreateNoteProtocol /*CreateNoteUseCase*/ = CreateNoteUseCase(),
         fetchAllNoteUseCase: FetchAllNoteProtocol /*FetchAllNoteUseCase*/ = FetchAllNoteUseCase(),
         updateNoteUseCase: UpdateNoteProtocol /*UpdateNoteUseCase*/ = UpdateNoteUseCase(),
         deleteNoteUseCase: DeleteNoteProtocol /*DeleteNoteUseCase*/ = DeleteNoteUseCase()
         
    ) {
        self.notas = notas
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllNoteUseCase = fetchAllNoteUseCase
        self.updateNoteUseCase = updateNoteUseCase
        self.deleteNoteUseCase = deleteNoteUseCase
      
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
    
    func updateNota(id:UUID, newTitulo: String, newText:String) async {
        do {
            try await updateNoteUseCase.updateNoteWith(id: id, title: newTitulo, text: newText)
        }catch{
            print("Error al actualizar nota: \(error)")
        }
    }
    
    func deleteNota(_ id: UUID) async {
        do {
            try await deleteNoteUseCase.deleteNoteWith(id: id)
            await fetchAllNotas()
        } catch let error as DatabaseError { // capturamos el error de la base de datos
            print("Error al borrar nota: \(error.localizedDescription)")
            databaseError = error
        } catch{
            print("Error al borrar nota: \(error)")
        }
    }
    //__________________________________________________
        /*
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
         */
    
}
