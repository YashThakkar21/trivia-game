//
//  TriviaQuestion.swift
//  Trivia
//
//  Created by Yash Thakkar on 3/18/24.
//

import Foundation
import UIKit

struct TriviaAPIResponse: Decodable {
  let triviaQuestion: [TriviaQuestion]
    
    private enum CodingKeys: String, CodingKey {
        case triviaQuestion = "results"
    }
}

struct TriviaQuestion: Decodable {
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    private enum CodingKeys: String, CodingKey {
        case category = "category"
        case question = "question"
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
