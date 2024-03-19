//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Yash Thakkar on 3/12/24.
//

import UIKit

struct Question {
    let category: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}

class TriviaViewController: UIViewController {
    
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var questionDescriptionLabel: UILabel!
    
    @IBOutlet weak var choice1Button: UIButton!

    @IBOutlet weak var choice2Button: UIButton!
    
    @IBOutlet weak var choice3Button: UIButton!
    
    @IBOutlet weak var choice4Button: UIButton!
    
    private var questions = [Trivia]() // tracks all the possible forecasts
    private var selectedquestionIndex = 0 // tracks which forecast is being shown, defaults to 0
    // Function override for the view controller
    // This is fired when the view has finished loading for the first time
    override func viewDidLoad() {
        // Some functions require you to call the super class implementation
        // Always read the online documentation to know if you need to
        super.viewDidLoad()
                
        questions = createMockData()
        
        TriviaQuestionService.fetchTriviaQuestions(amount: 10) { trivia in
            self.configure(with: trivia)
            
        }
        
//        configure(with: questions[selectedquestionIndex])
    }
    
    private func createMockData() -> [Trivia] {
        let mockData1 = Trivia(questionNumer: "Question 1/3", category: "Math", questionDescription: "What is 9 * 3?", choices: ["93", "27", "18", "12"])
        let mockData2 = Trivia(questionNumer: "Question 2/3", category: "Space", questionDescription: "What is the third planet in our solar system from the sun?", choices: ["Earth", "Mercury", "Mars", "Neptune"])
        let mockData3 = Trivia(questionNumer: "Question 3/3", category: "Formula 1", questionDescription: "How many world championships does Lewis Hamilton have?", choices: ["9", "8", "4", "7"])
        
        return [mockData1, mockData2, mockData3]
    }
    
    private func configure(with trivia: TriviaQuestion) {
        categoryLabel.text = trivia.category
        questionDescriptionLabel.text = trivia.question
        
        choice1Button.setTitle(trivia.correct_answer, for: .normal)
        choice2Button.setTitle(trivia.incorrect_answers[0], for: .normal)
        choice3Button.setTitle(trivia.incorrect_answers[1], for: .normal)
        choice4Button.setTitle(trivia.incorrect_answers[2], for: .normal)
    }
    
    

    @IBAction func choice1Button(_ sender: UIButton) {
        selectedquestionIndex = min(questions.count - 1, selectedquestionIndex + 1) // don't go higher than the last index
        configure(with: questions[selectedquestionIndex])
    }
    
    @IBAction func choice2Button(_ sender: UIButton) {
        selectedquestionIndex = min(questions.count - 1, selectedquestionIndex + 1) // don't go higher than the last index
        configure(with: questions[selectedquestionIndex])
    }
    
    @IBAction func choice3Button(_ sender: UIButton) {
        selectedquestionIndex = min(questions.count - 1, selectedquestionIndex + 1) // don't go higher than the last index
        configure(with: questions[selectedquestionIndex])
    }
    
    @IBAction func choice4Button(_ sender: UIButton) {
        selectedquestionIndex = min(questions.count - 1, selectedquestionIndex + 1) // don't go higher than the last index
        configure(with: questions[selectedquestionIndex])
    }
}
