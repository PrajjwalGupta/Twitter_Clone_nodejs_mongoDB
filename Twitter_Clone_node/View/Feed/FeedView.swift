//
//  FeedView.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 21/11/24.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject var viewModel = FeedViewModel()
    let user: User
    
    var body: some View {
        RefreshableScrollView {
            ScrollView(.vertical, showsIndicators: false, content: {
                LazyVStack(spacing: 18) {
                    ForEach(viewModel.tweets) { tweet in
                        TweetCellView(viewModel: TweetCellViewModel(tweet: tweet, currentUser: user))
                        Divider()
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                .zIndex(0)
            })
        } onRefresh: { control in
            DispatchQueue.main.async {
                self.viewModel.fetchTweets()
                control.endRefreshing()
            }
        }
    }
}

//struct FeedView: View {
//    @ObservedObject var viewModel = FeedViewModel()
//    let user: User
//    var body: some View {
//        RefreshableScrollView(content:
//        
//                                ScrollView(.vertical, showsIndicators: false, content: {
//            LazyVStack(spacing: 10) {
//                ForEach(viewModel.tweets) { tweet in
//                    TweetCellView(viewModel: TweetCellViewModel(tweet: tweet, currentUser: user))
//                    Divider()
//                }
//            }
//            .padding(.top)
//            .padding(.horizontal)
//            .zIndex(0)
//        })
//        ) { control in
//            DispatchQueue.main.async {
//                self.viewModel.fetchTweets()
//                control.endRefreshing()
//            }
//        }
//    }
//}

