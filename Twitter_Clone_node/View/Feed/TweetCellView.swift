//
//  TweetCellView.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 22/11/24.
//

import SwiftUI

struct TweetCellView: View {
    var sampleText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    var tweet: String
    var tweetImage: String?
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 20) {
                Image("me")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 10) {
                    Text("Prajjwal")
                        .fontWeight(.bold) +
                    Text("@prajjwal1")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    Text(tweet)
                        .frame(maxHeight: 100, alignment: .top)
                    if let image = tweetImage {
                        GeometryReader { proxy in
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: proxy.frame(in: .global).width, height: 250)
                                .cornerRadius(15)
                        }.frame(height: 250)
                    }
                }
            }// HStack
            HStack(spacing:50, content: {
                Button(action: {}) {
                    Image(systemName: "bubble")
                        .frame(width: 18, height: 12)
                        .foregroundStyle(.gray)
                }
                Button(action: {}) {
                    Image(systemName: "arrow.trianglehead.rectanglepath")
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

#Preview {
    TweetCellView(tweet: sampleText1)
}

var sampleText1 = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
