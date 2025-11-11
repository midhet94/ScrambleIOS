//
//  ViewModel.swift
//  Scramble
//
//  Created by Midhet Sulemani on 19/09/25.
//

import Foundation
import Combine

struct WordModel: Decodable {
    var data: [String]
}

class ViewModel: ObservableObject {
    @Published var words: [String] = []
    @Published var originalWord: [String] = []
    @Published var jumbledWord: [LetterItem] = []
    
    init() {
        let dataModel: WordModel = loadLocalJSON(filename: "words")
        self.words = dataModel.data
        self.originalWord = getWord()
        self.jumbledWord = jumbleIt(word: originalWord)
    }
    
    func loadLocalJSON<T: Decodable>(filename: String) -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("Couldn't find \(filename).json in main bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Couldn't load \(filename).json from main bundle.")
        }

        let decoder = JSONDecoder()

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename).json as \(T.self):\n\(error)")
        }
    }
    
    func getWord() -> [String] {
        if let randomWord = words.randomElement() {
            return randomWord.map { String($0) }
        }
        return getWord()
    }
    
    func jumbleIt(word: [String]) -> [LetterItem] {
        word.shuffled()
            .enumerated()
            .map { LetterItem(id: $0.offset, char: String($0.element)) }
    }
    
    func resetGame() {
        self.originalWord = getWord()
        self.jumbledWord = jumbleIt(word: originalWord)
    }
}
