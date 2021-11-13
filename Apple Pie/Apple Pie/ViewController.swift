//
//  ViewController.swift
//  Apple Pie
//
//  Created by Thomas, Jasmyne D. on 11/2/21.
//

import UIKit

class ViewController: UIViewController {
    var listOfWords = ["pirate", "cake","happy","clam","car","camera"]
    var incorrectMovesAllowed = 6
    var totalWins = 0 {
        didSet{
            newRound()
        }
    }
    var totalLosses = 0{
        didSet{
            newRound()
        }
    }
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
        
    }
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0{
            totalLosses += 1
        }
        else if currentGame.word == currentGame.formattedword{
            totalWins += 1
        }
        else{
            updateUI()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        
    }
    var currentGame: Game!
    func newRound(){
            if !listOfWords.isEmpty{
                let newWord = listOfWords.removeFirst()
                currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
                enableLeterButtons(true)
                updateUI()
        }
            else{
                enableLeterButtons(false)
            }
    }
    func enableLeterButtons(_ enable: Bool){
        for button in letterButtons{
            button.isEnabled = enable
        }
    }
    func updateUI(){
        var letters = [String]()
        for letter in currentGame.formattedword{
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator:" ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        print("Tree \(currentGame.incorrectMovesRemaining)")
    }


}

