//
//  PostView.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 21/11/24.
//

import SwiftUI

struct CreateTweetView: View {
    @Binding var show: Bool
    @State var text = ""
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = CreateTweetViewModel()
    var body: some View {
        VStack {
            HStack {
                Button(action:{presentationMode.wrappedValue.dismiss()},label: {
                    Text("Cancel")
                }).frame(width: 120, height: 40)
                    .overlay( RoundedRectangle(cornerRadius: 40 / 2).stroke(Color("bg"), lineWidth: 2)).padding()
                Spacer()
                Button(action:{
                    if text != "" {
                        self.viewModel.uploadPost(text: text)
                    }
                    self.show.toggle()
                    
                },label: {
                    Text("Tweet")
                }).frame(width: 120, height: 40)
                   
                .background(Color("bg"))
                    .foregroundStyle(.white)
                    .clipShape(.capsule).padding()
               
            }
            VStack(alignment: .leading){
                Text("Word limit: 280 character")
                    .font(.caption)
                    .foregroundStyle(.gray).opacity(0.5)
                    .padding(.bottom)
                    .padding(.horizontal)
                   
                    
                MultiLineTextField(text: $text)
            }.padding()
           
        }.padding(.top)
    }
}

//#Preview {
//    CreateTweetView()
//}
