//
//  ContentView.swift
//  AppTesting
//
//  Created by Carlos C on 21/2/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    // var viewModel = ViewModel() // lo mismo que el de arriba
    var viewModel: ViewModel = .init()
    
    @State var showNewNote: Bool = false
    
    var body: some View {
        
        NavigationStack {
            List (viewModel.notas) { nota in
                // ForEach(viewModel.notas) { nota in
                
                NavigationLink(value: nota) { // ¿NO ENTIENDO PORQUE PASAR PARÁMETRO?
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text(nota.title)
                            .font(.title3)
                            .bold()
                        
                        Text(nota.text ?? "")
                            .font(.headline)
                            .foregroundStyle(.secondary.opacity(0.75))
                    }
                    
                }
                // }
            }
            .navigationTitle("Notas")
            .toolbar{
                
                ToolbarItem(placement: .status) { // '.status': en la parte de abajo
                    
                    Button(
                        action: { self.showNewNote.toggle() },
                        label:  {
                        Label ("Crear nota", systemImage: "square.and.pencil")
                            .labelStyle(TitleAndIconLabelStyle()) // decirle que quieres que salga de la label
                        } )
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .bold()
                    
                }
            }
            // navegación a la pantalla de modificar o eliminar nota
            .navigationDestination(for: Nota.self, destination: { nota in
                ModificarEliminarNotaView(viewModel: viewModel, titulo: nota.title, texto: nota.getText, id: nota.id )
            })
            // navegación a la pantalla de añadir nota
            .fullScreenCover (
                isPresented: $showNewNote,
                content: {
                    NuevaNotaView(viewModel: viewModel)
                }
            )
            
            
            
        }
    }
}

#Preview {
    /*
     ContentView(viewModel: ViewModel(notas: [
     Nota(title: "Tarea 1", text: "Ir a correr", creationDate: Date.now),
     Nota(title: "Tarea 2", text: "Hacer deberes", creationDate: Date.now)
     ]))
     */
    
    ContentView(viewModel: .init(notas: [
        .init(title: "Tarea 1", text: "Ir a correr", creationDate: Date.now),
        .init(title: "Tarea 2", text: "Hacer deberes", creationDate: Date.now)
    ] )
    )
    
    // .modelContainer(for: Item.self, inMemory: true)
    // 📌 En la app real, SwiftData usa almacenamiento persistente automáticamente, pero en Preview necesitas definir explícitamente un contenedor de datos en memoria.
    // SwiftData necesita un contexto de almacenamiento donde guardar y recuperar datos, incluso en el modo de vista previa. En el segundo parámetro: `inMemory: true` se usa un almacenamiento en memoria temporal,
}
