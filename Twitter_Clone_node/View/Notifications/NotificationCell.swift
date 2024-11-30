//
//  NotificationCell.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 22/11/24.
//

import SwiftUI
import Kingfisher

struct NotificationsCell: View {
    
    @State var width = UIScreen.main.bounds.width
    let notification: Notification
    
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: width, height: 1, alignment: .center)
                .foregroundStyle(.blue)
                .opacity(0.3)
            HStack(alignment: .top, content: {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.blue)
                    .frame(width: 20, height: 20)
                    .cornerRadius(18)
                VStack(alignment: .leading, spacing: 5, content: {
                    KFImage(URL(string: "http://localhost:3007/\(notification.notSenderId)/avatar"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                        .cornerRadius(18)
                    Text("\(notification.username)")
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    + Text(notification.NotificationType.rawValue == "follow" ? NotificationType.follow.notificationMessage : NotificationType.like.notificationMessage)
                        .foregroundStyle(.black)
                })
                Spacer(minLength: 0)
            }).padding(.leading, 35)
        }
    }
}

//#Preview {
//    NotificationsCell()
//}
