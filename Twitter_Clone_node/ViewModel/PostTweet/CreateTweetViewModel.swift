//
//  CreateTweetViewModel.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 27/11/24.
//

import SwiftUI

class CreateTweetViewModel: ObservableObject {
    func uploadPost(text: String) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        RequestServices.requestDomain = "http://localhost:3007/tweets"
        RequestServices.postTweet(text: text, user: user.name, username: user.username, userId: user.id) { result in
            print(result)
        }
    }
}

