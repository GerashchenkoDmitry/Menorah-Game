//
//  ViewController.swift
//  Apple Pie Second
//
//  Created by Дмитрий Геращенко on 27/09/2019.
//  Copyright © 2019 Дмитрий Геращенко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["menorah", "candle", "hannukah", "word", "swift"]
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    var incorrectMovesAllowed = 7
    
    @IBOutlet weak var menorahImage: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newRound()
    }
    var currentGame: Game!
    
    func newRound() {
        if !listOfWords.isEmpty {
                let newWord = listOfWords.removeFirst()
                currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
                buttonsEnabled(true)
                updateGameState()
        } else {
            buttonsEnabled(false)
            hiddenLabels()
        }
    }
    
    func updateUI() {
        let mapped = game.formattedWord.compactMap { String($0) }
        correctWordLabel.text = mapped.joined(separator: " ")
        menorahImage.image = UIImage(named: "Menorah \(game.incorrectMovesRemaining)")
        scoreLabel.text = "Wins: \(totalWins) / Losses: \(totalLosses)"
    }
    

    func updateGameState() {
        if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else {
            updateUI()
        }
    }
    
    func buttonsEnabled(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func hiddenLabels() {
        correctWordLabel.isHidden = true
        scoreLabel.isHidden = true
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
}

