//
//  ViewController.swift
//  Word Garden
//
//  Created by Patrick on 9/18/17.
//  Copyright © 2017 Patrick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    var wordToGuess = "SWIFT"
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuestLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true

    }
    func updateUIAfterGuess() {
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    func formatUserGuestLabel(){
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + " \(letter)"
            } else {
                revealedWord += " _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    func guessALetter() {
  formatUserGuestLabel()
        guessCount += 1
        //decrements the wrongGuessesRemaining and shows the next flower image w one less pedal
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(guessedLetterField.text!) {
        wrongGuessesRemaining = wrongGuessesRemaining - 1
        flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
            
        }
        
        let revealedWord = userGuessLabel.text!
        //stop game if wrongGuessesRemaining = 0
        if wrongGuessesRemaining == 0 {
        playAgainButton.isHidden = false
        guessedLetterField.isEnabled = false
        guessLetterButton.isEnabled = false
        guessCountLabel.text = "So sorry. You're out of guesses. Try again?"
        } else if !revealedWord.contains("_") {
            //you've won a game
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You've got it! It took you \(guessCount) guesses to guess the word!"
        } else {
            //update guess count
            let guess = ( guessCount == 1 ? "Guess" :
            "Guesses")
//              var guess = "guesses"
//            if guessCount == 1 {
            //                guess = "guess"}
            
            guessCountLabel.text = "You've made \(guessCount) \(guess)"
        }
    }
    @IBAction func guessLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last { //if one of these is nil, it'll go to the else
            guessedLetterField.text = String(letterGuessed)
            guessLetterButton.isEnabled = true
        } else {
            //disable button if i dont have a single character in the guessedLetterField
            guessLetterButton.isEnabled = false
            
        }
    }
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
         guessALetter()
        updateUIAfterGuess()
    
        

    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
         guessALetter()
        updateUIAfterGuess()
      
        
        
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        lettersGuessed = ""
        formatUserGuestLabel()
        guessCountLabel.text = "You've Made 0 Guesses."
        guessCount = 0
        wrongGuessesRemaining = 8 
    }
}

