//
//  ProfileViewModel.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 28/11/24.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var tweets = [Tweet]()
    
    init(user: User) {
        self.user = user
        fetchTweets()
        checkIfUserIsCurrentUser()
        checkIfUseriSFollowed()
    }
    func fetchTweets() {
        RequestServices.requestDomain = "http://localhost:3007/tweets/\(self.user.id)"
        RequestServices.fetchData { res in
            switch res {
            case .success(let data):
                guard let tweets = try? JSONDecoder().decode([Tweet].self, from: data as! Data) else { return }
                DispatchQueue.main.async {
                    self.tweets = tweets
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func checkIfUserIsCurrentUser() {
        if (self.user._id == AuthViewModel.shared.currentUser?._id) {
            self.user.isCurrentUser = true
        }
    }
    func follow() {
        guard let authedUser = AuthViewModel.shared.currentUser else { return }
        RequestServices.requestDomain = "http://localhost:3007/users/\(self.user.id)/follow"
        RequestServices.followingProcess(id: self.user.id) { result in
            print(result)
            print("Followed")
        }
        RequestServices.requestDomain = "http://localhost:3007/notification"
        RequestServices.sendNotification(username: authedUser.username, notSenderId: authedUser.id, notRecivedId: self.user.id, notificationType: NotificationType.follow.rawValue, postText: "") { result in
            print("Followed")
        }
        self.user.isFollowed = true
        
    }
    func unfollow(){
        RequestServices.requestDomain = "http://localhost:3007/users/\(self.user.id)/unfollow"
        RequestServices.followingProcess(id: self.user.id) { result in
            print(result)
            print("Followed")
        }
        self.user.isFollowed = false
    }
    func checkIfUseriSFollowed() {
        if (self.user.followers.contains(AuthViewModel.shared.currentUser!._id)) {
            self.user.isFollowed = true
        } else {
            self.user.isFollowed = false
        }
    }
}
