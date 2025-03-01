//
//  NuevaNotaView.swift
//  AppTesting
//
//  Created by Carlos C on 21/2/25.
//

import SwiftUI

struct NuevaNotaView: View {
    
    var viewModel : ViewModel
    
    @State var titulo: String = ""
    @State var texto: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                Section {
                    TextField("Titulo", text: $titulo)
                        .accessibilityIdentifier("create_titulo_id") // para el text UI
                    TextField("Descripción", text: $texto)
                        .accessibilityIdentifier("create_descrip_id") // para el text UI
                } footer: {
                    Text("* Titulo es obligatorio")
                        .foregroundStyle(Color.red)
                }
            }
            .navigationTitle("Nueva nota")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {

                ToolbarItem(placement: .topBarLeading) {
                    Button("Salir"){
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button("Guardar"){
                        Task {
                            await viewModel.addNota(titulo: titulo, text: texto)
                            dismiss()
                        }
                        
                    }
                }
            }
  
        }
        
    }
}

#Preview {
    NuevaNotaView(viewModel: .init())
}
