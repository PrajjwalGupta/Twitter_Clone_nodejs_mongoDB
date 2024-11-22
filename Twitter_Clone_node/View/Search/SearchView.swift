//
//  SearchView.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 21/11/24.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @State var isEditing = false
    var body: some View {
        VStack {
        SearchBarView(searchText: $text, isEditing: $isEditing)
            .padding(.horizontal, 10)
        if !isEditing {
            List(0..<9) { i in
                SearchCell(tag: "Hello", tweets: String(i*2))
            }
        } else {
            List(0..<9) { i in
                SearchUserCell()
            }
        }
    }
    }
}

#Preview {
    SearchView()
}
