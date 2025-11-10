//
//  ContentView.swift
//  Scramble
//
//  Created by Midhet Sulemani on 18/09/25.
//

import SwiftUI

struct ContentView: View {
    let viewModel = ViewModel()
    
    var body: some View {
        let originalWord = viewModel.getWord()
        let jumbledWord = viewModel.jumbleIt(word: originalWord)
        
        VStack {
            HStack {
                ForEach(jumbledWord, id: \.self) {character in
                    Text(character.uppercased())
                        .bold()
                        .padding()
                        .background(RoundedRectangle(cornerSize: .zero).foregroundColor(.gray))
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
