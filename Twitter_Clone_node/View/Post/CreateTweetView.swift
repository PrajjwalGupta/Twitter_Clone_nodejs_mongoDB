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
    @State var imagePickerPresented = false
    @State var selectedImage: UIImage?
    @State var postImage: Image?
    @State var width = UIScreen.main.bounds.width
    
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
                        self.viewModel.uploadPost(text: text, image: selectedImage)
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
            if postImage == nil {
                Button(action: {
                    self.imagePickerPresented.toggle()
                }, label: {
                    Image(systemName: "paperclip.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .clipped()
                        .padding(.top)
                        .foregroundStyle(Color("bg"))
                }).sheet(isPresented: $imagePickerPresented) {
                    loadImage()
                } content: {
                    ImagePicker(image: $selectedImage)
                }
            }
           else if let image = postImage {
                VStack {
                    HStack(alignment: .top) {
                       image
                            .resizable()
                            .scaledToFill()
                            .frame(width: width * 0.9, height: 200)
                            .cornerRadius(16)
                            .padding(.horizontal)
                            
                            .clipped()
                            .padding()
                      
                    }
                }
            }
            Spacer()
           
        }.padding(.top)
    }
}

//#Preview {
//    CreateTweetView()
//}

extension CreateTweetView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        postImage = Image(uiImage: selectedImage)
    }
}
