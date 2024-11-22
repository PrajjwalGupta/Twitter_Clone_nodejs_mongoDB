//
//  SearchBarView.swift
//  Twitter_Clone_node
//
//  Created by Prajjwal Gupta on 22/11/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText : String
    @Binding var isEditing: Bool
    var body: some View {
        HStack {
            TextField("Search Tweet...", text: $searchText )
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(20)
                .overlay (
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.gray)
                            .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
            Button(action:{
                isEditing = false
                searchText = ""
                UIApplication.shared.endEditing()
            },label: {
                Text("Cancel")
            }).frame(width: 80, height: 30)
                .overlay( RoundedRectangle(cornerRadius: 30 / 2).stroke(Color("bg"), lineWidth: 2)).animation(.easeInOut).padding()
        }.onTapGesture {
            isEditing = true
        }
    }
}
//
//#Preview {
//    SearchBarView(searchText: sampleSearch)
//}


