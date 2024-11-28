//
//  EditProfileViewModel.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 28/11/24.
//

import SwiftUI

class EditProfileViewModel: ObservableObject {
    var user: User
    @Published var uploadComplete: Bool = false
    init(user: User) {
        self.user = user
    }
    func save(name: String?, bio: String?, website: String?, location: String?) {
        
        guard let UserNewName = name else { return }
        guard let UserNewWebsite = website else { return }
        guard let UserNewLocation = location else { return }
        guard let UserNewBio = bio else { return }
        
        self.user.name = UserNewName
        self.user.website = UserNewWebsite
        self.user.location = UserNewLocation
        self.user.bio = UserNewBio
        self.uploadComplete.toggle()
    }
    func uploadUserData(name: String?, bio: String?, website: String?, location: String?) {
        let userId = user.id
        let urlPath = "/users/\(userId)"
        let url = URL(string: "http://localhost:3007\(urlPath)")!
        AuthServices.makePatchRequestWithAuth(urlString: url, reqBody: ["name": name, "bio": bio, "website": website, "location": location]) { result in
            DispatchQueue.main.async {
                self.save(name: name, bio: bio, website: website, location: location)
                self.uploadComplete = true
                
            }
        }
    }
}
