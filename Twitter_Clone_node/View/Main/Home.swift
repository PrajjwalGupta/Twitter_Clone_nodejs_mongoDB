//
//  Home.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 21/11/24.
//

import SwiftUI

struct Home: View {
    @State var selectedIndex = 0
    @State var showCreateTweet = false
    @State var text = ""
    var body: some View {
       VStack {
            ZStack {
                
                TabView {
                    FeedView()
                        .onTapGesture {
                            self.selectedIndex = 0
                        }
                    .tabItem{
                        if (selectedIndex == 0) {
                        Image(systemName: "house")
                            .renderingMode(.template)
                            .foregroundColor(Color("bg"))
                        } else {
                            Image(systemName: "house")
                                .renderingMode(.template)
                                .foregroundColor(Color(.gray))
                        }
                    }.tag(0)
                    SearchView()
                        .onTapGesture {
                            self.selectedIndex = 1
                        }
                        .tabItem {
                            if (selectedIndex == 1) {
                            Image(systemName: "magnifyingglass")
                                    .renderingMode(.template)
                                    .foregroundColor(Color("bg"))
                            } else {
                                Image(systemName: "magnifyingglass")
                                    .renderingMode(.template)
                                    .foregroundColor(Color(.gray))
                            }
                        } .tag(1)
                    UserProfile()
                        .onTapGesture {
                            self.selectedIndex = 2
                        }
                        .tabItem {
                            if (selectedIndex == 2) {
                                Image(systemName: "person.2")
                                    .renderingMode(.template)
                                    .foregroundColor(Color("bg"))
                            }  else {
                                Image(systemName: "person.2")
                                    .renderingMode(.template)
                                    .foregroundColor(Color(.gray))
                            }
                        } .tag(2)
                    NotificationsView()
                        .onTapGesture {
                            self.selectedIndex = 3
                        }
                        .tabItem {
                            if (selectedIndex == 3) {
                                Image(systemName: "bell")
                                    .renderingMode(.template)
                                    .foregroundColor(Color("bg"))
                            }  else {
                                Image(systemName: "bell")
                                    .renderingMode(.template)
                                    .foregroundColor(Color(.gray))
                            }
                        }.tag(3)
                    MessagesView()
                        .onTapGesture {
                            self.selectedIndex = 4
                        }
                        .tabItem {
                            if (selectedIndex == 4) {
                                Image(systemName: "envelope")
                                .renderingMode(.template)
                                .foregroundColor(Color("bg"))
                        }   else {
                            Image(systemName: "envelope")
                                .renderingMode(.template)
                                .foregroundColor(Color(.gray))
                            }
                    }.tag(4)
                }
                VStack(alignment: .trailing) {
                    Spacer()
                    HStack(alignment: .bottom) {
                        Spacer()
                        Button(action: {self.showCreateTweet.toggle()}, label: {
                            Image("post_icon")
                                .renderingMode(.template)
                                .frame(width: 60, height: 60)
                                .background(Color("bg"))
                                .foregroundStyle(Color.white)
                                .clipShape(.circle)
                            
                            //Text("Ha")
                        })
                    }//HStack
                    .padding(.bottom, 70)
                    .padding(.trailing, 12)
                }//VStack
                .sheet(isPresented: $showCreateTweet, content: {CreateTweetView(text: text).presentationDetents([.medium,.large])})
            }
        }
    }
}

#Preview {
    Home()
}
