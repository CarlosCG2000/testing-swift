//
//  ModificarEliminarNotaView.swift
//  AppTesting
//
//  Created by Carlos C on 21/2/25.
//

import SwiftUI

struct ModificarEliminarNotaView: View {
    
    var viewModel : ViewModel
    
    @State var titulo: String
    @State var texto: String
    @State var id:UUID
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack {
            
            Form {
                Section {
                    TextField("Titulo", text: $titulo)
                    TextField("Descripción", text: $texto)
                }
            }
            
            Button(action: {
                viewModel.deleteNota(id)
            }, label: {
                Text("Eliminar nota")
                    .foregroundStyle(Color.gray)
                    .underline()
            })
            // .buttonStyle(BorderedButtonStyle())
            
        }
        .navigationTitle("Modificar nota")
        .background(Color(uiColor: .systemGroupedBackground)) // No se que color es ese
        .toolbar {
            
            ToolbarItem(placement: .topBarTrailing){
                Button("Guardar"){
                    viewModel.updateNota(id: id, newTitulo: titulo, newText: texto)
                    dismiss()
                }
            }
        }
    }
}


#Preview {
    NavigationStack {
        ModificarEliminarNotaView(viewModel: .init(), titulo: "Jugar a futbol", texto: "En el campo del vecindario", id: .init())
    }
}
