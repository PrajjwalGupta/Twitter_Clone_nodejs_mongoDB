//
//  NotificationsView.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 21/11/24.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        VStack {
            ScrollView {
                ForEach(0..<9) { _ in
                    NotificationsCell()
                }
            }
        }
    }
}

#Preview {
    NotificationsView()
}
