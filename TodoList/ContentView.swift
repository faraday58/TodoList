//
//  ContentView.swift
//  TodoList
//
//  Created by Armando Rodríguez on 07/08/23.
//

import SwiftUI

struct ContentView: View {
    @State var description: String = ""
    @ObservedObject var notesViewModel = NoteViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Añade una tarea")
                    .underline()
                    .foregroundColor(.gray)
                    .padding(.horizontal,16)
                TextEditor(text: $description)
                .foregroundColor(.gray)
                .frame(height: 100)
                .overlay {
                    RoundedRectangle(cornerRadius: 8).stroke(.green,lineWidth: 2)
                }
                Button("Crear"){
                    notesViewModel.saveNote(description: description)
                    description = ""
                    
                }
                .buttonStyle(.bordered)
                .tint(.green)
                Spacer()
                List {
                    ForEach($notesViewModel.notes, id: \.id)
                    { $note in
                        HStack{
                            if note.isFavorited {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            Text(note.description)
                        }
                        .swipeActions(edge: .trailing){
                            Button{
                                notesViewModel
                                    .updateFavoriteNote(
                                    notes: $note
                                    )
                            }label: {
                                Label("Favorito", systemImage: "star.fill" )
                            }.tint(.yellow)
                            
                        }
                        .swipeActions(edge: .leading){
                            Button{
                                notesViewModel
                                    .removeNote(withId: note.id)
                                    
                            }label: {
                                Label("Borrar", systemImage: "trash.fill" )
                            }.tint(.red)
                            
                        }
                    }
                }
                
            }.padding()
                .navigationTitle("To Do")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    Text(notesViewModel.getNumberOfNotes())
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
