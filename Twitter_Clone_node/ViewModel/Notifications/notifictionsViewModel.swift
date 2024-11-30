//
//  notifictionsViewModel.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 30/11/24.
//

import SwiftUI
class notificationViewModel: ObservableObject {
    let user: User
    @Published var notification = [Notification] ()
    
    init(user: User) {
        self.user = user
        fetchNotifications()
    }
    func fetchNotifications() {
        RequestServices.requestDomain = "http://localhost:3007/notifications/\(self.user.id)"
        RequestServices.fetchData { result in
            switch result {
            case .success(let data):
              guard let notification = try? JSONDecoder().decode([Notification].self, from: data as! Data) else {
                    return
                }
                DispatchQueue.main.async {
                    self.notification = notification
                }
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
}
