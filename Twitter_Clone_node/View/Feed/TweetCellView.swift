//
//  TweetCellView.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 22/11/24.
//

import SwiftUI
import Kingfisher

struct TweetCellView: View {


    @ObservedObject var viewModel: TweetCellViewModel
    
    init(viewModel: TweetCellViewModel) {
        self.viewModel = viewModel
    }
    
    var imageId: String = ""
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 20) {
                Image("me")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(self.viewModel.tweet.username)")
                        .fontWeight(.bold) +
                    Text("@\(self.viewModel.tweet.username)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    Text(self.viewModel.tweet.text)
                        .frame(maxHeight: 100, alignment: .top)
                    let imageId = viewModel.tweet.id
                    if imageId == viewModel.tweet.id {
                        if viewModel.tweet.Image == "true" {
                            GeometryReader { proxy in
                                KFImage(URL(string: "http://localhost:3007/tweets/\(imageId)/image"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: proxy.frame(in: .global).width, height: 250)
                                    .cornerRadius(15)
                                
                            }.frame(height: 250)
                        }
                    }
                }
                Spacer()
            }// HStack
            HStack(spacing:50, content: {
                Button(action: {}) {
                    Image(systemName: "bubble")
                        .frame(width: 18, height: 12)
                        .foregroundStyle(.gray)
                }
                Button(action: {}) {
                    Image(systemName: "arrow.2.squarepath")
                        .frame(width: 10, height: 12)
                        .foregroundStyle(.gray)
                }
                Button(action: {}) {
                    Image(systemName: "heart")
                        .frame(width: 18, height: 15)
                        .foregroundStyle(.gray)
                }
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up")
                        .frame(width: 18, height: 15)
                        .foregroundStyle(.gray)
                }
            }).padding(.top, 4)
        }
    }
}

