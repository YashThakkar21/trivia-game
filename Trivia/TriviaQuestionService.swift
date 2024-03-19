//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Yash Thakkar on 3/18/24.
//

import Foundation

class TriviaQuestionService {
    static func fetchTriviaQuestions(amount: Int,
                                     completion: ((TriviaQuestion) -> Void)? = nil) {
        let parameters = "api.php?amount=\(amount)"
        let url = URL(string: "https://opentdb.com/\(parameters)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
            }
            guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
            }
            let trivia = parse(data: data)
            
            let decoder = JSONDecoder()
            let response = try! decoder.decode(TriviaAPIResponse.self, from: data)
            
            DispatchQueue.main.async {
                completion?(response.results)
            }
        }
        task.resume()
    }
    
    private static func parse(data: Data) -> TriviaQuestion {
        let jsonDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        
        let results = jsonDictionary["results"] as! [String: Any]
        
        let category = results["category"] as! String
        
        let question = results["question"] as! String
        
        let correct_answer = results["correct_answer"] as! String
        
        let incorrect_answers = results["incorrect_answers"] as! [String]
        
        return TriviaQuestion(category: category, question: question, correct_answer: correct_answer, incorrect_answers: incorrect_answers)

    }
}
