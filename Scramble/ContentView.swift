//
//  ContentView.swift
//  Scramble
//
//  Created by Midhet Sulemani on 18/09/25.
//

import SwiftUI

struct ContentView: View {
    let viewModel = ViewModel()
    
    @State private var letters: [LetterItem]
    @GestureState private var dragOffset: CGSize = .zero
    @State private var draggingItem: LetterItem?
    @State private var showResultScreen = false
    
    init() {
        self.letters = viewModel.jumbledWord
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                ForEach(letters) { item in
                    Text(item.char.uppercased())
                        .font(.largeTitle.bold())
                        .frame(width: 55, height: 55)
                        .background(Color.blue.opacity(0.25))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(draggingItem?.id == item.id ? Color.blue : .clear, lineWidth: 3)
                        )
                        .offset(draggingItem?.id == item.id ? dragOffset : .zero)
                        .zIndex(draggingItem?.id == item.id ? 1 : 0)
                        .gesture(
                            DragGesture()
                                .updating($dragOffset, body: { value, state, _ in
                                    state = value.translation
                                    draggingItem = item
                                })
                                .onEnded { value in
                                    reorderItems(item: item, translation: value.translation)
                                    draggingItem = nil
                                }
                        )
                }
            }
            .animation(.spring(), value: letters)
            .fullScreenCover(isPresented: $showResultScreen) {
                ResultScreen(onRestart: resetGame)
            }
        }
    }
    
    /// Reorder when drag ends
    func reorderItems(item: LetterItem, translation: CGSize) {
        guard let fromIndex = letters.firstIndex(where: { $0.id == item.id }) else { return }

        let dragThreshold = 60.0 // width of a block
        var toIndex = fromIndex + Int(translation.width / dragThreshold)

        toIndex = max(min(toIndex, letters.count - 1), 0)

        if fromIndex != toIndex {
            let letter = letters.remove(at: fromIndex)
            letters.insert(letter, at: toIndex)
        }
        
        if letters.map({ $0.char }) == viewModel.originalWord {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut(duration: 0.6)) {
                    showResultScreen = true
                }
            }
        }
    }
    
    func resetGame() {
        viewModel.resetGame()
        self.letters = viewModel.jumbledWord
    }

}

#Preview {
    ContentView()
}
