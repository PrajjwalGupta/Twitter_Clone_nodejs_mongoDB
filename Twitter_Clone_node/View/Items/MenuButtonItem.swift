//
//  MenuButtonItem.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 22/11/24.
//

import SwiftUI

struct MenuButtonItem: View {
    var text: String
    var icon: String
    
   // var menuItems = [("Profile","person"), ("Lists", "list.bullet"), ("Topics","widget.small"), ("Bookmarks", "bookmark"), ("Moments","light.recessed.3")]
    var body: some View {
        VStack(spacing: 25) {
           // ForEach (menuItems, id: \.0) { item in
                HStack {
                    Image(systemName: icon)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.gray)
                    
                    Text(text)
                        .foregroundColor(.black)
                        Spacer(minLength: 0)
                }
                
           // }
        }
        .padding(.vertical, 12)
    }
}

#Preview {
    MenuButtonItem(text: "Profile", icon: "person")
}
