//
//  customProfileTextField.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 28/11/24.
//

import SwiftUI

struct customProfileTextField: View {
    
    @Binding var message: String
    var placeholder: String
    
    var body: some View {
        HStack {
            ZStack {
                HStack {
                    if message.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                TextField("", text: $message)
                    .foregroundColor(.blue)
            }
        }
    }
}

//#Preview {
//    customProfileTextField()
//}
