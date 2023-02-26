//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Create QuizBrain controller
    var quizBrain = QuizBrain()
    
    // All the UI components
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var choiceOne: UIButton!
    @IBOutlet weak var choiceTwo: UIButton!
    @IBOutlet weak var choiceThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
        updateScore()
    }
    
    // When either the True or the False button is pressed, it will tricker this function
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        // Disable button after the user did answer the question
        disableBtn()
        
        // Get the current label of the button that user selected
        guard let answer = sender.currentTitle else { return }
        
        // If the answer is correct, the button's background will be green and plus the score by 1, otherwise it will be red and the score remains the same
        if quizBrain.checkAnswer(selectedAns: answer) {
            sender.backgroundColor = UIColor.green
            // Increase score
            quizBrain.increaseScore()
            // Update score
            updateScore()
        } else {
            sender.backgroundColor = UIColor.red
        }
        
        // Wait for 0.5 seconds until navigate to the next question
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            // Update the question counter
            self.quizBrain.nextQuestion()
            // Prevent fatal error (index out of range) as well as restarting the quiz at the end of the game
            guard self.quizBrain.questionNumber < self.quizBrain.numberOfQuestion else {
                self.quizBrain.restartQuiz()
                self.updateUI()
                self.updateScore()
                return
            }
            // Go to the next question
            self.updateUI()
        }
    }
    
    func updateUI() {
        // Set question text
        questionLabel.text = quizBrain.getCurrentQuestionText
        // Set buttons: activate btns, clear background, and change text label
        setButtons(
            buttons: [choiceOne, choiceTwo, choiceThree],
            with: quizBrain.getCurrentQuestionChoices
        )
        // Set progress bar
        progressBar.progress = quizBrain.getCurrentProgress
    }
    
    func updateScore() {
        scoreLabel.text = "Score: \(quizBrain.getScore)"
    }
    
    func setButtons(buttons: [UIButton], with choices: [String]) {
        for (index, button) in buttons.enumerated() {
            // Set button label
            button.setTitle(choices[index], for: .normal)
            // Set button back ground
            button.backgroundColor = UIColor.clear
            // Acttivate button
            button.isEnabled = true
        }
    }
    
    func disableBtn() {
        choiceOne.isEnabled = false
        choiceTwo.isEnabled = false
        choiceThree.isEnabled = false
    }
}

