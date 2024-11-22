//
//  MessagesView.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 21/11/24.
//

import SwiftUI

struct MessagesView: View {
    @State var text = ""
    @State var isEditing = false
    var body: some View {
        VStack {
            SearchBarView(searchText: $text, isEditing: $isEditing)
            ScrollView {
                ForEach(0..<9) { _ in
                    MessageCellView()
                }
            }
        }
    }
}

#Preview {
    MessagesView()
}
