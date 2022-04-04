//
//  ContentView.swift
//  Notes WatchKit Extension
//
//  Created by Sarika on 04.04.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    func save() {
        do {
            //convert notes array to data using JSONEncoder
            let data = try JSONEncoder().encode(notes)
            
            //create new URL to save file using getDocumentDirectory
            let url = getDocumentDirectory().appendingPathComponent("notes")
            
            //write data to given URL
            try data.write(to: url)
        }
        catch{
           print("Saving data has failed")
        }
    }
    
    func load() {
        DispatchQueue.main.async {
            do{
                //get the notes URL path
                let url = getDocumentDirectory().appendingPathComponent("notes")
                
                //create new property for the data
                let data = try Data(contentsOf: url)
                
                //decode the data
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
            }
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6) {
                TextField("Add New Note", text: $text)
                Button {
                    //only execute action when textfield isnt empty
                    guard text.isEmpty == false else {return}
                    //creating a new note item with textfield value
                    let note = Note(id: UUID(), text: text)
                    //adding item into an array
                    notes.append(note)
                    //textfield empty
                    text = ""
                    //saving notes
                    save()
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 42, weight: .semibold))
                }
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)
            }
            Spacer()
            
            if notes.count >= 1 {
                List {
                    ForEach(0..<notes.count, id: \.self) { i in
                        NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                            HStack {
                                Capsule()
                                    .frame(width: 4)
                                    .foregroundColor(.accentColor)
                                Text(notes[i].text)
                                    .lineLimit(1)
                                    .padding(.leading, 5)
                            }
                        }//: HSTACK
                    }
                    .onDelete(perform: delete)
                }
            } else {
                Spacer()
                Image(systemName: "note.text")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .opacity(0.25)
                    .padding(25)
            }//: LIST
        }//: VSTACK
        .navigationTitle("Notes")
        .onAppear {
            load()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
