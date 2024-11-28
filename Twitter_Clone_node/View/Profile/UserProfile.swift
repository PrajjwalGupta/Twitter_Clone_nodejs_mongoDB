//
//  UserProfile.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 22/11/24.
//

import SwiftUI

struct UserProfile: View {
    @State var offset: CGFloat = 0
    @State var titleOfset: CGFloat = 0
    @State var currentTab = "Tweets"
    @State var tabBarOffset: CGFloat = 0
    @ObservedObject var viewModel: ProfileViewModel
    @Namespace var animation
    let user: User
    @State var editProfile: Bool = false
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .global).minY
                  // DispatchQueue.main.async {
                    Color.clear.onChange(of: minY) { newMinY in
                                               self.offset = newMinY
                          }
                   // }
                    //return AnyView(
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
                        Image("me")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                            .clipShape(Circle())
                            .padding(8)
                            .background(Color.white.clipShape(Circle()))
                            .offset(y: offset < 0 ? getoffset() - 20 : -20)
                            .scaleEffect(getScale())
                        Spacer()
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

                        
                        
                    }.padding(.top, -25)
                        .padding(.bottom, -10)
                    VStack(alignment: .leading) {
                        Text(self.user.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                        Text("@\(self.user.username)")
                            .foregroundStyle(.gray)
                        Text("Lorem Ipsum is simply dummy text of the printing and 4️⃣, 5️⃣typesetting industry.")
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
                    }.overlay (
                        GeometryReader { proxy -> Color in
                            let minY = proxy.frame(in: .global).minY
                            DispatchQueue.main.async {
                                self.titleOfset = minY
                            }
                            return Color.clear
                        }.frame(width: 0,height: 0), alignment: .top
                    )
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
//                        TweetCellView(tweet: "Hey, Check out my pics from OTTY!", tweetImage: "post")
//                        ForEach(0..<20, id: \.self) { _ in
//                            TweetCellView(tweet: sampleText1)
//                            Divider()
//                            
//                        }
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

//#Preview {
//    UserProfile()
//}
