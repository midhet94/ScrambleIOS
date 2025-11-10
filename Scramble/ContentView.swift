//
//  ContentView.swift
//  Scramble
//
//  Created by Midhet Sulemani on 18/09/25.
//

import SwiftUI

struct ContentView: View {
    let viewModel = ViewModel()
    
    @State private var offset = CGSize.zero
    @GestureState private var currentDragAmount = CGSize.zero
    
    var body: some View {
        HStack {
            ForEach(viewModel.jumbledWord, id: \.self) {character in
                Text(character.uppercased())
                    .bold()
                    .padding()
                    .background(
                        RoundedRectangle(cornerSize: .zero)
                            .foregroundColor(.gray))
                    .offset(x: offset.width + currentDragAmount.width,
                            y: offset.height + currentDragAmount.height)
                    .gesture(dragGesture)
            }
        }
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .updating($currentDragAmount) { value, gestureState, transaction in
                gestureState = value.translation
            }
            .onEnded { value in
                offset = CGSize(width: offset.width + value.translation.width,
                                height: offset.height + value.translation.height)
            }
    }
}

#Preview {
    ContentView()
}
