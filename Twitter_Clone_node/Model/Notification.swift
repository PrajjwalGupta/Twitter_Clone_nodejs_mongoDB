//
//  Notification.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 30/11/24.
//

import Foundation

struct Notification: Decodable, Identifiable {
    var _id: String
    var id: String {
        return _id
    }
    var username: String
    var notSenderId: String
    var notReceivedId: String
    var postText: String?
    var NotificationType: NotificationType
}

enum NotificationType: String, Decodable {
    case like = "like"
    case follow = "follow"
    var notificationMessage: String {
        switch self {
            case .like: return "liked your tweet"
            case .follow: return "started following your tweet"
        }
    }
}
