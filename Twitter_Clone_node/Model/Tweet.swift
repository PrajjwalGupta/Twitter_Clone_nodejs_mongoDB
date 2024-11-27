//
//  Tweet.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 27/11/24.
//

import SwiftUI

struct Tweet: Identifiable, Decodable {
    let _id: String
    var id: String {
        return _id
    }
    let text: String
    let userId: String
    let username: String
    let user: String
}
