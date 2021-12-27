//
//  TaskApi.swift
//  BucketList
//
//  Created by Hajar Alomari on 27/12/2021.
//

import Foundation


class TaskApi{
    
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
    
    static func addTask(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
     
            if let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/") {
                
                var request = URLRequest(url: url)
               
                request.httpMethod = "POST"
                let bodyData = "objective=\(objective)"
                
                request.httpBody = bodyData.data(using: .utf8)
                
                let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                
                task.resume()
            }
    }
    
    static func deleteTask(id: Int, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
     
            if let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(id)") {
                
                var request = URLRequest(url: url)
               
                request.httpMethod = "DELETE"
            
                let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                
                task.resume()
            }
    }
    
    static func updateTask(id: Int, objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
     
            if let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(id)") {
                
                var request = URLRequest(url: url)
               
                request.httpMethod = "PUT"
                
                let bodyData = "objective=\(objective)"
                
                request.httpBody = bodyData.data(using: .utf8)
                print("PUT \(bodyData) ")
                
                let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                task.resume()
            }
    }
    

    }


