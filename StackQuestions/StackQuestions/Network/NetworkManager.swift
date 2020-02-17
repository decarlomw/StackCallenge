//
//  NetworkManager.swift
//  StackQuestions
//
//  Created by Decarlo Williams on 2/16/20.
//  Copyright © 2020 Decarlo Williams. All rights reserved.
//

import Foundation
import UIKit

typealias completionHandler = (Any) -> Void

struct Constants {
    static let API_URL = "https://api.stackexchange.com/2.2/questions?order=desc&sort=activity&site=stackoverflow"
}

struct NetworkManager {
    // Fetching the data from the given URL
    fileprivate static func fetchData(url: URL, completionHandler: @escaping completionHandler) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error with fetching questions: \(error)")
                completionHandler(error)
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }
            
            if let data = data {
                print("DATA: \(String(decoding: data, as: UTF8.self))")
                completionHandler(data)
            }
        }
        task.resume()
    }
    
    
    static func fetchQuestions(completionHandler: @escaping completionHandler) {
        
        let url = URL(string: Constants.API_URL)!
        
        fetchData(url: url) { (response) in
            
            if let data = response as? Data {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    completionHandler(response.items)
                    
                } catch let error {
                    // handle error
                    completionHandler(error)
                }
            }
            else {
                let error = response as! Error
                completionHandler(error)
            }
        }
    }
}

