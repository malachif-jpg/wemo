//
//  LLMController.swift
//  wemo
//
//  Created by Malachi Frazier on 2/18/24.
//

import Foundation
import Observation

enum EndpointType {
    case summarize
    case deepize
    case imageAura
}

@Observable
class LLMController {
    var prompts: [String]
    var messages: [LLMMessage]
    var currentQuery: String
    
    var showingPrompts = true
    
    init() {
        self.prompts = [
            "How was my mood this week?",
            "Give me a writing prompt for today.",
            "Show me my most used words this year."
        ]
        self.messages = []
        self.currentQuery = ""
    }
    func addNewMessage(messageType: MessageType, message: String) {
        let newMessage = LLMMessage(message: "\(message)", messageType: messageType)
        messages.append(newMessage)
    }
    
    // Define a struct that matches the JSON structure.
    struct ResponseData: Codable {
        let deeper_question: String
        let longer_context: String
    }

    // Function to decode the JSON string.
    func decodeJSON(from jsonString: String) -> ResponseData? {
        let jsonData = Data(jsonString.utf8)
        let decoder = JSONDecoder()

        do {
            let responseData = try decoder.decode(ResponseData.self, from: jsonData)
            return responseData
        } catch {
            print("Failed to decode JSON: \(error)")
            return nil
        }
    }
    
    func callEndpoint(userId: String, endpointType: EndpointType) async {
        await _callEndpoint(userId: userId, endpointType: endpointType) { result in
            var value: Data? = nil
            switch result {
            case .success(let success):
                value = success
            case .failure(let failure):
                return
            }
            
            switch endpointType {
            case .summarize:
                print(String(data: value!, encoding: .utf8))
            case .deepize:
                let jsonString = String(data: value!, encoding: .utf8)
                let decoded = self.decodeJSON(from: jsonString!)
                print(decoded?.deeper_question)
            case .imageAura:
                print("Image aura")
            }
        }
    }
    
    private func _callEndpoint(userId: String, endpointType: EndpointType, completion: @escaping (Result<Data, Error>) -> Void) async {
        //let baseURL = "http://127.0.0.1:5000/summarize_and_deepize"
        let baseURL = "flask-production-cbc5.up.railway.app/summary"
        
        let queryParams = [
            "start_date": "07/01/2024",
            "end_date": "07/03/2024",
            "user_id": "b7a35889-a19c-42e8-b648-22dd102d227e"
        ]
        
        let queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = queryItems
        
        //            guard let url = components?.url else {
        //                throw CustomError.runtimeError("Could not convert URL components into url")
        //            }
        
        var urlString = ""
        switch endpointType {
        case .summarize:
            urlString = "http://flask-production-cbc5.up.railway.app/summarize?start_date=07/01/2023&end_date=07/03/2024&user_id=b7a35889-a19c-42e8-b648-22dd102d227e"
        case .deepize:
            urlString = "http://flask-production-cbc5.up.railway.app/summarize_and_deepize?start_date=07/01/2023&end_date=07/03/2024&user_id=b7a35889-a19c-42e8-b648-22dd102d227e"
        case .imageAura:
            urlString = "http://flask-production-cbc5.up.railway.app/generate_image?start_date=07/01/2023&end_date=07/03/2024&user_id=b7a35889-a19c-42e8-b648-22dd102d227e"
        }
        
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(.failure(CustomError.runtimeError("error converting url")))
            return
        }
        
        // Create the URLSession data task and handle the response
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                
            } else if let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode),
                      let data = data,
                      let responseString = String(data: data, encoding: .utf8) {
                completion(.success(data))
                
            } else {
                let error = NSError(domain: "", code: (response as? HTTPURLResponse)?.statusCode ?? 500, userInfo: nil)
                completion(.failure(error))
            }
        }
        
        // Start the task
        task.resume()
        
        
        
    }
    
    
    // Define the structures to match the JSON response
    struct ChatResponse: Codable {
        let choices: [Choice]
        // Include other properties as needed
    }

    struct Choice: Codable {
        let message: Message
    }

    struct Message: Codable {
        let role: String
        let content: String
    }

    // Function to parse the JSON response and extract the content
    func extractContent(from jsonString: String) -> String? {
        // Remove any non-JSON fluff if it's consistently structured
        let trimmedString = jsonString.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let data = trimmedString.data(using: .utf8) else { return nil }

        // Parse the JSON data
        do {
            let chatResponse = try JSONDecoder().decode(ChatResponse.self, from: data)
            return chatResponse.choices.first?.message.content
        } catch {
            print("Failed to decode JSON: \(error)")
            return nil
        }
    }
    
    func chatResponse(query: String, journalModel: JournalModel) {
        self.currentQuery = ""
        _chatResponse(query: query, journalModel: journalModel) { result in
            switch result {
            case .success(let responseString):
                
                print("Response String: \(responseString)")
                if let content = self.extractContent(from: responseString) {
                    print("Extracted content: \(content)")
                    self.addNewMessage(messageType: .model, message: content)
                }
            case .failure(let error):
                // Handle error case
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func _chatResponse(query: String, journalModel: JournalModel, completion: @escaping (Result<String, Error>) -> Void) {
        var entries = [String]()
        for entry in journalModel.entries {
            entries.append(entry.dateFormatted())
            entries.append(entry.title)
            entries.append(entry.content)
        }
        let combinedString = entries.joined(separator: ", ")
        
        let directive = "Please use the following information which are journal entries for the user and speak as if you were talking to the user and use the information below to answer this query, but don't directly reference the journal and don't be too verbose: \nquery: '\(query)' \ninformation to answer query: \(combinedString)"
        
        let openRouterAPIKey = "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"
        let url = URL(string: "https://openrouter.ai/api/v1/chat/completions")!
        
        // Create the URLRequest object with the necessary method, headers, and body
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(openRouterAPIKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Prepare the body of the POST request
        let postBody: [String: Any] = [
            "model": "gryphe/mythomist-7b:free",
            "messages": [
                ["role": "user", "content": "\(directive)"]
            ]
        ]
        
        // Convert the postBody to JSON data
        let jsonData = try! JSONSerialization.data(withJSONObject: postBody, options: [])

        // Set the request body
        request.httpBody = jsonData
        
        // Create the URLSession data task and handle the response
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
              if let error = error {
                  completion(.failure(error))
                  
              } else if let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode),
                        let data = data,
                        let responseString = String(data: data, encoding: .utf8) {
                  completion(.success(responseString))
                  
              } else {
                  let error = NSError(domain: "", code: (response as? HTTPURLResponse)?.statusCode ?? 500, userInfo: nil)
                  completion(.failure(error))
              }
          }

        // Start the task
        task.resume()
        
        
    }
    
}
