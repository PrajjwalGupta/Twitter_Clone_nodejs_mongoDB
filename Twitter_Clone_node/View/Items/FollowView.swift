//
//  FollowView.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 22/11/24.
//

import SwiftUI

struct FollowView: View {
    var count: Int
    var title: String
    var body: some View {
        HStack() {
            Text("\(count)")
                .fontWeight(.bold)
                .foregroundColor(.black)
            Text(title)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    FollowView(count: 12, title: "Prajjwal")
}
