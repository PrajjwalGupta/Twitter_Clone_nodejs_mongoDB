//
//  SideMenu.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 22/11/24.
//

import SwiftUI

struct SideMenu: View {
    @State var showMenu = false
    @ObservedObject var viewModel: AuthViewModel
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var width = UIScreen.main.bounds.width
    var menuItems = [("Profile","person"), ("Lists", "list.bullet"), ("Topics","widget.small"), ("Bookmarks", "bookmark"), ("Moments","light.recessed.3")]
   // var menuIcons = [,, ,, ]
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    NavigationLink(destination: UserProfile(user: viewModel.currentUser!).navigationBarHidden(false)) {
                        Image("me")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    }.navigationTitle("")
                        .onAppear {
                                       // Configure the navigation bar to be transparent
                                       let appearance = UINavigationBarAppearance()
                                       appearance.configureWithTransparentBackground()
                                       appearance.backgroundColor = UIColor.clear // Fully transparent
                                       
                                       UINavigationBar.appearance().standardAppearance = appearance
                                       UINavigationBar.appearance().scrollEdgeAppearance = appearance
                                   }
                    HStack(alignment: .top, spacing: 12, content: {
                        VStack(alignment: .leading, spacing: 12, content: {
                            NavigationLink(destination: UserProfile(user: viewModel.currentUser!).navigationBarHidden(false)) {
                                VStack(alignment: .leading, spacing: 12, content: { Text(viewModel.currentUser!.name)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    Text("@\(viewModel.currentUser!.username)")
                                        .foregroundColor(.gray)
                                })
                            }.navigationTitle("")
                                .onAppear {
                                               // Configure the navigation bar to be transparent
                                               let appearance = UINavigationBarAppearance()
                                               appearance.configureWithTransparentBackground()
                                               appearance.backgroundColor = UIColor.clear // Fully transparent
                                               
                                               UINavigationBar.appearance().standardAppearance = appearance
                                               UINavigationBar.appearance().scrollEdgeAppearance = appearance
                                           }
                            HStack(spacing: 20) {
                                FollowView(count: 8, title: "Following")
                                FollowView(count: 18, title: "Followers")
                            }.padding(.top)
                            Divider()
                                .padding(.top, 10)
                        })//VSTACK
                        Spacer(minLength: 0)
                        Button(action: {
                            withAnimation{
                                self.showMenu.toggle()
                            }
                        },label: {
                            Image(systemName: showMenu ? "chevron.down" : "chevron.up")
                                .foregroundColor(Color("bg"))
                        })
                    })//HStack
                    VStack(alignment: .leading) {
                        ForEach(menuItems, id: \.0) { item in
                            MenuButtonItem(text: item.0, icon: item.1)
                           
                        }
                        Divider()//.padding(.top)
                        Button(action: {}, label: {
                            MenuButtonItem(text: "Twitter Ads", icon: "arrow.up.right.square")
                        })
                        Divider()
                        Button(action: {}, label: {
                            Text("Settings and Privacy")
                                .foregroundColor(.black)
                        }).padding(.top,10)
                        Button(action: {}, label: {
                            Text("Help and Centre")
                                .foregroundColor(.black)
                        }).padding(.top,10)
                        Spacer()
                        Divider()
                            .padding(.top)
                            .padding(.bottom)
                        HStack {
                            Button(action: {}, label: {
                                Image(systemName: "lightbulb.max")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 36, height: 36)
                                    .padding(.leading, 20)
                            })//.padding()
                            Spacer()
                            Button(action: {}, label: {
                                Image(systemName: "qrcode.viewfinder")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 36, height: 36)
                                    .padding(.trailing, 20)
                            })
                        }
//                        Divider()
//                            .padding(.top)
//                            .padding(.bottom)
                    }.opacity(showMenu ? 1.0 : 0.0 )
                        .frame(height: showMenu ? nil : 0)
                    VStack(alignment: .leading) {
                        Button(action: {}, label: {
                            Text("Create a account")
                                .padding(.bottom, 10)
                        }).padding(.top, 10)
                        Button(action: {}, label: {
                            Text("Add an existing account?")
                                .padding(.trailing, 20)
                        })
                        Spacer(minLength: 0)
                    }.opacity(showMenu ? 0.0 : 1.0 )
                        .frame(height: showMenu ? 0 : nil)
                        
                    
                }//VStack
            }//HStack
            .padding(.horizontal, 20)
            .padding(.top, edges!.top == 0 ? 15 : edges?.top)
            .padding(.bottom)
           // .padding(.bottom, edges!.bottom == 0 ? 15 : edges?.bottom)
            .frame(width: width - 90)
            .background(.white)
            .ignoresSafeArea(.all, edges: .vertical)
            Spacer()
            
        }//First VStack
    }
}

