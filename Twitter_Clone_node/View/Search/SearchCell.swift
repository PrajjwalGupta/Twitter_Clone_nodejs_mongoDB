//
//  SearchCell.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 22/11/24.
//

import SwiftUI

struct SearchCell: View {
    var tag = ""
    var tweets = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            Text("hello").fontWeight(.heavy)
            Text(tweets + " tweets").fontWeight(.light)
        })
    }
}

#Preview {
    SearchCell()
}
