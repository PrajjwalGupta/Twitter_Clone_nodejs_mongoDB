//
//  NotificationsView.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 21/11/24.
//

import SwiftUI

struct NotificationsView: View {
    let user: User
    @ObservedObject var viewModel: notificationViewModel
    
    init(user: User) {
        self.user = user
        self.viewModel = notificationViewModel(user: user)
        
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.notification) { not in
                    NotificationsCell(notification: not)
                }
            }
        }
    }
}


