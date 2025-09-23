//
//  ViewModel.swift
//  Scramble
//
//  Created by Midhet Sulemani on 19/09/25.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var words: [String] = []
    
    init() {
        self.words = loadLocalJSON(filename: "words")
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
}
