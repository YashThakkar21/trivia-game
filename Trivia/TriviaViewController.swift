//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Yash Thakkar on 3/12/24.
//

import UIKit

class TriviaViewController: UIViewController {
    
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var choice1Button: UIButton!

    @IBOutlet weak var choice2Button: UIButton!
    
    @IBOutlet weak var choice3Button: UIButton!
    
    @IBOutlet weak var choice4Button: UIButton!
    
    private var triviaQuestions = [TriviaQuestion]() // tracks all the possible questions
    private var currentQuestionIndex = 0 // tracks which forecast is being shown, defaults to 0
    // Function override for the view controller
    // This is fired when the view has finished loading for the first time
    override func viewDidLoad() {
        // Some functions require you to call the super class implementation
        // Always read the online documentation to know if you need to
        super.viewDidLoad()
        fetchTriviaQuestions()
        
    }
    
    private func fetchTriviaQuestions() {
        TriviaQuestionService.fetchTriviaQuestions(amount: 10) { [weak self] questions in
            self?.triviaQuestions = questions
            self?.updateUI()
        }
    }
    
    private func updateUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard self.currentQuestionIndex < self.triviaQuestions.count else {
                return
            }
            let currentQuestion = self.triviaQuestions[self.currentQuestionIndex]
          
            self.categoryLabel.text = currentQuestion.category
            self.questionLabel.text = currentQuestion.question
            self.choice1Button.setTitle(currentQuestion.correctAnswer, for: .normal)
            self.choice2Button.setTitle(currentQuestion.incorrectAnswers[0], for: .normal)
            if currentQuestion.incorrectAnswers.count >= 2 {
                self.choice3Button.setTitle(currentQuestion.incorrectAnswers[1], for: .normal)
            } else {
                self.choice3Button.setTitle("", for: .normal) // Set a default text
                self.choice3Button.isEnabled = false // Disable the button
            }
            if currentQuestion.incorrectAnswers.count >= 3 {
                self.choice4Button.setTitle(currentQuestion.incorrectAnswers[2], for: .normal)
            } else {
                self.choice4Button.setTitle("", for: .normal) // Set a default text
                self.choice4Button.isEnabled = false // Disable the button
            }

            // Reset the state of choice3Button and choice4Button
            if currentQuestion.incorrectAnswers.count == 1 {
                self.choice3Button.isEnabled = true
                self.choice4Button.isEnabled = true
            }
            
            self.questionNumberLabel.text = "Question: \(self.currentQuestionIndex + 1)/\(self.triviaQuestions.count)"
        }
    }


    
    @IBAction func choiceButtonTapped(_ sender: UIButton) {
        currentQuestionIndex += 1
        updateUI()
    }
}
