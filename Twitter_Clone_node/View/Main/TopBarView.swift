//
//  TopBarView.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 22/11/24.
//

import SwiftUI

struct TopBarView: View {
    @State var width = UIScreen.main.bounds.width
    var body: some View {
        VStack {
            HStack {
                Button(action: {}) {
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 20)
                        .clipped()
                       // .font(.system(size: 42))
                        .foregroundColor(Color("bg"))
                        
                }
                Spacer(minLength: 0)
                Image("logo")
                Spacer()
            }.padding()
            Rectangle()
                .frame(width: width, height: 1)
                .foregroundStyle(.gray)
                .opacity(0.3)
        }
        .background(Color.white)
    }
}

#Preview {
    TopBarView()
}
