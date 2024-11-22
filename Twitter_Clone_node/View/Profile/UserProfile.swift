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
                                .frame(width: UIScreen.main.bounds.width, height: minY > 0 ? 180 + minY : 180 , alignment: .top)
                                .cornerRadius(0)
                            BlurView()
                                .opacity(blurViewOpacity())
                            VStack(spacing: 5) {
                                Text("Prajjwal")
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
            }
        }
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
}

#Preview {
    UserProfile()
}
