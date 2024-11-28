//
//  customProfileBioTextField.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 28/11/24.
//

import SwiftUI

struct customProfileBioTextField: View {
    @Binding var bio: String
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                if bio.isEmpty {
                    HStack {
                        Text("Add a bio to your profile")
                            .foregroundColor(.gray)
                        Spacer()
                        
                    }.padding(.top, 8)
                        .padding(.leading, 4)
                        .zIndex(1)
                }
                TextEditor(text: $bio)
                    .foregroundColor(.blue)
            }
        }.frame(height: 90)
    }
}
