//
//  FeedView.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 21/11/24.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach (0..<20, id: \.self) {  _ in
                    TweetCellView(tweet: "Hey all, check out my new pic from otty", tweetImage: "post")
                    Divider()
                    TweetCellView(tweet: sampleText1)
                    Divider()
                    
                }
            }
            .padding(.top)
            .padding(.horizontal)
            .zIndex(0)
        }
    }
}

#Preview {
    FeedView()
}
