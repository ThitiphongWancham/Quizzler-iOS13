//
//  QuizBrain.swift
//  Quizzler-iOS13
//
//  Created by Thitiphong Wancham on 17/2/2566 BE.
//  Copyright © 2566 BE The App Brewery. All rights reserved.
//

import Foundation

struct QuizBrain {
    private var quizzes = Question.questions.shuffled()
    private(set) var questionNumber = 0
    private var score = 0
    
    var getScore: Int {
        score
    }
    
    var currentQuestion: Question {
        quizzes[questionNumber]
    }
    
    var getCurrentQuestionText: String {
        currentQuestion.q
    }
    
    var getCurrentQuestionChoices: [String] {
        currentQuestion.a.shuffled()
    }
    
    var getCurrentQuestionAnswer: String {
        currentQuestion.correctAnswer
    }
    
    var numberOfQuestion: Int {
        quizzes.count
    }
    
    var getCurrentProgress: Float {
        Float(questionNumber + 1) / Float(numberOfQuestion)
    }
    
    mutating func nextQuestion() {
        questionNumber += 1
    }
    
    mutating func restartQuiz() {
        quizzes.shuffle()
        questionNumber = 0
        score = 0
    }
    
    mutating func increaseScore() {
        score += 1
    }
    
    func checkAnswer(selectedAns: String) -> Bool {
        selectedAns == getCurrentQuestionAnswer
    }
}
