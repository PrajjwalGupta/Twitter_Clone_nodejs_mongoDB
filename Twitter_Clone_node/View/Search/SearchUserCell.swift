//
//  SearchUserCell.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 22/11/24.
//

import SwiftUI

struct SearchUserCell: View {
    var body: some View {
        HStack {
            Image("me")
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("Prajjwal")
                    .fontWeight(.heavy)
                Text("@Prajjwal1")
            }
            Spacer(minLength: 0)
            
        }
    }
}

#Preview {
    SearchUserCell()
}
