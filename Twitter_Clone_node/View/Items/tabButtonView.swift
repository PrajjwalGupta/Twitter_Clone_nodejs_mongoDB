//
//  tabButtonView.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 23/11/24.
//

import SwiftUI

struct tabButtonView: View {
    @Binding var currentTab: String
    var animation: Namespace.ID
    var title: String
    var body: some View {
        Button(action: {}, label: {
            LazyVStack(spacing: 12){
                Text(title).fontWeight(.semibold).foregroundColor(currentTab == title ? .blue : .gray)
                    .padding(.horizontal)
                if currentTab == title {
                    Capsule()
                        .fill(Color.blue).frame(height: 1.2).matchedGeometryEffect(id: "TAB", in: animation)
                } else {
                    Capsule()
                        .fill(Color.clear).frame(height: 1.2)
                }
            }
        })
    }
}

//#Preview {
//    tabButtonView(currentTab: <#Binding<String>#>, title: "Tweets")
//}
