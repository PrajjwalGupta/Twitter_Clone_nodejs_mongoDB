//
//  TweetCellViewModel.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 27/11/24.
//

import SwiftUI

class TweetCellViewModel: ObservableObject {
    
    @Published var tweet: Tweet
    @Published var user: User?
    let currentUser: User
    
    init(tweet: Tweet, currentUser: User) {
        self.tweet = tweet
        self.currentUser = currentUser
        self.fetchUser(userId: tweet.user)
        checkUserifLikePost()
    }
    
    func fetchUser(userId: String) {
        AuthServices.requestDomain = "http://localhost:3007/users/\(userId)"
        AuthServices.fetchUser(id: userId) { result in
            switch result {
            case .success(let data):
                guard let user = try? JSONDecoder().decode(User.self, from: data as! Data) else { return }
                DispatchQueue.main.async {
                    self.user = user
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func like() {
        RequestServices.requestDomain = "http://localhost:3007/tweets/\(self.tweet.id)/like"
        RequestServices.likeTweet(id: self.tweet.id) { result in
            print("the tweet has been liked")
        }
        RequestServices.requestDomain = "http://localhost:3007/notification"
        RequestServices.sendNotification(username: self.currentUser.username, notSenderId: self.currentUser.id, notRecivedId: self.tweet.id, notificationType: NotificationType.like.rawValue, postText: self.tweet.text) { result in
            print(result)
        }
        self.tweet.didLike = true
    }
    func unlike() {
        RequestServices.requestDomain = "http://localhost:3007/tweets/\(self.tweet.id)/unlike"
        RequestServices.likeTweet(id: self.tweet.id) { result in
            print("the tweet has been unliked")
        }
        self.tweet.didLike = false
    }
    func checkUserifLikePost() {
        if (self.tweet.likes.contains(self.currentUser.id)) {
            self.tweet.didLike = true
        } else {
            self.tweet.didLike = false
        }
    }
    
}
