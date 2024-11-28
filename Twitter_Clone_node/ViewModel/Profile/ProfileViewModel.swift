//
//  ProfileViewModel.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 28/11/24.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}
