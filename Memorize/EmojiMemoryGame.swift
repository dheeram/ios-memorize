//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by James Byrne on 23/06/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

    private static var themes = [
        Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷", "🧙‍♀️", "🦇"], color: UIColor.systemOrange, numOfEmojis: 5),
        Theme(name: "Christmas", emojis: ["🎅", "🤶", "🎄", "🎁", "❄️", "⛄️"], color: UIColor.systemBlue, numOfEmojis: 6),
        Theme(name: "Summer", emojis: ["☀️", "🕶", "🥵", "🏖", "🏝", "⛱", "🌞", "🍉"], color: UIColor.systemYellow, numOfEmojis: 8),
        Theme(name: "Sports", emojis: ["⚽️", "🏓", "🏊‍♂️", "🎾", "🎿", "🏀", "🏂", "🏇", "🏈", "🏏", "🏑", "🏒", "🏸", "🏹", "⚾️", "⛳️", "🥍", "🥎", "⛷", "⛸", "🏎"], color: UIColor.systemGreen, numOfEmojis: 10),
        Theme(name: "Music", emojis: ["🎸", "🎧", "🎹", "🎤", "🎺", "🎻", "🎼", "🪕", "🎷", "🥁", "🎶", "🎵", "👩‍🎤", "👨‍🎤"], color: UIColor.systemRed, numOfEmojis: 10),
        Theme(name: "Flags", emojis: ["🇮🇪", "🇪🇸", "🇫🇷", "🇨🇦", "🇺🇸", "🇨🇳", "🇳🇮", "🇬🇧"], color: UIColor.systemGray, numOfEmojis: 8),
    ]
        
    private static func createMemoryGame() -> MemoryGame<String> {
        let theme = themes.randomElement()!
        
        print("json = \(String(decoding: theme.json!, as: UTF8.self))")
        
        return MemoryGame<String>(numberOfPairsOfCards: theme.numOfEmojis, themeName: theme.name) { pairIndex in
            return theme.emojis[pairIndex]
        }
    }
    
    private func getTheme() -> Theme? {
        EmojiMemoryGame.themes.first(where: { $0.name == model.themeName })
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var themeColor: Color {
        if let uiColor = getTheme()?.color {
            return Color(uiColor)
        } else {
            return Color.black
        }
    }
    
    var score: Int {
        get { model.score }
        set { model.score = newValue }
    }
    
    var themeName: String { model.themeName.capitalized }
    
    // MARK: Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}


