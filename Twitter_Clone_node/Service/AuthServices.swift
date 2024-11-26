//
//  AuthServices.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 26/11/24.
//
//
import Foundation
import SwiftUI

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case invalidResponse
}

public class AuthServices {
    public static var requestDomain = ""
    
    static func login(email: String, password: String, completion: @escaping(_ result: Result<Data?, AuthenticationError>) -> Void) {
        let urlString = URL(string: "http://localhost:3007/users/login")!
        makeRequest(urlString: urlString, reqBody: ["email": email, "password": password]) { res in
            switch res {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.invalidCredentials))
            }
        }
    }
    
    static func register(email: String, username: String, password: String, name: String, completion: @escaping (_ result: Result<Data?, AuthenticationError>) -> Void) {
        let urlString = URL(string: "http://localhost:3007/users")!
        makeRequest(urlString: urlString, reqBody: ["email": email, "username": username, "name": name, "password": password]) { res in
            switch res {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.invalidCredentials))
            }
        }
    }
    
    static func makeRequest(urlString: URL, reqBody: [String: Any], completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void) {
        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: reqBody, options: .prettyPrinted)
        } catch {
            completion(.failure(.decodingError))
            return
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
    
    static func fetchUser(id: String, completion: @escaping(_ result: Result<Data?, AuthenticationError>)-> Void) {
        let urlString = URL(string: "http://localhost:3007/users/\(id)")!  // Fixed URL
        var urlRequest = URLRequest(url: urlString)
        let session = URLSession.shared
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}


