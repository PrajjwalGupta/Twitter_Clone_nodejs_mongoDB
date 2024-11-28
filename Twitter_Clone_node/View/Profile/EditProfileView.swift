//
//  EditProfile.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 28/11/24.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    
    @State var profileImage: Image?
    @State private var selectedImage: UIImage?
    @State var imagePickerPreasented = false
    @State var name: String
    @State var location: String
    @State var bio: String
    @State var website: String
    @Binding var user: User
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: EditProfileViewModel
    
    init(user: Binding<User>) {
        self._user = user
        self.viewModel = EditProfileViewModel(user: self._user.wrappedValue)
        self._name = State(initialValue: _user.name.wrappedValue ?? "")
        self._location = State(initialValue: _user.location.wrappedValue ?? "")
        self._bio = State(initialValue: _user.bio.wrappedValue ?? "")
        self._website = State(initialValue: _user.website.wrappedValue ?? "")
    }
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(Color("bg"))
                    }
                    .frame(width: 120, height: 40)
                    .overlay( RoundedRectangle(cornerRadius: 40 / 2).stroke(Color("bg"), lineWidth: 2)).padding(.top)
                   
                    Spacer()
                    Button {
                        self.viewModel.uploadUserData(name: name, bio: bio, website: website, location: location)
                    } label: {
                        Text("Save")
                            .foregroundColor(.white)
                            .frame(width: 120, height: 40)
                            .background(Color("bg"))
                            .foregroundStyle(.white)
                            .clipShape(.capsule).padding(.top)
                    }
                }.padding(.horizontal, 10)
                HStack {
                    Spacer()
                    Text("Edit Profile")
                        .fontWeight(.heavy)
                        .padding(.top)
                    Spacer()
                }
            }
            VStack {
                Image("banner")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getRect().width, height: 100, alignment: .center)
                    .cornerRadius(0)
                HStack{
                    if profileImage == nil {
                        Button(action: {
                            self.imagePickerPreasented.toggle()
                        }, label: {
                            KFImage(URL(string: "http://localhost:3007/users/id/avatar"))
                                .resizable()
                                .placeholder{
                                    Image(systemName: "person")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 55, height: 55)
                                        .padding()
                                        .foregroundColor(.gray)
                                        .clipShape(Circle())
                                }.aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(8)
                                .background(Color.white)
                                .clipShape(Circle())
                                .offset(y: -20)
                                .padding(.leading, 20)
                            })
                        .sheet(isPresented: $imagePickerPreasented) {
                            loadImage()
                        } content: {
                            ImagePicker(image: $selectedImage)
                        }
                    } else if let image = profileImage {
                        VStack {
                            HStack(alignment: .top) {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                                    .padding(8)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .offset(y: -20)
                            }.padding()
                        }.padding(.leading, 12)
                    }
                    Spacer()
                }
                .onAppear {
                    KingfisherManager.shared.cache.clearCache()
                }
                .padding(.top, -20)
                .padding(.bottom, -10)
                
                VStack {
                    Divider()
                    HStack {
                        ZStack {
                            HStack {
                                Text("Name: ")
                                    .foregroundColor(.black)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            customProfileTextField(message: $name, placeholder: "Add your name...")
                                .padding(.leading, 90)
                        }
                    }.padding(.horizontal)
                    Divider()
                    HStack {
                        ZStack(alignment: .topLeading) {
                            HStack {
                                Text("Bio: ")
                                    .foregroundColor(.black)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            customProfileBioTextField(bio: $bio)
                                .padding(.leading, 86)
                                .padding(.top, -6)
                        }
                    }.padding(.horizontal)
                    Divider()
                    HStack {
                        ZStack {
                            HStack {
                                Text("Location: ")
                                    .foregroundColor(.black)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            customProfileTextField(message: $location, placeholder: "Enter you location...")
                                .padding(.leading, 90)
                        }
                    }.padding(.horizontal)
                    Divider()
                    HStack {
                        ZStack {
                            HStack {
                                Text("Website: ")
                                    .foregroundColor(.black)
                                    .fontWeight(.heavy)
                                Spacer()
                            }
                            customProfileTextField(message: $website, placeholder: "Enter your website...")
                                .padding(.leading, 90)
                        }
                    }.padding(.horizontal)
                }
            }
            Spacer()
        }
        .onReceive(viewModel.$uploadComplete) { complete in
            if complete {
                self.presentationMode.wrappedValue.dismiss()
                self.user.name = viewModel.user.name
                self.user.website = viewModel.user.website
                self.user.location = viewModel.user.location
                self.user.website = viewModel.user.website
            }
        }
    }
}
extension EditProfileView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}
