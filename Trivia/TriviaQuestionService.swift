import Foundation

class TriviaQuestionService {
    static func fetchTriviaQuestions(amount: Int,
                                     completion: @escaping ([TriviaQuestion]) -> Void) {
        let parameters = "amount=\(amount)"
        let url = URL(string: "https://opentdb.com/api.php?\(parameters)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }
            guard let data = data else {
                assertionFailure("No data received")
                return
            }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(TriviaAPIResponse.self, from: data)
                completion(response.triviaQuestion)
            } catch {
                assertionFailure("Failed to decode JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
