//
//  TriviaQuestion.swift
//  Trivia
//
//  Created by Yash Thakkar on 3/18/24.
//

import Foundation
import UIKit

struct TriviaAPIResponse: Decodable {
  let results: TriviaQuestion
}

struct TriviaQuestion: Decodable {
    let category: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}
