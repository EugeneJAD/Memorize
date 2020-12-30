//
//  EmogiMemoryGameViewModel.swift
//  Memorize
//
//  ViewModel
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    
    // model with String card content type
    @Published private var currentGame: MemoryGame<String> = EmojiMemoryGameViewModel.createNewGame()
    
    // MARK: - Access to the model
    var cards: Array<MemoryGame<String>.Card> {
        currentGame.cards
    }
    
    private static func createNewGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🙀"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { (pairIndex) in emojis[pairIndex] }
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        currentGame.choose(card: card)
    }
    
    func resetGame() {
        currentGame = EmojiMemoryGameViewModel.createNewGame()
    }
}
