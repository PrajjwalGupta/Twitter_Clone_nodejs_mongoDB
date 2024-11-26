//
//  AuthViewModel.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 24/11/24.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User? = nil
    
    init() {
        let defaults = UserDefaults.standard
        if let token = defaults.object(forKey: "jsonwebtoken") as? String {
            // If token exists, attempt to fetch user data
            if let userId = defaults.object(forKey: "userid") as? String {
                // Fetch user from API
                fetchUser(userId: userId)
            }
        } else {
            // No token found, user is not authenticated
            isAuthenticated = false
        }
    }

    static let shared = AuthViewModel()

    func login(email: String, password: String) {
        let defaults = UserDefaults.standard
        AuthServices.requestDomain = "http://localhost:3007/users/login"
        
        AuthServices.login(email: email, password: password) { res in
            switch res {
            case .success(let data):
                guard let user = try? JSONDecoder().decode(ApiResponse.self, from: data as! Data) else {
                    return
                }
                DispatchQueue.main.async {
                    defaults.set(user.token, forKey: "jsonwebtoken")
                    defaults.set(user.user.id, forKey: "userid")
                    self.isAuthenticated = true
                    self.currentUser = user.user
                    print("Logged in successfully")
                }
            case .failure(let error):
                print("Login failed: \(error)")
            }
        }
    }
    
    func register(name: String, username: String, email: String, password: String) {
        AuthServices.register(email: email, username: username, password: password, name: name) { result in
            switch result {
            case .success(let data):
                guard let user = try? JSONDecoder().decode(ApiResponse.self, from: data as! Data) else {
                    return
                }
            case .failure(let error):
                print("Registration failed: \(error.localizedDescription)")
            }
        }
    }

    func fetchUser(userId: String) {
        AuthServices.fetchUser(id: userId) { result in
            switch result {
            case .success(let data):
                guard let user = try? JSONDecoder().decode(User.self, from: data as! Data) else {
                    return
                }
                DispatchQueue.main.async {
                    // Set user data after successfully fetching user
                    UserDefaults.standard.setValue(user.id, forKey: "userid")
                    self.isAuthenticated = true
                    self.currentUser = user
                    print("User fetched: \(user)")
                }
            case .failure(let error):
                print("Failed to fetch user: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.isAuthenticated = false
                }
            }
        }
    }

    func logout() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        DispatchQueue.main.async {
            self.isAuthenticated = false
            self.currentUser = nil
        }
    }
}
