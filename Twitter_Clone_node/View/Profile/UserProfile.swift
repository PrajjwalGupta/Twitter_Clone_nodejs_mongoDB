//
//  UserProfile.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 22/11/24.
//

import SwiftUI
import Kingfisher

struct UserProfile: View {
    @State var offset: CGFloat = 0
    @State var titleOfset: CGFloat = 0
    @State var currentTab = "Tweets"
    @State var tabBarOffset: CGFloat = 0
    @ObservedObject var viewModel: ProfileViewModel
    var isFollowed: Bool { return viewModel.user.isFollowed ?? false }
    @Namespace var animation
    let user: User
    @State var editProfile: Bool = false
    var isCurrentUser: Bool {
        return viewModel.user.isCurrentUser ?? false
    }
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
        print("USER: \(viewModel.user.isCurrentUser)")
    }
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .global).minY
                    Color.clear.onChange(of: minY) { newMinY in
                                               self.offset = newMinY
                          }
                        ZStack {
                            Image("banner")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getRect().width, height: minY > 0 ? 180 + minY : 180 , alignment: .top)
                                .cornerRadius(0)
                            BlurView()
                                .opacity(blurViewOpacity())
                            VStack(spacing: 5) {
                                Text(self.user.name)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("150 Tweets")
                                    .foregroundColor(.white)
                            }.offset(y: 120)
                                .offset(y: titleOfset > 100 ? 0 : -getTitleOffset())
                                .opacity(titleOfset < 100 ? 1 : 0)
                        }
                        .clipped()
                        .frame(height: minY > 0 ? 180 + minY : nil)
                        .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
                   // )
                }.frame(height: 180)
                    .zIndex(1)
                VStack{
                    HStack {
                        KFImage(URL(string: "http://localhost:3007/users/\(self.viewModel.user.id)/avatar"))
                            .placeholder({
                                Image(systemName: "person.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())   
                            })
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(8)
                            .background(Color.white.clipShape(Circle()))
                            .offset(y: offset < 0 ? getoffset() - 20 : -20)
                            .scaleEffect(getScale())
                        Spacer()
                        if(self.isCurrentUser) {
                            Button(action:{
                                self.editProfile.toggle()
                            },label: {
                                Text("Edit Profile")
                            }).frame(width: 120, height: 40)
                                .overlay( RoundedRectangle(cornerRadius: 40 / 2).stroke(Color("bg"), lineWidth: 2)).padding()
                                .sheet(isPresented: $editProfile) {
                                    
                                } content: {
                                    EditProfileView(user: $viewModel.user)
                                }
                        } else {
                            Button(action:{
                                isFollowed ? self.viewModel.unfollow() : self.viewModel.follow()
                            },label: {
                                Text(isFollowed ? "Following" : "Follow")
                                    .foregroundColor(isFollowed ? .blue : .black)
                            }).frame(width: 120, height: 40)
                                .overlay( RoundedRectangle(cornerRadius: 40 / 2).stroke(Color("bg"), lineWidth: 2)).padding()
                        }
                    }.padding(.top, -25)
                        .padding(.bottom, -10)
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(self.viewModel.user.name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                            Text("@\(self.viewModel.user.username)")
                                .foregroundStyle(.gray)
                            Text(viewModel.user.bio ?? "Lorem Ipsum is simply dummy text of the printing and 4️⃣, 5️⃣typesetting industry.")
                            HStack(spacing: 8) {
                                if let userLocation = viewModel.user.location {
                                    if (userLocation != "") {
                                        HStack(spacing: 2) {
                                            Image(systemName: "location.circle")
                                                .frame(width: 44, height: 44, alignment: .center)
                                                .foregroundColor(Color("bg"))
                                            Text(userLocation)
                                                .foregroundColor(.gray)
                                                .font(.system(size: 20))
                                        }
                                    }
                                }
                                if let userwebsite = viewModel.user.website {
                                    if (userwebsite != "") {
                                        HStack(spacing: 2) {
                                            Image(systemName: "link")
                                                .frame(width: 24, height: 24, alignment: .center)
                                                .foregroundColor(Color("bg"))
                                            Text(userwebsite)
                                                .foregroundColor(.gray)
                                                .font(.system(size: 20))
                                        }.padding(.trailing, 10)
                                    }
                                }
                                Spacer()
                            }
                            HStack(spacing: 5) {
                                Text("54")
                                    .foregroundStyle(.primary)
                                    .fontWeight(.semibold)
                                Text("Followers")
                                    .foregroundStyle(.gray)
                                Text("234")
                                    .foregroundStyle(.primary)
                                    .fontWeight(.semibold)
                                    .padding(.leading, 10)
                                Text("Following")
                                    .foregroundStyle(.gray)
                            }.padding()
                        }
                        .padding(.leading, 8)
                        .overlay (
                            GeometryReader { proxy -> Color in
                                let minY = proxy.frame(in: .global).minY
                                DispatchQueue.main.async {
                                    self.titleOfset = minY
                                }
                                return Color.clear
                            }.frame(width: 0,height: 0), alignment: .top
                        )
                        Spacer()
                    }
                    VStack(spacing: 0) {
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack(spacing: 0) {
                                tabButtonView(currentTab: $currentTab, animation: animation, title: "Tweets")
                                tabButtonView(currentTab: $currentTab, animation: animation, title: "Tweets & Likes")
                                tabButtonView(currentTab: $currentTab, animation: animation, title: "Media")
                                tabButtonView(currentTab: $currentTab, animation: animation, title: "Likes")
                            }
                        }
                        Divider()
                    }.padding(.top, 30)
                        .background(Color.white)
                        .offset(y: tabBarOffset < 90 ? -tabBarOffset + 90 : 0)
                        .overlay (
                            GeometryReader { proxy -> Color in
                                let minY = proxy.frame(in: .global).minY
                                DispatchQueue.main.async {
                                    self.tabBarOffset = minY
                                }
                                return Color.clear
                            }.frame(width: 0, height: 0), alignment: .top
                        ).zIndex(1)
                    VStack(spacing: 18) {
                        ForEach(viewModel.tweets) { tweet in
                            TweetCellView(viewModel: TweetCellViewModel(tweet: tweet, currentUser: AuthViewModel.shared.currentUser!))
                        }
                    }.padding(.top)
                        .zIndex(0)
                }.padding(.horizontal)
                    .zIndex(-offset > 80 ? 0 : 1)
            }
        }.ignoresSafeArea(.all, edges: .top)
    }
    func blurViewOpacity() -> Double {
        let progress = -(offset + 80) / 150
        return Double(-offset > 80 ? progress : 0)
    }
    func getTitleOffset() -> CGFloat {
        let progress = 20 / titleOfset
        let offset = 60 * (progress > 0 && progress <= 1 ? progress : 1)
        return offset
    }
    func getoffset() -> CGFloat {
        let progress = (-offset / 80) * 20
        return progress <= 20 ? progress : 20
    }
    func getScale() -> CGFloat {
        let progress = -offset / 80
        let scale = 1.8 - (progress < 1.0 ? progress : 1.0)
        return scale < 1 ? scale : 1
        
    }
    
}


