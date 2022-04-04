//
//  DetailView.swift
//  Notes WatchKit Extension
//
//  Created by Sarika on 04.04.22.
//

import SwiftUI

struct DetailView: View {
    let note: Note
    let count: Int
    let index: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            //header
            
            HStack {
                Capsule()
                    .frame(height: 1)
                
                Image(systemName: "note.text")
                
                Capsule()
                    .frame(height: 1)
            }
            .foregroundColor(.accentColor)
            //content
            Spacer()
            
            ScrollView(.vertical){
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            //footer
            
            HStack(alignment: .center) {
                
                Image(systemName: "gear")
                    .imageScale(.large)
                
                Spacer()
                
                Text("\(count)/ \(index + 1)")
                Spacer()
                
                Image(systemName: "info.circle")
                    .imageScale(.large)
            }//: HSTACK
            .foregroundColor(.secondary)
            
        }//: VSTACK
        .padding(3)
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static var sampleData: Note = Note(id: UUID(), text: "hello, world")
    static var previews: some View {
        DetailView(note: sampleData, count: 5, index: 1)
    }
}
