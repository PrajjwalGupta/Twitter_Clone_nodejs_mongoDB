//
//  TweetCellViewModel.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 27/11/24.
//

import SwiftUI

class TweetCellViewModel: ObservableObject {
    
    @Published var tweet: Tweet
    
    init(tweet: Tweet) {
        self.tweet = tweet
    }
    
}
