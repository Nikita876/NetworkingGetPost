//
//  ViewController.swift
//  NetworkingGetPost
//
//  Created by Никита Коголенок on 24.03.21.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Variable
    let urlGet: String = "https://jsonplaceholder.typicode.com/posts"
    let urlPost: String = "https://jsonplaceholder.typicode.com/posts"
    // MARK: - Action
    /// getRequest
    @IBAction func getRequest(_ sender: Any) {
        
        guard let url = URL(string: urlGet) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            guard let response = response,
                  let data = data
            else { return }
            print(response)
            print(data)
            
            /// Перевод из одного хранения данных в другой (JSON)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
    /// postRequest
    @IBAction func postRequest(_ sender: Any) {
        
        guard let url = URL(string: urlPost) else { return }
        
        let userdData = ["Course": "Networking", "Lesson":"GET and POST Requests"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let httpBoby = try? JSONSerialization.data(withJSONObject: userdData, options: []) else { return }
        request.httpBody = httpBoby
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            guard let response = response,
                  let data = data
            else { return }
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
}
