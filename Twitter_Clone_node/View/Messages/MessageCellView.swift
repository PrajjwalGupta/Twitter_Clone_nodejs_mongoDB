//
//  MessageCellView.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 22/11/24.
//

import SwiftUI

struct MessageCellView: View {
    @State var width = UIScreen.main.bounds.width
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle().frame(width: width, height: 1)
                .foregroundColor(.gray).opacity(0.3)
            HStack(alignment: .top, spacing: 5) {
                Image("me")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    HStack {
                        Text("Prajjwal ").fontWeight(.heavy)
                        + Text("@Prajjwal1")
                            .fontWeight(.light)
                            .foregroundStyle(.gray)
                        Spacer()
                        Text("22/11/24")
                            .foregroundStyle(.gray).opacity(0.5)
                    }
                    Text("You: How is it going?")
                        .foregroundColor(.gray)
                    Spacer()
                }.padding(.leading, 4)
            }.padding(.horizontal)
        }.frame(width: width, height: 84)
    }
}

#Preview {
    MessageCellView()
}
